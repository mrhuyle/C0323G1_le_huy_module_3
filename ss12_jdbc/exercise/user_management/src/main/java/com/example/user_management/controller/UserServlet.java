package com.example.user_management.controller;

import com.example.user_management.model.User;
import com.example.user_management.service.IUserService;
import com.example.user_management.service.UserService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.ResultSet;
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
                showCreateForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
            case "sort":
                sortByName(request,response);
                break;
            default:
                listUser(request, response);
                break;
        }
    }

    private void sortByName(HttpServletRequest request, HttpServletResponse response) {
        List<User> list = userService.sortByName();
        RequestDispatcher dispatcher;
        if (list.isEmpty()) {
            dispatcher = request.getRequestDispatcher("user/error.jsp");
        } else {
            dispatcher = request.getRequestDispatcher("user/list.jsp");
            request.setAttribute("listUser",list);
            request.setAttribute("restore","Restore to the origin list");
        }
        try {
            dispatcher.forward(request,response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        userService.deleteUser(id);

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

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userService.selectUser(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("user/edit.jsp");
        request.setAttribute("user", user);
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) {
        RequestDispatcher dispatcher = request.getRequestDispatcher("user/create.jsp");
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
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
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                insertUser(request, response);
                break;
            case "edit":
                updateUser(request, response);
                break;
            case "search":
                searchByCountry(request, response);
                break;
        }
    }

    private void searchByCountry(HttpServletRequest request, HttpServletResponse response) {
        String searchStr = request.getParameter("searchStr");
        List<User> list = userService.searchByCountry(searchStr);
        RequestDispatcher dispatcher;
        if (list.isEmpty()) {
            dispatcher = request.getRequestDispatcher("user/error.jsp");
        } else {
            dispatcher = request.getRequestDispatcher("user/search_result.jsp");
            request.setAttribute("searchStr", searchStr);
            request.setAttribute("list", list);
        }
        try {
            dispatcher.forward(request,response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String country = request.getParameter("country");

        User updatedUser = new User(id, name, email, country);
        userService.updateUser(updatedUser);
        RequestDispatcher dispatcher = request.getRequestDispatcher("user/edit.jsp");
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    private void insertUser(HttpServletRequest request, HttpServletResponse response) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String country = request.getParameter("country");
        User newUser = new User(name, email, country);
        userService.insertUser(newUser);
        RequestDispatcher dispatcher = request.getRequestDispatcher("user/create.jsp");
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
