package imag.dac4.servlet;

import imag.dac4.Constants;
import imag.dac4.model.item.Item;
import imag.dac4.model.item.ItemDao;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AdminItemServlet", urlPatterns = {
        "/admin/item",
        "/admin/item/approve",
})
public class AdminItemServlet extends HttpServlet {

    @EJB ItemDao itemDao;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!this.isAdmin(req)) {
            req.getSession().setAttribute("error", 403);
            req.getSession().setAttribute("error_msg", "Forbidden: " + req.getRequestURI());
            req.getRequestDispatcher(Constants.JSP_INDEX).forward(req, resp);
            return;
        }

        final String[] split = req.getRequestURI().split("/");
        final String action = split[split.length - 1];
        switch (action.toLowerCase()) {
            case "item":
                req.setAttribute("items", this.itemDao.getItems());
                req.getRequestDispatcher(Constants.JSP_ADMIN_ITEMS).forward(req, resp);
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
        if (!this.isAdmin(req)) {
            req.getSession().setAttribute("error", 403);
            req.getSession().setAttribute("error_msg", "Forbidden: " + req.getRequestURI());
            req.getRequestDispatcher(Constants.JSP_INDEX).forward(req, resp);
            return;
        }

        final String[] split = req.getRequestURI().split("/");
        final String action = split[split.length - 1];
        switch (action.toLowerCase()) {
            case "approve":
                this.onApproveItemRequest(req, resp);
                break;
            default:
                req.getSession().setAttribute("error", 400);
                req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI());
                req.getRequestDispatcher(Constants.JSP_INDEX).forward(req, resp);
                break;
        }
    }

    private void onApproveItemRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String id = req.getParameter("id");

        if (id == null) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI());
            req.getRequestDispatcher(Constants.JSP_ADMIN_ITEMS).forward(req, resp);
            return;
        }

        final Item item = this.itemDao.read(Integer.parseInt(id));
        if (item == null) {
            // User doesn't exist
            req.getSession().setAttribute("error", 404);
            req.getSession().setAttribute("error_msg", "Not Found: Invalid id");
            req.getRequestDispatcher(Constants.JSP_ADMIN_ITEMS).forward(req, resp);
        } else if (item.isApproved()) {
            // User registration is already complete
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Item already accepted");
            req.getRequestDispatcher(Constants.JSP_ADMIN_ITEMS).forward(req, resp);
        } else {
            item.setApproved(true);
            this.itemDao.update(item);
            resp.sendRedirect("/admin/item");
        }
    }

    private boolean isAdmin(final HttpServletRequest req) {
        final Boolean isAdmin = (Boolean) req.getSession().getAttribute("isAdmin");
        return isAdmin != null && isAdmin;
    }
}
