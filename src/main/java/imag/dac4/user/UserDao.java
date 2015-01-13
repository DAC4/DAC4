package imag.dac4.user;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;

@Stateless
public class UserDao {

    @PersistenceContext
    private EntityManager entityManager;

    /* * * * * * * * * *
     * CRUD Operations *
     * * * * * * * * * */

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

    /* * * * * * * * * * *
     * Other operations  *
     * * * * * * * * * * */

    public List<User> getUsers() {
        TypedQuery<User> query = entityManager.createQuery("SELECT u FROM User u ORDER BY u.id", User.class);
        return query.getResultList();
    }
}
