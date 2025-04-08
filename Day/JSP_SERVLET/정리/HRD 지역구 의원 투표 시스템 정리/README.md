~~~markdown
# 🌟 HRD 지역구 의원 투표 시스템 정리

---

# 📌 개요 (Overview)

이 프로젝트는 **JSP와 Java**를 활용하여 웹페이지를 동적으로 구성하고, **Oracle DB와 연동**하여 정보를 조회/저장/출력하는 시스템입니다. ✨

**주요 기능:**
- **Order 통계 관리** (품목별, 날짜별, 지역별 구매 데이터 조회)
- **지역구 의원 투표 시스템** (후보자 조회, 투표 등록 및 검수)

HTML, CSS, Java, JSP 문법, JavaBean, Expression Language(EL) 등을 조합하여 완성도 높은 웹 페이지를 구성합니다.

---

# 🗂️ 프로젝트 파일 구조 (Project Structure)

```plaintext
📁 src/
   ├── 📄 OrderDto.java
   ├── 📄 OrderDto2.java
   ├── 📄 OrderDto3.java
   ├── 📄 MemberDto.java
   ├── 📄 VoteDto.java
   └── 📄 DBUtils.java

📁 WebContent/
   ├── 📁 layouts/
   │    ├── 📄 Header.jsp
   │    ├── 📄 Nav.jsp
   │    ├── 📄 Footer.jsp
   ├── 📄 01/index.jsp (후보조회)
   ├── 📄 02/index.jsp (투표하기)
   ├── 📄 02/create.jsp (투표 등록)
   ├── 📄 02/read.jsp (투표 검수)
   ├── 📄 03/index.jsp (투표검수조회)
   ├── 📄 selectAll_1.jsp (Order 품목별 통계)
   ├── 📄 selectAll_2.jsp (Order 지역별 통계)
   └── 📄 styles.css
```

---

# 💡 핵심 개념 요약 (Key Concepts)

### 📄 JSP 기본 세팅
- `<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>`
- 한글 깨짐 방지, JSP 설정

### 🧩 JSP 파일 분리 및 포함
- `<%@include file="/layouts/Header.jsp" %>` : Header, Nav, Footer를 따로 관리해 유지보수 편리

### 🎨 기본 레이아웃 구조
- `.wrapper`를 중심으로 `header`, `nav`, `main`, `footer` 배치
- `calc(100vh - 고정 높이들)`로 메인 영역 동적 높이 설정

### 🛠 데이터베이스 연동 (DBUtils)
- 싱글톤 패턴으로 DB 연결 및 조회/삽입
- 주요 메서드
  - `selectAllOrder()`, `selectAllOrder2()`, `selectAllOrder3()`
  - `selectAllMember()`, `insertVote()`, `selectAllVote()`

### 📦 DTO (Data Transfer Object)
- Java Bean 규약에 따라 작성 (private 변수 + getter/setter)
- DB 데이터를 안전하게 포장해 전송

### 🔗 Expression Language (EL)
- `${pageContext.request.contextPath}` : 프로젝트 기본 경로 자동 적용

### 📜 SQL 쿼리 요약

```sql
SELECT M.M_NO, M.M_NAME, P.P_NAME, M.P_SCHOOL, M.M_JUMIN, M.M_CITY, P.P_TEL1, P.P_TEL2, P.P_TEL3
FROM TBL_MEMBER_202005 M
JOIN TBL_PARTY_202005 P
ON M.P_CODE = P.P_CODE;
```

- 회원정보 + 정당정보를 한 번에 조회하는 JOIN 쿼리 사용

---

# 🔄 데이터 흐름 요약 (Data Flow)

```plaintext
DB (Order, Member, Vote 테이블)
   ↓
DBUtils (데이터 조회 or 입력)
   ↓
각 DTO에 저장 (OrderDto, MemberDto 등)
   ↓
JSP 페이지로 전달 및 출력 (<%=dto.getM_name()%> 등)
```

---

# ⚠ 주의사항 (Cautions)

- DB 연결정보(`DBUtils`)를 실제 배포 시 환경변수나 별도 설정파일로 관리할 것.
- include 경로는 절대경로(`/layouts/Header.jsp`)로 설정.
- 주민번호로 나이/성별 계산 시 `LocalDate`, `Period`를 정확히 사용할 것.
- SQL Injection 예방을 위해 PreparedStatement 사용.
- DTO의 getter/setter 누락 주의.

---

# 🧪 예제 또는 비유 (Examples or Analogies)

- **include** = 레고 블록 조립: 파츠를 만들어 끼워넣기
- **DTO** = 택배 상자: DB 데이터를 포장해 JSP로 전달
- **DBUtils** = 택배기사: 필요한 데이터를 요청받아 전달
- **contextPath** = 내비게이션 앱의 "집(Home)" 버튼

---

# ✅ 한 줄 요약 (1-Line Summary)

> **JSP + Java + Oracle DB를 연동하여, 통계와 투표 기능을 동적으로 구현한 웹 프로젝트입니다! 🚀**
~~~

