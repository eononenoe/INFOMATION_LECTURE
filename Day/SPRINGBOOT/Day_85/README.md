## INIT
### config
> JpaConfig
```java
package com.example.demo.config;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.init.DataSourceInitializer;
import org.springframework.jdbc.datasource.init.DatabasePopulator;
import org.springframework.jdbc.datasource.init.DatabasePopulatorUtils;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

@Configuration
@EntityScan(basePackages = {"com.example.demo.domain.entity"})
@EnableJpaRepositories
(
                basePackages ="com.example.demo.domain.repository",
                transactionManagerRef = "jpaTransactionManager"
)
public class JpaConfig {
    @Autowired
    private DataSource dataSource;

    @Bean
    LocalContainerEntityManagerFactoryBean entityManagerFactory() {
        LocalContainerEntityManagerFactoryBean entityManagerFactoryBean = new LocalContainerEntityManagerFactoryBean();
        entityManagerFactoryBean.setDataSource(dataSource);
        entityManagerFactoryBean.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
        entityManagerFactoryBean.setPackagesToScan("com.example.demo.domain.entity");

        Properties jpaProperties = new Properties();


        Map<String, Object> properties = new HashMap<>();
        properties.put("hibernate.hbm2ddl.auto", "update");                         // 필요에 따라 'create', 'validate' 등으로 변경
        properties.put("hibernate.dialect", "org.hibernate.dialect.MySQLDialect"); // 사용 중인 DB에 맞게 변경
        properties.put("hibernate.show_sql", true);
        properties.put("hibernate.format_sql", true);

        properties.put("hibernate.hibernate.jdbc.batch_size", 1000);
        properties.put("hibernate.hibernate.order_inserts", true);
        properties.put("hibernate.order_updates", true);
        properties.put("hibernate.jdbc.batch_versioned_data", true);
        entityManagerFactoryBean.setJpaPropertyMap(properties);

        return entityManagerFactoryBean;
    }


    //애플리케이션 시작 시 데이터베이스 초기화
    @Bean
    public DataSourceInitializer dataSourceInitializer() {
        DataSourceInitializer initializer = new DataSourceInitializer();
        initializer.setDataSource(dataSource);
        initializer.setDatabasePopulator(databasePopulator());
        return initializer;
    }

    //schema.sql과 data.sql 스크립트를 실행
    private DatabasePopulator databasePopulator() {
        //Spring Framework에서 제공하는 클래스로, 외부 리소스에 정의된 SQL 스크립트를 사용하여 데이터베이스를 초기화하거나 정리하는 데 사용
        ResourceDatabasePopulator populator = new ResourceDatabasePopulator();
        //src/main/resources 디렉토리에 위치한 SQL 스크립트를 로드
        Resource schemaScript = new ClassPathResource("schema.sql");
        Resource dataScript = new ClassPathResource("data.sql");
        populator.addScript(schemaScript);
        populator.addScript(dataScript);
        return populator;
    }

}
```
---
> TxConfig
```java
package com.example.demo.config;

import jakarta.persistence.EntityManagerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

@Configuration
@EnableTransactionManagement
public class TxConfig {
    @Autowired
    private DataSource dataSource;

    // 기본 TransactionManager
    @Bean(name = "dataSourceTransactionManager")
    public DataSourceTransactionManager transactionManager2() {
        //System.out.println("TX dataSrouce2 : " + dataSource2.toString());
        return new DataSourceTransactionManager(dataSource);
    }


    //    JPA TransactionManager Settings
    @Bean(name="jpaTransactionManager")
    public JpaTransactionManager jpaTransactionManager(EntityManagerFactory entityManagerFactory) {
        JpaTransactionManager transactionManager = new JpaTransactionManager();
        transactionManager.setEntityManagerFactory(entityManagerFactory);
        transactionManager.setDataSource(dataSource);

        return transactionManager;
    }

}
```
---
## DATASOURCE
### repository
> BookRepository
```java
package com.example.demo.domain.repository;

import com.example.demo.domain.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookRepository extends JpaRepository<Book,Long>{
    List<Book> findByBookName(String bookName);
    List<Book> findByPublisher(String publisher);
    List<Book> findByIsbn(String isbn);
    Book findByBookNameAndIsbn(String bookName, String isbn);
    List<Book> findByBookNameContains(String keyword);

    int countByBookName(String bookName);
    int countByBookNameContains(String bookName);
    //삭제
    void deleteByBookName(String bookname);

    //명명규칙 참고
// 07 JPA 명명규칙 확인 ------------------------------
//    // 책 이름으로 책 검색
//    List<Book> findByBookname(String bookname);
//    // 출판사로 책 검색
//    List<Book> findByPublisher(String publisher);
//    // ISBN으로 책 검색
//    Book findByIsbn(String isbn);
//    // 책 코드 범위로 책 검색
//    List<Book> findByBookcodeBetween(long start, long end);
//
//    // 책 이름이나 출판사로 책 검색
//    List<Book> findByBooknameOrPublisher(String bookname, String publisher);
//
//    // 책 이름이나 출판사로 책 검색, 정렬하여 가져오기
//    List<Book> findByBooknameOrPublisherOrderByBooknameAsc(String bookname, String publisher);
//
//    // 책 이름에 특정 문자열이 포함된 책 검색
//    List<Book> findByBooknameContaining(String keyword);
//
//    // 출판사가 특정 문자열로 시작하는 책 검색
//    List<Book> findByPublisherStartingWith(String prefix);
//
//    // 책 이름으로 책 개수 가져오기
//    int countByBookname(String bookname);
//
//    // 출판사로 책 개수 가져오기
//    int countByPublisher(String publisher);
//
//    // 책 이름으로 책 삭제
//    void deleteByBookname(String bookname);
// 07 JPA 명명규칙 확인  끝-----------------------------

}
```
---
> LendRepository
```java
package com.example.demo.domain.repository;

import com.example.demo.domain.entity.Lend;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LendRepository extends JpaRepository<Lend,Long> {
    @Query("SELECT l FROM Lend AS l JOIN FETCH l.user  where l.user.username = :username")
    List<Lend> findLendsByUser(@Param("username") String username);

    @Query("SELECT l FROM Lend AS l JOIN FETCH l.user JOIN FETCH l.book")
    List<Lend> findLendsByUserAndBook();

}
```
---
> MemoRepository
```java
package com.example.demo.domain.repository;

import com.example.demo.domain.entity.Memo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MemoRepository extends JpaRepository<Memo,Integer> {
}
```
---
## JPA_ENTITY
### entity
> Book
```java
package com.example.demo.domain.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="book")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Book {
    @Id
//  @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="bookcode")
    private Long bookCode;
    @Column(name="bookname")
    private String bookName;
    private String publisher;
    private String isbn;
}
```
---
> Lend
```java
package com.example.demo.domain.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="lend")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Lend {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER) //기본값
//    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "bookcode", foreignKey = @ForeignKey(name="FK_LEND_BOOK",
            foreignKeyDefinition = "FOREIGN KEY(bookcode) REFERENCES book(bookcode) ON DELETE CASCADE ON UPDATE CASCADE" ))
    private Book book;

//    @ManyToOne(fetch = FetchType.EAGER) //기본값
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "username", foreignKey = @ForeignKey(name="FK_LEND_USER",
            foreignKeyDefinition = "FOREIGN KEY(username) REFERENCES user(username) ON DELETE CASCADE ON UPDATE CASCADE" ))
    private User user;


}
```
---
> Memo
```java
package com.example.demo.domain.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="memo")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Memo {
    @Id
    private int id;
    private String text;


}
```
---
## SERVICE
### service
> TxTestService
```java
package com.example.demo.domain.service;

import com.example.demo.domain.dto.MemoDto;
import com.example.demo.domain.entity.Memo;
import com.example.demo.domain.mapper.MemoMapper;
import com.example.demo.domain.repository.MemoRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.SQLException;

@Service
@Slf4j
public class TxTestService {

    @Autowired
    private MemoMapper memoMapper;

    @Transactional(rollbackFor = SQLException.class,transactionManager = "dataSourceTransactionManager")
    public void addMemoTx(MemoDto dto) throws Exception	 {
        log.info("MemoService's addMemoTx Call! ");
        memoMapper.insert(dto);//01 정상INSERT
        throw new SQLException();
    }

    //JPA REPOSITORY
    @Autowired
    private MemoRepository memoRepository;

    @Transactional(rollbackFor = SQLException.class,transactionManager = "jpaTransactionManager")
    public void addMemoTx2(MemoDto dto) throws Exception{
        log.info("MemoService's addMemoTx2 Call!");
        Memo memo = new Memo();
        memo.setId(dto.getId());
        memo.setText(dto.getText());
        memoRepository.save(memo);
        throw new SQLException();
    }
}
```
---