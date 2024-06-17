package com.T_T.controller;

import java.io.IOException;
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }
}
