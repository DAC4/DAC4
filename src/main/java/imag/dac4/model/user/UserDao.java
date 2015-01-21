package imag.dac4.model.user;

import imag.dac4.model.Dao;

import javax.ejb.Stateless;
import javax.persistence.NoResultException;
import java.util.List;

@Stateless
public class UserDao extends Dao<Integer, User> {

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
}
