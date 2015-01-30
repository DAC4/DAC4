package imag.dac4.model.config;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Entity
@Table(name = "config")
public class Config implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id")
    private String key;

    @Column(name = "value")
    private String value;

    public Config() {
    }

    public String getKey() {
        return key;
    }

    public String getValue() {
        return value;
    }

    @Override
    public String toString() {
        return "Config{" +
            "key='" + key + '\'' +
            ", value='" + value + '\'' +
            '}';
    }
}
