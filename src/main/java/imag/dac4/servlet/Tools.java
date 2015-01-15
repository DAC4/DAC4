package imag.dac4.servlet;

import imag.dac4.model.user.User;

import javax.servlet.http.HttpServletRequest;

public final class Tools {

    public static void setHeaderAttributes(HttpServletRequest req) {
        req.removeAttribute("showLoginForm");
        req.removeAttribute("user");
        final User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            req.setAttribute("showLoginForm", true);
        } else {
            req.setAttribute("user", user);
        }
    }

    private Tools() {
    }
}
