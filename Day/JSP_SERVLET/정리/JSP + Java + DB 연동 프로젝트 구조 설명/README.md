# 🌟 JSP + Java + DB 연동 프로젝트 구조 설명

JSP와 Java를 활용하여 **웹페이지를 동적으로 구성**하고,  
**데이터베이스와 연동**하여 정보를 조회하고 출력하는 전체 구조를 정리했습니다. ✨

---

## 📌 개요 (Overview)

- JSP 파일에서 Java 코드를 연동해 동적인 웹페이지를 생성합니다.
- 데이터베이스(DB)에서 회원 정보를 조회하고, JSP를 통해 출력합니다.
- HTML, CSS, JSP 문법, Java Bean 규약, Expression Language(EL)를 조합하여 완성도 높은 웹 페이지를 구성합니다.

---

## 🗂️ 프로젝트 파일 구조 (Project Structure)

```plaintext
📁 src/
   └── 📄 MemberDao.java
   └── 📄 MemberDto.java

📁 WebContent/
   ├── 📁 layouts/
   │    ├── 📄 Header.jsp
   │    ├── 📄 Nav.jsp
   │    ├── 📄 Footer.jsp
   ├── 📄 Main.jsp
   ├── 📄 styles.css
```

- `layouts/` 폴더: 공통 UI 요소 분리 (Header, Nav, Footer)
- `MemberDao.java`: DB 연결 및 데이터 조회 처리
- `MemberDto.java`: 회원 데이터 저장용 Java Bean

---

## 💡 핵심 개념 요약 (Key Concepts)

### 📄 JSP 기본 세팅

- `<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>`  
  JSP 페이지 기본 설정 (Java 언어, HTML 출력, 한글 깨짐 방지)

### 🧩 JSP 파일 분리 및 포함

- `<%@include file="/layouts/Header.jsp" %>`  
  공통 요소 분리 및 코드 재사용성 향상

### 🎨 기본 레이아웃 구조

- `.wrapper`를 기준으로 header, nav, main, footer를 배치
- `calc(100vh - 80px - 50px - 80px)`를 이용해 화면 크기에 맞춰 main 영역 높이 자동 조정

### 🛠 데이터베이스 연동

- `selectAllMember()` 메소드로 DB 조회 결과를 MemberDto 객체에 담고, List로 반환
- SQL JOIN을 사용해 회원 기본 정보 + 소속 정당 정보까지 한 번에 가져옴

```java
public List<MemberDto> selectAllMember() throws Exception
```

### 📦 DTO (Data Transfer Object)

- 데이터 전송 객체로 MemberDto 클래스를 사용
- 캡슐화를 위해 getter/setter 메소드 정의

```jsp
<td><%=dto.getAddr()%></td>
```

- JSP 페이지에서 DTO 객체의 데이터를 안전하게 출력

### 🔗 Expression Language (EL)

- `${pageContext.request.contextPath}`를 사용하여 프로젝트 기본 경로를 동적으로 가져옴
- 서버 환경이 바뀌어도 하드코딩 없이 경로 자동 적용

```html
<li><a href="${pageContext.request.contextPath}">홈으로</a></li>
```

---

## 🔄 데이터 흐름 요약 (Data Flow)

```plaintext
DB (회원 테이블) 
   ↓
MemberDao (selectAllMember)
   ↓
MemberDto (회원 데이터 저장)
   ↓
JSP 페이지 출력 (<%=dto.getM_name()%>)
```

---

## 📜 SQL 쿼리 요약

```sql
SELECT 
  M.M_NO, M.M_NAME, P.P_NAME, M.P_SCHOOL, M.M_JUMIN, M.M_CITY,
  P.P_TEL1, P.P_TEL2, P.P_TEL3
FROM 
  TBL_MEMBER_202005 M
JOIN 
  TBL_PARTY_202005 P
ON 
  M.P_CODE = P.P_CODE
```

- 회원번호, 이름, 학교, 주민번호, 도시 정보 가져오기
- 소속 정당명, 전화번호 가져오기

---

## ✨ MemberDto 클래스 예시

```java
public class MemberDto {
  private String m_no;
  private String m_name;
  private String p_name;
  private String p_school;
  private String m_jumin;
  private String m_city;
  private String p_tel1;
  private String p_tel2;
  private String p_tel3;
  
  // (나머지 변수들도 동일한 방식으로 getter/setter 작성)
}
```

---

## ⚠ 주의사항 (Cautions)

- include 경로 설정 시 주의 (`/layouts/Header.jsp` 형태로 절대 경로 지정)
- DTO 클래스의 getter/setter 누락 시 데이터 전달 오류 발생
- PreparedStatement 사용으로 SQL Injection 예방
- JSP `<%= %>` 출력식과 EL `${}` 표현식 구분하여 사용

---

## 🧪 예제 또는 비유 (Examples or Analogies)

- **include** = 레고 블록 조립: 파츠를 미리 만들어 삽입
- **DTO** = 택배 상자: 필요한 정보를 안전하게 포장하고 전달
- **selectAllMember()** = 창고에서 상품을 꺼내 바구니에 정리
- **contextPath** = 내비게이션 앱의 "집(Home)" 버튼

---

## ✅ 한 줄 요약 (1-Line Summary)

> **JSP와 Java를 활용해 DB에서 정보를 조회하고, DTO를 통해 데이터를 안전하게 전달하여, 동적인 웹페이지를 구성하는 프로젝트입니다. 🚀**

---
