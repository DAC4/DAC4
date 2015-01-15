package imag.dac4.servlet;

import imag.dac4.Constants;
import imag.dac4.model.user.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "MainServlet", urlPatterns = "/index")
public class MainServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final User user = (User) req.getSession().getAttribute("user");
        if (user != null) {
            req.setAttribute("user", user);
            if ((Boolean) req.getSession().getAttribute("isAdmin")) {
                req.getRequestDispatcher(Constants.JSP_ADMIN_HOME).forward(req, resp);
            } else {
                req.getRequestDispatcher(Constants.JSP_USER_HOME).forward(req, resp);
            }
        } else {
            req.setAttribute("showLoginForm", true);
            req.getRequestDispatcher(Constants.JSP_INDEX).forward(req, resp);
        }
    }
}
