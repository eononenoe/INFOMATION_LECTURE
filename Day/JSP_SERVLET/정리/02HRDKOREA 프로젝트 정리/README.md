# 📚 02HRDKOREA 프로젝트 정리

---

## 📌 프로젝트 개요 (Overview)

이 프로젝트는 **JSP + Servlet + Java + JavaScript + Oracle DB**를 활용한  
**풀스택 웹 애플리케이션 예제**입니다.

**주요 기능:**
- 회원 관리
- 투표 관리
- 추가 데이터 관리
- 입력 폼 유효성 검사
- 오라클 DB 연동

✅ 작은 웹서비스를 처음부터 끝까지 구현하는 예제 프로젝트입니다.

---

## 🧩 전체 폴더 구조

```
02HRDKOREA/
├── src/main/java/Utils/
│   ├── DBUtils.java
│   ├── MemberDto.java
│   └── VoteDto.java
│
├── src/main/webapp/
│   ├── index.jsp
│   ├── template.jsp
│   ├── 01/ (회원 관리)
│   ├── 02/ (투표 관리)
│   ├── 03/ (추가기능1)
│   ├── 04/ (추가기능2)
│   ├── layouts/ (Header, Footer, Nav)
│   ├── META-INF/
│   │   └── MANIFEST.MF
│   └── WEB-INF/lib/
│       └── ojdbc6.jar
│
├── .classpath
├── .project
└── .settings/
```

---

# 🛠️ 1. Java 소스 코드 정리

## 📄 DBUtils.java

✅ DB 연결, 쿼리 실행을 돕는 유틸리티 클래스입니다.

| 코드 | 설명 |
|:---|:---|
| `Class.forName("oracle.jdbc.driver.OracleDriver");` | 오라클 JDBC 드라이버를 불러옵니다. |
| `DriverManager.getConnection(...);` | 오라클 DB에 연결합니다. |
| `insertVote(VoteDto voteDto)` | 투표 정보를 DB에 저장합니다. |
| `selectAllVotes()` | 전체 투표 목록을 조회합니다. |
| `selectVote(String id)` | 특정 투표 데이터를 조회합니다. |
| `updateVote(VoteDto voteDto)` | 투표 정보를 수정합니다. |
| `deleteVote(String id)` | 투표 정보를 삭제합니다. |

✅ **싱글톤 패턴** 사용: DBUtils 인스턴스는 단 하나만 존재합니다.

---

## 📄 MemberDto.java

✅ **회원 정보를 담는 데이터 상자**입니다.

| 필드 | 설명 |
|:---|:---|
| `String id` | 회원 아이디 |
| `String name` | 회원 이름 |
| `String password` | 회원 비밀번호 |

👉 회원 관련 데이터를 주고받을 때 사용합니다.

---

## 📄 VoteDto.java

✅ **투표 정보를 담는 데이터 상자**입니다.

| 필드 | 설명 |
|:---|:---|
| `String v_jumin` | 주민번호 |
| `String v_name` | 이름 |
| `String m_no` | 후보자 번호 |
| `String v_time` | 투표 시간 |
| `String v_area` | 투표 장소 |
| `String v_confirm` | 유권자 확인 여부 |

👉 투표 등록, 수정, 조회에 사용합니다.

---

# 🖥️ 2. JSP 파일 정리

## 📂 01/, 02/, 03/, 04/ 폴더 공통 JSP 흐름

| 파일명 | 역할 |
|:---|:---|
| `index.jsp` | 전체 목록 조회 |
| `create.jsp` | 새 항목 등록 폼 |
| `read.jsp` | 항목 상세 조회 |
| `update.jsp` | 항목 수정 폼 |
| `delete.jsp` | 항목 삭제 |

**CRUD 흐름을 따릅니다!**

---

## 📄 JavaScript 유효성 검사 코드 (`isValid()` 함수)

```javascript
function isValid() {
    var form = document.vote_form;
    if (form.v_jumin.value === "") {
        alert("주민번호가 입력되지 않았습니다!");
        form.v_jumin.focus();
        return;
    }
    if (form.v_confirm.value === "") {
        alert("유권자 확인이 선택되지 않았습니다!");
        return;
    }
    form.submit();
}
```

| 코드 | 설명 |
|:---|:---|
| `form.v_jumin.value === ""` | 주민번호가 입력되지 않았는지 확인 |
| `alert(...)` | 비었으면 경고창 띄우기 |
| `form.submit();` | 모두 입력됐으면 제출하기 |

✅ 폼 제출 전에 입력 확인하는 기능입니다.

---

## 📂 layouts 폴더

| 파일명 | 설명 |
|:---|:---|
| `Header.jsp` | 상단 메뉴를 출력합니다. |
| `Footer.jsp` | 하단 정보를 출력합니다. |
| `Nav.jsp` | 좌측/상단 네비게이션 바를 출력합니다. |

👉 전체 페이지에 일관성 있는 구조를 제공!

---

# ⚙️ 3. 프로젝트 설정 파일

| 파일명 | 역할 |
|:---|:---|
| `.classpath` | 이클립스에서 클래스 경로를 관리합니다. |
| `.project` | 이클립스 프로젝트 설정 파일입니다. |
| `.settings/` | 프로젝트 세부 설정 (코딩 스타일, 빌드 설정 등) |

✅ 이클립스(Eclipse)에서 프로젝트를 열 때 필수입니다.

---

# 📦 4. 라이브러리 파일 설명

| 파일명 | 설명 |
|:---|:---|
| `ojdbc6.jar` | 오라클 DB와 Java를 연결해주는 드라이버입니다. |

✅ Java 프로그램이 오라클 DB에 연결할 수 있게 도와줍니다.

---

# 🗂️ 5. META-INF 폴더

| 파일명 | 설명 |
|:---|:---|
| `MANIFEST.MF` | 웹 애플리케이션 메타정보 파일입니다. (버전, 설정 등) |

✅ 주로 배포할 때 필요한 정보를 담습니다.

---

# 🧠 전체 CRUD 흐름 요약

```
index.jsp → create.jsp → createAction.jsp → read.jsp → update.jsp → updateAction.jsp → delete.jsp → deleteAction.jsp
```

- 목록 조회 → 새로 등록 → 상세 보기 → 수정 → 삭제

---

# 🧪 비유로 쉽게 설명!

🏡 작은 마을 시스템:

| 구성요소 | 설명 |
|:---|:---|
| 회원 등록(create.jsp) | 주민 등록소 |
| 투표 등록(create.jsp) | 마을 회의 안건 등록 |
| 목록 보기(index.jsp) | 마을 주민 명단 열람 |
| 수정(update.jsp) | 주민 정보 수정 |
| 삭제(delete.jsp) | 주민 정보 삭제 |

---

# ✅ 한 줄 요약 (1-Line Summary)

> **02HRDKOREA는 JSP, Java, Oracle을 활용한 CRUD 웹 시스템 풀패키지! 모든 파일과 코드를 초등학생도 이해할 수 있게 완벽 정리한 README 🚀**

---
