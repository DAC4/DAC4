package imag.dac.dac4;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "guests")
public class Guest implements Serializable {
    private static final long serialVersionUID = 1L;

    // Persistent Fields:
    @Id
    @GeneratedValue
    @Column(name = "id")
    Long id;

    @Column(name = "name")
    private String name;

    // Constructors:
    public Guest() {
    }

    public Guest(String name) {
        this.name = name;
    }

    // String Representation:
    @Override
    public String toString() {
        return name;
    }
}
