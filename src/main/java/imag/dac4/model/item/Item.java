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

    @Column(name = "imageId")
    private String imageId;

    @Column(name = "description")
    private String description;

    @Column(name = "availability")
    private boolean availability;

    @Column(name = "lockerNum")
    private int lockerNum;

    @Column(name = "maxLoanDuration")
    private int maxLoanDuration;

    @Column(name = "accepted")
    private boolean accepted;

    public Item() {
    }

    public Item(int ownerId, String name, String imageId, String description, boolean availability, int lockerNum, int maxLoanDuration, boolean accepted) {
        this.ownerId = ownerId;
        this.name = name;
        this.imageId = imageId;
        this.description = description;
        this.availability = availability;
        this.lockerNum = lockerNum;
        this.maxLoanDuration = maxLoanDuration;
        this.accepted = accepted;
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

    public String getImageId() {
        return imageId;
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

    public boolean isAccepted() {
        return accepted;
    }
}
