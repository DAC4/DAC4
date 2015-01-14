package imag.dac4.model.loan;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;

@Stateless
public class LoanDao {

    @PersistenceContext
    private EntityManager entityManager;

    // ##################### //
    // ## CRUD operations ## //
    // ##################### //

    public void create(Loan loan) {
        entityManager.persist(loan);
    }

    public Loan read(int id) {
        return entityManager.find(Loan.class, id);
    }

    public void update(Loan loan) {
        entityManager.merge(loan);
    }

    public void delete(int id) {
        entityManager.remove(entityManager.find(Loan.class, id));
    }

    // ###################### //
    // ## Other operations ## //
    // ###################### //

    public List<Loan> getLoans() {
        TypedQuery<Loan> query = entityManager.createQuery("SELECT l FROM Loan l ORDER BY l.id", Loan.class);
        return query.getResultList();
    }
}
