package imag.dac4.model.item;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "items")
public class Item implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "ownerId")
    private int ownerId;

    @Column(name = "name")
    private String name;

    @Column(name = "imagePath")
    private String imagePath;

    @Column(name = "description")
    private String description;

    @Column(name = "availability")
    private boolean availability;

    @Column(name = "lockerNum")
    private int lockerNum;

    @Column(name = "maxLoanDuration")
    private int maxLoanDuration;

    @Column(name = "approved")
    private boolean approved;

    @Column(name = "bookerId")
    private Integer bookerId;

    public Item() {
    }

    public Item(int ownerId, String name, String imagePath, String description, int lockerNum, int maxLoanDuration) {
        this.ownerId = ownerId;
        this.name = name;
        this.imagePath = imagePath;
        this.description = description;
        this.availability = true;
        this.lockerNum = lockerNum;
        this.maxLoanDuration = maxLoanDuration;
        this.approved = false;
        this.bookerId = null;
    }

    public int getId() {
        return id;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public String getName() {
        return name;
    }

    public String getImagePath() {
        return imagePath;
    }

    public String getDescription() {
        return description;
    }

    public boolean isAvailable() {
        return availability;
    }

    public int getLockerNum() {
        return lockerNum;
    }

    public int getMaxLoanDuration() {
        return maxLoanDuration;
    }

    public boolean isApproved() {
        return approved;
    }

    public Integer getBookerId() {
        return bookerId;
    }

    public boolean isBooked() {
        return this.bookerId != null;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setImagePath(String imageId) {
        this.imagePath = imageId;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setAvailable(boolean availability) {
        this.availability = availability;
    }

    public void setLockerNum(int lockerNum) {
        this.lockerNum = lockerNum;
    }

    public void setMaxLoanDuration(int maxLoanDuration) {
        this.maxLoanDuration = maxLoanDuration;
    }

    public void setApproved(boolean accepted) {
        this.approved = accepted;
    }

    public void setBookerId(Integer bookerId) {
        this.bookerId = bookerId;
    }
}
