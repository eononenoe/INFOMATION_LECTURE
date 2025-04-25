# 🚦 Spring MVC DispatcherServlet 구조 정리

Spring MVC에서 DispatcherServlet은 **모든 웹 요청의 진입점**으로 동작하며, 요청을 적절한 Controller로 전달하고, 응답 결과를 사용자에게 반환하는 **프론트 컨트롤러(Front Controller)**입니다.

---

## 📌 DispatcherServlet 기본 개념

- DispatcherServlet은 Spring의 모든 웹 요청 흐름을 제어하는 핵심 컴포넌트입니다.
- View 기반 전통 MVC와 REST API 구조 모두 이 DispatcherServlet을 통해 흐름이 시작됩니다.

---

## 🧭 전체 동작 흐름 (View 반환 방식)

![DispatcherServlet Flow - View](/image.png)

| 순번 | 구성 요소 | 설명 |
|------|-----------|------|
| ① | Client → DispatcherServlet | 사용자가 `/user` 와 같은 URL로 요청을 보냄 |
| ② | DispatcherServlet → HandlerMapping | 해당 URL과 매핑되는 Controller 탐색 |
| ③ | HandlerMapping → DispatcherServlet | 알맞은 Controller 객체 반환 |
| ④ | DispatcherServlet → HandlerAdapter | Controller 실행을 위한 어댑터 실행 요청 |
| ⑤ | HandlerAdapter → Controller | Controller에서 비즈니스 로직 처리 |
| ⑥ | Controller → HandlerAdapter | 처리 결과(ModelAndView) 반환 |
| ⑦ | HandlerAdapter → DispatcherServlet | 결과 DispatcherServlet에 전달 |
| ⑧ | DispatcherServlet → ViewResolver | View 이름으로 JSP 경로 찾기 |
| ⑨ | ViewResolver → DispatcherServlet | 실제 View 경로 반환 |
| ⑩ | DispatcherServlet → View | View 렌더링 후 사용자에게 응답 |

---

## 📥 전체 흐름 추가 시각화 (View 방식)

![전통 View 기반 전체 흐름도 - Developer Role 명시](/image%20(2).png)

🧠 **설명**  
- 파란색: Spring이 처리하는 영역  
- 주황색: 개발자가 작성해야 하는 코드  
- 초록색: DB 등 외부 자원  
→ 전체 MVC 구조를 한눈에 파악할 수 있어요!

---

## 💡 핵심 컴포넌트 정리

| 컴포넌트 | 설명 |
|----------|------|
| **DispatcherServlet** | 요청을 받는 프론트 컨트롤러 |
| **HandlerMapping** | 어떤 Controller에 매핑되는지 결정 |
| **HandlerAdapter** | Controller 실행 방법 결정 |
| **Controller** | 비즈니스 로직 처리 |
| **ViewResolver** | View 이름 → JSP 물리적 경로로 매핑 |
| **View (JSP)** | 사용자에게 최종 HTML 결과 응답 |

---

## 🔁 REST API 구조 (@RestController 기반)

![RestController 흐름](/image%20(1).png)

- `@RestController`는 `@Controller + @ResponseBody` 조합입니다.
- ViewResolver 대신 `HttpMessageConverter`가 동작하여 객체 → JSON 변환을 수행합니다.

### 특징

| 항목 | 설명 |
|------|------|
| View 없음 | View 이름 반환 대신 객체 반환 |
| JSON 자동 변환 | MappingJackson2HttpMessageConverter 사용 |
| REST API 작성에 최적화 | 주로 데이터 전송 위주의 처리에 적합 |

---

## 🔄 @Controller + @ResponseBody 구조

![Controller + ResponseBody 흐름](/image%20(3).png)

- @Controller는 기본적으로 View 반환용이며,  
  객체를 반환하고 싶을 때는 `@ResponseBody`를 명시적으로 붙여야 합니다.
- 이 때도 **HttpMessageConverter**가 동작하여 JSON으로 변환됩니다.

---

## 📦 전통적 JSP View 방식 MVC 흐름도

![JSP 기반 MVC 흐름](/image%20(2).png)

- Controller는 Service → Repository → DB로 요청 전달
- 결과 데이터를 Model에 담아 ViewResolver를 통해 JSP 파일 렌더링
- 사용자에게 최종 HTML 응답 반환

---

## 🧪 전체 흐름을 설명형으로 표현한 이미지

![설명형 흐름도](/image%20(4).png)

이 그림은 전체 DispatcherServlet 구조를 마치 **만화처럼 설명**해주는 버전입니다.  
초보자도 직관적으로 흐름을 이해할 수 있어요!

📌 **포인트 요약**  
- 요청 → DispatcherServlet → Handler → Controller → ViewResolver → JSP
- 결과적으로 HTML 또는 JSON 응답 반환!

---

## ✉ @RequestBody & @ResponseBody 상세 요약

| 어노테이션 | 설명 |
|------------|------|
| **@RequestBody** | 클라이언트가 보낸 JSON 데이터를 Java 객체로 변환 |
| **@ResponseBody** | Java 객체를 JSON으로 변환해 응답 Body에 포함 |

> 주로 **비동기 통신(AJAX, Fetch, Axios)** 에서 사용됩니다.

---

## 🎯 @Controller vs @RestController

| 항목 | @Controller | @RestController |
|------|-------------|-----------------|
| 주 목적 | View 반환 | JSON 반환 |
| 내부 구조 | ViewResolver 사용 | HttpMessageConverter 사용 |
| JSON 반환 방식 | + @ResponseBody 필요 | 기본 포함 |

---

## 🧪 REST API 예시 (Spring + JSON)

```java
@RestController
@RequestMapping("/memo")
public class RestController_02Memo {

    @Autowired
    private MemoService memoService;

    @PostMapping("/add_rest_post")
    public void add(@RequestBody MemoDto dto) {
        memoService.addMemo(dto);
    }

    @DeleteMapping("/remove/{id}")
    public void remove(@PathVariable int id) {
        memoService.removeMemo(id);
    }
}
```

---

## 🧪 실습 예시: View + REST AJAX 호출

![rest.jsp 동작 UI](/image%20(4).png)

- 다양한 요청 방식 테스트 가능
  - XHR, Fetch, Axios, Form GET/POST 등
- REST API 연동 실습에 최적화된 인터페이스

---

## ✅ 최종 요약

> Spring MVC에서 DispatcherServlet은 웹 요청의 허브이며, 전통적인 View 기반 처리와 RESTful JSON 기반 처리 모두 유연하게 지원한다.  
> 이를 제대로 이해하면 Spring Web 구조의 절반은 마스터한 셈! 💪🚀
