# 🌐 Spring MVC 요청 매핑 & 파라미터 처리 정리

---

## 📌 개요 (Overview)

스프링 MVC에서는 웹 요청을 처리할 메서드를 지정하고, 요청에 포함된 데이터(파라미터, 본문 등)를 다양한 방식으로 받아 처리할 수 있다.  
이 문서에서는 요청 매핑과 파라미터 바인딩 방식들을 정리한다.

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🗺️ 요청 URI 매핑 애노테이션

| 애노테이션 | 설명 |
|------------|------|
| `@RequestMapping` | 가장 기본적인 매핑, 다양한 옵션(`method`, `params`, `headers`) 가능 |
| `@GetMapping` | GET 요청 전용 매핑 |
| `@PostMapping` | POST 요청 전용 매핑 |
| `@PutMapping` | PUT 요청 전용 매핑 |
| `@DeleteMapping` | DELETE 요청 전용 매핑 |

#### `@RequestMapping` 주요 옵션

- `value` 또는 `path`: 매핑할 URI 경로
- `method`: HTTP 메서드 지정 (GET, POST 등)
- `params`: 특정 파라미터가 있을 때만 매핑
- `headers`: 특정 헤더가 있을 때만 매핑
- `consumes`: 요청 Content-Type 제한
- `produces`: 응답 Content-Type 제한

---

### 📥 요청 파라미터 처리 애노테이션

| 애노테이션 | 설명 |
|------------|------|
| `@RequestParam` | 쿼리스트링 또는 폼 데이터 바인딩 |
| `@RequestBody` | 요청 본문(JSON 등)을 객체나 문자열로 바인딩 |
| `@PathVariable` | URI 경로의 일부를 변수로 바인딩 |
| `@ModelAttribute` | 폼 데이터를 객체로 바인딩 (DTO/VO) |

---

## 📋 실습 예제 기반 정리 (`ParameterTestController.java`)

| URI | 방식 | 사용된 애노테이션 | 설명 |
|-----|------|------------------|------|
| `/param/p01` | GET | `@RequestParam(required=false)` | 선택적 파라미터 |
| `/param/p02` | GET | `@RequestParam(required=true)` | 필수 파라미터 |
| `/param/p03` | POST | `@RequestParam` | POST 폼 데이터 처리 |
| `/param/p04` | POST | `@RequestBody` | 비동기 요청, 전체 body 처리 |
| `/param/p05` | GET | `@RequestParam(defaultValue="홍길동")` | 기본값 지정 |
| `/param/p06` | GET | `@ModelAttribute` | DTO로 바인딩 |
| `/param/p07` | GET | DTO 자동 바인딩 | 쿼리스트링 → DTO |
| `/param/p08` | POST | `@RequestBody` | JSON → DTO |
| `/param/p09/{id}` | GET | `@PathVariable("id")` | 경로 변수 매핑 |

---

## 🧾 View로 데이터 전달 방법

| 클래스 | 설명 |
|--------|------|
| `Model` | View에 데이터 전달 (기본적인 방식) |
| `ModelAndView` | 데이터 + 뷰 이름 동시 설정 |
| `ModelMap`, `Map` | `Model`과 동일 기능, key-value 형식 데이터 전달 |
| `RedirectAttributes` | 리다이렉트 시 데이터 전달 유지

---

## 📄 실습 컨트롤러 코드 (`ParameterTestController.java`)

```java
// 일부 발췌 - 전체 코드는 src/main/java/com/example/app/controller/ParameterTestController.java 참고
@RequestMapping(value="/p01",method=RequestMethod.GET)
public void p01(@RequestParam(value="name", required=false) String name) {
    log.info("GET /param/p01..." + name);
}

@PostMapping(value="/p03")
public void p03(@RequestParam(value="name", required=true) String name) {
    log.info("POST /param/p03..." + name);
}

@PostMapping(value="/p04")
public void p04(@RequestBody String name) {
    log.info("POST /param/p04..." + name);
}

@RequestMapping(value="/p07",method=RequestMethod.GET)
public void p07(@ModelAttribute PersonDto dto) {
    log.info("GET /param/p07..." + dto);
}

@RequestMapping(value="/p08/{username}/{age}/{addr}",method=RequestMethod.GET)
public void p08(
    @PathVariable("username") String name,
    @PathVariable int age,
    @PathVariable String addr) {
    log.info("GET /param/p08..." + name+" " + age + " " + addr);
}
```

---

## 📦 프로젝트 내 주요 클래스 요약

###  `PersonComponent.java`

```java
@Component
@Data
public class PersonComponent {
    private String username = "티모";
    private int age = 33;
    private String addr = "인천";
}
```

- `@Component`: 스프링 빈으로 등록
- `@Data`: Lombok의 자동 Getter/Setter, toString 포함

###  `PersonDto.java`

```java
@Data
@AllArgsConstructor
@NoArgsConstructor
@Component
@Builder
public class PersonDto {
    private String username;
    private int age;
    private String addr;
}
```

- DTO 형태의 데이터 전달 객체
- JSON 매핑, 폼 매핑 등에 사용

---
## 🔁 FORWARD / REDIRECT

| 반환 값 | 설명 |
|---------|------|
| `forward:/uri` | 서버 내부 이동 (URL 안 바뀜) |
| `redirect:/uri` | 클라이언트에게 재요청 (URL 바뀜) |

---

## ⚠ 주의사항 (Cautions)

- `@RequestParam` 기본값은 `required=true` → 누락 시 오류 발생
- `@RequestBody`는 `Content-Type: application/json` 필요
- DTO 바인딩 시 필드 이름과 파라미터 이름 일치 필수
- `@ModelAttribute`는 form 데이터에 적합

---

## 🧪 예제 또는 비유 (Examples or Analogies)

- `@RequestParam` 👉 "주소창에서 `?name=홍길동` → `name` 변수에 저장"
- `@RequestBody` 👉 "본문의 JSON 데이터 전체를 객체로 변환"
- `@PathVariable("id")` 👉 "`/user/3`에서 `3`을 추출해서 변수로"
- `@ModelAttribute` 👉 "폼에서 넘어온 여러 값들을 한 DTO에 담음"

---

## ✅ 한 줄 요약 (1-Line Summary)

📌 **Spring에서는 다양한 애노테이션을 통해 HTTP 요청을 처리하고, 데이터를 쉽게 바인딩하여 활용할 수 있다.**
