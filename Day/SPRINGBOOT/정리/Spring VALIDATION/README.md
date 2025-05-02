# 🔍 VALIDATION 정리

📌 개요 (Overview)

VALIDATION은 사용자로부터 입력받은 데이터가 올바른 형식인지 검사하는 기능입니다. 특히 폼을 통해 전송된 데이터에 대해 서버 측에서 제약 조건을 설정하여 잘못된 입력을 사전에 방지할 수 있습니다.

💡 핵심 개념 요약 (Key Concepts)

- `@NotNull`, `@NotEmpty`, `@Size`: 필드에 대한 유효성 검사를 수행하는 어노테이션입니다.
- DTO(Data Transfer Object): 사용자로부터 받은 데이터를 담고, 그 데이터에 유효성 조건을 부여합니다.
- BindingResult: 유효성 검사 결과를 담는 객체로, 오류 처리에 사용됩니다.

⚠ 주의사항 (Cautions)

- 유효성 어노테이션은 JSR-303 표준을 따르며, 관련 라이브러리(`spring-boot-starter-validation`)가 필요합니다.
- 컨트롤러에서는 `@Valid`와 `BindingResult`를 함께 사용해야 오류 정보를 받을 수 있습니다.

---

## 📄 MemoDto.java

📂 위치: `src/main/java/com/example/demo/domain/dto/MemoDto.java`

✍️ 파일 간단 설명: 폼 입력값의 유효성을 검증하는 DTO 클래스입니다.

🧩 코드 일부 발췌:
```java
package com.example.demo.domain.dto;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
@Data
@NoArgsConstructor
```

📌 등장 메서드 목록:
- (메서드 없음)

🔍 코드 속 개념 설명:
유저 입력을 담기 위한 DTO 클래스이며, 유효성 검증 어노테이션이 포함되어 있습니다.

🧠 등장하는 주요 키워드 설명:
- 🔒 `@NotNull`: 해당 값이 null이 아니어야 함을 검증합니다.
- 🈳 `@NotEmpty`: null이 아니면서 비어있지 않은 문자열을 요구합니다.
- 🔢 `@Size`: 문자열 또는 컬렉션의 길이나 크기를 제한합니다.


🧪 예제 또는 비유 (Examples or Analogies)

- 유효성 어노테이션은 마치 공항 보안 검색대처럼, 기준에 맞지 않는 데이터를 걸러냅니다.


---

## 📄 PersonDto.java

📂 위치: `src/main/java/com/example/demo/domain/dto/PersonDto.java`

✍️ 파일 간단 설명: 폼 입력값의 유효성을 검증하는 DTO 클래스입니다.

🧩 코드 일부 발췌:
```java
package com.example.demo.domain.dto;
import org.springframework.stereotype.Component;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
//@Getter
//@Setter
//@ToString
@Data
```

📌 등장 메서드 목록:
- (메서드 없음)

🔍 코드 속 개념 설명:
유저 입력을 담기 위한 DTO 클래스이며, 유효성 검증 어노테이션이 포함되어 있습니다.

🧠 등장하는 주요 키워드 설명:
- 🔒 `@NotNull`: 해당 값이 null이 아니어야 함을 검증합니다.
- 🈳 `@NotEmpty`: null이 아니면서 비어있지 않은 문자열을 요구합니다.
- 🔢 `@Size`: 문자열 또는 컬렉션의 길이나 크기를 제한합니다.


🧪 예제 또는 비유 (Examples or Analogies)

- 유효성 어노테이션은 마치 공항 보안 검색대처럼, 기준에 맞지 않는 데이터를 걸러냅니다.


📚 한 줄 요약 (1-Line Summary)

DTO에 유효성 검사를 적용함으로써 사용자 입력 데이터를 사전에 검증하고 안전한 처리를 할 수 있습니다.
