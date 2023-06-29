package com.example.discount;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "DiscountServlet", value = "/DiscountServlet")
public class DiscountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String description = request.getParameter("description");
        int price = Integer.parseInt(request.getParameter("price"));
        float percent = Float.parseFloat(request.getParameter("percent"));

        float result = (price * (1 + (percent * 1 / 100)));

        PrintWriter writer = response.getWriter();
        writer.println("<html>");
        writer.println("<h1>Description: " + description + "</h1>");
        writer.println("<h1>Price: " + price + "</h1>");
        writer.println("<h1>Discount Percent: " + percent + "</h1>");
        writer.println("<h1>After discount price: " + result + "</h1>");
        writer.println("</html>");
    }
}
