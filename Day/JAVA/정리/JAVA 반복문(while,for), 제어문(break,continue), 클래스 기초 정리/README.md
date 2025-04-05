# 📚 JAVA 반복문(while/for), 제어문(break/continue), 클래스 기초 정리

---

## 📌 개요 (Overview)

이번 파트에서는

- 반복문 `while`, `for`
- 제어문 `break`, `continue`
- 기본 클래스 개념과 생성자
- 메서드 오버로딩, 가변인자, 지역변수

등 Java 프로그램의 필수 뼈대를 만드는 문법을 연습합니다! 🚀

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🔄 반복문 (while, for)
- **while**: 조건을 먼저 검사하고 반복
- **for**: 초기값, 조건식, 증감식을 한 줄에 작성

### 🚪 break, continue
- **break**: 반복문 즉시 탈출
- **continue**: 현재 반복을 건너뛰고 다음 반복 실행

### 🏗 클래스와 객체
- **클래스**: 객체를 만들기 위한 설계도
- **객체**: 클래스를 통해 메모리에 생성된 실체
- **속성(Attribute)**: 변수
- **기능(Function)**: 메서드

### 🔥 생성자(Constructor)
- 객체 생성시 자동 호출되는 메서드
- 클래스 이름과 같고 반환형이 없음

### 🎯 메서드 오버로딩
- 메서드 이름은 같지만 매개변수 다르게 여러개 선언 가능

### 🧹 지역변수 vs 멤버변수
- **지역변수**: 메서드나 블록 내부에서 선언, 블록 끝나면 사라짐
- **멤버변수**: 클래스 내부 선언, 객체가 살아있는 동안 유지

### ✨ 가변인자
- 메서드 매개변수에 `...`을 붙이면 여러 개 인자를 받을 수 있음

---

## ⚠ 주의사항 (Cautions)

- while문 쓸 때 **무한루프 주의** (반복 변수 꼭 변화시켜야 함)
- break는 **가장 가까운 반복문**만 탈출한다.
- nextInt 후 nextLine을 쓸 경우 **버퍼 비우기**
- 클래스 내부 변수와 지역변수 이름이 겹치면 `this.`로 구분
- 생성자 직접 만들면 기본 생성자 제공 안 함!

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 📦 while 구구단 출력 (C02While)

```java
int dan = 2;
while (dan <= 9) {
    int i = 1;
    while (i <= 9) {
        System.out.printf("%d x %d = %d\n", dan, i, dan * i);
        i++;
    }
    System.out.println();
    dan++;
}
```

---

### 📦 별 찍기 - 피라미드 만들기 (C02While)

```java
int i = 0;
while (i < 4) {
    int j = 0;
    while (j < 3 - i) {
        System.out.print(" ");
        j++;
    }
    int k = 0;
    while (k <= 2 * i) {
        System.out.print("*");
        k++;
    }
    System.out.println();
    i++;
}
```

---

### 📦 break / continue 제어문 (C03Continue_Break)

```java
// break 사용 예시
Scanner sc = new Scanner(System.in);
int sum = 0;
while (true) {
    int n = sc.nextInt();
    if (n == -1) break;
    sum += n;
}
System.out.println("SUM: " + sum);

// continue 사용 예시
int i = 1, sum = 0;
while (i <= 10) {
    if (i % 3 == 0) {
        i++;
        continue;
    }
    sum += i;
    i++;
}
System.out.println("SUM (3의배수 제외): " + sum);
```

---

### 📦 for문 기본 구조 (C04For)

```java
for (int i = 0; i < 10; i++) {
    System.out.println("HELLO WORLD");
}
```

---

### 📦 리스트 반복 출력 (C05기타반복처리)

```java
List<String> lists = new ArrayList<>();
lists.add("JAVA");
lists.add("SPRINGBOOT");
lists.add("REACT");

// 기본 for
for (int i = 0; i < lists.size(); i++) {
    System.out.println(lists.get(i));
}

// 향상된 for
for (String subject : lists) {
    System.out.println(subject);
}

// stream
lists.stream().forEach(item -> System.out.println(item));
```

---

### 📦 객체 개념 정리 (C00INFO)

- **객체(Object)**: 세상에 존재하는 모든 것
- **속성**: 변수 (ex: 이름, 나이)
- **기능**: 메서드 (ex: 걷기, 말하기)
- **메모리 구조**
  - 스택(Stack): 지역변수
  - 힙(Heap): 객체 저장
  - 메서드 영역: 클래스, static 저장

---

### 📦 클래스 생성 및 사용 (C01Main ~ C02PersonMain)

```java
class Person {
    String name;
    int age;
    float height;
    double weight;
}

// 객체 생성
Person hong = new Person();
hong.name = "홍길동";
hong.age = 15;
hong.height = 177.5f;
hong.weight = 70.5;
System.out.printf("%s %d %f %f\n", hong.name, hong.age, hong.height, hong.weight);
```

---

### 📦 메서드와 기능 추가 (C03PersonMain)

```java
class Person {
    String name;
    int age;
    float height;
    double weight;
    
    void talk() { System.out.println(name + "님이 말합니다."); }
    void walk() { System.out.println(name + "님이 걷습니다."); }
    void showInfo() {
        System.out.printf("%s %d %f %f\n", name, age, height, weight);
    }
}
```

---

### 📦 메서드 다양한 형태 (C04MethodMain)

```java
class MethodTest {
    Scanner sc = new Scanner(System.in);
    int sum1(int a, int b) { return a + b; }
    int sum2() { return sc.nextInt() + sc.nextInt(); }
    void sum3(int a, int b) { System.out.println(a + b); }
    void sum4() { System.out.println(sc.nextInt() + sc.nextInt()); }
}
```

---

### 📦 지역변수와 멤버변수 차이 (C05LocalVarMain)

```java
class Example {
    int num = 10;
    void show() {
        int num = 5; // 지역변수
        System.out.println(num); // 지역변수 출력
        System.out.println(this.num); // 멤버변수 출력
    }
}
```

---

### 📦 메서드 오버로딩 (C06MethodOverloadingMain)

```java
class Calculator {
    int sum(int a, int b) { return a + b; }
    int sum(int a, int b, int c) { return a + b + c; }
    int sum(double a, double b, double c) { return (int)(a + b + c); }
}
```

---

### 📦 가변인자 사용 (C07가변인자)

```java
class Calculator {
    int sum(int... nums) {
        int result = 0;
        for (int n : nums) {
            result += n;
        }
        return result;
    }
}
```

---

### 📦 생성자 사용법 (C08ConstructorMain)

```java
class Person {
    int age;
    String name;
    
    Person() { System.out.println("디폴트 생성자 호출"); }
    Person(int age) { this.age = age; }
    Person(int age, String name) { this.age = age; this.name = name; }
}
```

---

## ✅ 한 줄 요약 (1-Line Summary)

> **반복문과 제어문으로 흐름을 만들고, 클래스와 메서드로 기능을 완성한다! 자바의 뼈대는 바로 여기서 시작된다!** 🚀
