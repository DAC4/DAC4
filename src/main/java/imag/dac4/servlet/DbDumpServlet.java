package imag.dac4.servlet;

import imag.dac4.Constants;
import imag.dac4.model.item.ItemDao;
import imag.dac4.model.loan.LoanDao;
import imag.dac4.model.user.UserDao;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DbDumpServlet", urlPatterns = "/db")
public class DbDumpServlet extends HttpServlet {

    @EJB UserDao userDao;
    @EJB ItemDao itemDao;
    @EJB LoanDao loanDao;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Tools.setHeaderAttributes(req);
        req.setAttribute("users", userDao.getUsers());
        req.setAttribute("items", itemDao.getItems());
        req.setAttribute("loans", loanDao.getLoans());
        req.getRequestDispatcher(Constants.JSP_DEBUG).forward(req, resp);
    }
}
