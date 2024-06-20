package com.T_T.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.T_T.model.Member;
import com.T_T.model.MemberDAO;
import com.T_T.model.MemberDTO;

@WebServlet("/UpdateCon")
public class UpdateCon extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		/* response.setContentType("text/plain"); */
		response.setCharacterEncoding("UTF-8");

		// 현재 세션에서 사용자 정보 가져오기
		HttpSession session = request.getSession();
		MemberDTO memberInfo = (MemberDTO) session.getAttribute("memberInfo");

//        if (memberInfo == null) {
//            response.getWriter().write("error:User is not logged in.");
//            return;
//        }

		String user_email = memberInfo.getUser_email();
		String currentPassword = request.getParameter("currentPassword");
		System.out.println("입력PW ::: " + currentPassword);

		String newPassword = request.getParameter("newPassword");
		String user_name = request.getParameter("user_name");
		String user_mbti = request.getParameter("user_mbti");

		// MBTI 유효성 검사
		List<String> validMbtiTypes = Arrays.asList("ISTJ", "ISFJ", "INFJ", "INTJ", "ISTP", "ISFP", "INFP", "INTP",
				"ESTP", "ESFP", "ENFP", "ENTP", "ESTJ", "ESFJ", "ENFJ", "ENTJ");

		/*
		 * if (!validMbtiTypes.contains(user_mbti)) {
		 * request.getRequestDispatcher("/T_T_Main/Error.jsp").forward(request,
		 * response); return; }
		 */

		// 데이터베이스에서 비밀번호 확인
		MemberDAO memberDAO = new MemberDAO();
		Member member = memberDAO.getMemberByEmail(user_email);

		if (member == null || !member.getUser_pw().equals(currentPassword)) {
			// 비밀번호가 일치하지 않으면 에러 메시지 전송
			System.out.println("실행3");
			PrintWriter out = response.getWriter();

			JSONObject obj = new JSONObject();
			obj.put("res", true);
			out.print(obj);

		} else {
			System.out.println("맞을때");
			PrintWriter out = response.getWriter();
			JSONObject obj = new JSONObject();
			obj.put("res", false);
			out.print(obj);
			
	        // 비밀번호가 일치하면 사용자 정보 업데이트
			
			member.setUser_mbti(user_mbti);
	        member.setUser_name(user_name);

	        if (newPassword != null && !newPassword.isEmpty()) {
	            member.setUser_pw(newPassword);
	        }
			boolean updateSuccess = memberDAO.updateMember(member);
			if (updateSuccess) {
				// 세션 정보도 업데이트
				memberInfo.setUser_name(user_name);
				memberInfo.setUser_mbti(user_mbti);
				session.setAttribute("memberInfo", memberInfo);
			}
		}


//
//
//        if (updateSuccess) {
//            // 세션 정보도 업데이트
//            memberInfo.setUser_name(user_name);
//            memberInfo.setUser_mbti(user_mbti);
//            session.setAttribute("memberInfo", memberInfo);
//
//            response.getWriter().write("success:Profile updated successfully.");
//        } else {
//            response.getWriter().write("error:Profile update failed.");
//        }
	}
}
