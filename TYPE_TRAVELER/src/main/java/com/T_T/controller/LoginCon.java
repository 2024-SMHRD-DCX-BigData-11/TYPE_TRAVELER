package com.T_T.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.T_T.model.Member;
import com.T_T.model.MemberDAO;

@WebServlet("/LoginCon")
public class LoginCon extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String pw = request.getParameter("pw");

        Member member = new Member(email, pw);
        Member login_member = new MemberDAO().login(member);

        if (login_member != null) {
            // 로그인 성공
            request.getSession().setAttribute("useremail", email);
            response.sendRedirect("T_T_Main.jsp");
        } else {
            // 로그인 실패
            response.sendRedirect("T_T_Main.jsp?loginError=true");
        }
    }
}
