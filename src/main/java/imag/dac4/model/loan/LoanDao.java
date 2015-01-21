package imag.dac4.model.loan;

import imag.dac4.model.Dao;

import javax.ejb.Stateless;
import javax.persistence.TypedQuery;
import java.util.List;

@Stateless
public class LoanDao extends Dao<Integer, Loan> {

    public LoanDao() {
        super(Loan.class);
    }

    public List<Loan> getLoans() {
        TypedQuery<Loan> query = entityManager.createQuery("SELECT l FROM Loan l ORDER BY l.id", Loan.class);
        return query.getResultList();
    }
}
