# ⚠ EXCEPTION 정리

📌 개요 (Overview)

EXCEPTION 처리는 웹 애플리케이션 실행 중 발생할 수 있는 다양한 예외 상황을 안전하게 다루기 위한 구조입니다. 사용자에게 친절한 오류 메시지를 제공하고, 서버의 안정성을 유지하는 데 필수적인 요소입니다.

💡 핵심 개념 요약 (Key Concepts)

- `@ControllerAdvice`: 모든 컨트롤러에서 발생하는 예외를 한 곳에서 처리할 수 있도록 하는 전역 예외 처리 어노테이션입니다.
- `@ExceptionHandler`: 특정 예외가 발생했을 때 실행할 메서드를 지정합니다.
- 사용자 정의 오류 페이지: 예외에 맞는 화면을 보여줄 수 있도록 JSP나 HTML로 구성할 수 있습니다.

⚠ 주의사항 (Cautions)

- `@ExceptionHandler` 메서드는 반환값을 명확히 설정하지 않으면 동작하지 않을 수 있으므로 ViewName 또는 ResponseEntity 등을 지정해야 합니다.
- `@ControllerAdvice`는 패키지 기준으로 동작 범위를 제한할 수 있으므로 구성 위치에 유의해야 합니다.

---

## 📄 ExceptionTestController.java

📂 위치: `src/main/java/com/example/demo/controller/ExceptionTestController.java`

✍️ 파일 간단 설명: Spring MVC에서 발생하는 예외를 처리하는 전용 컨트롤러 또는 전역 예외 핸들러입니다.

🧩 코드 일부 발췌:
```java
package com.example.demo.controller;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import java.io.FileNotFoundException;
@Controller
@Slf4j
```

📌 등장 메서드 목록:
- fileNotFoundExceptionHandler()
- arithmeticExceptionHandler()
- arithmeticExceptionHandler()
- ex1_1()
- ex1()

🔍 코드 속 개념 설명:
예외 상황을 컨트롤러 또는 전역에서 처리하며, 오류 메시지나 뷰를 사용자에게 제공합니다.

🧠 등장하는 주요 키워드 설명:
- 🧯 `@ExceptionHandler`: 특정 예외 발생 시 실행할 메서드를 정의합니다.
- 🛡 `@ControllerAdvice`: 모든 컨트롤러의 예외를 한 곳에서 처리할 수 있도록 구성합니다.
- 📄 `ModelAndView`: 예외 처리 시 전달할 뷰 이름과 데이터를 함께 지정할 수 있는 객체입니다.


🧪 예제 또는 비유 (Examples or Analogies)

- 예외 처리 구조는 마치 자동차 에어백처럼, 문제 발생 시 사용자와 시스템을 보호합니다.


---

## 📄 GlobalExceptionHandler.java

📂 위치: `src/main/java/com/example/demo/controller/exception/GlobalExceptionHandler.java`

✍️ 파일 간단 설명: Spring MVC에서 발생하는 예외를 처리하는 전용 컨트롤러 또는 전역 예외 핸들러입니다.

🧩 코드 일부 발췌:
```java
package com.example.demo.controller.exception;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import lombok.extern.slf4j.Slf4j;
@ControllerAdvice
@Slf4j
public class GlobalExceptionHandler {
	@ExceptionHandler(Exception.class)
	public String AllExceptionExceptionHandler(Exception e, Model model) {
```

📌 등장 메서드 목록:
- AllExceptionExceptionHandler()

🔍 코드 속 개념 설명:
예외 상황을 컨트롤러 또는 전역에서 처리하며, 오류 메시지나 뷰를 사용자에게 제공합니다.

🧠 등장하는 주요 키워드 설명:
- 🧯 `@ExceptionHandler`: 특정 예외 발생 시 실행할 메서드를 정의합니다.
- 🛡 `@ControllerAdvice`: 모든 컨트롤러의 예외를 한 곳에서 처리할 수 있도록 구성합니다.
- 📄 `ModelAndView`: 예외 처리 시 전달할 뷰 이름과 데이터를 함께 지정할 수 있는 객체입니다.


🧪 예제 또는 비유 (Examples or Analogies)

- 예외 처리 구조는 마치 자동차 에어백처럼, 문제 발생 시 사용자와 시스템을 보호합니다.


📚 한 줄 요약 (1-Line Summary)

예외 상황을 안전하게 처리하고 사용자에게 의미 있는 오류 메시지를 제공하기 위한 전역 예외 처리 구조를 구현합니다.
