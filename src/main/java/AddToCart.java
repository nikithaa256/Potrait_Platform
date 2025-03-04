
import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get customer_id from the request parameter
        String customerIdParam = request.getParameter("customer_id");
        int customerId = Integer.parseInt(customerIdParam);

        int portraitId = Integer.parseInt(request.getParameter("portrait_id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Database connection details
        String url = "jdbc:mysql://localhost:3306/ASA1";
        String user = "root";
        String password = "tiger";

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            // Check if the item already exists in the cart
            String checkCartQuery = "SELECT quantity FROM cart WHERE customer_id = ? AND portrait_id = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkCartQuery)) {
                checkStmt.setInt(1, customerId);
                checkStmt.setInt(2, portraitId);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    // Update the quantity
                    int existingQuantity = rs.getInt("quantity");
                    int newQuantity = existingQuantity + quantity;

                    String updateCartQuery = "UPDATE cart SET quantity = ? WHERE customer_id = ? AND portrait_id = ?";
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateCartQuery)) {
                        updateStmt.setInt(1, newQuantity);
                        updateStmt.setInt(2, customerId);
                        updateStmt.setInt(3, portraitId);
                        updateStmt.executeUpdate();
                    }
                } else {
                    // Add new item
                    String insertCartQuery = "INSERT INTO cart (customer_id, portrait_id, quantity) VALUES (?, ?, ?)";
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertCartQuery)) {
                        insertStmt.setInt(1, customerId);
                        insertStmt.setInt(2, portraitId);
                        insertStmt.setInt(3, quantity);
                        insertStmt.executeUpdate();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to the gallery after adding to cart
        response.sendRedirect("gallery.jsp?customer_id=" + customerId); // Pass customer_id back to gallery
    }
}
