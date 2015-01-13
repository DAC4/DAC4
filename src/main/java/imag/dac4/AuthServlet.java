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
import java.util.regex.Pattern;

@WebServlet(name = "AuthServlet", urlPatterns = "/auth")
public class AuthServlet extends HttpServlet {

    private static final Pattern EMAIL_PATTERN = Pattern.compile("\\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}\\b");

    @EJB UserDao userDao;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String action = req.getParameter("action");
        switch (action.toLowerCase()) {
            case "register":
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
                break;
            default:
                req.setAttribute("error", 400);
                req.setAttribute("error_msg", "Bad Request");
                req.getRequestDispatcher("/index.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String action = req.getParameter("action");
        switch (action.toLowerCase()) {
            case "login":
                this.onConnectionRequest(req, resp);
                break;
            case "register":
                this.onRegistrationRequest(req, resp);
                break;
            default:
                req.setAttribute("error", 400);
                req.setAttribute("error_msg", "Bad Request");
                req.getRequestDispatcher("/index.jsp").forward(req, resp);
                break;
        }
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
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        } else if (!user.isRegistrationComplete()) {
            // User registration isn't complete
            req.setAttribute("error", 403);
            req.setAttribute("error_msg", "Forbidden: User registration incomplete");
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        } else {
            // User exists and password is valid
            // TODO Session
            if (isAdmin) {
                req.getRequestDispatcher("/homeAdmin.jsp").forward(req, resp);
            } else {
                req.getRequestDispatcher("/home.jsp").forward(req, resp);
            }
        }
    }

    private void onRegistrationRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String login = req.getParameter("login");
        final String password = req.getParameter("password");
        final String name = req.getParameter("name");
        final String email = req.getParameter("email");
        req.removeAttribute("login");
        req.removeAttribute("password");
        req.removeAttribute("name");
        req.removeAttribute("email");

        final User user = this.userDao.getByLogin(login);

        if (user != null) {
            // User already exists
            req.setAttribute("error", 409);
            req.setAttribute("error_msg", "Conflict: Login already used");
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        } else if (!EMAIL_PATTERN.matcher(email).matches()) {
            // Email is invalid
            req.setAttribute("error", 400);
            req.setAttribute("error_msg", "Bad Request: Email is invalid");
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        } else {
            // TODO Actually register
        }
    }
}