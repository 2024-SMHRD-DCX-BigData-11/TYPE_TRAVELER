package com.T_T.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor // 모든 필드를 포함하는 생성자
@NoArgsConstructor  // 기본 생성자
@RequiredArgsConstructor // NonNull 필드를 포함하는 생성자

public class Member {
    @NonNull
    private String user_email;
    @NonNull
    private String user_pw;
    @NonNull
    private String user_name;
    @NonNull
    private String user_mbti;	
    
    
    public Member(String user_email, String user_pw) {
        this.user_email = user_email;
        this.user_pw = user_pw;
    }
}
