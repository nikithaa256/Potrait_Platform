<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

       body {
    background-color: #FFC0CB; /* Lavender color */
    display: flex;
    justify-content: center;
    padding: 20px;
    color: #333;
}
       

        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(255, 240, 245, 0.6); /* light pinkish overlay */
            z-index: 1;
        }

        .cart-container {
            width: 85%;
            max-width: 800px;
            padding: 20px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            position: relative;
            z-index: 2; /* Ensure content appears over the overlay */
        }

        h2 {
            font-size: 2.2rem;
            text-align: center;
            color: #b44b66;
            margin-bottom: 20px;
            text-shadow: 1px 1px 3px #e0e0e0;
        }

        .cart-item {
            display: flex;
            align-items: center;
            padding: 15px;
            margin-bottom: 10px;
            border-radius: 12px;
            background-color: #fdf3f7;
            box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
        }

        .cart-item:nth-child(even) {
            background-color: #faf0f3;
        }

        .item-details {
            flex: 1;
            margin-right: 10px;
        }

        .item-quantity, .item-price {
            text-align: center;
            min-width: 80px;
        }

        .actions {
            display: flex;
            align-items: center;
        }

        button, input[type="submit"] {
            cursor: pointer;
            border: none;
            border-radius: 5px;
            padding: 6px 10px;
            font-size: 1rem;
        }

        .quantity-btn {
            background-color: #ff809f;
            color: #fff;
            margin: 0 2px;
        }

        .quantity-btn:hover {
            background-color: #ff4c7d;
        }

        .update-btn {
            background-color: #4CAF50;
            color: white;
            padding: 6px 12px;
            margin-left: 5px;
        }

        .update-btn:hover {
            background-color: #45a049;
        }

        .remove-btn {
            background-color: #f44336;
            color: white;
            padding: 6px 12px;
            margin-left: 10px;
        }

        .remove-btn:hover {
            background-color: #e53935;
        }

        .total-price {
            font-size: 1.6rem;
            color: #b44b66;
            font-weight: bold;
            text-align: right;
            margin: 20px 0;
            text-shadow: 1px 1px 3px #e0e0e0;
        }

        .confirm-purchase {
            text-align: center;
            margin-top: 15px;
        }

        .confirm-btn {
            background-color: #b44b66;
            color: #fff;
            padding: 12px 20px;
            font-size: 1.2rem;
            border-radius: 5px;
            text-transform: uppercase;
        }

        .confirm-btn:hover {
            background-color: #953755;
        }
    </style>
</head>
<body>
    <div class="overlay"></div> <!-- Overlay to add a transparent effect over the background image -->
    
    <div class="cart-container">
        <h2>Your Cart</h2>

        <%
            String customerIdParam = request.getParameter("customer_id");
            int customerId = 0;

            if (customerIdParam != null) {
                customerId = Integer.parseInt(customerIdParam);
            } else {
                out.println("<p>You are not logged in. Please <a href='login.jsp'>login</a> to view your cart.</p>");
                return;
            }

            String url = "jdbc:mysql://localhost:3306/ASA1";
            String user = "root";
            String password = "tiger";
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Register JDBC driver
                conn = DriverManager.getConnection(url, user, password);
                String query = "SELECT c.quantity, p.id AS portrait_id, p.label, p.price FROM cart c JOIN portraits p ON c.portrait_id = p.id WHERE c.customer_id = ?";
                pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, customerId);
                rs = pstmt.executeQuery();

                if (!rs.next()) {
                    out.println("<p>Your cart is empty.</p>");
                    out.println("<a href='gallery.jsp'>Go to Products</a>");
                } else {
                    double total = 0;

                    do {
                        int quantity = rs.getInt("quantity");
                        int portraitId = rs.getInt("portrait_id");
                        String label = rs.getString("label");
                        double price = rs.getDouble("price");
                        total += price * quantity;

                        out.println("<div class='cart-item'>");
                        out.println("<div class='item-details'>" + label + "</div>");
                        out.println("<div class='item-quantity'>");
                        out.println("<form action='UpdateCartQuantityServlet' method='post' style='display:inline;'>");
                        out.println("<button type='button' class='quantity-btn' onclick='decreaseQuantity(" + portraitId + ")'>-</button>");
                        out.println("<input type='number' id='quantity_" + portraitId + "' name='quantity' value='" + quantity + "' min='1' readonly>");
                        out.println("<button type='button' class='quantity-btn' onclick='increaseQuantity(" + portraitId + ")'>+</button>");
                        out.println("<input type='hidden' name='portrait_id' value='" + portraitId + "'>");
                        out.println("<input type='hidden' name='customer_id' value='" + customerId + "'>");
                        out.println("<input type='submit' class='update-btn' value='Update'>");
                        out.println("</form>");
                        out.println("</div>");
                        out.println("<div class='item-price'>Rs" + (price * quantity) + "</div>");
                        out.println("<div class='actions'><form action='RemoveFromCartServlet' method='post'>");
                        out.println("<input type='hidden' name='portrait_id' value='" + portraitId + "'>");
                        out.println("<input type='hidden' name='customer_id' value='" + customerId + "'>");
                        out.println("<input type='submit' class='remove-btn' value='Remove'>");
                        out.println("</form></div>");
                        out.println("</div>");
                    } while (rs.next());

                    out.println("<div class='total-price'>Total: Rs" + total + "</div>");
                    out.println("<div class='confirm-purchase'>");
                    out.println("<form action='ConfirmPurchase' method='post'>");
                    out.println("<input type='hidden' name='customer_id' value='" + customerId + "'>");
                    out.println("<button type='submit' class='confirm-btn'>Confirm Purchase</button>");
                    out.println("</form></div>");
                }
            } catch (ClassNotFoundException e) {
                out.println("<p>MySQL Driver not found: " + e.getMessage() + "</p>");
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        %>
    </div>

    <script>
        function increaseQuantity(portraitId) {
            const quantityInput = document.getElementById('quantity_' + portraitId);
            quantityInput.value = parseInt(quantityInput.value) + 1;
        }

        function decreaseQuantity(portraitId) {
            const quantityInput = document.getElementById('quantity_' + portraitId);
            if (parseInt(quantityInput.value) > 1) {
                quantityInput.value = parseInt(quantityInput.value) - 1;
            }
        }
    </script>
</body>
</html>
