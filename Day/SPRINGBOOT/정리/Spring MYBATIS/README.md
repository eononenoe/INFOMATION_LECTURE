
# 🗂 MYBATIS 정리

📌 개요 (Overview)

MYBATIS는 SQL 쿼리를 직접 작성하여 객체와 매핑해주는 ORM 프레임워크입니다. XML 또는 어노테이션 방식으로 SQL을 정의할 수 있으며, 복잡한 쿼리를 유연하게 다룰 수 있습니다.

💡 핵심 개념 요약 (Key Concepts)

- `@Mapper`: 인터페이스를 MyBatis 매퍼로 등록하여 XML과 매핑합니다.
- `SqlSessionFactory`: SQL 실행을 위한 세션을 생성하는 팩토리 객체입니다.
- `Mapper XML`: SQL 쿼리를 정의하는 XML 파일로, 인터페이스 메서드와 매핑됩니다.
- `sqlSessionTemplate`: 트랜잭션과 연동되어 동기식 SQL 실행을 보장하는 템플릿 객체입니다.

⚠ 주의사항 (Cautions)

- Mapper XML의 namespace는 반드시 인터페이스의 FQCN과 일치해야 합니다.
- MyBatis 설정 시에는 `SqlSessionFactory`, `DataSource`, `MapperScan` 구성이 적절히 연결되어야 합니다.

---

## 📄 MybatisConfig.java

📂 위치: `src/main/java/com/example/demo/config/MybatisConfig.java`

✍️ 파일 간단 설명: MyBatis 설정 또는 매퍼 인터페이스 및 테스트를 포함하는 클래스입니다.

🧩 코드 일부 발췌:
```java
package com.example.demo.config;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import javax.sql.DataSource;
```

📌 등장 메서드 목록:
- sqlSessionFactory()
- sqlSessionTemplate()

🔍 코드 속 개념 설명:
MyBatis와 관련된 설정, SQL 매핑 인터페이스, 테스트 구현을 포함합니다.

🧠 등장하는 주요 키워드 설명:
- 🧩 `@Mapper`: 인터페이스를 MyBatis 매퍼로 인식시킵니다.
- 🏗 `SqlSessionFactory`: SQL 실행 세션을 생성합니다.
- 🌀 `sqlSessionTemplate`: SqlSession의 템플릿으로 트랜잭션 처리와 SQL 실행을 관리합니다.
- 🧪 `@MapperScan`: 매퍼 인터페이스들이 위치한 패키지를 지정합니다.


🧪 예제 또는 비유 (Examples or Analogies)

- MyBatis는 JDBC로 SQL을 직접 작성하되, 객체와 SQL을 연결해주는 통역사 역할을 합니다.


---

## 📄 MemoMapper.java

📂 위치: `src/main/java/com/example/demo/domain/mapper/MemoMapper.java`

✍️ 파일 간단 설명: MyBatis 설정 또는 매퍼 인터페이스 및 테스트를 포함하는 클래스입니다.

🧩 코드 일부 발췌:
```java
package com.example.demo.domain.mapper;
import com.example.demo.domain.dto.MemoDto;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;
@Mapper
public interface MemoMapper {
	@SelectKey(statement="select max(id)+1 from tbl_memo",keyProperty = "id",before = false, resultType = int.class)
	@Insert(value = "insert into tbl_memo values(#{id},#{text},#{writer},#{createAt})")
	public int insert(MemoDto memoDto);
```

📌 등장 메서드 목록:
- insert()
- update()
- delete()
- selectAt()
- insertXml()
- updateXml()
- deleteXml()
- selectAtXml()

🔍 코드 속 개념 설명:
MyBatis와 관련된 설정, SQL 매핑 인터페이스, 테스트 구현을 포함합니다.

🧠 등장하는 주요 키워드 설명:
- 🧩 `@Mapper`: 인터페이스를 MyBatis 매퍼로 인식시킵니다.
- 🏗 `SqlSessionFactory`: SQL 실행 세션을 생성합니다.
- 🌀 `sqlSessionTemplate`: SqlSession의 템플릿으로 트랜잭션 처리와 SQL 실행을 관리합니다.
- 🧪 `@MapperScan`: 매퍼 인터페이스들이 위치한 패키지를 지정합니다.


🧪 예제 또는 비유 (Examples or Analogies)

- MyBatis는 JDBC로 SQL을 직접 작성하되, 객체와 SQL을 연결해주는 통역사 역할을 합니다.


---

## 📄 MemoMapperTest.java

📂 위치: `src/test/java/com/example/demo/domain/mapper/MemoMapperTest.java`

✍️ 파일 간단 설명: MyBatis 설정 또는 매퍼 인터페이스 및 테스트를 포함하는 클래스입니다.

🧩 코드 일부 발췌:
```java
package com.example.demo.domain.mapper;
import com.example.demo.domain.dto.MemoDto;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import java.time.LocalDateTime;
@SpringBootTest
@MapperScan
class MemoMapperTest {
```

📌 등장 메서드 목록:
- t1()
- t2()

🔍 코드 속 개념 설명:
MyBatis와 관련된 설정, SQL 매핑 인터페이스, 테스트 구현을 포함합니다.

🧠 등장하는 주요 키워드 설명:
- 🧩 `@Mapper`: 인터페이스를 MyBatis 매퍼로 인식시킵니다.
- 🏗 `SqlSessionFactory`: SQL 실행 세션을 생성합니다.
- 🌀 `sqlSessionTemplate`: SqlSession의 템플릿으로 트랜잭션 처리와 SQL 실행을 관리합니다.
- 🧪 `@MapperScan`: 매퍼 인터페이스들이 위치한 패키지를 지정합니다.


🧪 예제 또는 비유 (Examples or Analogies)

- MyBatis는 JDBC로 SQL을 직접 작성하되, 객체와 SQL을 연결해주는 통역사 역할을 합니다.


📚 한 줄 요약 (1-Line Summary)

MyBatis는 SQL을 직접 작성하면서도 객체와의 매핑을 유연하게 수행할 수 있는 ORM 대체 프레임워크입니다.
