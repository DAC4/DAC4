package imag.dac4.model.user;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "users")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    public static final int ADMIN_ID = 1;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "login")
    private String login;

    @Column(name = "password")
    private String password;

    @Column(name = "name")
    private String name;

    @Column(name = "email")
    private String email;

    @Column(name = "credits")
    private int credits;

    @Column(name = "registrationComplete")
    private boolean registrationComplete;

    public User() {
    }

    public User(String login, String password, String name, String email, int credits, boolean registrationComplete) {
        this.login = login;
        this.password = password;
        this.name = name;
        this.email = email;
        this.credits = credits;
        this.registrationComplete = registrationComplete;
    }

    public int getId() {
        return id;
    }

    public String getLogin() {
        return login;
    }

    public String getPassword() {
        return password;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public int getCredits() {
        return credits;
    }

    public boolean isRegistrationComplete() {
        return registrationComplete;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", login='" + login + '\'' +
                ", password='" + password + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", credits=" + credits +
                ", registrationComplete=" + registrationComplete +
                '}';
    }
}