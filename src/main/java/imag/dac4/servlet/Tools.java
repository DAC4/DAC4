package imag.dac4.servlet;

import imag.dac4.model.user.User;

import javax.servlet.http.HttpSession;

public final class Tools {

    public static void updateSessionAttributes(HttpSession session) {
        final User user = (User) session.getAttribute("user");
        final Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (user == null) {
            session.setAttribute("showLoginForm", true);
            if (isAdmin != null && isAdmin) {
                session.setAttribute("menu-config", "admin");
            } else {
                session.setAttribute("menu-config", "user");
            }
        } else {
            session.removeAttribute("showLoginForm");
            session.setAttribute("menu-config", "anon");
        }
    }

    private Tools() {
    }
}
