package imag.dac.dac4;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Enumeration;

@WebServlet(name = "MyServlet", urlPatterns = "/")
public class MyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        StringBuilder builder = new StringBuilder();
        Enumeration attributeNames = req.getAttributeNames();
        if (attributeNames.hasMoreElements()) {
            while (attributeNames.hasMoreElements()) {
                String name = (String) attributeNames.nextElement();
                builder.append(name).append('=').append(req.getAttribute(name));
                if (attributeNames.hasMoreElements()) {
                    builder.append(',');
                }
            }
        } else {
            builder.append("kek");
        }
        req.setAttribute("text", builder.toString());
        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }
}
