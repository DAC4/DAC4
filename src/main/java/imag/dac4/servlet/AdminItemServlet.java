package imag.dac4.servlet;

import imag.dac4.Constants;
import imag.dac4.model.item.Item;
import imag.dac4.model.item.ItemDao;
import imag.dac4.model.loan.LoanDao;
import imag.dac4.model.user.User;
import imag.dac4.model.user.UserDao;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

@WebServlet(name = "AdminItemServlet", urlPatterns = {
        "/admin/items",
        "/admin/item/approve",
        "/admin/item/remove",
})
public class AdminItemServlet extends HttpServlet {

    @EJB UserDao userDao;
    @EJB ItemDao itemDao;
    @EJB LoanDao loanDao;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String[] split = req.getRequestURI().split("/");
        final String action = split[split.length - 1];
        switch (action.toLowerCase()) {
            case "items":
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
        final String[] split = req.getRequestURI().split("/");
        final String action = split[split.length - 1];
        switch (action.toLowerCase()) {
            case "approve":
                this.onApproveItemRequest(req, resp);
                break;
            case "remove":
                this.onRemoveItemRequest(req, resp);
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
            final User owner = this.userDao.read(item.getOwnerId());
            owner.setCredits(owner.getCredits() + 1);
            this.userDao.update(owner);
            req.getSession().setAttribute("success_msg", "Successfully approved item \"" + item.getName() + '"');
            resp.sendRedirect("/admin/items");
        }
    }

    private void onRemoveItemRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String idString = req.getParameter("id");
        if (idString == null) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Missing Parameter");
            req.getRequestDispatcher("/admin/items").forward(req, resp);
            return;
        }

        final int id;
        try {
            id = Integer.parseInt(idString);
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Invalid id");
            req.getRequestDispatcher("/admin/items").forward(req, resp);
            return;
        }
        final Item item = this.itemDao.read(id);
        if (item == null) {
            // Item doesn't exist
            req.getSession().setAttribute("error", 404);
            req.getSession().setAttribute("error_msg", "Not Found: Invalid id");
            req.getRequestDispatcher("/admin/items").forward(req, resp);
        } else if (item.isApproved() && !item.isAvailable()) {
            // Item is not in the system
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Item not available");
            req.getRequestDispatcher("/admin/items").forward(req, resp);
        } else {
            this.loanDao.forgetItemHistory(id);
            this.itemDao.delete(id);
            Files.delete(Paths.get(getServletContext().getRealPath(File.separator), item.getImagePath()));
            req.getSession().setAttribute("success_msg", "Successfully removed item \"" + item.getName() + '"');
            resp.sendRedirect("/admin/items");
        }
    }
}
