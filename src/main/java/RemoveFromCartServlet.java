import java.io.IOException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int portraitId = Integer.parseInt(request.getParameter("portrait_id"));
        int customerId = Integer.parseInt(request.getParameter("customer_id"));

        String url = "jdbc:mysql://localhost:3306/ASA1";
        String user = "root";
        String password = "tiger";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DriverManager.getConnection(url, user, password);
            String query = "DELETE FROM cart WHERE portrait_id = ? AND customer_id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, portraitId);
            pstmt.setInt(2, customerId);
            pstmt.executeUpdate();

            response.sendRedirect("cart.jsp?customer_id=" + customerId);

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
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
