package imag.dac.dac4;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;

@Stateless
public class UserDao {
    @PersistenceContext private EntityManager em;

    public void create(User user) {
        em.persist(user);
    }

    public void update(User user) {
        em.merge(user);
    }

    public void delete(long id) {
        User user = em.find(User.class, id);
        em.remove(user);
    }

    public List<User> getUsers() {
        TypedQuery<User> query = em.createQuery("SELECT g FROM User g ORDER BY g.id", User.class);
        return query.getResultList();
    }
}
