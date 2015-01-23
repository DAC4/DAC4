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
        "/admin/user/update-credit"
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
                    if (user.getId() != 1) {
                        pairs.put(user, this.userDao.isRemovable(user));
                    }
                }
                req.setAttribute("users", pairs.iterator());
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
            case "update-credit":
                this.onUpdateUserCredit(req, resp);
            default:
                req.getSession().setAttribute("error", 400);
                req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI());
                req.getRequestDispatcher(Constants.JSP_INDEX).forward(req, resp);
                break;
        }
    }

    private void onUpdateUserCredit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String idString = req.getParameter("id");
        final String amountString = req.getParameter("amount");

        if (idString == null || amountString == null) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Missing Parameter");
            resp.sendRedirect("/admin/users");
            return;
        }

        final int id;
        final int amount;
        try {
            id = Integer.parseInt(idString);
            amount = Integer.parseInt(amountString);
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Invalid parameter");
            resp.sendRedirect("/admin/users");
            return;
        }

        final User user = this.userDao.read(id);
        if (user == null) {
            // User doesn't exist
            req.getSession().setAttribute("error", 404);
            req.getSession().setAttribute("error_msg", "Not Found: Invalid login");
        } else if (amount < 0) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Invalid amount");
        } else {
                user.setCredits(amount);
                userDao.update(user);
                resp.sendRedirect("/admin/users");
        }
    }

    private void onApproveUserRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String idString = req.getParameter("id");
        if (idString == null) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Missing Parameter");
            resp.sendRedirect("/admin/users");
            return;
        }

        final int id;
        try {
            id = Integer.parseInt(idString);
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Invalid id");
            resp.sendRedirect("/admin/users");
            return;
        }

        final User user = this.userDao.read(id);
        if (user == null) {
            // User doesn't exist
            req.getSession().setAttribute("error", 404);
            req.getSession().setAttribute("error_msg", "Not Found: Invalid login");
        } else if (user.isApproved()) {
            // User registration is already complete
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: User registration already complete");
        } else {
            user.setApproved(true);
            this.userDao.update(user);
            req.getSession().setAttribute("success_msg", "Successfully removed user \"" + user.getName() + '"');
        }
        resp.sendRedirect("/admin/users");
    }

    private void onRemoveUserRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String idString = req.getParameter("id");
        if (idString == null) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Missing Parameter");
            resp.sendRedirect("/admin/users");
            return;
        }

        final int id;
        try {
            id = Integer.parseInt(idString);
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Invalid id");
            resp.sendRedirect("/admin/users");
            return;
        }

        if (id == 1) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Can't remove Admin");
            resp.sendRedirect("/admin/users");
            return;
        }

        final User user = this.userDao.read(id);
        if (user == null) {
            // User doesn't exist
            req.getSession().setAttribute("error", 404);
            req.getSession().setAttribute("error_msg", "Not Found: Invalid id");
        } else if (!this.userDao.isRemovable(user)) {
            // User can't be removed
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Cannot remove user with items and/or running loans");
        } else {
            this.userDao.delete(id);
            req.getSession().setAttribute("success_msg", "Successfully removed user \"" + user.getLogin() + '"');
        }
        resp.sendRedirect("/admin/users");
    }
}
