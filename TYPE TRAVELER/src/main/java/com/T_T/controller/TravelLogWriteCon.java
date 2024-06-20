package com.T_T.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.T_T.model.TravelLog;
import com.T_T.model.TravelLogDAO;
import com.T_T.model.MemberDTO;

@WebServlet("/TravelLogWriteCon")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class TravelLogWriteCon extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 세션에서 사용자 정보 가져오기
        HttpSession session = request.getSession();
        MemberDTO member = (MemberDTO) session.getAttribute("memberInfo");

        if (member == null) {
            // 로그인되지 않은 경우 로그인 페이지로 리디렉션
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 폼 데이터 가져오기
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String user_email = member.getUser_email();

        // 파일 업로드 처리
        Part filePart = request.getPart("file");
        String fileName = getFileName(filePart);
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // 파일 경로를 웹 경로로 변환
        String imagePath = request.getContextPath() + "/uploads/" + fileName;

        // 현재 날짜 가져오기
        String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

        // 디버깅 로그
        System.out.println("Title: " + title);
        System.out.println("Content: " + content);
        System.out.println("User Email: " + user_email);
        System.out.println("Image Path: " + imagePath);
        System.out.println("Current Date: " + currentDate);

        // TravelLog 객체 생성
        TravelLog log = new TravelLog(0, imagePath, title, content, user_email, currentDate, null, null, null);

        // 데이터베이스에 저장
        TravelLogDAO dao = new TravelLogDAO();
        dao.insertTravelLog(log);

        // 저장 후 목록 페이지로 리디렉션
        response.sendRedirect(request.getContextPath() + "/TravelLogCon");
    }

    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
