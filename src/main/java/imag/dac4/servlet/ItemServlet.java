package imag.dac4.servlet;

import imag.dac4.Constants;
import imag.dac4.model.item.Item;
import imag.dac4.model.item.ItemDao;
import imag.dac4.model.loan.Loan;
import imag.dac4.model.loan.LoanDao;
import imag.dac4.model.user.User;
import imag.dac4.model.user.UserDao;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ItemServlet", urlPatterns = {
        "/item",
        "/item/borrow",
        "/item/register",
        "/item/awaiting-validation",
        "/items",
})
public class ItemServlet extends HttpServlet {

    @EJB ItemDao itemDao;
    @EJB LoanDao loanDao;
    @EJB UserDao userDao;

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
                    req.getSession().setAttribute("error", 400);
                    req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI() + " (Unknown or missing id)");
                    req.getRequestDispatcher(Constants.JSP_ITEM).forward(req, resp);
                    return;
                }
                final Item item = this.itemDao.read(id);
                if (item == null || !item.isApproved() && !isAdmin) {
                    req.getSession().setAttribute("error", 400);
                    req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI() + " (Unknown or missing id)");
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
            case "register":
                req.getRequestDispatcher(Constants.JSP_ITEM_REGISTER).forward(req, resp);
                break;
            case "awaiting-validation":
                req.getRequestDispatcher(Constants.JSP_ITEM_AWAITING_VALIDATION).forward(req, resp);
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
            case "borrow":
                this.onBorrowItemRequest(req, resp);
                break;
            case "register":
                this.onItemRegistrationRequest(req, resp);
                break;
            default:
                req.getSession().setAttribute("error", 400);
                req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI());
                resp.sendRedirect("/");
                break;
        }
    }

    private void onBorrowItemRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String idString = req.getParameter("id");

        if (idString == null) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Missing parameter");
            resp.sendRedirect("/");
            return;
        }

        final int id;
        try {
            id = Integer.parseInt(idString);
        } catch (final NumberFormatException e) {
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI() + " (Unknown or missing id)");
            resp.sendRedirect("/");
            return;
        }

        final Item item = this.itemDao.read(id);
        if (item == null || !item.isApproved()) {
            // Item doesn't exist
            req.getSession().setAttribute("error", 404);
            req.getSession().setAttribute("error_msg", "Not Found: Invalid id");
            resp.sendRedirect("/items");
        } else if (!item.isAvailable()) {
            // Item not available
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Item already borrowed");
            resp.sendRedirect("/items");
        } else {
            final User user = (User) req.getSession().getAttribute("user");
            if (user == null) {
                // Not logged in
                req.getSession().setAttribute("error", 403);
                req.getSession().setAttribute("error_msg", "Forbidden: " + req.getRequestURI());
                resp.sendRedirect("/");
            } else if (user.getCredits() <= 0) {
                // Not enough credits
                req.getSession().setAttribute("error", 403);
                req.getSession().setAttribute("error_msg", "Forbidden: Not enough credits");
                resp.sendRedirect("/items");
            } else {
                // item is not available anymore
                item.setAvailable(false);
                this.itemDao.update(item);
                // user spends 1 credit
                user.setCredits(user.getCredits() - 1);
                this.userDao.update(user);
                this.loanDao.create(new Loan(user.getId(), item.getId()));
                resp.sendRedirect("/items");
            }
        }
    }

    private void onItemRegistrationRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String name = req.getParameter("name");
        final String description = req.getParameter("description");
        final String lockerNumString = req.getParameter("lockerNum");
        final String maxLoanDurationString = req.getParameter("maxLoanDuration");

        final User user = (User) req.getSession().getAttribute("user");

        if (user == null) {
            // Not logged in
            req.getSession().setAttribute("error", 403);
            req.getSession().setAttribute("error_msg", "Forbidden: " + req.getRequestURI());
            resp.sendRedirect("/");
        } else if (name == null || description == null || lockerNumString == null || maxLoanDurationString == null) {
            // Missing parameter
            req.getSession().setAttribute("error", 400);
            req.getSession().setAttribute("error_msg", "Bad Request: Missing parameter");
            resp.sendRedirect("/item/register");
        } else {
            final int lockerNum, maxLoanDuration;
            try {
                lockerNum = Integer.parseInt(lockerNumString);
                maxLoanDuration = Integer.parseInt(maxLoanDurationString);
                if (lockerNum < Constants.LOCKER_NUM_MIN ||
                        lockerNum > Constants.LOCKER_NUM_MAX ||
                        maxLoanDuration < Constants.MAX_LOAN_DURATION_MIN) {
                    throw new IllegalArgumentException();
                }
            } catch (final IllegalArgumentException e) {
                // Invalid parameter type
                req.getSession().setAttribute("error", 400);
                req.getSession().setAttribute("error_msg", "Bad Request: Invalid parameter type");
                resp.sendRedirect("/item/register");
                return;
            }
            final Item item = new Item(user.getId(), name, null /* TODO */, description, lockerNum, maxLoanDuration);
            this.itemDao.create(item);
            resp.sendRedirect("/item/awaiting-validation");
        }
    }
}
