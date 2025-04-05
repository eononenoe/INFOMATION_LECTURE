# 🧠 Java 람다식(Lambda) + 스트림(Stream) + 함수형 프로그래밍 완전 정리

---

## 📌 개요 (Overview)

이번 학습에서는

- **람다식(Lambda Expression)** 을 통한 간결한 코드 작성
- **스트림(Stream API)** 을 이용한 컬렉션 데이터 처리
- **함수형 인터페이스(Functional Interface)** 를 기반으로 한 프로그래밍 패턴

을 배웠습니다! 🎯

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🔹 람다식 (Lambda)

- 메서드를 하나의 **식(Expression)** 처럼 간결하게 표현하는 방법
- 기존의 익명 내부 클래스(Anonymous Class)를 더 짧게!

```java
// 기존 방식
new Thread(new Runnable() {
    public void run() {
        System.out.println("Hello");
    }
}).start();

// 람다식
new Thread(() -> System.out.println("Hello")).start();
```

---

### 🔹 스트림 (Stream)

- 컬렉션(Collection)의 데이터를 **흐름처럼** 처리하는 방법
- filter, map, reduce 등을 통해 데이터 변환과 집계가 가능

```java
List<Integer> list = Arrays.asList(1, 2, 3, 4, 5);

List<Integer> evenSquares = list.stream()
    .filter(n -> n % 2 == 0)  // 짝수만
    .map(n -> n * n)          // 제곱
    .collect(Collectors.toList());

System.out.println(evenSquares); // [4, 16]
```

---

### 🔹 함수형 인터페이스 (Functional Interface)

- **추상 메서드가 딱 하나만** 있는 인터페이스
- @FunctionalInterface 어노테이션으로 선언

```java
@FunctionalInterface
interface Calculator {
    int calculate(int a, int b);
}

Calculator add = (a, b) -> a + b;
System.out.println(add.calculate(3, 4)); // 7
```

---

## ⚠ 주의사항 (Cautions)

- 람다식에서는 **return** 문이 하나라면 `{}` 생략 가능, 여러 줄일 땐 `{}` 필수
- 스트림은 **한 번 사용하면 재사용 불가** (필요하면 다시 생성해야 함)
- 함수형 인터페이스는 **추상 메서드가 1개**만 있어야 함
- 스트림 최종 연산이 수행되기 전까지는 **실제 처리되지 않고 지연** (Lazy Evaluation)

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 🧠 람다식
> 코드를 **"한 줄 메시지"처럼 보내는 메신저**  
> (복잡한 클래스를 다 만들 필요 없이 단번에!)

---

### 🧹 스트림
> **물줄기**를 따라 **필터링, 변환, 집계**를 자동으로 해주는 신기한 정수기 💧

---

### 🧩 함수형 인터페이스
> 버튼을 눌렀을 때 "단 하나의 행동만" 정해놓는 **단일 명령어 리모컨** 🎛️

---

## ✅ 한 줄 요약 (1-Line Summary)

> **람다로 코드를 간결하게, 스트림으로 데이터를 우아하게, 함수형 프로그래밍으로 똑똑하게!** 🚀

