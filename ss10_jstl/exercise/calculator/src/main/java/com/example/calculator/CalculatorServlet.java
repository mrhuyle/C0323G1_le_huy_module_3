package com.example.calculator;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CalculatorServlet", urlPatterns = "/CalculatorServlet")
public class CalculatorServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        float firstOperand = Float.parseFloat(request.getParameter("first_operand"));
        float secondOperand = Float.parseFloat(request.getParameter("second_operand"));
        String operator = request.getParameter("operator");

        float result = calculate(firstOperand, secondOperand, operator, request);
        String str = firstOperand + operator + secondOperand + " = " + result;
        request.setAttribute("str",str);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/result.jsp");
        dispatcher.forward(request, response);
    }

    private float calculate(float firstOperand, float secondOperand, String operator, HttpServletRequest request)  {
        float result = 0;
        try {
            switch (operator) {
                case "+":
                    result = firstOperand + secondOperand;
                    break;
                case "-":
                    result = firstOperand - secondOperand;
                    break;
                case "*":
                    result = firstOperand * secondOperand;
                    break;
                case "/":
                    if (secondOperand != 0) {
                        result = firstOperand / secondOperand;
                    } else {
                        throw new ArithmeticException("Cannot divide by zero!");
                    }
                    break;
            }
        } catch (ArithmeticException e) {
            e.printStackTrace();
            request.setAttribute("error","Error: Division by zero is not allowed.");
            return 0;
        }
        return result;
    }
}
