package com.T_T.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.T_T.database.SqlSessionManager;

public class RegionDAO {

   SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

   public List<Region> listAll() {
      SqlSession session = sqlSessionFactory.openSession(true);
      List<Region> rows = session.selectList("com.T_T.database.RegionMapper.listAll");
      session.close();
      return rows;
   }

   public List<Region> list4(Map<String, Object> map) {
      SqlSession session = sqlSessionFactory.openSession(true);
      List<Region> rows = session.selectList("com.T_T.database.RegionMapper.list4", map);
      session.close();
      return rows;
   }

   public int count(Map<String, Object> map) {
      SqlSession session = sqlSessionFactory.openSession(true);
      int rows = session.selectOne("com.T_T.database.RegionMapper.count", map);
      session.close();
      return rows;
   }

   public List<Region> listRandom4() {
      SqlSession session = sqlSessionFactory.openSession(true);
      List<Region> rows = session.selectList("com.T_T.database.RegionMapper.listRandom4");
      session.close();
      return rows;
   }

   public List<Region> selectRegion(Map<String, Object> map) {
      SqlSession session = sqlSessionFactory.openSession(true);
      List<Region> rows = session.selectList("com.T_T.database.RegionMapper.selectRegion", map);
      session.close();
      return rows;
   }

   public List<Integer> selectMbti(String mbti) {
      SqlSession session = sqlSessionFactory.openSession(true);
      List<Integer> rows = session.selectList("com.T_T.database.RegionMapper.selectMbti", mbti);
      session.close();
      return rows;
   }

   public List<Integer> selectMbtis(List<String> mbti) {
      SqlSession session = sqlSessionFactory.openSession(true);
      List<Integer> rows = session.selectList("com.T_T.database.RegionMapper.selectMbtis", mbti);
      session.close();
      return rows;
   }
}
