package com.T_T.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.T_T.model.InfoResponse;
import com.T_T.model.Region;
import com.T_T.model.RegionDAO;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/RegionInfoCon")
public class RegionInfoCon extends HttpServlet {
   private static final long serialVersionUID = 1L;

   protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
      response.setContentType("application/json");
      response.setCharacterEncoding("UTF-8");

      int page = Integer.parseInt(request.getParameter("page"));

      String region = request.getParameter("region");
      String category = request.getParameter("category");
      String mbti = request.getParameter("mbti");

      System.out.println("region : " + region);
      System.out.println("category : " + category);
      System.out.println("mbti : " + mbti);

      Map<String, Object> map = new HashMap<>();
      List<String> regions = new ArrayList<>();

      if (region.equals("전체")) {
         regions.add("");
      } else {
         for (String r : region.split(",")) {
            if (r.equals("충북")) {
               regions.add("충청북도");
            } else if (r.equals("충남")) {
               regions.add("충청남도");
            } else if (r.equals("경북")) {
               regions.add("경상북도");
            } else if (r.equals("경남")) {
               regions.add("경상남도");
            } else if (r.equals("전남")) {
               regions.add("전라남도");
            } else {
               regions.add(r);
            }
         }
      }
      map.put("page", page);
      map.put("regions", regions);

      RegionDAO dao = new RegionDAO();
      List<Integer> categoryList = null;
      if (!mbti.isEmpty()) {
         List<String> mbtiList = new ArrayList<>();
         for (String m : mbti.split(",")) {
            mbtiList.add(m);
         }
         categoryList = dao.selectMbtis(mbtiList);
         for (int i : categoryList) {
            System.out.println(i);
         }
      }
      if (!category.isEmpty()) {
         if (categoryList == null) {
            categoryList = new ArrayList<>();
         }
         if (category.contains("자연경관")) {
            categoryList.add(1);
         }
         if (category.contains("문화및역사")) {
            categoryList.add(2);
         }
         if (category.contains("도시관광")) {
            categoryList.add(3);
         }
         if (category.contains("레저및액티비티")) {
            categoryList.add(4);
         }
         if (category.contains("맛집탐방")) {
            categoryList.add(5);
         }
         if (category.contains("힐링및휴식")) {
            categoryList.add(6);
         }
         if (category.contains("가족여행")) {
            categoryList.add(7);
         }
         if (category.contains("로맨틱여행")) {
            categoryList.add(8);
         }
         if (category.contains("호캉스여행")) {
            categoryList.add(9);
         }
      }
      map.put("category", categoryList);

      List<Region> result = dao.list4(map);

      InfoResponse resp = new InfoResponse();
      resp.setItems(result);
      resp.setTotalItems(dao.count(map));

      ObjectMapper objectMapper = new ObjectMapper();
      String json = objectMapper.writeValueAsString(resp);
      response.getWriter().write(json);
   }
}