package com.T_T.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.T_T.database.SqlSessionManager;

public class MemberDAO {

    SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

    public int join(Member member) {
        SqlSession session = sqlSessionFactory.openSession(true);
        int cnt = session.insert("com.T_T.database.MemberMapper.join", member);
        session.close();
        return cnt;
    }

    public Member login(Member member) {
        SqlSession session = sqlSessionFactory.openSession(true);
        Member login_member = session.selectOne("com.T_T.database.MemberMapper.login", member);
        session.close();
        return login_member;
    }

    public Member getMemberByEmail(String email) {
        SqlSession session = sqlSessionFactory.openSession(true);
        Member member = session.selectOne("com.T_T.database.MemberMapper.getMemberByEmail", email);
        session.close();
        return member;
    }

    public boolean updateMember(Member member) {
        SqlSession session = sqlSessionFactory.openSession(true);
        int cnt = session.update("com.T_T.database.MemberMapper.updateMember", member);
        session.close();
        return cnt > 0;
    }
}
