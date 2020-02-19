package cn.itcast.bookstore.user.web.filter;

import cn.itcast.bookstore.user.domain.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "LoginFilter")
public class LoginFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        User user = (User) request.getSession().getAttribute("session_user");
        if (user!=null){
            chain.doFilter(req, resp);
        }else{
            request.setAttribute("msg","请登录！");
            request.getRequestDispatcher("jsps/user/login.jsp").forward(request,response);
        }

    }

    public void init(FilterConfig config) throws ServletException {

    }

}
