# 📚 Java MVC 기반 도서 관리 시스템 (with JDBC, Singleton Pattern, Layered Architecture)

---

## 📌 개요 (Overview)

이번 프로젝트에서는

- **Dto/Dao/Service/Controller 구조**
- **JDBC를 이용한 MySQL 연동**
- **FrontController 패턴**
- **싱글톤(Singleton) 패턴**
- **JUnit을 통한 단위 테스트**

를 모두 적용해서  
간단한 **도서 등록 및 회원 가입 시스템**을 완성했습니다! 🛠️

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🧱 전체 아키텍처 구조

```text
[View (테스트 코드)]
       ↓
[FrontController]
       ↓
[SubController (UserController, BookController)]
       ↓
[Service Layer (UserServiceImpl)]
       ↓
[DAO Layer (UserDaoImpl, BookDaoImpl)]
       ↓
[MySQL Database]
```

---

### ✨ 주요 기술 요소

| 요소          | 설명                                                                                     |
|---------------|-------------------------------------------------------------------------------------------|
| **DTO**       | 데이터 전송 객체 (UserDto, BookDto)                                                        |
| **DAO**       | DB 접근 객체 (UserDaoImpl, BookDaoImpl)                                                    |
| **Service**   | 비즈니스 로직 처리 (UserServiceImpl)                                                      |
| **Controller**| 요청 분기 및 처리 담당 (FrontController + SubControllers)                                 |
| **JDBC**      | Java와 MySQL DB 연동 (Connection, PreparedStatement, ResultSet 활용)                      |
| **싱글톤**    | DAO, Service, FrontController에 적용하여 인스턴스 1개만 생성                               |
| **테스트**    | JUnit5를 사용하여 Controller, DAO, Service 단위테스트 수행                                |

---

### 🗂️ 주요 클래스 및 파일 설명

| 분류         | 클래스명                | 설명                                  |
|--------------|-------------------------|--------------------------------------|
| **DTO**     | UserDto, BookDto         | 데이터 전송용 객체                   |
| **DAO**     | UserDaoImpl, BookDaoImpl | JDBC를 사용하여 DB 접근 및 CRUD 수행 |
| **Service** | UserServiceImpl          | 비즈니스 로직 처리                   |
| **Controller** | FrontController, UserController, BookController | 요청 분기 및 서비스 호출 |
| **인터페이스** | SubController           | 모든 Controller가 구현해야 할 인터페이스 |
| **테스트**   | ControllerTests, DaoTests, ServiceTests | 각 계층별 단위 테스트 수행 |

---

### 🔥 기능 요약

- **회원가입** (/user, serviceNo=1)
- **도서등록** (/book, serviceNo=1)
- (※ 조회, 수정, 삭제 기능은 일부 미완성, 확장 예정)

---

## ⚠ 주의사항 (Cautions)

- **DB 연결정보** (`url`, `id`, `pw`)는 `DaoImpl` 내부에 하드코딩 되어있으니, 환경에 맞게 수정 필요합니다!
- `tbl_user`, `tbl_book` 테이블 사전 생성 필요!
- **MySQL Driver (Connector/J)** 라이브러리가 반드시 포함되어야 JDBC 연결이 됩니다.
- 싱글톤 패턴 사용 시 **multi-thread 환경에서는 주의**가 필요합니다 (현재는 단일 실행 기준 설계).
- 유효성 검증 로직이 기본적으로 들어있지만, 추가 검증이 필요할 수 있습니다.

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 🧠 FrontController
> "식당의 주문받는 매니저" 🍽️  
> (어떤 요청이 오든 담당 부서(Controller)로 정확히 연결해줍니다.)

---

### 🛠️ DAO
> "서버랑 직접 대화하는 전담 오퍼레이터" 🎙️  
> (SQL을 직접 실행하고 결과를 넘겨줍니다.)

---

### 🧩 싱글톤 패턴
> "1명만 존재하는 전담 매니저" 👤  
> (한 번만 만들어지고 끝까지 그 객체를 재사용합니다.)

---

## ✅ 한 줄 요약 (1-Line Summary)

> **JDBC + MVC + 싱글톤 패턴을 활용해 깔끔하고 계층화된 Java 백엔드 어플리케이션을 구현했습니다! 🚀**

---

# 📋 실행 방법 요약

1. **MySQL에 bookDB 데이터베이스 생성**
2. **tbl_user, tbl_book 테이블 생성**
3. **JDBC 연결 확인 (url, id, pw 수정)**
4. **JUnit 테스트 실행**
    - `DaoTests`
    - `ServiceTests`
    - `ControllerTests`

---

# 📌 추가 확장 아이디어 (Optional)

- ✅ 로그인(Session 개념 추가)
- ✅ 회원 정보 수정 / 삭제
- ✅ 도서 수정 / 삭제
- ✅ 권한(Role) 별 기능 분리 (ex. 회원 vs 관리자)
- ✅ 예외처리(ErrorController 추가)

---

🎯 **다음 레벨로 넘어가기 준비 완료입니다!**
