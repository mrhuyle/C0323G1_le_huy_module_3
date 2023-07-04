package com.example.user_management.controller;

import com.example.user_management.model.User;
import com.example.user_management.service.IUserService;
import com.example.user_management.service.UserService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UserServlet", urlPatterns = "/users")
public class UserServlet extends HttpServlet {
    private static IUserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                break;
            default:
                listUser(request, response);
                break;
        }
    }

    private void listUser(HttpServletRequest request, HttpServletResponse response) {
        List<User> listUser = userService.selectAllUsers();
        RequestDispatcher dispatcher;
        if (listUser.isEmpty()) {
            dispatcher = request.getRequestDispatcher("user/error.jsp");
        } else {
            dispatcher = request.getRequestDispatcher("user/list.jsp");
            request.setAttribute("listUser", listUser);
        }
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
