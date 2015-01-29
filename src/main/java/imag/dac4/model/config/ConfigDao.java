package imag.dac4.model.config;

import imag.dac4.model.Dao;

import javax.ejb.Stateless;

@Stateless
public class ConfigDao extends Dao<String, Config> {

    public ConfigDao() {
        super(Config.class);
    }

    public Integer getLockerAmount() {
        try {
            return Integer.parseInt(this.read("lockerAmount").getValue());
        } catch (final NullPointerException | NumberFormatException e) {
            return null;
        }
    }
}
