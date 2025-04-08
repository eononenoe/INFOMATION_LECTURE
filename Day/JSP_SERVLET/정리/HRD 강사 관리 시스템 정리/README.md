~~~markdown
# 📚 HRD 강사 관리 시스템 정리

---

# 📌 개요 (Overview)

이 프로젝트는 **JSP와 Java**를 사용하여 강사 정보를 조회하고 출력하는 간단한 웹 애플리케이션입니다.

주요 기능은 다음과 같습니다:
- 강사 정보 전체 조회
- 강사 등록일 포맷 변환 및 출력

---

# 🗂️ 프로젝트 파일 구조 (Project Structure)

```plaintext
📁 src/
   ├── 📄 TeacherDto.java
   └── 📄 DBUtils.java

📁 WebContent/
   ├── 📁 layouts/
   │    ├── 📄 Header.jsp
   │    ├── 📄 Nav.jsp
   │    ├── 📄 Footer.jsp
   └── 📄 03HRDKOREA/index.jsp (강사조회 화면)
```

---

# 💡 핵심 개념 요약 (Key Concepts)

### 📄 JSP 기본 세팅

- `<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>` : JSP 파일 기본 설정

### 📦 DTO (Data Transfer Object)

- `TeacherDto` 클래스는 강사 정보를 저장합니다.
  - 강사코드, 강사명, 강의명, 수강료, 강사자격취득일 필드를 가짐

### 🛠 DB 연결 및 조회

- `DBUtils` 클래스는 싱글톤 패턴으로 DB 연결 관리
- `selectAllTeacher()` 메소드로 강사 전체 리스트 조회

### 🗓️ 날짜 포맷 변환

- DB에는 `yyyyMMdd` 포맷으로 저장된 등록일을 가져옴
- `LocalDate`와 `DateTimeFormatter`를 사용해 `yyyy년 MM월 dd일` 형식으로 변환 후 출력

```java
DateTimeFormatter inFmt = DateTimeFormatter.ofPattern("yyyyMMdd");
LocalDate localDate = LocalDate.parse(date, inFmt);
DateTimeFormatter outFmt = DateTimeFormatter.ofPattern("yyyy년MM월dd일");
localDate.format(outFmt);
```

---

# 🔄 데이터 흐름 요약 (Data Flow)

```plaintext
DB (TBL_TEACHER_202201)
   ↓
DBUtils.selectAllTeacher()
   ↓
TeacherDto 리스트 저장
   ↓
JSP 페이지 (index.jsp)로 전달하여 출력
```

---

# 📜 SQL 쿼리 요약

```sql
SELECT * FROM TBL_TEACHER_202201;
```

- 테이블의 모든 컬럼(강사코드, 강사명, 강의명, 수강료, 등록일) 조회

---

# ⚠ 주의사항 (Cautions)

- 날짜 변환 시 `DateTimeFormatter` 포맷 문자열 오류 주의
- JSP 출력 시 DTO의 null 체크 필요
- DB 연결 종료 처리를 놓치지 않기 (ResultSet, PreparedStatement, Connection close)

---

# 🧪 예제 또는 비유 (Examples or Analogies)

- **TeacherDto** = 선생님 개인 파일철 📂
  - 강사 한 명의 정보를 정리한 파일입니다.

- **selectAllTeacher()** = 교무실에서 선생님 명단 꺼내오기 🧑‍🏫

- **DateTimeFormatter 변환** = 8자리 숫자 생일(19990815)을 "1999년 08월 15일"로 읽기 쉽게 바꾸는 작업 🎂

---

# ✅ 한 줄 요약 (1-Line Summary)

> **JSP와 Java를 통해 강사 정보를 조회하고, 날짜 포맷을 변환하여 웹페이지에 출력하는 간단한 시스템입니다! 🚀**
~~~

