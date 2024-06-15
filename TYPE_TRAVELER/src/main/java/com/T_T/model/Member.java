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
    private String email;
    @NonNull
    private String pw;
    private String name;
    private String mbti;
}
