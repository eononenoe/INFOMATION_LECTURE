# 📚 Spring HandlerMapping 정리

## 📌 개요 (Overview)

- **HandlerMapping**은 클라이언트의 요청 URL과 이를 처리할 **Controller의 메서드**를 연결해주는 핵심 컴포넌트입니다.
- DispatcherServlet이 요청을 받으면, 어떤 컨트롤러가 처리할지 결정하는 역할을 합니다.
- Spring MVC는 다양한 HandlerMapping 전략을 제공합니다 (Annotation 기반, BeanName 기반 등).

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🌟 주요 역할

| 항목                 | 설명 |
|----------------------|------|
| DispatcherServlet     | 모든 요청을 받아서 알맞은 Handler로 위임 |
| HandlerMapping        | 요청 URL을 처리할 컨트롤러 메서드를 찾아줌 |
| HandlerAdapter        | 찾은 Handler를 실행할 수 있도록 도와줌 |
| Controller            | 실질적으로 요청을 처리하는 클래스 (핸들러) |

### 🌟 매핑 방식

- Spring 3.x 이후 대부분의 프로젝트는 **@RequestMapping** 혹은 그 확장인 **@GetMapping / @PostMapping** 방식 사용
- 기본적인 매핑 전략은 `RequestMappingHandlerMapping` 클래스에 의해 동작합니다.

```java
@RestController
@RequestMapping("/user")
public class UserController {

    @GetMapping("/{id}")
    public String getUser(@PathVariable int id) {
        return "User ID: " + id;
    }
}
```

- 위의 예제는 `/user/3` 요청이 오면 `getUser()` 메서드로 매핑됩니다.

---

## 🧠 HandlerMapping 흐름도 (요약)

```text
1. 클라이언트 요청 → DispatcherServlet
2. DispatcherServlet → HandlerMapping
3. HandlerMapping → 해당 Controller/메서드 찾음
4. HandlerAdapter가 메서드 실행
5. 결과(View 또는 JSON 등)를 DispatcherServlet이 반환
```

---

## ⚠ 주의사항 (Cautions)

- **중복 매핑**은 런타임 예외 발생 가능 → URL은 고유해야 함
- **메서드 매핑 시** `@RequestMapping`과 `@GetMapping`, `@PostMapping`이 혼용될 수 있으니 주의
- XML 기반이 아닌 Java Config 사용 시 `@EnableWebMvc` 설정 필요

---

## 🧪 예제 코드 (Examples)

### 📋 WebMvcConfig에서 매핑 설정
```java
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.example.app")
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.jsp("/WEB-INF/views/", ".jsp");
    }
}
```

### 📋 커스텀 핸들러 예시 (CustomHandler.java)
```java
public class CustomHandler {
    public String handle() {
        return "Custom handler response";
    }
}
```

### 📋 다양한 컨트롤러 예시

#### ✅ HomeController.java
```java
@Controller
public class HomeController {

    @GetMapping("/")
    public String home() {
        return "home"; // → /WEB-INF/views/home.jsp
    }
}
```

#### ✅ ParameterTestController.java
```java
@Controller
@RequestMapping("/param")
public class ParameterTestController {

    @PostMapping("/submit")
    public String submit(@RequestParam String name) {
        return "param/forward_result";
    }
}
```

---

## ✅ 한 줄 요약 (1-Line Summary)

> **HandlerMapping**은 요청 URL을 처리할 컨트롤러 메서드와 연결해주는 핵심 컴포넌트이며, Spring MVC 요청 흐름의 첫 번째 핵심 관문이다! 🔄
