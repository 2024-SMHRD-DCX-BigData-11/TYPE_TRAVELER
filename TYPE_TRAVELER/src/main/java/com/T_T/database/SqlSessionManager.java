package com.T_T.database;

import java.io.IOException;
import java.io.Reader;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlSessionManager {     
    public static SqlSessionFactory sqlSessionFactory;

    static {
        String resource = "com/T_T/database/mybatis-config.xml";      
        Reader reader;
        try {
            reader = Resources.getResourceAsReader(resource);
            //SqlSessionFactory : SqlSession(db연결, Sql 실행, 트랜잭션 관리) 생성
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static SqlSessionFactory getSqlSession() {
        return sqlSessionFactory;
    }
}
