# 📚 03HRDKOREA 프로젝트 정리

---

## 📌 프로젝트 개요 (Overview)

**JSP + Servlet + Java + JavaScript + Oracle DB**를 이용하여  
회원, 투표, 수업, 강사 정보를 관리하는 웹 어플리케이션입니다.

**주요 기능:**
- 회원 등록, 수정, 삭제
- 투표 등록, 수정, 삭제
- 수업 등록, 수정, 삭제
- 강사 등록, 수정, 삭제
- 폼 입력 유효성 검사
- Oracle DB 연동

✅ 하나의 시스템 안에 다양한 데이터 관리 기능을 연습할 수 있습니다!

---

## 📂 전체 폴더 구조

```
03HRDKOREA/
├── src/main/java/Utils/
│   ├── ClassDto.java
│   ├── DBUtils.java
│   ├── Join1Dto.java
│   ├── Join2Dto.java
│   ├── MemberDto.java
│   ├── TeacherDto.java
│   └── VoteDto.java
│
├── src/main/webapp/
│   ├── index.jsp
│   ├── template.jsp
│   ├── 01/ (회원 관리)
│   ├── 02/ (투표 관리)
│   ├── 03/ (수업 관리)
│   ├── 04/ (강사 관리)
│   ├── layouts/ (Header, Footer, Nav)
│   ├── META-INF/MANIFEST.MF
│   └── WEB-INF/lib/ojdbc6.jar
│
├── .classpath
├── .project
└── .settings/
```

---

# 🛠️ 1. Java 소스 코드 정리

## 📄 DBUtils.java

✅ DB 연결과 쿼리 실행을 담당하는 유틸리티 클래스입니다.

| 코드 | 설명 |
|:---|:---|
| `Class.forName("oracle.jdbc.driver.OracleDriver");` | 오라클 드라이버를 메모리에 올립니다. |
| `DriverManager.getConnection(...)` | 오라클 DB에 연결합니다. |
| `insertXXX(Dto)` | 데이터를 삽입하는 메서드들 |
| `selectAllXXX()` | 데이터를 모두 조회하는 메서드들 |
| `updateXXX(Dto)` | 데이터를 수정하는 메서드들 |
| `deleteXXX(id)` | 데이터를 삭제하는 메서드들 |

✅ **싱글톤 패턴 사용** : DBUtils 객체 하나만 생성해서 사용합니다.

---

## 📄 DTO 파일들 설명

| 파일명 | 역할 |
|:---|:---|
| MemberDto.java | 회원(id, 이름, 비밀번호) 데이터 저장 |
| VoteDto.java | 투표(주민번호, 이름, 후보번호, 시간, 지역, 확인여부) 데이터 저장 |
| ClassDto.java | 수업(id, 수업명, 교실) 데이터 저장 |
| TeacherDto.java | 강사(id, 이름, 과목) 데이터 저장 |
| Join1Dto.java | 조인 결과 저장용 DTO (ex: 회원 + 투표) |
| Join2Dto.java | 다른 조인 결과 저장용 DTO |

✅ **DTO (Data Transfer Object)** 는 데이터를 옮기는 상자입니다.

---

# 🖥️ 2. JSP 파일 정리 (01 ~ 04폴더)

모든 폴더는 **CRUD** 구조를 가집니다!

| 파일명 | 기능 설명 |
|:---|:---|
| `index.jsp` | 전체 목록 보여주기 |
| `create.jsp` | 새로운 데이터 등록 폼 |
| `read.jsp` | 특정 데이터 상세 보기 |
| `update.jsp` | 데이터 수정 폼 |
| `delete.jsp` | 데이터 삭제 확인 |

---

## 📄 JavaScript 코드 (폼 유효성 검사)

(주로 `create.jsp`, `update.jsp` 안에 있음)

```javascript
function isValid() {
    var form = document.vote_form;
    if (form.v_jumin.value === "") {
        alert("주민번호를 입력하세요!");
        form.v_jumin.focus();
        return;
    }
    if (form.v_confirm.value === "") {
        alert("유권자 확인을 선택하세요!");
        return;
    }
    form.submit();
}
```

| 코드 | 설명 |
|:---|:---|
| `form.v_jumin.value === ""` | 주민번호 미입력 시 경고창 |
| `form.v_confirm.value === ""` | 유권자 확인 선택 안했으면 경고창 |
| `form.submit();` | 문제 없으면 폼 제출 |

✅ **폼을 제대로 입력하지 않으면 등록되지 않게 막아줍니다!**

---

## 📄 layouts 폴더 (Header, Footer, Nav)

| 파일명 | 설명 |
|:---|:---|
| Header.jsp | 페이지 상단 메뉴바 (홈, 회원관리 등 링크) |
| Footer.jsp | 페이지 하단 저작권 표시 |
| Nav.jsp | 사이드 네비게이션 바 (페이지 이동 링크) |

✅ 사이트 전체에 통일된 UI 제공!

---

# ⚙️ 3. 프로젝트 설정 파일 설명

| 파일명 | 설명 |
|:---|:---|
| .classpath | 이클립스 클래스 경로 관리 파일 |
| .project | 이클립스 프로젝트 기본 설정 파일 |
| .settings/ | 이클립스용 추가 설정 (코딩 스타일, 빌드 관련 등) |

✅ 이클립스(Eclipse IDE)로 프로젝트를 열 때 꼭 필요합니다.

---

# 📦 4. 라이브러리 파일

| 파일명 | 설명 |
|:---|:---|
| ojdbc6.jar | Java 프로그램이 오라클 DB와 통신할 수 있게 해주는 드라이버 파일 |

✅ DB 작업을 할 수 있게 도와줍니다!

---

# 🗂️ 5. META-INF 폴더

| 파일명 | 설명 |
|:---|:---|
| MANIFEST.MF | 웹 프로젝트의 기본 메타데이터 파일 (버전, 설정 등) |

✅ WAR 파일로 배포할 때 필요한 정보입니다.

---

# 🧠 전체 기능 흐름 요약 (CRUD 흐름)

```
목록(index.jsp) → 등록(create.jsp) → 등록처리(createAction.jsp) → 상세보기(read.jsp) → 수정(update.jsp) → 수정처리(updateAction.jsp) → 삭제(delete.jsp) → 삭제처리(deleteAction.jsp)
```

모든 폴더(01, 02, 03, 04)가 이 흐름을 따릅니다!

---

# 🧪 비유로 쉽게 설명

🏡 작은 마을 시스템:

| 구성요소 | 역할 |
|:---|:---|
| create.jsp | 새 주민 등록 창구 |
| createAction.jsp | 주민 정보 저장소 |
| read.jsp | 주민 정보 조회 창구 |
| update.jsp | 주민 정보 수정 창구 |
| delete.jsp | 주민 정보 삭제 창구 |
| isValid() | 잘못 입력하면 "잘못했어요!" 경고창 띄우는 검사관 |

---

# ✅ 한 줄 요약 (1-Line Summary)

> **03HRDKOREA는 회원, 투표, 수업, 강사 데이터를 JSP + Java + Oracle DB로 CRUD 처리하는 풀스택 프로젝트입니다! 🚀**

---
