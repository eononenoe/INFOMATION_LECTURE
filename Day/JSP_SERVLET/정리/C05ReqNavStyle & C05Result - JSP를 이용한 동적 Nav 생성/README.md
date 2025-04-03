# 🌐 C05ReqNavStyle & C05Result - JSP를 이용한 동적 Navigation Bar 생성

---

## 📌 개요 (Overview)

이 프로젝트는 **JSP를 활용하여 사용자가 입력한 메뉴 이름과 스타일을 기반으로 동적인 내비게이션 바(NavBar)** 를 생성하는 예제입니다.

사용자는 4개의 메뉴 이름(`col1`, `col2`, `col3`, `col4`)과 스타일 코드(`style`)를 입력하며, `C05Result.jsp` 페이지에서는 이 값을 받아서 HTML `<ul>` 태그로 구성된 네비게이션 메뉴를 출력합니다.

> ✔️ 즉, **사용자가 직접 디자인한 NavBar를 실시간으로 만들어주는 JSP 예제**입니다!

---

## 💡 핵심 개념 요약 (Key Concepts)

- **Form 입력 → JSP 처리**: 사용자가 입력한 데이터를 `GET` 방식으로 `C05Result.jsp`에 전달
- **`request.getParameter()`**: JSP에서 사용자의 입력을 가져오기 위한 함수
- **동적 HTML 생성**: `<ul>` 안에 `<li>` 항목들을 동적으로 삽입
- **인라인 스타일 적용**: 사용자가 입력한 `style` 코드를 `<ul style="...">`로 삽입하여 CSS 반영
- **스크립틀릿(Scriptlet) 사용**: `<%= %>` 구문을 이용해 HTML 안에서 Java 코드를 출력

---

## ⚠ 주의사항 (Cautions)

- 사용자 입력으로 들어가는 **style 코드는 반드시 CSS 문법에 맞게 작성**되어야 합니다.
- `col1 ~ col4`에 아무 값도 넣지 않으면 빈 `<li>`가 출력됩니다.
- 실제 서비스 환경에서는 **XSS(Cross-Site Scripting)** 방지를 위해 사용자 입력을 필터링해야 합니다.
- JSP에서 Scriptlet 사용은 가급적 피하고, 실제 개발에선 **MVC 패턴, JSTL, EL(Expression Language)** 사용을 권장합니다.

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### ✅ 입력 예시 (C05ReqNavStyle.jsp에서 사용자 입력)

| 항목   | 예시 값 |
|--------|--------|
| col1   | Home   |
| col2   | About  |
| col3   | Services |
| col4   | Contact |
| style  | `background-color:black; color:white; display:flex; justify-content:space-around;` |

### 🖥️ 결과 화면 (C05Result.jsp에서 생성된 NavBar)

```html
<ul style="background-color:black; color:white; display:flex; justify-content:space-around;">
  <li>Home</li>
  <li>About</li>
  <li>Services</li>
  <li>Contact</li>
</ul>
```

이렇게 사용자가 입력한 대로 메뉴 이름이 나오고, 스타일도 즉시 적용되어 멋진 내비게이션 바가 만들어집니다! 💫

---

## 🔍 핵심 JSP 코드 설명

### 📄 C05ReqNavStyle.jsp (입력 폼 페이지)

```jsp
<form action="C05Result.jsp">
  <h2>NAV 만들기</h2>
  <input name="col1" placeholder="열이름1">
  <input name="col2" placeholder="열이름2">
  <input name="col3" placeholder="열이름3">
  <input name="col4" placeholder="열이름4">
  <input name="style" placeholder="Nav기본 스타일Code">
  <button>페이지 생성 요청</button>
</form>
```

> 사용자가 메뉴 이름과 스타일을 입력하고 제출하면, `C05Result.jsp`로 이동합니다.

---

### 📄 C05Result.jsp (결과 페이지 - 동적 출력)

```jsp
<%
  String col1 = request.getParameter("col1");
  String col2 = request.getParameter("col2");
  String col3 = request.getParameter("col3");
  String col4 = request.getParameter("col4");
  String navStyle = request.getParameter("style");
%>

<ul style="<%=navStyle%>">
  <li><%=col1 %></li>
  <li><%=col2 %></li>
  <li><%=col3 %></li>
  <li><%=col4 %></li>
</ul>
```

> JSP의 `스크립틀릿`을 이용하여 사용자 입력값을 동적으로 HTML에 삽입하고, 스타일까지 적용합니다.

---

## ✅ 한 줄 요약 (1-Line Summary)

💻 *사용자가 입력한 메뉴 이름과 스타일 코드를 기반으로 JSP에서 동적인 Navigation Bar를 만들어주는 실습 예제입니다!*

---

## 🎯 활용 팁

- 👉 JavaScript와 연결하면 동적 스타일 미리보기 기능도 추가 가능
- 👉 jQuery, Bootstrap 등으로 더 멋진 UI 구성 가능
- 👉 실제 프로젝트에서는 JSP 대신 React/Vue 등으로 구현하기도 함

---