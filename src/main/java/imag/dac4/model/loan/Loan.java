package imag.dac4.model.loan;

import org.apache.commons.lang3.time.DateUtils;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;

@Entity
@Table(name = "loans")
public class Loan implements Serializable {

    private static final long serialVersionUID = 1L;

    private static final SimpleDateFormat FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "userId")
    private int userId;

    @Column(name = "itemId")
    private int itemId;

    @Column(name = "returned")
    private boolean returned;

    @Column(name = "startDate")
    private Date startDate;

    @Column(name = "endDate")
    private Date endDate;

    public Loan() {
    }

    public Loan(int userId, int itemId) {
        this.userId = userId;
        this.itemId = itemId;
        this.returned = false;
        this.startDate = new Date(System.currentTimeMillis());
        this.endDate = null;
    }

    public String getStartDateAsString() {
        return FORMAT.format(startDate);
    }

    public String getEndDateAsString() {
        return FORMAT.format(endDate);
    }

    public String getMaxEndDateAsString(final int maxLoanDuration) {
        return FORMAT.format(DateUtils.addDays(startDate, maxLoanDuration));
    }

    public boolean shouldHaveBeenReturned(final int maxLoanDuration) {
        return DateUtils.addDays(startDate, maxLoanDuration).before(new Date(System.currentTimeMillis()));
    }

    public boolean shouldReturnTomorrow(final int maxLoanDuration) {
        final java.util.Date maxReturnDate = DateUtils.addDays(startDate, maxLoanDuration);

        // Today + one day
        final Calendar c1 = Calendar.getInstance();
        c1.roll(Calendar.DATE, true);

        // Last day to bring back the item
        final Calendar c2 = Calendar.getInstance();
        c2.setTime(DateUtils.addDays(startDate, maxLoanDuration));

        // Check that they represent the same day
        return c1.get(Calendar.ERA) == c2.get(Calendar.ERA)
                && c1.get(Calendar.YEAR) == c2.get(Calendar.YEAR)
                && c1.get(Calendar.DAY_OF_YEAR) == c2.get(Calendar.DAY_OF_YEAR);
    }

    public int getId() {
        return id;
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

    public Date getStartDate() {
        return startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public void setReturned(boolean returned) {
        this.returned = returned;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
}
