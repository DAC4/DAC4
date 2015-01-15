package imag.dac4;

import imag.dac4.model.item.Item;
import imag.dac4.model.item.ItemDao;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ItemServlet", urlPatterns = {
        "/item",
        "/item/loan",
        "/items",
})
public class ItemServlet extends HttpServlet {

    @EJB ItemDao itemDao;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final Boolean isAdminParam = (Boolean) req.getSession().getAttribute("isAdmin");
        final boolean isAdmin = isAdminParam != null && isAdminParam;

        final String[] split = req.getRequestURI().split("/");
        final String action = split[split.length - 1];
        switch (action.toLowerCase()) {
            case "item":
                final Item item = this.itemDao.read(Integer.parseInt(req.getParameter("id")));
                if (item == null || !item.isAccepted() && !isAdmin) {
                    req.setAttribute("error", 400);
                    req.setAttribute("error_msg", "Bad Request: " + req.getRequestURI() + " (Unknown or missing id)");
                } else {
                    req.setAttribute("item", item);
                }
                req.getRequestDispatcher(Constants.JSP_ITEM).forward(req, resp);
                break;
            case "items":
                req.setAttribute("isAdmin", isAdmin);
                req.setAttribute("items", this.itemDao.getItems());
                req.getRequestDispatcher(Constants.JSP_ITEMS).forward(req, resp);
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
        // TODO
        final String[] split = req.getRequestURI().split("/");
        final String action = split[split.length - 1];
        switch (action.toLowerCase()) {
            case "loan":
                this.onLoanItemRequest(req, resp);
                break;
            default:
                req.setAttribute("error", 400);
                req.setAttribute("error_msg", "Bad Request: " + req.getRequestURI());
                req.getRequestDispatcher(Constants.JSP_INDEX).forward(req, resp);
                break;
        }
    }

    private void onLoanItemRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /* TODO
        final String id = req.getParameter("id");
        req.removeAttribute("id");

        if (id == null) {
            req.setAttribute("error", 400);
            req.setAttribute("error_msg", "Bad Request: " + req.getRequestURI());
            req.getRequestDispatcher(Constants.JSP_ADMIN_ITEMS).forward(req, resp);
            return;
        }

        final Item item = this.itemDao.read(Integer.parseInt(id));
        if (item == null) {
            // User doesn't exist
            req.setAttribute("error", 404);
            req.setAttribute("error_msg", "Not Found: Invalid id");
            req.getRequestDispatcher(Constants.JSP_ADMIN_ITEMS).forward(req, resp);
        } else if (item.isAccepted()) {
            // User registration is already complete
            req.setAttribute("error", 400);
            req.setAttribute("error_msg", "Bad Request: Item already accepted");
            req.getRequestDispatcher(Constants.JSP_ADMIN_ITEMS).forward(req, resp);
        } else {
            item.setAccepted(true);
            this.itemDao.update(item);
            resp.sendRedirect("/admin/item");
        }
        */
    }
}
