package com.T_T.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.T_T.database.SqlSessionManager;


public class MemberDAO {
	
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	
    public Member login(Member member) {
        SqlSession session = sqlSessionFactory.openSession(true);
        Member login_member = session.selectOne("com.T_T.database.MemberMapper.login", member);
        session.close();
        return login_member;
	}	

}
