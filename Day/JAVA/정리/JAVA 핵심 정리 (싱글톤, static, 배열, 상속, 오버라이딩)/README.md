# 📚 JAVA 핵심 정리 : 싱글톤, static, 배열, 상속, 오버라이딩

---

## 📌 개요 (Overview)

이번 파트에서는

- 싱글톤 패턴 (Singleton Pattern)
- static 키워드 (공유 변수/메서드)
- 배열과 2차원 배열
- 상속(Inheritance)과 메서드 오버라이딩(Method Overriding)

를 학습합니다! ✨

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🏢 싱글톤 (Singleton)
- **클래스 인스턴스를 하나만 생성해서 공유**하는 디자인 패턴
- 주로 설정, 로그 관리 등에 사용
- private 생성자 + static instance + static getter

### 🔒 private
- 클래스 외부에서 직접 접근할 수 없게 막는 접근제어자

### 🧱 static
- **클래스 수준**에서 공유하는 멤버 (변수/메서드)
- 객체를 생성하지 않고 `클래스명.변수` 형태로 바로 접근 가능

### ⭕ void
- 메서드가 반환(return)값이 없음을 의미

### 📦 ArrayList와 for-each문
- `for(Object : ArrayList)` = 하나하나 꺼내서 사용
- `ArrayList.get(인덱스)`로 값에 직접 접근 가능

### 🏡 상속 (Inheritance)
- 부모 클래스의 속성과 기능을 자식 클래스가 물려받음
- `extends` 키워드 사용
- 오버라이딩(재정의) 가능

---

## ⚠ 주의사항 (Cautions)

- 싱글톤은 **private 생성자**로 외부 생성을 막는다.
- static 메서드는 **static 변수나 지역 변수**만 사용 가능.
- `String` 비교는 항상 `.equals()`
- 배열의 **인덱스 초과** 주의
- 상속받은 메서드 오버라이딩 시 **메서드 시그니처(이름/매개변수)**는 같아야 한다.

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 📦 싱글톤 패턴 구조

```java
class Company {
    private static Company instance;
    private Company() {}  // 외부에서 객체 생성 막기
    public static Company getInstance() {
        if (instance == null) instance = new Company();
        return instance;
    }
}
```
> **Company.getInstance()**를 통해서만 객체를 생성하고 공유

---

### 📦 static 사용 예시

```java
class C01Simple {
    static int num1;
    int num2;
    
    public C01Simple() {
        num1 = 0;
        num2 = 0;
    }
}
```
> `static`은 모든 객체가 **공유**합니다. 객체 생성 없이 `클래스명.변수`로 접근 가능!

---

### 📦 메인 메서드 매개변수 받기 (C05MainParam)

```java
public static void main(String[] args) {
    for(String param : args) {
        System.out.println(param);
    }
}
```
- 실행 시 입력한 인자값들이 `args` 배열로 들어온다.

---

### 📦 배열 다루기 (C06Ex)

```java
int[] arr = new int[5];
for(int i=0; i<arr.length; i++) {
    arr[i] = sc.nextInt();
}
```
- 입력받은 값으로 배열 채우기
- 최대값, 최소값, 합계 구하기도 가능

---

### 📦 2차원 배열 + 과목별 총점 평균 (C06Ex)

```java
int[][] scores = new int[5][3]; // 5명, 3과목
for(int i=0; i<5; i++) {
    for(int j=0; j<3; j++) {
        scores[i][j] = sc.nextInt();
    }
}
```
- 각 학생 합/평균
- 과목별 합/평균도 구하기 가능

---

### 📦 배열 합치기 (C04Ex)

```java
public static int[] concat(int[] a, int[] b) {
    int[] result = new int[a.length + b.length];
    // a, b 복사
}
```
> **두 배열을 하나로 합치기!**

---

### 📦 상속 기본 예제 (C01InheritanceMain)

```java
class Point2D {
    int x, y;
}

class Point3D extends Point2D {
    int z;
}
```
> 3D포인트는 2D포인트에 z축만 추가한 것!

---

### 📦 생성자 오버로딩 + super() 호출 (C02InheritanceMain)

```java
Point3D(int x, int y, int z) {
    super(x,y);  // 상위(Point2D) 생성자 호출
    this.z = z;
}
```
> 부모 생성자 호출은 `super()`

---

### 📦 메서드 오버라이딩 (C03MethodOverriding)

```java
class Dog extends Animal {
    void sound() {
        System.out.println("멍멍");
    }
}
```
> 부모 메서드를 **자식이 재정의(override)** 해서 다른 동작 가능!

---

### 📦 ColorTV 상속 문제 (C04Ex)

```java
class ColorTV extends TV {
    int color;
    void printProperty() {
        System.out.printf("%d인치 %d컬러\n", size, color);
    }
}
```
> 출력 결과: `32인치 1024컬러`

---

### 📦 Parttimer vs Regular 직원 클래스 (C05Ex)

```java
class Parttimer extends Employee {
    int hourPay;
}

class Regular extends Employee {
    int salary;
}
```
> 직원(Employee)을 상속받아 알바생, 정규직 각각 구현

---

## ✅ 한 줄 요약 (1-Line Summary)

> **싱글톤은 객체를 하나만! static은 모두 공유! 상속은 확장하고, 오버라이딩은 다르게!** 🚀

