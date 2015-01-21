package imag.dac4.model.item;

import imag.dac4.model.user.User;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;

@Stateless
public class ItemDao {

    @PersistenceContext
    private EntityManager entityManager;

    // ##################### //
    // ## CRUD operations ## //
    // ##################### //

    public void create(Item item) {
        entityManager.persist(item);
    }

    public Item read(int id) {
        return entityManager.find(Item.class, id);
    }

    public void update(Item item) {
        entityManager.merge(item);
    }

    public void delete(int id) {
        entityManager.remove(entityManager.find(Item.class, id));
    }

    // ###################### //
    // ## Other operations ## //
    // ###################### //

    public List<Item> getItems() {
        TypedQuery<Item> query = entityManager.createQuery("SELECT i FROM Item i ORDER BY i.id", Item.class);
        return query.getResultList();
    }

    public List<Item> getItems(User user) {
        if (user != null) {
            TypedQuery<Item> query = entityManager.createQuery("SELECT i FROM Item i WHERE i.ownerId = :id ORDER BY i.id", Item.class);
            query.setParameter("id", user.getId());
            return query.getResultList();
        } else {
            return null;
        }
    }
}
