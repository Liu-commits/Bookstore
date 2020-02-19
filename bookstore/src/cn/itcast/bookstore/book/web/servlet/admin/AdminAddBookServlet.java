package cn.itcast.bookstore.book.web.servlet.admin;

import cn.itcast.bookstore.book.domain.Book;
import cn.itcast.bookstore.book.service.BookService;
import cn.itcast.bookstore.category.domain.Category;
import cn.itcast.bookstore.category.service.CategoryService;
import cn.itcast.commons.CommonUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;
import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AdminAddBookServlet")
public class AdminAddBookServlet extends HttpServlet {
    private BookService bookService = new BookService();
    private CategoryService categoryService = new CategoryService();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        //上传三步
        DiskFileItemFactory factory = new DiskFileItemFactory(15*1024,new File("F:/f/temp"));
        ServletFileUpload sfu = new ServletFileUpload(factory);
        //设置单个文件上传大小15kb
        sfu.setFileSizeMax(20 * 1024);
        request.setAttribute("categoryList",categoryService.findAll());
        try {
            /*
            把fileItemList中的数据封装到book中
             */
            List<FileItem> fileItemList= sfu.parseRequest(request);
            Map<String,String> map = new HashMap<String, String>();
            for (FileItem fileItem:fileItemList ) {
                if (fileItem.isFormField()) {
                    map.put(fileItem.getFieldName(), fileItem.getString("UTF-8"));
                }
            }
                Book book = CommonUtils.toBean(map,Book.class);
                //为book指定bid
                book.setBid(CommonUtils.uuid());
                Category category = CommonUtils.toBean(map,Category.class);
                book.setCategory(category);

                /*
                保存上传的文件
                 */

                String savepath = this.getServletContext().getRealPath("/book_img");
                String filename = CommonUtils.uuid()+"_"+fileItemList.get(1).getName();

                File destFile = new File(savepath,filename);
                //把文件写入上传目录中
                fileItemList.get(1).write(destFile);

            Image image = new ImageIcon(destFile.getAbsolutePath()).getImage();
            if (image.getWidth(null)>200 || image.getHeight(null)>200){
                destFile.delete();
                request.setAttribute("msg","您上传的文件超出了200*200！");
                request.setAttribute("categoryList",categoryService.findAll());
                request.getRequestDispatcher("/adminjsps/admin/book/add.jsp").forward(request,response);

                return;


            }
            //设置book对象的image
                book.setImage("book_img/"+filename);

                /*
                校验文件的扩展名
                 */
                if (!filename.toLowerCase().endsWith("jpg")){
                    request.setAttribute("msg","文件名后缀必须以”jpg“结尾！");
                    request.setAttribute("categoryList",categoryService.findAll());
                    request.getRequestDispatcher("/adminjsps/admin/book/add.jsp").forward(request,response);

                    return;
                }
                //使用bookservice完成保存
                bookService.add(book);
                request.getRequestDispatcher("/admin/AdminBookServlet?method=findAll").forward(request,response);


        } catch (Exception e) {
            //文件超出限制大小异常
            if (e instanceof FileUploadBase.FileSizeLimitExceededException){
                request.setAttribute("msg","您上传的文件大小超出了限制（15KB）！");
                request.getRequestDispatcher("/adminjsps/admin/book/add.jsp").forward(request,response);
            }else if(e instanceof FileUploadBase.IOFileUploadException){
                request.setAttribute("msg","系统找不到指定路径！"+e.getMessage());
                request.getRequestDispatcher("/adminjsps/admin/book/add.jsp").forward(request,response);
            }else{
                request.setAttribute("msg","未知错误！"+e.getMessage());
                request.getRequestDispatcher("/adminjsps/admin/book/add.jsp").forward(request,response);
            }
        }


        }


}
