package com.T_T.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("user_pw");
        String name = request.getParameter("user_name");
        String mbti = request.getParameter("user_mbti");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@project-db-cgi.smhrd.com:1524:xe", "sc_DCX_bigdata11_p2_4", "smhrd4");

            String query = "INSERT INTO tb_user (email, password, name, mbti) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            pstmt.setString(3, name);
            pstmt.setString(4, mbti);

            int row = pstmt.executeUpdate();
            if (row > 0) {
                response.sendRedirect("/T_T_Schedule.jsp");
            }
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
