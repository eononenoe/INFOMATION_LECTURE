
# 🌿 Spring Boot Thymeleaf 정리 가이드

---

## 📌 개요 (Overview)

Thymeleaf는 HTML을 렌더링하는 **Java 템플릿 엔진**입니다.  
Spring MVC에서 View 템플릿으로 널리 사용되며, JSP보다 **표현력, 재사용성, HTML 호환성**이 우수합니다.

- HTML5를 기반으로 브라우저에서 그대로 열 수 있음
- 서버 사이드 렌더링과 함께 정적 HTML 미리보기 가능
- 다양한 조건문, 반복문, 객체 바인딩 기능 제공

---

## ⚙️ Maven 의존성 설정

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-thymeleaf</artifactId>
</dependency>
```

---

## 🗂 디렉토리 구조

```
src/
├── java/
│   └── com.example.demo.controller/
└── resources/
    ├── static/         ← 정적 리소스(css, js, 이미지 등)
    ├── templates/      ← Thymeleaf HTML 템플릿
    └── application.properties 또는 application.yml
```

---

## ✨ 기본 컨트롤러 예제

```java
@Controller
public class HomeController {
    @GetMapping("/hello")
    public String hello(Model model) {
        model.addAttribute("name", "홍길동");
        return "hello";
    }
}
```

### hello.html (templates/hello.html)
```html
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head><title>Hello Page</title></head>
<body>
  <h1>안녕하세요, <span th:text="${name}">이름</span>!</h1>
</body>
</html>
```

---

## 🧠 주요 문법 요약 (Key Concepts)

### 📌 변수 출력
```html
<p th:text="${message}">기본 값</p>
```

### 📌 조건문
```html
<div th:if="${user != null}">
  <p th:text="${user.name}"></p>
</div>
<div th:unless="${user != null}">
  <p>사용자 정보 없음</p>
</div>
```

### 📌 반복문
```html
<ul>
  <li th:each="item : ${itemList}" th:text="${item}"></li>
</ul>
```

### 📌 링크 연결
```html
<a th:href="@{/hello}">Hello 페이지 이동</a>
```

### 📌 폼 입력
```html
<form th:action="@{/form}" method="post">
    <input type="text" name="username" th:value="${username}" />
    <button type="submit">제출</button>
</form>
```

---

## 📝 폼 처리 예제

### FormController.java
```java
@Controller
public class FormController {

    @GetMapping("/form")
    public String showForm(Model model) {
        model.addAttribute("username", "");
        return "form";
    }

    @PostMapping("/form")
    public String submitForm(@RequestParam String username, Model model) {
        model.addAttribute("username", username);
        return "result";
    }
}
```

### form.html
```html
<form th:action="@{/form}" method="post">
    <input type="text" name="username" />
    <button type="submit">제출</button>
</form>
```

### result.html
```html
<p th:text="'입력한 이름은: ' + ${username}"></p>
```

---

## 🧩 객체 바인딩 예제

### User.java
```java
public class User {
    private String name;
    private int age;
    // getters / setters
}
```

### UserController.java
```java
@Controller
public class UserController {

    @GetMapping("/user")
    public String showForm(Model model) {
        model.addAttribute("user", new User());
        return "userForm";
    }

    @PostMapping("/user")
    public String submit(@ModelAttribute User user, Model model) {
        return "userResult";
    }
}
```

### userForm.html
```html
<form th:action="@{/user}" th:object="${user}" method="post">
    이름: <input type="text" th:field="*{name}" /><br/>
    나이: <input type="number" th:field="*{age}" /><br/>
    <button type="submit">전송</button>
</form>
```

### userResult.html
```html
<p th:text="'이름: ' + ${user.name}"></p>
<p th:text="'나이: ' + ${user.age}"></p>
```

---

## 🧱 레이아웃 구성 (thymeleaf-layout-dialect)

### 의존성 추가
```xml
<dependency>
    <groupId>nz.net.ultraq.thymeleaf</groupId>
    <artifactId>thymeleaf-layout-dialect</artifactId>
    <version>3.1.0</version>
</dependency>
```

### layout.html (공통 레이아웃)
```html
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout">
<head>
  <title layout:title-pattern="$CONTENT_TITLE - My Site">기본 타이틀</title>
</head>
<body>
  <header><h1>공통 헤더</h1></header>

  <section layout:fragment="content">
    본문 내용이 들어갑니다.
  </section>

  <footer><p>공통 푸터</p></footer>
</body>
</html>
```

### 사용자 페이지 예시
```html
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout"
      layout:decorate="~{layout}">
<head><title>사용자 페이지</title></head>
<body>
<section layout:fragment="content">
  <h2>사용자 정보</h2>
</section>
</body>
</html>
```

---

## 정리 요약

| 항목 | 설명 |
|------|------|
| 템플릿 경로 | `resources/templates/` |
| 정적 리소스 경로 | `resources/static/` |
| 주요 태그 | `th:text`, `th:each`, `th:if`, `th:href`, `th:action`, `th:field` |
| 폼 바인딩 | `th:object`, `@ModelAttribute`, `@RequestParam` |
| 레이아웃 구성 | `layout:decorate`, `layout:fragment` |
| 활용 | JSP 대체, 서버사이드 렌더링, 정적/동적 페이지 혼합 구성 |

---

📚 한 줄 요약 (1-Line Summary)

Thymeleaf는 HTML과 자연스럽게 어우러지는 Spring Boot의 대표적인 템플릿 엔진으로, 서버사이드 렌더링과 폼 처리, 레이아웃 구성까지 모두 아우릅니다.
