package com.T_T.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EmailCheckCon")
public class EmailCheckCon extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user_email = request.getParameter("inputEmail");
        System.out.println("실행1");
        // JDBC 연결 설정 (예시에서는 간단히 설명하기 위해 URL, 사용자명, 비밀번호를 직접 기재했습니다. 실제 프로젝트에서는 보안을 고려하여 설정하세요.)
        String jdbcUrl = "jdbc:oracle:thin:@project-db-cgi.smhrd.com:1524:xe"; // Oracle 데이터베이스 URL
        String dbUser = "sc_DCX_bigdata11_p2_4";
        String dbPassword = "smhrd4";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean exists = false;
        System.out.println("실행2");
        try {
            // 데이터베이스 연결
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
            System.out.println("실행3");
            // 이메일 중복 확인 쿼리
            String sql = "SELECT COUNT(*) AS count FROM tb_user WHERE user_email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user_email);
            System.out.println(user_email);
            rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("count");
                if (count > 0) {
                	System.out.println("있음");
                    exists = true;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            // 자원 해제
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // JSON 응답 작성
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(exists);
        out.flush();
    }
}
