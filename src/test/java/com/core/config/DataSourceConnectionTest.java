package com.core.config;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * DataSource 연결 테스트 클래스
 */
public class DataSourceConnectionTest {

    @Test
    public void testDataSourceConnection() {
        System.out.println("=== DataSource 연결 테스트 시작 ===");
        
        try {
            // Spring Context 생성 및 DataSourceConfig 로드
            ApplicationContext context = new AnnotationConfigApplicationContext(DataSourceConfig.class);
            DataSource dataSource = context.getBean(DataSource.class);
            
            
            // 연결 테스트
            try (Connection conn = dataSource.getConnection()) {
                // 간단한 쿼리 실행 테스트
                try (Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT 1 as test, current_timestamp as now")) {
                    
                    if (rs.next()) {
                        System.out.println("✅ 쿼리 실행 성공!");
                        System.out.println("   Test Value: " + rs.getInt("test"));
                        System.out.println("   Current Time: " + rs.getTimestamp("now"));
                    }
                }
                
                System.out.println("=== DataSource 연결 테스트 완료 ===");
                
            } catch (Exception e) {
                System.err.println("❌ 데이터베이스 연결 실패!");
                System.err.println("에러 메시지: " + e.getMessage());
                e.printStackTrace();
                System.err.println("=== DataSource 연결 테스트 실패 ===");
                throw e;
            }
            
        } catch (Exception e) {
            System.err.println("❌ DataSource 빈 생성 실패!");
            System.err.println("에러 메시지: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("DataSource 연결 테스트 실패", e);
        }
    }
}


