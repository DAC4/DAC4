package imag.dac4.model;

import imag.dac4.model.user.User;
import imag.dac4.model.user.UserDao;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UserServlet", urlPatterns = {"/user"})
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Injected DAO EJB:
    @EJB UserDao userDao;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("users", userDao.getUsers());
        request.getRequestDispatcher("/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        try {
            userDao.create(new User(login, password, name, email, 50, false));
        } catch (EJBException e) {
            request.setAttribute("error", "Failed to insert new User");
        }

        // Display the list of users
        doGet(request, response);
    }

    /* TODO We can only really use GET and POST.

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long id = Long.parseLong(request.getParameter("id"));

        try {
            userDao.delete(id);
        } catch (EJBException e) {
            request.setAttribute("error", "Failed to remove user");
        }

        doGet(request, response);
    }

    */
}
