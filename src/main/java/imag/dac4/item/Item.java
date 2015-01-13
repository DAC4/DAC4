package imag.dac4.item;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "items")
public class Item implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "imageId")
    private String imageId;

    @Column(name = "description")
    private String description;

    @Column(name = "?object-availability")
    private String object_availability; // TODO Wtf is this

    @Column(name = "?object-depDate")
    private Date object_depDate; // TODO Wtf is this

    @Column(name = "?object-disp")
    private boolean object_disp; // TODO Wtf is this

    @Column(name = "lockerNum")
    private int lockerNum;

    @Column(name = "?object-dureemax")
    private boolean object_dureemax; // TODO Wtf is this

    @Column(name = "?object-accepted")
    private boolean object_accepted; // TODO Wtf is this

    public Item() {
    }

    public Item(String name, String imageId, String description, String object_availability, Date object_depDate, boolean object_disp, int lockerNum, boolean object_dureemax, boolean object_accepted) {
        this.name = name;
        this.imageId = imageId;
        this.description = description;
        this.object_availability = object_availability;
        this.object_depDate = object_depDate;
        this.object_disp = object_disp;
        this.lockerNum = lockerNum;
        this.object_dureemax = object_dureemax;
        this.object_accepted = object_accepted;
    }

    public int getId() {
        return id;
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

    public String getObject_availability() {
        return object_availability;
    }

    public Date getObject_depDate() {
        return object_depDate;
    }

    public boolean isObject_disp() {
        return object_disp;
    }

    public int getLockerNum() {
        return lockerNum;
    }

    public boolean isObject_dureemax() {
        return object_dureemax;
    }

    public boolean isObject_accepted() {
        return object_accepted;
    }
}
