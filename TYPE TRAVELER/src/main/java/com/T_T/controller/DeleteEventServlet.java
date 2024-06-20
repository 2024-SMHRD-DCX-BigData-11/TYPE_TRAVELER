package com.T_T.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteEventServlet")
public class DeleteEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@project-db-cgi.smhrd.com:1524:xe", "sc_DCX_bigdata11_p2_4", "smhrd4");

            String query = "DELETE FROM tb_schedule WHERE schedule_id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, Integer.parseInt(id));

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                response.setStatus(HttpServletResponse.SC_OK); // 성공 상태 코드 설정
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 삭제할 레코드를 찾지 못한 경우
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error: Driver not found");
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
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
