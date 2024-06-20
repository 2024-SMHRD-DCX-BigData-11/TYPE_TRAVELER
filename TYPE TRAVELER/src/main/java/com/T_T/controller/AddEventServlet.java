package com.T_T.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddEventServlet")
public class AddEventServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        

		String email = request.getParameter("email");
		String title = request.getParameter("title");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@project-db-cgi.smhrd.com:1524:xe",
					"sc_DCX_bigdata11_p2_4", "smhrd4");

			String query = "INSERT INTO tb_schedule (schedule_id, user_email, title, start_date, end_date) VALUES (tb_schedule_SEQ.NEXTVAL, ?, ?, ?, ?)";
			PreparedStatement pstmt = conn.prepareStatement(query, new String[] {"schedule_id"});
			pstmt.setString(1, email);
			pstmt.setString(2, title);
			pstmt.setString(3, startDate);
			pstmt.setString(4, endDate);

			int rowsInserted = pstmt.executeUpdate();

			if (rowsInserted > 0) {
				// 데이터 삽입 성공 시 생성된 ID 가져오기
				ResultSet generatedKeys = pstmt.getGeneratedKeys();
				if (generatedKeys.next()) {
					int generatedId = generatedKeys.getInt(1); // 여기서 1은 컬럼 인덱스입니다.
					System.out.println("Generated ID: " + generatedId);
					response.getWriter().print("{\"id\": " + generatedId + "}");	
				}
				generatedKeys.close();	
			}
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}
}
