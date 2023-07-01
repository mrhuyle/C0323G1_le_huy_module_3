<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Calculator</title>
    <style>
        .cal {
            width: 70%;
            height: auto;
            border: 2px solid blue;
            padding: 15px;
            text-align: center;
        }
    </style>
</head>
<body>
<h1>Calculator</h1>
<form action="/CalculatorServlet" method="post">
    <div class="cal">
        <h2>Simple Calculator</h2>
        <table>
            <tr>
                <td>First Operand</td>
                <td><input type="number" name="first_operand"></td>
            </tr>
            <tr>
                <td>Operator</td>
                <td>
                    <select name="operator" id="select">
                        <option value="+">Addition</option>
                        <option value="-">Subtraction</option>
                        <option value="*">Multiplication</option>
                        <option value="/">Division</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Second Operand</td>
                <td><input type="number" name="second_operand"></td>
            </tr>
        </table>
        <input type="submit" value="calculate">
    </div>
</form>
</body>
</html>