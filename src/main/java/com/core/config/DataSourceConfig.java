package com.core.config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

@Configuration
@MapperScan(basePackages = {"com.core.event.mapper", "com.core.product.mapper", "com.core.brand.mapper"})
@EnableTransactionManagement
public class DataSourceConfig {

    /**
     * DataSource 빈 생성
     * 시스템 프로퍼티나 환경 변수에서 값을 읽고, 없으면 기본값 사용
     * 순수 Spring MVC에서는 application.yml을 사용하지 않음
     */
    @Bean
    public DataSource dataSource() {
        // 시스템 프로퍼티 또는 환경 변수에서 읽기 (우선순위: 시스템 프로퍼티 > 환경 변수 > 기본값)
        String jdbcUrl = System.getProperty("db.url", 
            System.getenv("DB_URL") != null ? System.getenv("DB_URL") : 
            "jdbc:postgresql://199.192.27.181:10036/hddfs_dev");
        
        String username = System.getProperty("db.username",
            System.getenv("DB_USERNAME") != null ? System.getenv("DB_USERNAME") :
            "hddfs_dev");
        
        String password = System.getProperty("db.password",
            System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") :
            "123456");
        
        String driverClassName = System.getProperty("db.driver",
            System.getenv("DB_DRIVER") != null ? System.getenv("DB_DRIVER") :
            "org.postgresql.Driver");
        
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl(jdbcUrl);
        config.setUsername(username);
        config.setPassword(password);
        config.setDriverClassName(driverClassName);
        config.setMaximumPoolSize(10);
        config.setMinimumIdle(5);
        config.setConnectionTimeout(30000);
        config.setIdleTimeout(600000);
        config.setMaxLifetime(1800000);
        // 연결 실패 시에도 애플리케이션이 시작되도록 설정 (0 = 무한 대기, -1 = 즉시 실패하지 않음)
        config.setInitializationFailTimeout(-1);
        // 연결 테스트 쿼리
        config.setConnectionTestQuery("SELECT 1");
        
        HikariDataSource dataSource = new HikariDataSource(config);
        return dataSource;
    }

    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) {
        try {
            SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
            sessionFactory.setDataSource(dataSource);
            sessionFactory.setConfigLocation(new ClassPathResource("mybatis-config.xml"));
            sessionFactory.setMapperLocations(new PathMatchingResourcePatternResolver()
                    .getResources("classpath:mapper/**/*.xml"));
            return sessionFactory.getObject();
        } catch (Exception e) {
            // 데이터베이스 연결 실패 시에도 애플리케이션이 시작되도록 예외를 로그만 남기고 계속 진행
            System.err.println("⚠️ SqlSessionFactory 생성 실패 (데이터베이스 연결 문제일 수 있음): " + e.getMessage());
            e.printStackTrace();
            // 예외를 다시 던지지 않고 null을 반환하면 안 되므로, 빈 생성은 실패하지만 
            // 애플리케이션 시작은 계속되도록 하려면 @ConditionalOnBean 같은 조건부 빈을 사용해야 함
            // 일단은 예외를 던지되, DataSource 설정에서 이미 initializationFailTimeout(-1)을 설정했으므로
            // 연결 실패해도 빈 생성은 시도됨
            throw new RuntimeException("SqlSessionFactory 생성 실패: " + e.getMessage(), e);
        }
    }

    @Bean
    public PlatformTransactionManager transactionManager(DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }
}
