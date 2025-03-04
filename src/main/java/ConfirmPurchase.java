 import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ConfirmPurchase extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerIdParam = request.getParameter("customer_id");

        if (customerIdParam == null || customerIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Customer ID is missing.");
            return;
        }

        int customerId;
        try {
            customerId = Integer.parseInt(customerIdParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Customer ID.");
            return;
        }

        // Database connection details
        String url = "jdbc:mysql://localhost:3306/ASA1";
        String user = "root";
        String password = "tiger";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        double totalAmount = 0;

        try {
            // Register the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            // Calculate the total amount from the cart
            String totalQuery = "SELECT SUM(p.price * c.quantity) AS total FROM cart c JOIN portraits p ON c.portrait_id = p.id WHERE c.customer_id = ?";
            pstmt = conn.prepareStatement(totalQuery);
            pstmt.setInt(1, customerId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                totalAmount = rs.getDouble("total");
            }

            // Insert order into the database with total amount
            String insertOrderQuery = "INSERT INTO orders (customer_id, total_amount) VALUES (?, ?)";
            pstmt = conn.prepareStatement(insertOrderQuery);
            pstmt.setInt(1, customerId);
            pstmt.setDouble(2, totalAmount);
            pstmt.executeUpdate();

            // Clear the cart after purchase
            String clearCartQuery = "DELETE FROM cart WHERE customer_id = ?";
            pstmt = conn.prepareStatement(clearCartQuery);
            pstmt.setInt(1, customerId);
            pstmt.executeUpdate();

            // Set confirmation message in the request attribute
            request.setAttribute("confirmationMessage", "Thank you for confirming your purchase!");
            request.setAttribute("customerId", customerId);
            
            // Forward to confirmation JSP
            request.getRequestDispatcher("ConfirmPurchase.jsp").forward(request, response);

        } catch (ClassNotFoundException e) {
            response.getWriter().println("MySQL Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            response.getWriter().println("Database error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
