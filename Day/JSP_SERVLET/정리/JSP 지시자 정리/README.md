# 📘 JSP 지시자(Directive) 완전 정복 가이드

JSP에서 **지시자(Directive)**는 JSP 페이지에 대한 **전역적인 설정**을 지정할 때 사용하는 특별한 문법이에요!  
JSP 컨테이너에게 페이지 전체에 적용할 중요한 정보를 알려주는 역할을 합니다.

---

## 📌 개요 (Overview)

- 지시자는 `<%@ ... %>` 형식으로 사용돼요.
- HTML이 아니라 **JSP 페이지 자체를 설정**하기 위한 용도로 쓰여요.
- JSP에는 다음과 같은 **3가지 지시자**가 있어요:

| 지시자 종류 | 형식 | 설명 |
|-------------|------|------|
| `page`      | `<%@ page 속성="값" %>` | JSP 페이지의 전역 속성 설정 (인코딩, import, 에러 처리 등) |
| `include`   | `<%@ include file="파일명" %>` | **정적인 파일 포함** (컴파일 시 포함됨) |
| `taglib`    | `<%@ taglib prefix="접두어" uri="태그라이브러리URI" %>` | 사용자 정의 태그(JSTL 등) 사용을 위한 선언 |

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🔧 1. page 지시자

`page` 지시자는 JSP 페이지의 **전역 속성**을 지정해요.

| 속성 | 설명 | 예시 |
|------|------|------|
| `language` | 사용할 스크립트 언어 (기본값: java) | `<%@ page language="java" %>` |
| `contentType` | MIME 타입 및 문자 인코딩 설정 | `<%@ page contentType="text/html; charset=UTF-8" %>` |
| `import` | 자바 클래스 import (여러 개 가능) | `<%@ page import="java.util.*, java.text.*" %>` |
| `session` | 세션 사용 여부 (기본값: true) | `<%@ page session="true" %>` |
| `errorPage` | 에러 발생 시 이동할 페이지 | `<%@ page errorPage="error.jsp" %>` |
| `isErrorPage` | 현재 페이지가 에러 처리 페이지인지 여부 | `<%@ page isErrorPage="true" %>` |

---

### 📂 2. include 지시자

- JSP 파일에 **정적인 리소스(header.jsp 등)** 를 포함시킬 때 사용해요.
- 컴파일 시점에 포함되므로 **HTML 조각이나 공통 파일**을 넣을 때 자주 쓰입니다.

```jsp
<%@ include file="header.jsp" %>
```

💡 동적인 include는 `<jsp:include>` 액션 태그를 사용합니다.

---

### 🏷 3. taglib 지시자

- **JSTL**이나 사용자 정의 태그 라이브러리를 사용할 때 선언해요.
- 태그에 접두어를 붙여서 JSP에서 쉽게 사용할 수 있어요.

```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
```

| 속성 | 설명 |
|------|------|
| `prefix` | 사용할 태그 접두어 |
| `uri` | 태그 라이브러리의 URI (TLD 위치) |

---

## ⚠ 주의사항 (Cautions)

- `include`는 **정적 포함**만 가능해요. 실행 중 포함은 `<jsp:include>`를 사용해야 해요.
- `taglib`는 **커스텀 태그 사용 시 필수**에요. JSTL 쓸 때 자주 등장합니다.
- `page` 지시자는 **페이지 상단**에 위치하는 것이 관례입니다.

---

## 🧪 예제 또는 비유 (Examples or Analogies)

> 📦 `page`는 페이지 전체에 설정을 지정하는 "환경 설정 메뉴"
> 🧩 `include`는 반복되는 HTML 조각을 복붙 대신 "한 번에 불러오기"
> 🛠 `taglib`는 마치 도구 상자를 열어 JSTL 같은 "특수 도구"를 사용하는 선언!

---

## ✅ 한 줄 요약 (1-Line Summary)

> ✨ JSP 지시자는 **페이지 전반의 설정**을 담당하는 똑똑한 안내서입니다!

---
