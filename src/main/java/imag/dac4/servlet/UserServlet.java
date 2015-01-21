package imag.dac4.servlet;

import imag.dac4.Constants;
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
        "/user/items"
})
public class UserServlet extends HttpServlet{

    @EJB ItemDao itemDao;
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final Boolean isAdminParam = (Boolean) req.getSession().getAttribute("isAdmin");
        final User user = (User) req.getSession().getAttribute("user");
        final boolean isAdmin = isAdminParam != null && isAdminParam;

        final String[] split = req.getRequestURI().split("/");
        final String action = split[split.length - 1];
        switch (action.toLowerCase()) {
            case "items":
                req.setAttribute("isAdmin", isAdmin);
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
            default:
                req.getSession().setAttribute("error", 400);
                req.getSession().setAttribute("error_msg", "Bad Request: " + req.getRequestURI());
                resp.sendRedirect("/");
                break;
        }
    }
}
