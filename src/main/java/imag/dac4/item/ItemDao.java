package imag.dac4.item;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;

@Stateless
public class ItemDao {

    @PersistenceContext
    private EntityManager entityManager;

    /* * * * * * * * * *
     * CRUD Operations *
     * * * * * * * * * */

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

    /* * * * * * * * * * *
     * Other operations  *
     * * * * * * * * * * */

    public List<Item> getItems() {
        TypedQuery<Item> query = entityManager.createQuery("SELECT i FROM Item i ORDER BY i.id", Item.class);
        return query.getResultList();
    }
}
