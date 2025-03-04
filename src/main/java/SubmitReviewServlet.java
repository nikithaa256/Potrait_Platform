import java.io.IOException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SubmitReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerIdParam = request.getParameter("customer_id");
        String portraitIdParam = request.getParameter("portrait_id");
        String reviewText = request.getParameter("review_text");

        if (customerIdParam == null || portraitIdParam == null || reviewText == null || reviewText.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid review submission.");
            return;
        }

        int customerId;
        int portraitId;
        try {
            customerId = Integer.parseInt(customerIdParam);
            portraitId = Integer.parseInt(portraitIdParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid customer ID or portrait ID.");
            return;
        }

        // Database connection details
        String url = "jdbc:mysql://localhost:3306/ASA1";
        String user = "root";
        String password = "tiger";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Register the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            // Insert review into the database
            String insertReviewQuery = "INSERT INTO reviews (portrait_id, customer_id, review_text) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(insertReviewQuery);
            pstmt.setInt(1, portraitId);
            pstmt.setInt(2, customerId);
            pstmt.setString(3, reviewText);
            pstmt.executeUpdate();

            // Redirect back to the gallery page
            response.sendRedirect("gallery.jsp?customer_id=" + customerId);
        } catch (ClassNotFoundException | SQLException e) {
            response.getWriter().println("Database error: " + e.getMessage());
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
