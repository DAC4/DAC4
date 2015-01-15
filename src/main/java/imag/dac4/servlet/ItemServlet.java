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
                final int id;
                try {
                    id = Integer.parseInt(req.getParameter("id"));
                } catch (final NumberFormatException e) {
                    req.setAttribute("error", 400);
                    req.setAttribute("error_msg", "Bad Request: " + req.getRequestURI() + " (Unknown or missing id)");
                    req.getRequestDispatcher(Constants.JSP_ITEM).forward(req, resp);
                    return;
                }
                final Item item = this.itemDao.read(id);
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
        final String idString = req.getParameter("id");

        if (idString == null) {
            req.setAttribute("error", 400);
            req.setAttribute("error_msg", "Bad Request: " + req.getRequestURI());
            req.getRequestDispatcher(Constants.JSP_ADMIN_ITEMS).forward(req, resp);
            return;
        }

        final int id;
        try {
            id = Integer.parseInt(idString);
        } catch (final NumberFormatException e) {
            req.setAttribute("error", 400);
            req.setAttribute("error_msg", "Bad Request: " + req.getRequestURI() + " (Unknown or missing id)");
            req.getRequestDispatcher(Constants.JSP_ITEMS).forward(req, resp);
            return;
        }

        final Item item = this.itemDao.read(id);
        if (item == null || !item.isAccepted()) {
            // Item doesn't exist
            req.setAttribute("error", 404);
            req.setAttribute("error_msg", "Not Found: Invalid id");
            req.getRequestDispatcher(Constants.JSP_ITEMS).forward(req, resp);
        } else if (!item.isAvailable()) {
            // Item not available
            req.setAttribute("error", 400);
            req.setAttribute("error_msg", "Bad Request: Item already loaned");
            req.getRequestDispatcher(Constants.JSP_ITEMS).forward(req, resp);
        } else {
            // TODO Check credits
            // TODO Register item loan
            // TODO Redirect to confirmation page with max loan end date
        }
    }
}
