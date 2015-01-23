package imag.dac4;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "MainFilter", urlPatterns = "/*")
public class MainFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain filterChain) throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        final HttpServletRequest httpReq = (HttpServletRequest) req;
        final HttpServletResponse httpResp = (HttpServletResponse) resp;
        final String path = httpReq.getRequestURI().substring(httpReq.getContextPath().length());

        if (path.startsWith("/static")) {
            filterChain.doFilter(req, resp);
        } else if (!path.equals("/")) {
            if (!path.equals("/auth/login") && !Tools.isConnected(httpReq)) {
                httpReq.getSession().setAttribute("error", 403);
                httpReq.getSession().setAttribute("error_msg", "Forbidden: Please login");
                httpResp.sendRedirect("/");
            } else if (path.startsWith("/admin") && !Tools.isAdmin(httpReq)) {
                httpReq.getSession().setAttribute("error", 403);
                httpReq.getSession().setAttribute("error_msg", "Forbidden: Reserved to administrator");
                httpResp.sendRedirect("/");
            } else {
                filterChain.doFilter(req, resp);
            }
        } else {
            httpReq.getRequestDispatcher("/index").forward(httpReq, resp);
        }
    }

    @Override
    public void destroy() {
    }
}
