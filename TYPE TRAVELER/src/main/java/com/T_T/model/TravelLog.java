package com.T_T.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor // 모든 필드를 포함하는 생성자
@NoArgsConstructor  // 기본 생성자
public class TravelLog {
    
    private int tlog_id;
    private String tlog_img;
    private String tlog_title;
    private String tlog_content;
    private String user_email;
    private String created_at;
    private String author; // 닉네임 추가
    private String user_name;   // name 추가
    private String user_mbti;   // MBTI 추가   
}