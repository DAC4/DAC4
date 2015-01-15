package imag.dac4.servlet;

import imag.dac4.Constants;
import imag.dac4.model.user.User;
import imag.dac4.model.user.UserDao;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AuthServlet", urlPatterns = {
        "/auth/register",
        "/auth/login",
        "/auth/logout",
        "/auth/awaiting-validation"
})
public class AuthServlet extends HttpServlet {

    @EJB UserDao userDao;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Tools.setHeaderAttributes(req);
        final String[] split = req.getRequestURI().split("/");
        final String action = split[split.length - 1];
        switch (action.toLowerCase()) {
            case "register":
                req.getRequestDispatcher(Constants.JSP_AUTH_REGISTER).forward(req, resp);
                break;
            case "login":
                resp.sendRedirect("/");
                break;
            case "logout":
                req.getSession().removeAttribute("user");
                req.getSession().removeAttribute("isAdmin");
                Tools.setHeaderAttributes(req);
                resp.sendRedirect("/");
                break;
            case "awaiting-validation":
                req.getRequestDispatcher(Constants.JSP_AUTH_AWAITING_VALIDATION).forward(req, resp);
                break;
            default:
                req.setAttribute("error", 400);
                req.setAttribute("error_msg", "Bad Request: " + req.getRequestURI());
                req.getRequestDispatcher(Constants.JSP_INDEX).forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Tools.setHeaderAttributes(req);
        final String[] split = req.getRequestURI().split("/");
        final String action = split[split.length - 1];
        switch (action.toLowerCase()) {
            case "login":
                this.onConnectionRequest(req, resp);
                break;
            case "register":
                this.onRegistrationRequest(req, resp);
                break;
            default:
                req.setAttribute("error", 400);
                req.setAttribute("error_msg", "Bad Request: " + req.getRequestURI());
                req.getRequestDispatcher(Constants.JSP_INDEX).forward(req, resp);
                break;
        }
    }

    private void onConnectionRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String login = req.getParameter("login");
        final String password = req.getParameter("password");
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
        } else if (!user.isApproved()) {
            // User registration isn't complete
            req.setAttribute("error", 403);
            req.setAttribute("error_msg", "Forbidden: User registration incomplete");
            req.getRequestDispatcher(Constants.JSP_INDEX).forward(req, resp);
        } else {
            // User exists and password is valid
            req.getSession().setAttribute("user", user);
            req.getSession().setAttribute("isAdmin", isAdmin);
            Tools.setHeaderAttributes(req);
            resp.sendRedirect("/");
        }
    }

    private void onRegistrationRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String login = req.getParameter("login");
        final String password = req.getParameter("password");
        final String passwordConfirm = req.getParameter("passwordConfirm");
        final String name = req.getParameter("name");
        final String email = req.getParameter("email");
        req.removeAttribute("password");
        req.removeAttribute("passwordConfirm");

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
        } else if (!Constants.EMAIL_PATTERN.matcher(email).matches()) {
            // Email is invalid
            req.setAttribute("error", 400);
            req.setAttribute("error_msg", "Bad Request: Email is invalid");
            req.getRequestDispatcher(Constants.JSP_AUTH_REGISTER).forward(req, resp);
        } else {
            user = new User(login, password, name, email);
            this.userDao.create(user);
            resp.sendRedirect("/auth/awaiting-validation");
        }
    }
}
