package com.T_T.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.T_T.model.PaginationParams;
import com.T_T.model.TravelLog;
import com.T_T.model.TravelLogDAO;

@WebServlet("/TravelLogCon")
public class TravelLogCon extends HttpServlet {
   private static final long serialVersionUID = 1L;
   private static final int RECORDS_PER_PAGE = 3;

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
      int page = 1;
      String search = request.getParameter("search");
      String type = request.getParameter("type");
      System.out.println(search);
      if (request.getParameter("page") != null) {
         page = Integer.parseInt(request.getParameter("page"));
      }
      int offset = (page - 1) * RECORDS_PER_PAGE;

      TravelLogDAO dao = new TravelLogDAO();

      String title = null;
      String mbti = null;
      String author = null;
      if (type != null) {
         switch (type) {
         case "title":
            title = search;
            break;
         case "mbti":
            mbti = search;
            break;
         case "author":
            author = search;
            break;
         }
      }

      PaginationParams params = new PaginationParams(offset, RECORDS_PER_PAGE, page, title, mbti, author);
      List<TravelLog> travelLogs = dao.selectTravelLogs(params);
      int totalRecords = dao.countTravelLogs(params);
      int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

      request.setAttribute("travelLogs", travelLogs);
      request.setAttribute("currentPage", page);
      request.setAttribute("totalPages", totalPages);
      request.setAttribute("search", search);
      request.setAttribute("type", type);

      request.getRequestDispatcher("/T_T_Log/T_T_Log.jsp").forward(request, response);
   }
}
