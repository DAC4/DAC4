package imag.dac4.servlet;

import imag.dac4.Constants;
import imag.dac4.model.user.User;
import imag.dac4.model.user.UserDao;
import imag.dac4.util.pairlist.PairList;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminUserServlet", urlPatterns = {
        "/admin/users",
        "/admin/user/approve",
        "/admin/user/remove",
})
public class AdminUserServlet extends HttpServlet {

    @EJB UserDao userDao;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String[] split = req.getRequestURI().split("/");
        final String action = split[split.length - 1];
        switch (action.toLowerCase()) {
            case "users":
                // TODO: Not Optimal AT ALL (but admin)
                final List<User> users = this.userDao.getUsers();
                final PairList<User, Boolean> pairs = new PairList<>();
                for (User user : users) {
                    pairs.put(user, this.userDao.isRemovable(user));
                }
                req.setAttribute("users", pairs);
                req.getRequestDispatcher(Constants.JSP_ADMIN_USERS).forward(req, resp);
                break;
            default:
                req.getSession().setAttribute("error", 400);
                req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI());
                req.getRequestDispatcher(Constants.JSP_INDEX).forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String[] split = req.getRequestURI().split("/");
        final String action = split[split.length - 1];
        switch (action.toLowerCase()) {
            case "approve":
                this.onApproveUserRequest(req, resp);
                break;
            case "remove":
                this.onRemoveUserRequest(req, resp);
                break;
            default:
                req.getSession().setAttribute("error", 400);
                req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI());
                req.getRequestDispatcher(Constants.JSP_INDEX).forward(req, resp);
                break;
        }
    }

    private void onApproveUserRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String login = req.getParameter("login");

        if (login == null) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI());
            req.getRequestDispatcher(Constants.JSP_ADMIN_USERS).forward(req, resp);
            return;
        }

        final User user = this.userDao.getByLogin(login);
        if (user == null) {
            // User doesn't exist
            req.getSession().setAttribute("error", 404);
            req.getSession().setAttribute("error_msg", "Not Found: Invalid login");
            req.getRequestDispatcher(Constants.JSP_ADMIN_USERS).forward(req, resp);
        } else if (user.isApproved()) {
            // User registration is already complete
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: User registration already complete");
            req.getRequestDispatcher(Constants.JSP_ADMIN_USERS).forward(req, resp);
        } else {
            user.setApproved(true);
            this.userDao.update(user);
            req.getSession().setAttribute("success_msg", "Successfully removed user \"" + user.getName() + '"');
            resp.sendRedirect("/admin/users");
        }
    }

    private void onRemoveUserRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // TODO
        resp.sendRedirect("/admin/users");
    }
}
