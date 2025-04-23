# 🌱 Spring MVC 구조 & Lombok 개념 정리

---

## 🍋 Lombok 정리

## 📌 개요 (Overview)

**Lombok**은 자바에서 너무 자주 반복되는 코드를 자동으로 만들어주는 **마법 도구**야!  
`@Getter`, `@Setter`, `@ToString` 같은 어노테이션 하나만 붙이면,  
**getter/setter, toString, 생성자** 같은 코드를 **직접 쓰지 않아도 자동 생성**해줘!  
➡ 덕분에 **코드가 깔끔해지고**, 실수도 줄일 수 있어! 🙌

---

## 💡 핵심 개념 요약 (Key Concepts)

- 📦 **Lombok은 라이브러리다** → 의존성 추가 후 `@` 어노테이션만 붙이면 자동 코드 생성!
- ✍ **어떤 코드들이 자동 생성될까?**
  - `@Getter` ➡ getName(), getAge() 같은 메서드 자동 생성
  - `@Setter` ➡ setName("홍길동") 같은 메서드 자동 생성
  - `@ToString` ➡ 객체 정보를 보기 좋게 출력하는 메서드 자동 생성
  - `@NoArgsConstructor` ➡ 기본 생성자 자동 생성
  - `@AllArgsConstructor` ➡ 모든 필드를 받는 생성자 자동 생성
- 🧼 **DTO, VO 클래스에서 특히 유용하다!**

---

## ⚠ 주의사항 (Cautions)

- 🛠 **IDE 설정 필수!**: Lombok은 자동으로 코드를 생성하므로, IDE(예: Eclipse, IntelliJ)가 이를 인식하도록 설정해야 해.
  - 예: IntelliJ에서는 "Enable annotation processing"을 꼭 켜줘야 해!
- ❌ **디버깅할 때 헷갈릴 수 있음**: 실제 코드는 없지만, 작동하니까 처음엔 마법처럼 느껴질 수 있어.
- 📦 **의존성 꼭 추가해야 함!**
  ```xml
  <!-- Maven 기준 -->
  <dependency>
      <groupId>org.projectlombok</groupId>
      <artifactId>lombok</artifactId>
      <version>1.18.30</version> <!-- 버전은 상황에 따라 변경 -->
      <scope>provided</scope>
  </dependency>

---

## 📌 이 프로젝트로 배운 것

- Spring MVC 기본 구조와 동작 흐름
- DispatcherServlet과 Context 설정 분리 (`web.xml`, `root-context.xml`, `servlet-context.xml`)
- Java 기반 Bean 등록 (`@Configuration`, `@Bean`)
- Lombok을 활용한 DTO 선언 및 자동화 (`@Getter`, `@Setter`, `@ToString`)
- ViewResolver 설정을 통한 JSP 연동
- STS3 프로젝트 구조와 Maven 연동

---

## 🧠 핵심 개념 요약

### ✅ DispatcherServlet의 역할
> 모든 클라이언트 요청을 중앙에서 받아 Controller로 분기하는 **Front Controller**

### ✅ Context 설정의 분리
- `root-context.xml`: **Service, DAO 등 전역 Bean 설정**
- `servlet-context.xml`: **Web MVC 관련 설정 (@Controller, ViewResolver)**

### ✅ Java 기반 Bean 등록
```java
@Configuration
public class PersonDtoBeanConfig {
    @Bean
    public PersonDto personDto() {
        return new PersonDto();
    }
}
```
→ XML 없이 Java 코드로 직접 Bean 설정이 가능하며 가독성과 유지보수성이 높음

---

## ⚙️ 프로젝트 구조 요약

```plaintext
src/main/java
└── com.example.app
    ├── config/
    │   ├── PersonComponent.java        // @Component 예시
    │   └── PersonDtoBeanConfig.java    // Java 기반 Bean 등록
    ├── controller/
    │   ├── HomeController.java         // @Controller 예시
    │   └── SimpleController.java
    └── domain/dto/
        └── PersonDto.java              // Lombok 기반 DTO

src/main/webapp/WEB-INF
├── web.xml                            // DispatcherServlet 등록
└── spring/
    ├── root-context.xml               // 전역 Bean 설정
    └── appServlet/servlet-context.xml // MVC 관련 설정

src/main/resources
└── log4j.xml                          // 로그 설정
```

---

## 🔁 동작 흐름

```plaintext
1. 사용자가 브라우저에서 / 요청
2. DispatcherServlet(web.xml에 등록) 이 요청을 받음
3. servlet-context.xml 설정을 기반으로 HomeController 실행
4. Controller가 JSP 뷰 이름 반환
5. ViewResolver가 JSP 위치를 찾아 렌더링
```

---

## 🧪 Lombok + DI 실습 예시

### 📌 `PersonDto.java`
```java
@Getter
@Setter
@ToString
public class PersonDto {
    private String name;
    private int age;
}
```

→ getter/setter, toString 메서드가 자동 생성되어 DTO 코드 간결화

---

### 📌 `PersonDtoBeanConfig.java`
```java
@Configuration
public class PersonDtoBeanConfig {
    @Bean
    public PersonDto personDto() {
        return new PersonDto();
    }
}
```

→ 이 Bean은 다른 클래스에서 `@Autowired`로 주입받을 수 있음

---

## 🧩 사용한 기술 요약

| 기술 | 설명 | 사용 목적 |
|------|------|------------|
| Spring MVC | 웹 요청 처리 프레임워크 | 사용자 요청 처리 |
| Lombok | DTO 코드 자동 생성 | 코드 간결화 |
| Java Config | XML 대체 설정 방식 | Bean 등록 |
| DispatcherServlet | 요청의 중앙 처리자 | Controller 연결 |
| ViewResolver | JSP 매핑 처리 | 결과 화면 연결 |

---

## ✅ 한 줄 요약

> **이 프로젝트는 Spring MVC 구조를 직접 구현해보고, Java 기반 설정과 Lombok을 활용한 Bean 관리까지 경험해보는 실습 예제입니다.**

---

