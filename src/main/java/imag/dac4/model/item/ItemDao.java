package imag.dac4.model.item;

import imag.dac4.model.Dao;
import imag.dac4.model.user.User;

import javax.ejb.Stateless;
import javax.persistence.TypedQuery;
import java.util.List;

@Stateless
public class ItemDao extends Dao<Integer, Item> {

    public ItemDao() {
        super(Item.class);
    }

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
