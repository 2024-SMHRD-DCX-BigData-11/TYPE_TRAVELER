package com.T_T.model;

import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Region {

   private int region_id;
   private String region_title;
   private String region_info;
   private String region_address;
   private String keyword;   
   private String region_img;
   
   // 검색용
   private String region;
   private List<Integer> category = new ArrayList<>();
   
   public void addCategory(int category) {
      this.category.add(category);
   }
}
