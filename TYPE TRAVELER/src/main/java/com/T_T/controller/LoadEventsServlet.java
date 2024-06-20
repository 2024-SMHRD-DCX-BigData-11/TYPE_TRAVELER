package com.T_T.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import lombok.Getter;
import lombok.Setter;

@WebServlet("/LoadEventsServlet")
public class LoadEventsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	response.setCharacterEncoding("UTF-8");
    	
        String email = request.getParameter("email");
        System.out.println(email);
        if (email == null || email.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"user_email parameter is missing\"}");
            return;
        }

        List<Event> events = new ArrayList<>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@project-db-cgi.smhrd.com:1524:xe", "sc_DCX_bigdata11_p2_4", "smhrd4");

            String query = "SELECT schedule_id, title, start_date, end_date FROM tb_schedule WHERE user_email = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);

            rs = pstmt.executeQuery();
            System.out.println();
            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt("schedule_id"));
                event.setTitle(rs.getString("title"));
                event.setStart(rs.getString("start_date"));
                event.setEnd(rs.getString("end_date"));
                events.add(event);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Database driver not found\"}");
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Database error: " + e.getMessage() + "\"}");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        String json = new Gson().toJson(events);
        response.setContentType("application/json");
        response.getWriter().write(json);
    }

    @Getter
    @Setter
    private class Event {
        private int id;
        private String title;
        private String start;
        private String end;
    }
}
