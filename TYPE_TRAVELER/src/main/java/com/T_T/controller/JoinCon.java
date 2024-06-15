package com.T_T.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
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

    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String email = request.getParameter("email");
        String pw = request.getParameter("pw");
        String name = request.getParameter("name");
        String mbti = request.getParameter("mbti");

        Member member = new Member(email, pw, name, mbti); // 모든 필드를 포함하여 Member 객체 생성

        int cnt = new MemberDAO().join(member);

        if (cnt == 1) {
            System.out.println("회원가입 성공!");
            RequestDispatcher rd = request.getRequestDispatcher("JoinSuccess.jsp");
            // request.setAttribute("email", member.getEmail());
            rd.forward(request, response);
        } else {
            System.out.println("회원가입 실패..");
        }

        return "T_T_Main.jsp";
    }
}

