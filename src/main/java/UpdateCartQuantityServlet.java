import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateCartQuantityServlet")
public class UpdateCartQuantityServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customer_id"));
        int portraitId = Integer.parseInt(request.getParameter("portrait_id"));
        int newQuantity = Integer.parseInt(request.getParameter("quantity"));

        try {
            // Connect to the database
            String url = "jdbc:mysql://localhost:3306/ASA1";
            String user = "root";
            String password = "tiger";
            Connection conn = DriverManager.getConnection(url, user, password);

            // Update the cart quantity for the specified customer and portrait
            String query = "UPDATE cart SET quantity = ? WHERE customer_id = ? AND portrait_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, newQuantity);
            pstmt.setInt(2, customerId);
            pstmt.setInt(3, portraitId);
            pstmt.executeUpdate();

            // Redirect back to the cart page
            response.sendRedirect("cart.jsp?customer_id=" + customerId);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error updating quantity");
        }
    }
}
