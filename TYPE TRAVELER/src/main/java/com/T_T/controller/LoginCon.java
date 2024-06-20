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
import com.T_T.model.MemberDTO;

@WebServlet("/LoginCon")
public class LoginCon extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        
        String user_email = request.getParameter("user_email");
        String user_pw = request.getParameter("user_pw");
        String redirectURL = request.getParameter("redirectURL"); // 리디렉션 URL 받아오기

        Member member = new Member(user_email, user_pw);
        
        Member login_member = new MemberDAO().login(member);

        if (login_member != null) {
            // 로그인 성공
            HttpSession session = request.getSession();
            
            // Member 정보에서 비밀번호를 제외하고 MemberDTO 객체를 생성
            MemberDTO memberDTO = new MemberDTO(
                login_member.getUser_email(),
                login_member.getUser_name(),
                login_member.getUser_mbti()
            );

            session.setAttribute("memberInfo", memberDTO); // 세션에 MemberDTO 객체 저장
            
            // 리디렉션 URL이 존재하면 해당 URL로 리디렉션, 없으면 메인 페이지로 리디렉션
            if (redirectURL != null && !redirectURL.isEmpty()) {
                response.sendRedirect(redirectURL);
            } else {
                response.sendRedirect(request.getContextPath() + "/T_T_Main/T_T_Main.jsp");
            }
          
        } else {
            // 로그인 실패
            String referer = request.getHeader("Referer").replace("?loginError=true", "").replace("&loginError=true", ""); // 이전 페이지 URL 가져오기
            response.sendRedirect(referer + "?loginError=true"); // 이전 페이지로 리디렉션
        }
    }
}