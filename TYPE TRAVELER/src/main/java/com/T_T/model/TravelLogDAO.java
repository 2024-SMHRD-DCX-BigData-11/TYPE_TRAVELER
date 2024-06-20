package com.T_T.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import com.T_T.database.SqlSessionManager;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class TravelLogDAO {

    private static final Logger LOGGER = Logger.getLogger(TravelLogDAO.class.getName());
    private static final String NAMESPACE = "com.T_T.database.TravelLogMapper";

    private SqlSessionFactory sqlSessionFactory;

    public TravelLogDAO() {
        this.sqlSessionFactory = SqlSessionManager.getSqlSession();
    }

    public TravelLogDAO(SqlSessionFactory sqlSessionFactory) {
        this.sqlSessionFactory = sqlSessionFactory;
    }

    public List<TravelLog> selectTravelLogs(PaginationParams params) {
        List<TravelLog> list = null;
        try (SqlSession session = sqlSessionFactory.openSession()) {
            list = session.selectList(NAMESPACE + ".selectTravelLogs", params);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error selecting travel logs", e);
        }
        return list;
    }

    public int countTravelLogs(PaginationParams params) {
        int count = 0;
        try (SqlSession session = sqlSessionFactory.openSession()) {
            count = session.selectOne(NAMESPACE + ".countTravelLogs", params);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error counting travel logs", e);
        }
        return count;
    }

    public void insertTravelLog(TravelLog log) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            session.insert(NAMESPACE + ".insertTravelLog", log);
            session.commit();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error inserting travel log: " + log, e);
        }
    }

    // 추가 메서드: 업데이트
    public void updateTravelLog(TravelLog log) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            session.update(NAMESPACE + ".updateTravelLog", log);
            session.commit();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error updating travel log: " + log, e);
        }
    }

    // 추가 메서드: 삭제
    public void deleteTravelLog(int tlog_id) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            session.delete(NAMESPACE + ".deleteTravelLog", tlog_id);
            session.commit();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error deleting travel log with ID: " + tlog_id, e);
        }
    }
}
