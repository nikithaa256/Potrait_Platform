<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Portrait Gallery</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #87CEEB;
            padding: 20px;
            color: #333;
        }
        .logout-button, .cart-button, .submit-button {
            background-color: #ff66b3;
            border: none;
            color: white;
            padding: 10px 15px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 10px;
        }
        .logout-button:hover, .cart-button:hover, .submit-button:hover {
            background-color: #ff3385;
        }
        h2 {
            text-align: center;
            color: #e91e63;
        }
        .portrait-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
        }
        .row {
            display: flex;
            justify-content: center;
            gap: 20px;
            width: 100%;
        }
        .portrait {
            display: flex;
            align-items: center;
            width: 45%;
            padding: 10px;
            border: 1px solid #ddd;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .portrait img {
            max-width: 150px;
            height: auto;
            border-radius: 5px;
            margin-right: 15px;
            cursor: pointer;
        }
        .portrait-details {
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        .portrait h3, .portrait p {
            color: #e91e63;
            margin: 5px 0;
        }
    
        .reviews {
            margin-top: 5px;
            font-size: 0.85em;
            color: #000080;
            max-height: 60px;
            overflow-y: auto;
        }
        .review-form {
            margin-top: 5px;
        }
        h4 {
            margin: 5px 0; /* Reduced margin for 'Reviews' and 'Add a Review' headings */
            color: #333;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            padding-top: 60px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
        }
        .modal-content {
            margin: auto;
            display: block;
            max-width: 80%;
            max-height: 80%;
        }
        .modal-close {
            position: absolute;
            top: 20px;
            right: 35px;
            color: #fff;
            font-size: 40px;
            font-weight: bold;
            cursor: pointer;
        }
    </style>
    <script>
        function openModal(imageUrl) {
            document.getElementById("modal").style.display = "block";
            document.getElementById("modal-image").src = imageUrl;
        }
        function closeModal() {
            document.getElementById("modal").style.display = "none";
        }
    </script>
</head>
<body>
    <form action="login.jsp">
        <button class="logout-button" type="submit">Logout</button>
    </form>

    <h2>Portrait Gallery</h2>

    <div class="portrait-container">
    <% 
        String customerIdParam = request.getParameter("customer_id");
        Integer customerId = null;

        if (customerIdParam != null) {
            try {
                customerId = Integer.parseInt(customerIdParam);
            } catch (NumberFormatException e) {
                out.println("<p class='error'>Invalid customer ID. Please <a href='login.jsp'>log in</a>.</p>");
            }
        } else {
            out.println("<p class='error'>Please <a href='login.jsp'>log in</a> to view the gallery.</p>");
        }

        if (customerId != null) {
            String url = "jdbc:mysql://localhost:3306/ASA1";
            String user = "root";
            String password = "tiger";
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                conn = DriverManager.getConnection(url, user, password);
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT * FROM portraits");

                int count = 0;
                while (rs.next()) {
                    if (count % 2 == 0) {
                        out.println("<div class='row'>");
                    }

                    int portraitId = rs.getInt("id");
                    String label = rs.getString("label");
                    String price = rs.getString("price");
                    String description = rs.getString("description");
                    String imageUrl = rs.getString("image_url");
    %>
                    <div class="portrait">
                        <img src="<%= imageUrl %>" alt="<%= label %>" onclick="openModal('<%= imageUrl %>')">
                        <div class="portrait-details">
                            <h3><%= label %></h3>
                            <p class="price" style="color: navy; font-weight: bold;">Price: Rs<%= price %></p>
                            <p><%= description %></p>

                            <!-- Add to Cart Form -->
                            <form action="AddToCart" method="post">
                                <input type="hidden" name="portrait_id" value="<%= portraitId %>">
                                <input type="hidden" name="customer_id" value="<%= customerId %>">
                                <label>Quantity:</label>
                                <input type="number" name="quantity" value="1" min="1">
                                <button class="submit-button" type="submit">Add to Cart</button>
                            </form>

                            <!-- Review Section -->
                            <h4>Reviews:</h4>
                            <div class="reviews">
                                <% 
                                    PreparedStatement reviewStmt = null;
                                    ResultSet reviewRs = null;
                                    try {
                                        String reviewQuery = "SELECT r.review_text, r.created_at, c.username AS customer_name " +
                                                             "FROM reviews r JOIN customers c ON r.customer_id = c.id " +
                                                             "WHERE r.portrait_id = ?";
                                        reviewStmt = conn.prepareStatement(reviewQuery);
                                        reviewStmt.setInt(1, portraitId);
                                        reviewRs = reviewStmt.executeQuery();

                                        int reviewCount = 0;
                                        while (reviewRs.next() && reviewCount < 10) { 
                                            String reviewText = reviewRs.getString("review_text");
                                            String reviewerName = reviewRs.getString("customer_name");
                                %>
                                            <p class="review-text"><strong><%= reviewerName %>:</strong> <%= reviewText %> <span style="font-size: 0.7em; color: #000080;">(Posted on <%= reviewRs.getTimestamp("created_at") %>)</span></p>
                                <%          
                                            reviewCount++;
                                        }
                                    } catch (SQLException e) {
                                        out.println("<p class='error'>Error fetching reviews: " + e.getMessage() + "</p>");
                                    } finally {
                                        if (reviewRs != null) try { reviewRs.close(); } catch (SQLException e) { }
                                        if (reviewStmt != null) try { reviewStmt.close(); } catch (SQLException e) { }
                                    }
                                %>
                            </div>

                            <h4>Add a Review:</h4>
                            <form action="SubmitReviewServlet" method="post" class="review-form">
                                <input type="hidden" name="customer_id" value="<%= customerId %>">
                                <input type="hidden" name="portrait_id" value="<%= portraitId %>">
                                <textarea name="review_text" required></textarea>
                                <button class="submit-button" type="submit">Submit Review</button>
                            </form>
                        </div>
                    </div>
    <%
                    count++;
                    if (count % 2 == 0) {
                        out.println("</div>");
                    }
                }
                if (count % 2 != 0) {
                    out.println("</div>");
                }
            } catch (SQLException e) {
                out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { }
                if (conn != null) try { conn.close(); } catch (SQLException e) { }
            }
        }
    %>
    </div>

    <form action="cart.jsp" method="get" style="margin-top: 20px;">
        <input type="hidden" name="customer_id" value="<%= customerId %>">
        <button class="cart-button" type="submit">View Cart</button>
    </form>

    <!-- Modal for enlarged image -->
    <div id="modal" class="modal" onclick="closeModal()">
        <span class="modal-close" onclick="closeModal()">&times;</span>
        <img class="modal-content" id="modal-image">
    </div>
</body>
</html>
