# 📚 Java 도서 관리 시스템 (Oracle + MVC + JDBC + ConnectionPool)

---

## 📌 개요 (Overview)

이 프로젝트는 **도서 등록/조회/수정/삭제**를 기반으로 한  
**Oracle Database** 연동 Java 프로그램입니다!  

구조는 철저하게 **MVC 패턴**과 **싱글톤 패턴**을 따르고,  
**커넥션 풀(Connection Pool)** 로 성능 최적화까지 고려했습니다. 🚀

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🧱 전체 시스템 구조

```text
[Viewer (View)] 
      ↓ 
[FrontController] 
      ↓ 
[SubController (BookController 등)] 
      ↓ 
[Service Layer (BookServiceImpl)] 
      ↓ 
[DAO Layer (BookDAOImpl)] 
      ↓ 
[Oracle Database + ConnectionPool]
```

---

### ✨ 사용된 주요 기술

| 요소         | 설명                                                                                         |
|--------------|---------------------------------------------------------------------------------------------|
| **MVC 패턴**  | Controller-Service-DAO 레이어를 분리하여 역할 구분                                          |
| **JDBC**     | Java로 Oracle 데이터베이스와 직접 통신                                                       |
| **Connection Pool** | DB 연결을 매번 새로 만들지 않고, 재사용하여 속도 향상                                |
| **Singleton 패턴** | DAO, Service, Controller 계층에서 단일 객체를 생성하여 관리                          |
| **FrontController 패턴** | 하나의 진입점으로 모든 요청을 받아 서브 컨트롤러에 위임                         |
| **JUnit**    | Controller, DAO, Service 계층 단위 테스트 수행                                               |

---

### 🗂️ 주요 클래스 설명

| 분류         | 클래스명                     | 설명                                                  |
|--------------|-------------------------------|-------------------------------------------------------|
| **Domain**   | BookDTO, BookDAO, BookDAOImpl | 데이터 전송 및 DB접근(Insert/Delete/Select)           |
| **Service**  | BookServiceImpl               | 비즈니스 로직 처리 (트랜잭션 처리 포함)                |
| **Controller** | FrontController, BookController | 요청 라우팅 및 세부처리 담당                           |
| **Viewer**   | Viewer                       | 사용자와 상호작용하는 콘솔 메뉴 UI                      |
| **Test**     | ControllerTest, DAOTest, ServiceTest | JUnit5 기반 단위 테스트 케이스 작성                    |

---

### 🔥 지원하는 기능

- 도서 등록 (Insert)
- 도서 조회 (Select / SelectAll) *(진행 중)*
- 도서 수정 (Update) *(진행 중)*
- 도서 삭제 (Delete)
- 트랜잭션 기반 처리 (insert 실패시 rollback)
- JDBC Connection Pool 사용

---

## ⚠ 주의사항 (Cautions)

- **DB 연결 정보**(`url`, `id`, `pw`)는 `BookDAOImpl` 안에 설정되어 있습니다. 본인 DB 환경에 맞게 수정해주세요!
- **Oracle JDBC 드라이버**(ojdbc8.jar 등)가 반드시 classpath에 포함되어야 합니다.
- `book_tbl` 테이블이 Oracle DB에 미리 생성되어 있어야 합니다.
- **ConnectionPool** 초기 설정에 따라 ConnectionItem 개수를 관리할 수 있습니다 (기본 10개).

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 🍴 FrontController
> "레스토랑의 종합 안내데스크"  
> (어디로 갈지 결정해주는 중앙 관리자)

---

### 🛠️ DAO
> "은행 창구 직원"  
> (DB에 직접 가서 돈 입금/출금하는 사람)

---

### ♻️ ConnectionPool
> "공유 우산" ☔  
> (필요할 때 빌려쓰고, 다 쓰면 다시 제자리에 돌려놓기!)

---

## ✅ 한 줄 요약 (1-Line Summary)

> **JDBC + MVC + 싱글톤 + ConnectionPool로 안정적인 Oracle 도서 관리 시스템을 설계했습니다! 🎯**

---

# 📋 실행 순서 요약

1. **Oracle Database 준비**
   - `book_tbl` 테이블 생성 (필수!)
   
2. **JDBC 드라이버(ojdbc.jar) 프로젝트에 포함**

3. **BookDAOImpl**에서 `url`, `id`, `pw` 수정

4. **JUnit 테스트 실행**
   - `DAOTest`
   - `ServiceTest`
   - `ControllerTest`

5. **Viewer 실행 (Main.java)**
   - 콘솔 메뉴로 직접 프로그램 사용 가능!

---

# 🚀 추가 기능 아이디어 (To-Do)

- [ ] 도서 수정/조회 기능 완성
- [ ] 회원 테이블, 대여 테이블 추가
- [ ] 로그인/로그아웃 세션 관리
- [ ] 관리자/회원 권한별 메뉴 분리
- [ ] API 문서 자동화 (Swagger 등)
- [ ] Spring Boot 기반 REST API로 리팩토링

---

**🔥 꾸준한 확장과 리팩토링을 통해 완성도 높은 프로젝트를 만들어 가봅시다!**
