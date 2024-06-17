package com.T_T.controller;

import java.io.IOException;
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
import javax.servlet.http.HttpSession;

import com.T_T.model.Member;
import com.T_T.model.MemberDAO;

@WebServlet("/JoinCon")
public class JoinCon extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("JoinCon doPost called");

        request.setCharacterEncoding("UTF-8");

        String userEmail = request.getParameter("user_email");
        String userPw = request.getParameter("user_pw");
        String userName = request.getParameter("user_name");
        String userMbti = request.getParameter("user_mbti");

        System.out.println("Received data: " + userEmail + ", " + userPw + ", " + userName + ", " + userMbti);

        // 이메일 중복 확인
        boolean emailExists = isEmailExists(userEmail);

        if (emailExists) {
            // 이메일이 이미 존재하는 경우
            HttpSession session = request.getSession();
            session.setAttribute("joinError", "입력하신 이메일 주소는 이미 사용 중입니다.");
            response.sendRedirect(request.getContextPath() + "/T_T_Main/T_T_Join.jsp");
        } else {
            // 이메일이 존재하지 않는 경우 회원 가입 처리
            Member newMember = new Member(userEmail, userPw, userName, userMbti);
            MemberDAO memberDAO = new MemberDAO();
            
            boolean success = memberDAO.insertMember(newMember);

            if (success) {
                HttpSession session = request.getSession();
                session.setAttribute("memberInfo", newMember);
                session.setAttribute("joinSuccess", true);
                System.out.println("Member registration successful. Redirecting to main page.");
                response.sendRedirect(request.getContextPath() + "/T_T_Main/T_T_Main.jsp");
            } else {
                System.out.println("Member registration failed. Redirecting to main page.");
                response.sendRedirect(request.getContextPath() + "/T_T_Main/T_T_Main.jsp");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    // 이메일 중복 확인 메서드
    private boolean isEmailExists(String email) {
        boolean exists = false;

        // JDBC 연결 설정 (예시에서는 간단히 설명하기 위해 URL, 사용자명, 비밀번호를 직접 기재했습니다. 실제 프로젝트에서는 보안을 고려하여 설정하세요.)
        String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:xe"; // Oracle 데이터베이스 URL
        String dbUser = "your_username";
        String dbPassword = "your_password";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // 데이터베이스 연결
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // 이메일 중복 확인 쿼리
            String sql = "SELECT COUNT(*) AS count FROM tb_user WHERE email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);

            rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("count");
                if (count > 0) {
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

        return exists;
    }
}
