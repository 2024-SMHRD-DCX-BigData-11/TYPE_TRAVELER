package com.T_T.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.T_T.model.MemberDAO;
import com.T_T.model.Member;
import com.google.gson.Gson;
import java.util.logging.Logger;

@WebServlet("/EmailCheckCon")
public class EmailCheckCon extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(EmailCheckCon.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String inputEmail = request.getParameter("inputEmail");
        logger.info("Received email: " + inputEmail);

        MemberDAO memberDAO = new MemberDAO();
        Member existingMember = memberDAO.getMemberByEmail(inputEmail);

        boolean exists = (existingMember != null);
        logger.info("Email exists: " + exists);

        // JSON 형식으로 결과 전송
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(exists));
    }
}
