# 🌱 SPRING WebDataBinder & 유효성 검사 (Spring MVC)

📌 **개요 (Overview)**  
`WebDataBinder`는 웹 폼에서 보낸 값을 자바 객체로 바꿔주는 애임.  
그리고 바꾸는 과정에서 값이 이상한지도 같이 검사해줌.  
덕분에 폼 데이터 처리할 때 되게 편하고 안정적으로 쓸 수 있음!

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🧰 WebDataBinder가 뭐냐면
- 폼에서 넘어온 문자열 데이터를 자바 객체로 자동으로 넣어줌  
- `@ModelAttribute`로 컨트롤러 메서드 파라미터에 바인딩됨
- 역할은 딱 두 가지:
  1. **타입 변환 (문자열 → 자바 객체 필드)**  
  2. **데이터 유효성 검사**

### 🔖 관련 애노테이션 정리

#### 바인딩 관련
- `@ModelAttribute`: 폼 값 → 자바 객체 필드 자동 바인딩
- `@InitBinder`: WebDataBinder 초기 설정할 때 씀
- `BindingResult`: 바인딩 중 오류 생기면 여기 담김

#### 유효성 검사
- `@Valid`: 객체 검증
- `@Validated`: 클래스/그룹 단위 검증

---

## 🧪 예제 or 비유 (Examples or Analogies)

### 🎯 비유: 웹에서 날짜 넘겨줄 때
- URL: `year=2021&month=10&day=1` 이렇게 넘어옴
- 이거 다 문자열이라서 그냥 쓸 수 없음
- WebDataBinder가 이걸 MyDate 객체로 변환
- 그 다음 BindingResult가 유효한 값인지 확인해줌

### 🖼 시각화 이미지 첨부

> WebDataBinder의 흐름을 한눈에 볼 수 있게 도식화한 이미지 👇

![WebDataBinder 구조](/image.jpg)

---

## ⚠ 주의사항 (Cautions)

- `BindingResult`는 꼭 유효성 검사 대상 **바로 뒤에 와야 함**
- 순서 틀리면 제대로 동작 안 하거나 예외 뜸
- 유효성 검사 하려면 아래 의존성도 필요함

```xml
<!-- hibernate-validator 관련 의존성 -->
<dependency>
  <groupId>org.hibernate.validator</groupId>
  <artifactId>hibernate-validator</artifactId>
  <version>6.0.7.Final</version>
</dependency>
<dependency>
  <groupId>javax.validation</groupId>
  <artifactId>validation-api</artifactId>
  <version>2.0.1.Final</version>
</dependency>
```

---

## ✅ 유효성 검사 애노테이션 정리

#### 숫자 관련
- `@Min(value)`: 최소값 이상인가
- `@Max(value)`: 최대값 이하인가
- `@Positive`: 양수인가
- `@PositiveOrZero`: 양수 or 0인가
- `@Negative`: 음수인가
- `@NegativeOrZero`: 음수 or 0인가

#### 문자열 관련
- `@NotBlank`: 빈 문자열 아니어야 함
- `@Size(min, max)`: 길이 체크
- `@Email`: 이메일 형식 맞는지
- `@Pattern(regexp)`: 정규식 체크
- `@URL`: URL 형식 맞는지

#### 날짜/시간 관련
- `@DateTimeFormat(pattern)`: 날짜 포맷 지정
- `@Future`: 미래 날짜인지
- `@FutureOrPresent`: 미래 or 현재인지
- `@Past`: 과거 날짜인지
- `@PastOrPresent`: 과거 or 현재인지

#### 기타
- `@AssertTrue`: true여야 함
- `@AssertFalse`: false여야 함
- `@CreditCardNumber`: 카드번호 유효한지

---

## ✅ 한 줄 요약 (1-Line Summary)

> WebDataBinder는 폼에서 온 값들을 자바 객체에 자동으로 넣어주고, 값이 이상한지도 같이 체크해주는 도구다! 🎩✨
