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

@WebServlet("/UpdateCon")
public class UpdateCon extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 현재 세션에서 사용자 정보 가져오기
        HttpSession session = request.getSession();
        MemberDTO memberInfo = (MemberDTO) session.getAttribute("memberInfo");
        
        if (memberInfo == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User is not logged in.");
            return;
        }

        String user_email = memberInfo.getUser_email();
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String user_name = request.getParameter("user_name");
        String user_mbti = request.getParameter("user_mbti");

        // 데이터베이스에서 비밀번호 확인
        MemberDAO memberDAO = new MemberDAO();
        Member member = memberDAO.getMemberByEmail(user_email);

        if (member == null || !member.getUser_pw().equals(currentPassword)) {
            // 비밀번호가 일치하지 않으면 에러 메시지 전송
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Current password is incorrect.");
            return;
        }

        // 비밀번호가 일치하면 사용자 정보 업데이트
        member.setUser_name(user_name);
        member.setUser_mbti(user_mbti);

        if (newPassword != null && !newPassword.isEmpty()) {
            member.setUser_pw(newPassword);
        }

        boolean updateSuccess = memberDAO.updateMember(member);

        if (updateSuccess) {
            // 세션 정보도 업데이트
            memberInfo.setUser_name(user_name);
            memberInfo.setUser_mbti(user_mbti);
            session.setAttribute("memberInfo", memberInfo);

            // 메인 페이지로 리디렉션
            response.sendRedirect(request.getContextPath() + "/T_T_Main/T_T_Main.jsp");
        } else {
        	response.sendRedirect(request.getContextPath() + "/T_T_Main/T_T_Main.jsp");
        }
    }
}
