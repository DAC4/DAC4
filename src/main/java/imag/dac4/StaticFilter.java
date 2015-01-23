package imag.dac4;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@WebFilter(filterName = "StaticFilter", urlPatterns = "/")
public class StaticFilter implements Filter {

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
        } else {
            // Pass to our front servlet
            httpReq.getRequestDispatcher("/index").forward(httpReq, resp);
        }
    }

    @Override
    public void destroy() {
    }
}
