package com.T_T.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.T_T.model.Region;
import com.T_T.model.RegionDAO;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/RegionCon")
public class RegionCon extends HttpServlet {
   private static final long serialVersionUID = 1L;

   protected void service(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
      response.setContentType("application/json");
      response.setCharacterEncoding("UTF-8");

      String region = request.getParameter("region");
      int category = Integer.parseInt(request.getParameter("category"));
      String mbti = request.getParameter("mbti");

      System.out.println("region : " + region);
      System.out.println("category : " + category);
      System.out.println("mbti : " + mbti);

      List<Region> regions = null;

      if (region.isEmpty() && category == 0 && mbti.isEmpty()) {
         regions = new RegionDAO().listRandom4();
      } else {
         RegionDAO dao = new RegionDAO();
         List<Integer> categorys = new ArrayList<>();
         if (category > 0) {
            categorys.add(category);
         }
         if (!mbti.isEmpty()) {
            categorys.addAll(dao.selectMbti(mbti));
         }
         Map<String, Object> map = new HashMap<>();
         map.put("region", region);
         map.put("category", categorys);
         regions = dao.selectRegion(map);
      }

      ObjectMapper objectMapper = new ObjectMapper();
      String json = objectMapper.writeValueAsString(regions);
      response.getWriter().write(json);
   }
}
