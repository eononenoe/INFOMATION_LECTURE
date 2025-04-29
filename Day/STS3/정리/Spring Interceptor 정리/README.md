# 📚 ex10_interceptor 프로젝트 정리

## 📌 개요 (Overview)

- **ex10_interceptor** 프로젝트는 **Spring MVC** 기반 웹 애플리케이션입니다.
- 다양한 **요청 처리**, **인터셉터(Interceptor)**, **전역 예외 처리(Global Exception Handler)**, **REST API** 등을 다루는 연습을 목적으로 만들어졌습니다.
- 파일 업로드/다운로드, 파라미터 테스트, 세션 관리, 메모 CRUD 기능을 포함합니다.

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🌟 주요 특징

| 항목               | 설명 |
| :----------------- | :--- |
| 인터셉터(Interceptor) 사용 | 컨트롤러 실행 전/후 요청을 가로채 추가 로직 수행 |
| 전역 예외 처리 (Exception Handling) | `@ControllerAdvice`를 이용해 애플리케이션 전체 예외를 처리 |
| 파일 업로드/다운로드 기능  | Multipart 업로드, 서버 저장, 다운로드 구현 |
| MyBatis ORM 연동   | SQL 매퍼를 통한 데이터베이스 연동 |
| RESTful API 구현    | REST 컨트롤러로 JSON 기반 API 제공 |
| 다양한 JSP 뷰 페이지 제공 | 에러, 메모, 파일, 파라미터 테스트 등 다양한 JSP 파일 포함 |

### 🌟 Interceptor란?

- 요청(Request)이 **Controller**에 도달하기 전에 **가로채서 전/후 처리**를 할 수 있는 기능입니다.
- 대표적인 예시로:
  - 로그인 체크
  - 요청 로깅
  - 권한 검사
  - 세션 체크
- **`MemoInterceptor.java`** 파일에서 구현되어 있습니다.

**Interceptor 흐름:**
1. 클라이언트 요청 → DispatcherServlet
2. DispatcherServlet → Interceptor 전처리 (`preHandle`)
3. Controller 요청 처리
4. DispatcherServlet → Interceptor 후처리 (`postHandle`, `afterCompletion`)

### 🌟 전역 예외 처리(Global Exception Handler)

- `@ControllerAdvice` + `@ExceptionHandler` 조합으로 예외를 한 곳에서 처리합니다.
- 사용자 친화적인 에러 페이지 제공(`error.jsp` 등).

**핵심 클래스:**
- `GlobalExceptionHandler.java`

### 🌟 REST API Controller

- `@RestController`를 이용해 데이터를 **JSON** 형태로 주고받습니다.
- `MemoRestController.java` 예시
- 브라우저에서 바로 API 호출 결과를 확인할 수 있습니다.

---

## ⚠ 주의사항 (Cautions)

- **인터셉터 등록**을 `WebMvcConfig.java` 안에서 정확히 해줘야 작동합니다.
- **MyBatis Mapper XML**(`MemoMapper.xml`) 위치와 경로가 올바르게 연결되어야 데이터베이스 연동이 정상 작동합니다.
- JSP 파일 경로는 `/WEB-INF/views/` 하위에 있어야 직접 접근이 불가능하고, DispatcherServlet을 통해 접근합니다.
- 파일 업로드 경로 설정에 따라 서버 쓰기 권한 문제가 발생할 수 있으니 주의해야 합니다.

---

## 🧪 예제 또는 비유 (Examples)

### 📋 Interceptor 등록 예시 (WebMvcConfig.java)
```java
@Override
public void addInterceptors(InterceptorRegistry registry) {
    registry.addInterceptor(new MemoInterceptor())
            .addPathPatterns("/memo/**") // memo로 시작하는 요청만 가로챔
            .excludePathPatterns("/login", "/logout"); // 로그인/로그아웃은 제외
}
```

### 📋 전역 예외 처리 예시 (GlobalExceptionHandler.java)
```java
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public String handleAllException(Exception ex, Model model) {
        model.addAttribute("msg", ex.getMessage());
        return "global_error"; // /WEB-INF/views/global_error.jsp
    }
}
```

### 📋 REST Controller 간단 예시
```java
@RestController
@RequestMapping("/api/memo")
public class MemoRestController {

    @GetMapping("/{id}")
    public MemoDto getMemo(@PathVariable int id) {
        return memoService.getMemo(id); // 메모 정보 JSON으로 반환
    }
}
```

---

## ✅ 한 줄 요약 (1-Line Summary)

> **ex10_interceptor**는 Spring MVC 구조에서 **Interceptor 활용**, **전역 예외 처리**, **REST API** 구축을 종합적으로 연습할 수 있는 프로젝트다! 🚀
