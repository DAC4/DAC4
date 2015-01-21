package imag.dac4.servlet;

import imag.dac4.Constants;
import imag.dac4.model.item.Item;
import imag.dac4.model.item.ItemDao;
import imag.dac4.model.user.User;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UserServlet", urlPatterns = {
        "/user",
        "/user/items",
        "/user/items/remove"
})
public class UserServlet extends HttpServlet{

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
                onItemRemoveRequest(req, resp);
                break;
            default:
                req.getSession().setAttribute("error", 400);
                req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI());
                resp.sendRedirect("/");
                break;
        }
    }

    private void onItemRemoveRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final User user = (User) req.getSession().getAttribute("user");
        int id = (int) req.getAttribute("itemId");
        Item item = itemDao.read(id);
        if (item != null) {
            if (item.getOwnerId() == user.getId() || this.isAdmin(req)) {
                itemDao.delete(id);
            } else {
                req.getSession().setAttribute("error", 403);
                req.getSession().setAttribute("error_msg", "Forbidden: this item is not yours.");
            }
        } else {
            req.getSession().setAttribute("error", 404);
            req.getSession().setAttribute("error_msg", "Not found: no such item");
        }
        req.getRequestDispatcher(Constants.JSP_USER_ITEMS).forward(req, resp);
    }

    private boolean isAdmin(final HttpServletRequest req) {
        final Boolean isAdmin = (Boolean) req.getSession().getAttribute("isAdmin");
        return isAdmin != null && isAdmin;
    }
}
