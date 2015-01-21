package imag.dac4.model;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

public abstract class Dao<K, T> {

    @PersistenceContext
    protected EntityManager entityManager;

    private final Class<T> type;

    protected Dao(Class<T> type) {
        this.type = type;
    }

    // ##################### //
    // ## CRUD operations ## //
    // ##################### //

    public void create(T t) {
        entityManager.persist(t);
    }

    public T read(K key) {
        return entityManager.find(this.type, key);
    }

    public void update(T t) {
        entityManager.merge(t);
    }

    public void delete(K key) {
        entityManager.remove(entityManager.find(this.type, key));
    }
}
