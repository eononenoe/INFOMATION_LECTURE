
# 📦 PARAM 관련 파일 정리

📌 개요 (Overview)

PARAM은 클라이언트가 요청한 데이터(파라미터)를 서버에서 어떻게 전달받고 처리하는지를 보여주는 기능입니다. 이 기능을 통해 `GET`, `POST` 등의 HTTP 요청에서 전송된 값을 컨트롤러에서 받는 방식을 학습할 수 있습니다.

💡 핵심 개념 요약 (Key Concepts)

- `@RequestParam`: URL 쿼리 스트링 또는 폼 데이터에서 단일 파라미터 값을 추출합니다.
- `@ModelAttribute`: 폼 데이터를 객체 단위로 매핑합니다.
- `@RequestMapping`, `@GetMapping`, `@PostMapping`: HTTP 요청의 경로 및 메서드를 처리하는 어노테이션입니다.

⚠ 주의사항 (Cautions)

- `@RequestParam`은 기본적으로 `required=true`이므로, 파라미터가 반드시 포함되어야 합니다. 필요하지 않다면 `required=false` 옵션을 추가하세요.
- DTO를 사용할 경우 `@ModelAttribute`가 생략 가능하지만 명시하는 것이 명확성을 높입니다.

---

## 📄 ParameterTestController.java

📂 위치: `src/main/java/com/example/demo/controller/ParameterTestController.java`

✍️ 파일 간단 설명: 사용자 요청 파라미터를 처리하고 전달하는 역할의 Controller 클래스입니다.

🧩 코드 일부 발췌:
```java
package com.example.demo.controller;
import com.example.demo.domain.dto.PersonDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
```

📌 등장 메서드 목록:
- p01()
- p02()
- p03()
- p04()
- p05()
- p07()
- p09()
- page01()
- page02()
- page03()
- page04()
- page05()
- f1()
- f2()
- f3()
- r1()

🔍 코드 속 개념 설명:
Spring MVC의 Controller이며, 사용자의 입력 파라미터를 처리하는 메서드를 포함합니다.

🧠 등장하는 주요 키워드 설명:
- 📥 `@RequestParam`: 요청 파라미터를 메서드 인자로 바인딩합니다.
- 🧾 `@ModelAttribute`: 폼 데이터를 자바 객체(DTO)로 자동 매핑합니다.
- 🌐 `@RequestMapping`: HTTP 요청의 URL과 컨트롤러 메서드를 매핑합니다.
- 🔄 `redirect:` / `forward:`: 뷰 리졸버에 의해 리다이렉트 또는 포워딩 처리됩니다.


🧪 예제 또는 비유 (Examples or Analogies)

- `@RequestParam`은 마치 설문지에서 하나의 질문에 대한 답변을 직접 입력받는 방식입니다.
- `@ModelAttribute`는 여러 질문이 모인 폼을 한 번에 제출하고 객체로 받는 방식과 비슷합니다.


📚 한 줄 요약 (1-Line Summary)

사용자 입력 파라미터를 받는 다양한 방법(`@RequestParam`, `@ModelAttribute`)을 컨트롤러를 통해 학습할 수 있습니다.
