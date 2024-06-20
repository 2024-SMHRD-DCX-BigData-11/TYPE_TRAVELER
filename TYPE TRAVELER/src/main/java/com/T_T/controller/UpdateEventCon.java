package com.T_T.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateEventCon")
public class UpdateEventCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);

		Instant instant = Instant.parse(start);
		// 2. Instant를 LocalDate로 변환 (UTC 타임존 사용)
		LocalDate localDate = instant.atZone(ZoneId.of("UTC")).toLocalDate();
		// 3. LocalDate를 java.sql.Date로 변환
		Date start_ = Date.valueOf(localDate);

		Instant instant_ = Instant.parse(end);
		// 2. Instant를 LocalDate로 변환 (UTC 타임존 사용)
		LocalDate localDate_ = instant_.atZone(ZoneId.of("UTC")).toLocalDate();
		// 3. LocalDate를 java.sql.Date로 변환
		Date end_ = Date.valueOf(localDate_);

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@project-db-cgi.smhrd.com:1524:xe",
					"sc_DCX_bigdata11_p2_4", "smhrd4");

			String query = "UPDATE tb_schedule SET start_date = ?, end_date = ? WHERE schedule_id = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setDate(1, start_);
			pstmt.setDate(2, end_);
			pstmt.setString(3, id);

			pstmt.executeUpdate();
			response.setStatus(HttpServletResponse.SC_OK); // 성공 상태 코드 설정
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.getWriter().write("Error: Driver not found");
		} catch (SQLException e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.getWriter().write("Error: " + e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.getWriter().write("Error: " + e.getMessage());
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
