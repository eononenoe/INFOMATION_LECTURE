# 📚 SERVLET INIT 정리

---

## 📌 개요 (Overview)

이 프로젝트는 **서블릿(Servlet)** 을 연습하는 아주 기본적인 예제들이 모여있어!  
서블릿이란 쉽게 말하면 **웹 서버에서 자바로 웹페이지를 만드는 기술**이야.  
우리가 자바로 웹페이지에 글을 쓰거나, 버튼을 누를 때 반응하게 하고 싶을 때 서블릿을 사용해! 🚀

---

## 💡 핵심 개념 요약 (Key Concepts)

### 1. 전체 흐름 한눈에 보기

- `index.jsp`: 첫 메인 화면 (INDEX PAGE)
- 회원가입 👉 `join.jsp` 작성 후 가입 버튼 누름
- 로그인 👉 `login.jsp` 작성 후 로그인 버튼 누름
- 로그인 성공하면 👉 `main.jsp` 로 이동

---

### 2. 서블릿 파일별 정리

#### 📄 C01Servlet_Test.java

- **Servlet 기본 골격**을 보여주는 파일.
- **init()**, **service()**, **destroy()** 메서드가 호출될 때 로그를 찍어!
- 주소 `/TEST_01` 로 매핑되어 있음.

> 🛠️ Servlet 생명주기 배우는 연습용!

---

#### 📄 C02Servlet_Test.java

- C01과 거의 비슷.
- **service()** 메서드 안에 요청 처리 로직을 넣을 수 있어!

> 🔥 Servlet 요청 처리 흐름을 이해하는 단계!

---

#### 📄 C03Servlet_Test.java

- 주소 `/main.do` 로 매핑된 서블릿.
- **GET 요청**을 받으면 `main.jsp` 페이지로 **forward(전달)** 해줌.

> 🚪 브라우저가 요청할 때 main 페이지로 안내하는 문지기 역할!

---

#### 📄 C04Servlet_Test.java

- 주소 `/join.do` 로 매핑된 서블릿.
- **GET 요청**은 회원가입 폼으로 이동 (`join.jsp`)
- **POST 요청**은 입력받은 username, password를 **세션에 저장**하고 `login.do`로 리다이렉트!

> 🛒 회원가입 기능을 맡은 서블릿!

---

#### 📄 C05Servlet_test.java

- 주소 `/login.do` 로 매핑된 서블릿.
- **GET 요청**은 로그인 폼을 보여주고 (`login.jsp`)
- **POST 요청**은 세션에 저장된 값과 비교해서 로그인 성공 여부를 판별!

> 🛡️ 로그인 검사 담당 서블릿!

---

### 3. JSP 파일별 정리

#### 🖥️ index.jsp

```html
<h1>INDEX PAGE</h1>
```
- 그냥 "INDEX PAGE" 라고 써있는 메인 진입 화면이야.

---

#### 🖥️ join.jsp

```html
<h1>JOIN PAGE</h1>
<form action="${pageContext.request.contextPath}/join.do" method="post">
    <input name="username" /><br/>
    <input name="password" /><br/>
    <button>회원가입</button>
</form>
```
- 사용자에게 **아이디/비밀번호를 입력**받아서 `/join.do`로 POST 요청을 보내.

---

#### 🖥️ login.jsp

```html
<h1>LOGIN PAGE</h1>
<form action="${pageContext.request.contextPath}/login.do" method="post">
    <input name="username" /> <br/>
    <input name="password" /><br/>
    <button>로그인</button>
</form>
<div>${username_msg}</div>
<div>${password_msg}</div>
```
- 로그인 폼을 입력하고 로그인 요청을 보내.
- 로그인 실패하면 오류 메세지가 `${username_msg}`, `${password_msg}`로 출력돼.

---

#### 🖥️ main.jsp

```html
<h1>MAIN PAGE</h1>
```
- 로그인 성공 후 이동하는 메인 페이지야!

---

## ⚠ 주의사항 (Cautions)

- **한글 처리**: 꼭 `charset=UTF-8` 설정해주지 않으면 글자가 깨질 수 있어!  
- **요청 방식 구분**: GET과 POST는 다르게 동작해야 해.
- **세션 관리**: 아이디/비밀번호 저장은 세션을 이용해야 해.
- **Redirect와 Forward 차이**: 
  - `forward`: 서버 내부 이동 (URL 안 변함)
  - `redirect`: 클라이언트에게 새로운 URL로 이동 요청 (URL 변함)

---

## 🧪 예제 또는 비유 (Examples or Analogies)

- **Servlet은 레스토랑의 요리사!**
  - 손님(브라우저)이 메뉴(GET/POST 요청)를 고르면,
  - 요리사(서블릿)가 맞는 음식을 요리해서(응답 생성) 가져다주는 느낌! 🍽️

- **web.xml은 식당 매뉴판**
  - 어떤 요리를 누가 담당하는지 적어놓은 메뉴판이야! 📝

- **세션은 사물함 열쇠**
  - 로그인 정보(username/password)를 사물함(session)에 저장해두고, 필요한 사람이 다시 꺼내쓴다! 🗝️

---

## ✅ 한 줄 요약 (1-Line Summary)

> 서블릿은 웹 서버 속 '자바 요리사'로, 웹 요청을 받아 멋진 결과를 요리해 응답하는 기술이다! 🍝✨

---
