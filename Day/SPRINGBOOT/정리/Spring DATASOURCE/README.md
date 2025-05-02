
# 🧩 DATASOURCE 정리

📌 개요 (Overview)

DATASOURCE는 데이터베이스와의 연결을 관리하는 핵심 설정입니다. 커넥션 풀을 이용해 성능을 최적화하고, 여러 개의 데이터 소스를 설정하여 다양한 DB 작업을 수행할 수 있도록 구성합니다.

💡 핵심 개념 요약 (Key Concepts)

- `DataSource`: 데이터베이스 연결을 위한 기본 인터페이스입니다.
- `HikariCP`: Spring Boot에서 기본적으로 사용하는 커넥션 풀 구현체로, 빠르고 가볍습니다.
- 다중 DataSource: 하나의 애플리케이션에서 여러 데이터베이스를 동시에 사용하는 구성입니다.

⚠ 주의사항 (Cautions)

- 다중 데이터소스를 설정할 때는 각 데이터소스마다 별도의 `@Bean`, `@Qualifier`, `@Primary` 설정이 필요합니다.
- 테스트 코드에서는 실제 DB가 아닌 Mock 또는 Test DB를 사용하도록 환경 분리가 필요합니다.

---

## 📄 DataSourceConfig.java

📂 위치: `src/main/java/com/example/demo/config/DataSourceConfig.java`

✍️ 파일 간단 설명: 애플리케이션과 DB를 연결하는 데이터소스 설정 또는 테스트 클래스입니다.

🧩 코드 일부 발췌:
```java
package com.example.demo.config;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import javax.sql.DataSource;
@Configuration
public class DataSourceConfig {
	// Spring-jdbc DataSource
	@Bean
```

📌 등장 메서드 목록:
- dataSource2()
- dataSource3()

🔍 코드 속 개념 설명:
DataSource를 설정하거나 이를 테스트하는 데 사용되는 구성 클래스입니다.

🧠 등장하는 주요 키워드 설명:
- 🔌 `DataSource`: JDBC 커넥션을 제공하는 객체입니다.
- 🚰 `HikariDataSource`: HikariCP 기반의 커넥션 풀 구현체입니다.
- 🧪 `@Test`: JUnit 테스트 메서드임을 나타내는 어노테이션입니다.
- 💉 `@Autowired`: 빈 주입을 자동으로 처리합니다.


🧪 예제 또는 비유 (Examples or Analogies)

- DataSource는 DB로 가는 수도꼭지이고, 커넥션 풀은 수도꼭지를 효율적으로 여러 개 관리하는 정수 시스템과 같습니다.


---

## 📄 DataSourceConfigTest.java

📂 위치: `src/test/java/com/example/demo/config/DataSourceConfigTest.java`

✍️ 파일 간단 설명: 애플리케이션과 DB를 연결하는 데이터소스 설정 또는 테스트 클래스입니다.

🧩 코드 일부 발췌:
```java
package com.example.demo.config;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
@SpringBootTest
class DataSourceConfigTest {
    @Autowired
```

📌 등장 메서드 목록:
- t1()
- t2()

🔍 코드 속 개념 설명:
DataSource를 설정하거나 이를 테스트하는 데 사용되는 구성 클래스입니다.

🧠 등장하는 주요 키워드 설명:
- 🔌 `DataSource`: JDBC 커넥션을 제공하는 객체입니다.
- 🚰 `HikariDataSource`: HikariCP 기반의 커넥션 풀 구현체입니다.
- 🧪 `@Test`: JUnit 테스트 메서드임을 나타내는 어노테이션입니다.
- 💉 `@Autowired`: 빈 주입을 자동으로 처리합니다.


🧪 예제 또는 비유 (Examples or Analogies)

- DataSource는 DB로 가는 수도꼭지이고, 커넥션 풀은 수도꼭지를 효율적으로 여러 개 관리하는 정수 시스템과 같습니다.


---

## 📄 DataSourceTests.java

📂 위치: `src/test/java/com/example/demo/config/DataSourceTests.java`

✍️ 파일 간단 설명: 애플리케이션과 DB를 연결하는 데이터소스 설정 또는 테스트 클래스입니다.

🧩 코드 일부 발췌:
```java
package com.example.demo.config;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
@SpringBootTest
public class DataSourceTests {
    @Autowired
```

📌 등장 메서드 목록:
- t1()

🔍 코드 속 개념 설명:
DataSource를 설정하거나 이를 테스트하는 데 사용되는 구성 클래스입니다.

🧠 등장하는 주요 키워드 설명:
- 🔌 `DataSource`: JDBC 커넥션을 제공하는 객체입니다.
- 🚰 `HikariDataSource`: HikariCP 기반의 커넥션 풀 구현체입니다.
- 🧪 `@Test`: JUnit 테스트 메서드임을 나타내는 어노테이션입니다.
- 💉 `@Autowired`: 빈 주입을 자동으로 처리합니다.


🧪 예제 또는 비유 (Examples or Analogies)

- DataSource는 DB로 가는 수도꼭지이고, 커넥션 풀은 수도꼭지를 효율적으로 여러 개 관리하는 정수 시스템과 같습니다.


📚 한 줄 요약 (1-Line Summary)

데이터베이스와의 안정적인 연결을 위한 설정 및 테스트 구성을 통해 다중 데이터소스 환경도 효과적으로 운용할 수 있습니다.
