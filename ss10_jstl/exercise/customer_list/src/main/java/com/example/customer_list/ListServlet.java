package com.example.customer_list;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ListServlet", value = "/ListServlet")
public class ListServlet extends HttpServlet {
    private List<Customer> customerList;

    public void init() throws ServletException {
        customerList = new ArrayList<>();
        customerList.add(new Customer("1", "Lý Tiểu Long", "01/01/1999", "Hong Kong", "https://hips.hearstapps.com/hmg-prod/images/gettyimages-156478862.jpg"));
        customerList.add(new Customer("2", "Tôn Ngộ Không", "01/01/1999", "Heaven", "https://static.dw.com/image/18616853_804.jpg"));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("customers", customerList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/display_list.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
