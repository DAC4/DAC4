package imag.dac4.loan;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "loans")
public class Loan implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "date")
    private Date date;

    @Column(name = "?emp-retDate")
    private Date emp_retDate; // TODO Wtf is this

    @Column(name = "userId")
    private int userId;

    @Column(name = "itemId")
    private int itemId;

    @Column(name = "returned")
    private boolean returned;

    @Column(name = "?emp-datedep")
    private boolean emp_datedep; // TODO Wtf is this

    public Loan() {
    }

    public Loan(Date date, Date emp_retDate, int userId, int itemId, boolean returned, boolean emp_datedep) {
        this.date = date;
        this.emp_retDate = emp_retDate;
        this.userId = userId;
        this.itemId = itemId;
        this.returned = returned;
        this.emp_datedep = emp_datedep;
    }

    public int getId() {
        return id;
    }

    public Date getDate() {
        return date;
    }

    public Date getEmp_retDate() {
        return emp_retDate;
    }

    public int getUserId() {
        return userId;
    }

    public int getItemId() {
        return itemId;
    }

    public boolean isReturned() {
        return returned;
    }

    public boolean isEmp_datedep() {
        return emp_datedep;
    }
}
