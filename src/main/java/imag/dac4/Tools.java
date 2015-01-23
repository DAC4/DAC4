package imag.dac4;

import imag.dac4.model.user.User;

import javax.servlet.http.HttpServletRequest;

/**
 * @author Ribesg
 */
public class Tools {

    public static User getUser(final HttpServletRequest req) {
        return (User) req.getSession().getAttribute("user");
    }

    public static boolean isConnected(final HttpServletRequest req) {
        return Tools.getUser(req) != null;
    }

    public static boolean isAdmin(final HttpServletRequest req) {
        final Boolean isAdmin = (Boolean) req.getSession().getAttribute("isAdmin");
        return isAdmin != null && isAdmin;
    }
}
