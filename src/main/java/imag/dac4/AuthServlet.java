package imag.dac4;

import imag.dac4.model.user.User;
import imag.dac4.model.user.UserDao;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AuthServlet", urlPatterns = "/auth")
public class AuthServlet extends HttpServlet {

    private static final String EMAIL_PATTERN = "/\\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}\\b/i";

    @EJB UserDao userDao;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String action = req.getParameter("action");
        if (action != null) {
            switch (action.toLowerCase()) {
                case "register":
                    req.getRequestDispatcher(Constants.JSP_AUTH_REGISTER).forward(req, resp);
                    return;
                case "logout":
                    req.getSession().removeAttribute("user");
                    req.getSession().removeAttribute("isAdmin");
                    req.getRequestDispatcher(Constants.JSP_INDEX).forward(req, resp);
                default:
                    break;
            }
        }
        req.setAttribute("error", 400);
        req.setAttribute("error_msg", "Bad Request");
        req.getRequestDispatcher(Constants.JSP_INDEX).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String action = req.getParameter("action");
        if (action != null) {
            switch (action.toLowerCase()) {
                case "login":
                    this.onConnectionRequest(req, resp);
                    return;
                case "register":
                    this.onRegistrationRequest(req, resp);
                    return;
                default:
                    req.setAttribute("error", 400);
                    req.setAttribute("error_msg", "Bad Request: Unknown action '" + action + "'");
                    req.getRequestDispatcher(Constants.JSP_INDEX).forward(req, resp);
                    break;
            }
        }
        req.setAttribute("error", 400);
        req.setAttribute("error_msg", "Bad Request");
        req.getRequestDispatcher(Constants.JSP_INDEX).forward(req, resp);
    }

    private void onConnectionRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String login = req.getParameter("login");
        final String password = req.getParameter("password");
        req.removeAttribute("login");
        req.removeAttribute("password");

        final User user = this.userDao.getByLogin(login);
        final boolean isAdmin = user != null && user.getId() == User.ADMIN_ID;

        req.setAttribute("user", user);
        req.setAttribute("admin", isAdmin);
        if (user == null || !user.getPassword().equals(password)) {
            // User doesn't exist, password is invalid
            req.setAttribute("error", 401);
            req.setAttribute("error_msg", "Unauthorized: Invalid login/password");
            req.getRequestDispatcher(Constants.JSP_INDEX).forward(req, resp);
        } else if (!user.isRegistrationComplete()) {
            // User registration isn't complete
            req.setAttribute("error", 403);
            req.setAttribute("error_msg", "Forbidden: User registration incomplete");
            req.getRequestDispatcher(Constants.JSP_INDEX).forward(req, resp);
        } else {
            // User exists and password is valid
            req.getSession().setAttribute("user", user);
            req.getSession().setAttribute("isAdmin", isAdmin);
            req.setAttribute("login", user.getLogin());
            req.setAttribute("name", user.getName());
            req.setAttribute("email", user.getEmail());
            if (isAdmin) {
                req.getRequestDispatcher(Constants.JSP_ADMIN_HOME).forward(req, resp);
            } else {
                req.getRequestDispatcher(Constants.JSP_USER_HOME).forward(req, resp);
            }
        }
    }

    private void onRegistrationRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String login = req.getParameter("login");
        final String password = req.getParameter("password");
        final String passwordConfirm = req.getParameter("passwordConfirm");
        final String name = req.getParameter("name");
        final String email = req.getParameter("email");
        req.removeAttribute("login");
        req.removeAttribute("password");
        req.removeAttribute("passwordConfirm");
        req.removeAttribute("name");
        req.removeAttribute("email");

        User user = this.userDao.getByLogin(login);

        if (user != null) {
            // User already exists
            req.setAttribute("error", 409);
            req.setAttribute("error_msg", "Conflict: Login already used");
            req.getRequestDispatcher(Constants.JSP_AUTH_REGISTER).forward(req, resp);
        } else if (!password.equals(passwordConfirm)) {
            // Passwords don't match
            req.setAttribute("error", 400);
            req.setAttribute("error_msg", "Bad Request: Passwords don't match");
            req.getRequestDispatcher(Constants.JSP_AUTH_REGISTER).forward(req, resp);
        } else if (!email.matches(EMAIL_PATTERN)) {
            // Email is invalid
            req.setAttribute("error", 400);
            req.setAttribute("error_msg", "Bad Request: Email is invalid");
            req.getRequestDispatcher(Constants.JSP_AUTH_REGISTER).forward(req, resp);
        } else {
            user = new User(login, password, name, email);
            this.userDao.create(user);
            req.setAttribute("login", login);
            req.setAttribute("name", name);
            req.getRequestDispatcher(Constants.JSP_AUTH_AWAITING_VALIDATION).forward(req, resp);
        }
    }
}
