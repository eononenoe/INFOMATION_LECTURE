# 📚 RESTful 웹 서비스 & HTTP 메서드 정리

## 📌 개요 (Overview)

- **@RestController**는 Spring에서 **RESTful 웹 서비스를 제공**하기 위한 특수한 Controller입니다.
- REST(Representational State Transfer)는 **네트워크를 통해 외부 자원에 접근**하는 아키텍처 스타일입니다.
- 주고받는 데이터는 **JSON**, **XML** 형태로 표현되며, **@Controller + @ResponseBody** 조합과 유사합니다.
- 프론트엔드에서는 다양한 **비동기 요청 기술**(XHR, Promise, Fetch, Axios)을 통해 서버와 통신합니다.

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🌟 RestController 기본
- `@RestController = @Controller + @ResponseBody`
- **리턴 값**을 그대로 **HTTP Response Body**에 담아 전송
- 주로 JSON, XML 같은 **데이터 포맷**을 리턴
- API 서버 구축 시 필수 사용

### 🌟 HTTP 요청 메서드 정리

| 메서드 | 설명                  | 주 용도                  |
| :----- | :-------------------- | :------------------------ |
| GET    | 서버로부터 데이터 요청 | 데이터 조회 (SELECT)       |
| POST   | 서버에 새 리소스 생성  | 데이터 생성 (INSERT)       |
| PUT    | 리소스 전체 수정 요청  | 전체 업데이트 (UPDATE)     |
| PATCH  | 리소스 일부 수정 요청  | 부분 업데이트 (UPDATE)     |
| DELETE | 서버 리소스 삭제 요청  | 데이터 삭제 (DELETE)       |
| HEAD   | 본문 없이 헤더만 요청  | 상태 확인 (응답 테스트)     |
| OPTIONS| 지원 메서드 목록 요청  | CORS, 통신 가능 메서드 확인 |

### 🌟 비동기 요청 방법 종류 (프론트엔드)

| 종류           | 등장 시기 | 특징 및 설명 |
| :------------- | :-------- | :----------- |
| XMLHttpRequest | 1999년    | 전통적인 비동기 통신 방법 |
| Promise        | 2015년    | 콜백 헬 해결, 비동기 흐름 관리 |
| Fetch API      | 2015년    | 간결한 문법 + Promise 기반 |
| Axios          | 2014년    | Promise 기반, JSON 자동 직렬화, 인터셉터 지원 |

---

## ⚠ 주의사항 (Cautions)

- **PUT vs PATCH**를 혼동하지 말자!
  - **PUT**: 리소스 전체를 덮어쓴다. (모든 필드 필요)
  - **PATCH**: 리소스의 일부분만 수정한다. (필요한 부분만 전송)
- **@RestController**를 사용할 때는 리턴 타입에 따라 `produces` 옵션을 명시해주는 것이 좋습니다.
- **POST, PUT, PATCH** 요청 시에는 Body에 반드시 데이터를 담아야 한다.
- `@GetMapping`, `@PostMapping` 등은 `@RequestMapping(method=...)`를 더 간단하게 사용한 단축 어노테이션이다.

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 📬 PUT vs PATCH 비교 예시

**PUT 전체 덮어쓰기**
```http
PUT /user/123
Content-Type: application/json

{
  "name": "홍길동",
  "email": "hong@example.com",
  "phone": "010-1234-5678"
}
```
➡️ 기존 정보 전부를 새로 덮어씀.

**PATCH 일부 수정**
```http
PATCH /user/123
Content-Type: application/json

{
  "phone": "010-5678-1234"
}
```
➡️ 필요한 데이터(전화번호)만 수정.

### 🧩 @RestController 실제 코드 예시

```java
@RestController
@RequestMapping("/api")
public class ExampleRestController {

    @GetMapping(value="/hello", produces = MediaType.TEXT_PLAIN_VALUE)
    public String sayHello() {
        return "Hello, World!";
    }

    @PostMapping(value="/user", produces = MediaType.APPLICATION_JSON_VALUE)
    public User createUser(@RequestBody User user) {
        return userService.save(user);
    }
}
```

---

## 🧠 추가 심화 개념 (Advanced Concepts)

### 🔹 ResponseEntity 사용하기
- API 응답 시 **상태 코드**와 **본문 데이터**를 함께 반환할 수 있음

```java
@GetMapping("/data")
public ResponseEntity<String> getData() {
    return ResponseEntity.status(HttpStatus.OK).body("Success");
}
```

### 🔹 MediaType 종류
| MediaType 상수 | 설명 |
| :------------- | :--- |
| `APPLICATION_JSON_VALUE` | application/json |
| `APPLICATION_XML_VALUE`  | application/xml |
| `TEXT_PLAIN_VALUE`        | text/plain |
| `TEXT_HTML_VALUE`         | text/html |

- **produces** 옵션은 응답 타입을 명시할 때 사용한다.
- **consumes** 옵션은 요청 본문 타입을 지정할 때 사용한다.

### 🔹 RESTful API 설계 시 주의사항
- URL은 **명사** 형태로 작성한다. (예: `/users`, `/memos`)
- 행위(동사)는 HTTP 메서드로 표현한다. (예: 조회는 GET, 추가는 POST)
- 계층 구조를 잘 표현한다. (예: `/users/1/memos`)

---

## ✅ 한 줄 요약 (1-Line Summary)

> **@RestController**는 JSON/XML 데이터로 주고받는 **RESTful API 서버**를 만들 때 사용하며, **HTTP 메서드**는 "GET=조회, POST=생성, PUT=전체수정, PATCH=부분수정, DELETE=삭제"로 구분한다! 🚀

