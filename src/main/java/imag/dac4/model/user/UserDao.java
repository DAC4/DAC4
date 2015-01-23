package imag.dac4.model.user;

import imag.dac4.model.Dao;
import imag.dac4.model.item.Item;
import imag.dac4.model.item.ItemDao;
import imag.dac4.model.loan.Loan;
import imag.dac4.model.loan.LoanDao;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.NoResultException;
import java.util.List;

@Stateless
public class UserDao extends Dao<Integer, User> {

    @EJB ItemDao itemDao;
    @EJB LoanDao loanDao;

    public UserDao() {
        super(User.class);
    }

    public User getByLogin(final String login) {
        try {
            return entityManager
                    .createQuery("SELECT u FROM User u WHERE u.login = :login", User.class)
                    .setParameter("login", login)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public List<User> getUsers() {
        return entityManager.createQuery("SELECT u FROM User u ORDER BY u.id", User.class).getResultList();
    }

    public boolean canUserBorrow(User user) {
        final List<Loan> loans = this.loanDao.getLoans(user);
        for (Loan loan : loans) {
            final Item item = this.itemDao.read(loan.getItemId());
            if (!loan.isReturned() && loan.shouldHaveBeenReturned(item.getMaxLoanDuration())) {
                return false;
            }
        }
        return true;
    }

    public boolean isRemovable(User user) {
        final List<Item> items = this.itemDao.getItems(user);
        if (items.size() == 0) {
            final List<Loan> loans = this.loanDao.getLoans(user);
            for (Loan loan : loans) {
                if (!loan.isReturned()) {
                    return false;
                }
            }
            return true;
        } else {
            return false;
        }
    }
}
