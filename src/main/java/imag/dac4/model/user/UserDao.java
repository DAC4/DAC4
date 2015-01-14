package imag.dac4.model.user;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class UserDao {

    @PersistenceContext
    private EntityManager entityManager;

    // ##################### //
    // ## CRUD operations ## //
    // ##################### //

    public void create(User user) {
        entityManager.persist(user);
    }

    public User read(int id) {
        return entityManager.find(User.class, id);
    }

    public void update(User user) {
        entityManager.merge(user);
    }

    public void delete(int id) {
        entityManager.remove(entityManager.find(User.class, id));
    }

    // ###################### //
    // ## Other operations ## //
    // ###################### //

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
