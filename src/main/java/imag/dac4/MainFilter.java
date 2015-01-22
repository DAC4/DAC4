package imag.dac4;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@WebFilter(filterName = "MainFilter", urlPatterns = "/")
public class MainFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain filterChain) throws IOException, ServletException {
        final HttpServletRequest httpReq = (HttpServletRequest) req;
        final String path = httpReq.getRequestURI().substring(httpReq.getContextPath().length());

        if (path.startsWith("/static")) {
            // Pass to default servlet
            filterChain.doFilter(httpReq, resp);
        } else if (path.startsWith("/admin") && !this.isAdmin(httpReq)) {
            httpReq.getSession().setAttribute("error", 403);
            httpReq.getSession().setAttribute("error_msg", "Forbidden: " + httpReq.getRequestURI());
            httpReq.getRequestDispatcher(Constants.JSP_INDEX).forward(req, resp);
        } else {
            // Pass to our front servlet
            httpReq.getRequestDispatcher("/index").forward(httpReq, resp);
        }
    }

    private boolean isAdmin(final HttpServletRequest req) {
        final Boolean isAdmin = (Boolean) req.getSession().getAttribute("isAdmin");
        return isAdmin != null && isAdmin;
    }

    @Override
    public void destroy() {
    }
}
