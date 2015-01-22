package imag.dac4.servlet;

import imag.dac4.Constants;
import imag.dac4.model.item.Item;
import imag.dac4.model.item.ItemDao;
import imag.dac4.model.user.User;
import imag.dac4.model.user.UserDao;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UserServlet", urlPatterns = {
        "/user/items",
        "/user/item/remove",
})
public class UserServlet extends HttpServlet {

    @EJB UserDao userDao;
    @EJB ItemDao itemDao;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final User user = (User) req.getSession().getAttribute("user");
        final String[] split = req.getRequestURI().split("/");
        final String action = split[split.length - 1];

        switch (action.toLowerCase()) {
            case "items":
                req.setAttribute("items", this.itemDao.getItems(user));
                req.getRequestDispatcher(Constants.JSP_USER_ITEMS).forward(req, resp);
                break;
            default:
                req.getSession().setAttribute("error", 400);
                req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI());
                resp.sendRedirect("/");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String[] split = req.getRequestURI().split("/");
        final String action = split[split.length - 1];
        switch (action.toLowerCase()) {
            case "remove":
                this.onItemRemoveRequest(req, resp);
            default:
                req.getSession().setAttribute("error", 400);
                req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI());
                resp.sendRedirect("/");
                break;
        }
    }

    private void onItemRemoveRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final User user = (User) req.getSession().getAttribute("user");
        int id = Integer.parseInt(req.getParameter("itemId"));
        Item item = this.itemDao.read(id);
        if (item != null) {
            // check user rights
            if (user != null && (item.getOwnerId() == user.getId())) {
                // check item status
                if (item.isAvailable()) {
                    this.itemDao.delete(id);
                    // take away 1 credit from user
                    user.setCredits(user.getCredits() - 1);
                    this.userDao.update(user);
                    resp.sendRedirect("/user/items");
                } else { // item unavailable
                    req.getSession().setAttribute("error", 400);
                    req.getSession().setAttribute("error_msg", "Bad Request: "
                            + req.getRequestURI()
                            + " (This item is currently unavailable. You cannot delete it)");
                    resp.sendRedirect("/user/items");
                }
            } else { // user rights incorrect
                req.getSession().setAttribute("error", 400);
                req.getSession().setAttribute("error_msg", "Bad Request: "
                        + req.getRequestURI()
                        + " (This item is not yours)");
                resp.sendRedirect("/");
            }
        } else { // item not found
            req.getSession().setAttribute("error", 404);
            req.getSession().setAttribute("error_msg", "Bad Request: "
                    + req.getRequestURI()
                    + " (Unknown or missing id)");
            resp.sendRedirect("/user/items");
        }
    }
}
