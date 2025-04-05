# 🚀 Java 함수형 프로그래밍 심화: 함수형 인터페이스, 람다, 스트림, 어노테이션

---

## 📌 개요 (Overview)

이번 학습에서는

- **사용자 정의 함수형 인터페이스**
- **Java 기본 제공 함수형 인터페이스** (`Function`, `Supplier`, `Consumer`, `Predicate` 등)
- **스트림 API**를 이용한 데이터 변형 및 집계
- **사용자 정의 어노테이션(Custom Annotation)** 작성 및 활용

을 다루었습니다! 🧩

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🔹 함수형 인터페이스 (Functional Interface)

- **@FunctionalInterface** 애너테이션 사용
- **추상 메서드가 하나**만 존재
- 람다식을 통해 인스턴스 생성

```java
@FunctionalInterface
interface Calculator {
    int calculate(int a, int b);
}

Calculator add = (a, b) -> a + b;
System.out.println(add.calculate(10, 20)); // 출력: 30
```

---

### 🔹 고급 함수형 인터페이스 활용

- **가변 인자 (varargs)** 를 통한 합, 차, 곱, 나눗셈 연산
- **List<Object> 필터링 + 매핑 + 집계**
- **Function chaining** (`andThen()`, `compose()` 사용)
- **커링 (Currying)** : 함수가 다른 함수를 반환

```java
Function<Integer, Function<Integer, Integer>> addFunc = x -> y -> x + y;
System.out.println(addFunc.apply(10).apply(20)); // 출력: 30
```

---

### 🔹 어노테이션 (Annotation)

- **@Retention(RetentionPolicy.RUNTIME)**  
  → 프로그램 실행 중에도 어노테이션 정보 유지
- **@Target(ElementType.TYPE, ElementType.METHOD)**  
  → 클래스/메서드에 적용 가능
- **Custom Annotation 직접 만들기!**

```java
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE})
public @interface CustomAnnotation {
    String value() default "";
    int number() default 0;
    boolean isOpen() default false;
}
```

사용:

```java
@CustomAnnotation(value = "HELLO", number = 5, isOpen = true)
class MyClass {}
```

---

## ⚠ 주의사항 (Cautions)

- **함수형 인터페이스**는 **추상 메서드가 반드시 하나**여야 한다.
- **람다식 내부에서 return만 있는 경우** `{}` 생략 가능.
- **스트림(Stream)은 일회성**이다! → 한 번 연산하면 재사용 불가.
- **커링(Currying)** 패턴은 익숙하지 않으면 헷갈릴 수 있다! 차근차근 따라가기 🐢
- **@Retention(RUNTIME)** 이 없으면 실행 중에 어노테이션 정보를 얻을 수 없다.

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 🧠 함수형 인터페이스
> "전달받은 레시피 하나만 보고 요리를 완성하는 요리사" 👨‍🍳  
> (추상 메서드가 하나니까!)

---

### 🛠️ 스트림 API
> "공장에서 나오는 부품을 자동으로 필터링, 조립, 포장하는 컨베이어 벨트" 🏭

---

### 🎯 어노테이션
> "개발자 메모 포스트잇" 📋  
> (컴파일러나 프로그램이 참고하는 힌트)

---

## ✅ 한 줄 요약 (1-Line Summary)

> **람다로 깔끔하게, 스트림으로 유연하게, 함수형 인터페이스와 어노테이션으로 똑똑하게 프로그래밍하자!** 🚀

