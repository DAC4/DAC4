package imag.dac4.model.loan;

import imag.dac4.model.Dao;
import imag.dac4.model.item.Item;
import imag.dac4.model.item.ItemDao;
import imag.dac4.model.user.User;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.TypedQuery;
import java.util.List;

@Stateless
public class LoanDao extends Dao<Integer, Loan> {

    @EJB ItemDao itemDao;

    public LoanDao() {
        super(Loan.class);
    }

    public List<Loan> getLoans() {
        TypedQuery<Loan> query = entityManager.createQuery("SELECT l FROM Loan l ORDER BY l.id", Loan.class);
        return query.getResultList();
    }

    public List<Loan> getLoans(User user) {
        if (user != null) {
            TypedQuery<Loan> query = entityManager.createQuery("SELECT l FROM Loan l WHERE l.userId = :id ORDER BY l.id", Loan.class);
            query.setParameter("id", user.getId());
            return query.getResultList();
        } else {
            return null;
        }
    }

    public void forgetItemHistory(Integer id) {
        TypedQuery<Loan> query = entityManager.createQuery("DELETE FROM Loan l WHERE l.itemId = :id", Loan.class);
        query.setParameter("id", id);
    }

    public boolean canUserBorrow(User user) {
        final List<Loan> loans = getLoans(user);
        for (Loan loan : loans) {
            final Item item = this.itemDao.read(loan.getItemId());
            if (!loan.isReturned() && loan.shouldHaveBeenReturned(item.getMaxLoanDuration())) {
                return false;
            }
        }
        return true;
    }
}
