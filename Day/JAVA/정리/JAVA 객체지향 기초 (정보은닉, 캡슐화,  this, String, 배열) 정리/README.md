# 📚 JAVA 객체지향 기초 (정보은닉, 캡슐화, this, String, 배열) 정리

---

## 📌 개요 (Overview)

이번 파트에서는

- 객체지향 기본 개념(정보은닉, 캡슐화, this)
- 문자열 다루기 (String, StringBuilder)
- 배열(Array)과 2차원 배열
- 클래스 배열 사용법

등 Java OOP 프로그래밍과 데이터 구조 기초를 배우게 됩니다! 🚀

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🛡️ 정보은닉 (Information Hiding)
- `private`로 외부 접근을 막고, `getter/setter`를 통해 접근 제어

### 📦 캡슐화 (Encapsulation)
- 기능 관련 메서드들을 한데 묶고 내부 구현을 감추는 것
- 외부에서는 기능만 사용할 수 있도록 설계

### 🔥 this 키워드
- 자신의 객체를 가리키는 예약어
- 지역변수와 멤버변수 이름이 같을 때 구분하거나 생성자 간 호출에도 사용

### 🧵 String vs StringBuilder
- `String`은 불변(immutable) → 수정 시 매번 새로운 객체 생성
- `StringBuilder`는 변경가능(mutable) → 성능 좋음

### 📚 배열 (Array)
- 같은 타입의 데이터를 하나로 묶는 자료구조
- 1차원, 2차원 배열 그리고 **클래스 배열** 사용법

---

## ⚠ 주의사항 (Cautions)

- String은 `==` 대신 `.equals()`로 비교!
- 배열은 선언만 하면 공간만 생기고 값은 없음 (초기화 필요)
- 클래스 배열도 객체를 `new`로 각각 생성해줘야 함
- StringBuilder를 쓰면 메모리 관리가 훨씬 효율적이다

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 📦 모든 인자 받는 생성자 / 가변 인자 생성자

```java
public class Profile {
    String name, addr, job, major;
    
    public Profile(String name, String addr, String job, String major) {
        this.name = name;
        this.addr = addr;
        this.job = job;
        this.major = major;
    }
    
    public Profile(String... args) {
        this.name = args[0];
        this.addr = args[1];
        this.job = args[2];
        this.major = args[3];
    }
}
```
- ✅ 고정된 인자용 생성자 + ✅ 다양한 개수 인자용 가변생성자 모두 구현 가능

---

### 📦 getter / setter 사용 예시

```java
// Getter
public String getName() {
    return name;
}

// Setter
public void setName(String name) {
    this.name = name;
}
```
> ✍ 정보를 **읽을 땐 getter**, **수정할 땐 setter**를 사용!

---

### 📦 TV, Grade 클래스 실습 예제 (C09Ex)

```java
TV myTv = new TV("LG", 2017, 32);
myTv.show(); 

Grade me = new Grade(90, 80, 70);
System.out.println("평균은 " + me.average());
```

---

### 📦 정보은닉, 캡슐화 예시 (C01정보은닉, C02캡슐화)

```java
class Car {
    private Engine engine = new Engine();
    
    public void run() {
        engine.start();
    }
}

class Engine {
    private void intake() {}
    private void compress() {}
    private void explode() {}
    private void exhaust() {}
    
    public void start() {
        intake();
        compress();
        explode();
        exhaust();
    }
}
```

- 외부에서는 `run()`만 호출 가능 = 내부 동작은 숨김

---

### 📦 this 키워드 활용 (C03This)

```java
class Example {
    int x;
    
    Example(int x) {
        this.x = x;
    }
    
    Example getThis() {
        return this;
    }
}
```
- `this`는 객체 자신을 가리킴

---

### 📦 String 메모리 비교 (C04StringClass)

```java
String str1 = "java";
String str2 = "java";
String str3 = new String("java");

System.out.println(str1 == str2); // true
System.out.println(str1 == str3); // false
System.out.println(str1.equals(str3)); // true
```
- 🔥 문자열 비교는 무조건 `.equals()`!

---

### 📦 StringBuilder 사용 (C05StringClass)

```java
StringBuilder sb = new StringBuilder();
for (int i = 0; i < 10; i++) {
    sb.append(i);
}
System.out.println(sb.toString());
```
- 🔥 성능 최적화: StringBuilder 추천

---

### 📦 Profile 클래스 완성형 (C06Ex)

```java
Profile hong = new Profile("홍길동,대구,프로그래머,컴퓨터공학");

System.out.println(hong.toString());
System.out.println("길동 포함여부 : " + hong.isContain("길동"));
System.out.println("프로필 일치여부 : " + hong.isEquals("홍길동,대구,프로그래머,컴퓨터공학"));
```

---

### 📦 1차원 배열 사용 예시 (C01ArrayMain)

```java
int[] arr = new int[5];
Scanner sc = new Scanner(System.in);

for (int i = 0; i < arr.length; i++) {
    arr[i] = sc.nextInt();
}

System.out.println("최대값: " + Arrays.stream(arr).max().getAsInt());
System.out.println("최소값: " + Arrays.stream(arr).min().getAsInt());
```

---

### 📦 얕은 복사 vs 깊은 복사 (C02ArrayMain)

```java
// 얕은 복사 (같은 주소)
int[] arr1 = {1, 2, 3};
int[] arr2 = arr1;

// 깊은 복사 (새로운 배열 생성)
int[] arr3 = Arrays.copyOf(arr1, arr1.length);
```

---

### 📦 2차원 가변 배열 사용 (C03ArrayMain)

```java
int arr[][] = {
    {10, 20, 30},
    {40, 50},
    {60, 70, 80, 90}
};

System.out.println(arr[1][1]); // 50
```
- 🔥 배열마다 열(column) 수가 다를 수 있다!

---

### 📦 클래스 배열 사용법 (C04ClassArrayMain)

```java
C04Person[] people = new C04Person[3];
people[0] = new C04Person("홍길동", 55);
people[1] = new C04Person("김영희", 35);
people[2] = new C04Person("김범수", 40);

for (C04Person p : people) {
    System.out.println(p);
}
```

---

## ✅ 한 줄 요약 (1-Line Summary)

> **객체를 만들고, 숨기고, 연결하고, 관리하는 모든 기술 = 자바 OOP의 기본!** 🛡️🚗📚

