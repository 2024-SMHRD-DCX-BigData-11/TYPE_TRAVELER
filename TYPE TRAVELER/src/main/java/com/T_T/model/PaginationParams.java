package com.T_T.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class PaginationParams {
   private int offset;
   private int limit;
   private int page;
   private String title;
   private String mbti;
   private String author;
}