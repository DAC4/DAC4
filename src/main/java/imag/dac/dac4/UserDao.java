package imag.dac.dac4;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;

@Stateless
public class UserDao {
    // Injected database connection:
    @PersistenceContext private EntityManager em;

    // Stores a new guest:
    public void persist(User user) {
        em.persist(user);
    }

    // Retrieves all the guests:
    public List<User> getUsers() {
        TypedQuery<User> query = em.createQuery("SELECT g FROM User g ORDER BY g.id", User.class);
        return query.getResultList();
    }
}
