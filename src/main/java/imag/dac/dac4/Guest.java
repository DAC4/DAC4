package imag.dac.dac4;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.io.Serializable;

@Entity
public class Guest implements Serializable {
    private static final long serialVersionUID = 1L;

    // Persistent Fields:
    @Id
    @GeneratedValue
    Long id;
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
