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

@WebServlet("/LoginCon")
public class LoginCon extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		String user_email = request.getParameter("user_email");
		String user_pw = request.getParameter("user_pw");

		Member member = new Member(user_email, user_pw);
		
		Member login_member = new MemberDAO().login(member);

        if (login_member != null) {
            // 로그인 성공
            HttpSession session = request.getSession();
            session.setAttribute("member", login_member);
            response.sendRedirect(request.getContextPath() + "/T_T_Main/T_T_Main.jsp"); // 메인 페이지로 리디렉션
        } else {
            // 로그인 실패
        	// 로그인 실패
            String referer = request.getHeader("Referer"); // 이전 페이지 URL 가져오기
            response.sendRedirect(referer + "?loginError=true"); // 이전 페이지로 리디렉션
        }
    }
}
