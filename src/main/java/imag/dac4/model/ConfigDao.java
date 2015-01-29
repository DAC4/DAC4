package imag.dac4.model;

/**
 * @author Ribesg
 */
public class ConfigDao extends Dao<String, String> {

    public ConfigDao() {
        super(String.class);
    }

    public Integer getLockerAmount() {
        try {
            return Integer.parseInt(this.read("lockerAmount"));
        } catch (final NumberFormatException e) {
            return null;
        }
    }
}
