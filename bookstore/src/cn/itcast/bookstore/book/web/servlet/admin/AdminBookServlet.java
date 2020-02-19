package cn.itcast.bookstore.book.web.servlet.admin;

import cn.itcast.bookstore.book.domain.Book;
import cn.itcast.bookstore.book.service.BookService;
import cn.itcast.bookstore.category.domain.Category;
import cn.itcast.bookstore.category.service.CategoryService;
import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "AdminBookServlet")
public class AdminBookServlet extends BaseServlet {
    private BookService bookService = new BookService();
     private CategoryService categoryService = new CategoryService();
    public String findAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("bookList",bookService.findAll());
        return "f:/adminjsps/admin/book/list.jsp";
    }

    public String load(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bid = request.getParameter("bid");
        request.setAttribute("book",bookService.load(bid));
        request.setAttribute("categoryList",categoryService.findAll());
        return "f:/adminjsps/admin/book/desc.jsp";
    }


    /*
    添加图书准备
     */
    public String addPre(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setAttribute("categoryList",categoryService.findAll());
        return "f:/adminjsps/admin/book/add.jsp";
    }

    /*
    管理员后台删除图书
     */


    public String del(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String bid = request.getParameter("bid");
        bookService.delete(bid);
        return findAll(request,response);
    }
    /*
    管理员后台编辑图书
     */
    public String edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        Book book = CommonUtils.toBean(request.getParameterMap(), Book.class);
        String cid = request.getParameter("cid");
        Category category = categoryService.editPre(cid);
        System.out.println(book+"----"+category);
        book.setCategory(category);
        bookService.edit(book);

        return findAll(request,response);
    }
}
