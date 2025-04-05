# 📚 JAVA 핵심 정리 : 업캐스팅, 다운캐스팅, 추상클래스, 인터페이스

---

## 📌 개요 (Overview)

이번 파트에서는

- 업캐스팅(Upcasting) / 다운캐스팅(Downcasting)
- 추상 클래스(Abstract Class)
- 인터페이스(Interface)
- 변환 클래스(Converter)

를 학습합니다! 🚀

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🐾 업캐스팅 (Upcasting)
- 자식 클래스 ➡ 부모 클래스 타입으로 변환
- **자동 변환** (Casting 생략 가능)
- ✅ 부모 타입으로 메서드 사용 가능 (재정의된 메서드도 호출됨)

### 🐾 다운캐스팅 (Downcasting)
- 부모 클래스 ➡ 자식 클래스 타입으로 변환
- **강제 변환** 필요: `(자식클래스) 부모객체`
- ✅ 자식 고유 기능(확장된 기능)에 접근 가능

### 🧩 abstract
- **추상 클래스**: 미완성 클래스
- **추상 메서드**: 미완성 메서드 (구현 강제)

### 🧱 interface
- 메서드는 모두 **추상 메서드**
- 변수를 만들면 무조건 **`public static final` 상수**가 된다
- 다중 상속 가능 (클래스는 다중 상속 불가)

### ✍ String.format()
- 숫자를 문자열로 변환할 때 포맷을 지정할 수 있다
- 예) `String result = String.format("%.3f", 3.14159); // "3.142"`

---

## ⚠ 주의사항 (Cautions)

- 다운캐스팅은 항상 **instanceof** 체크를 해주는 게 안전
- 추상 클래스는 **객체 생성 불가** (new 불가)
- 인터페이스는 구현(implements)해야 사용 가능
- 인터페이스 변수 = 항상 `public static final`
- 오버라이딩 시 @Override 꼭 붙이자! (가독성↑, 실수↓)

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 🐾 업캐스팅 기본

```java
Dog dog = new Dog();
Animal animal = dog;  // 업캐스팅
animal.makeSound();   // "멍멍!" 출력
```
> 자식 객체를 부모 타입으로 변환!

---

### 🐾 다운캐스팅 기본

```java
Animal animal = new Dog(); // 업캐스팅
Dog dog = (Dog) animal;     // 다운캐스팅
dog.fetch();               // 자식 기능 사용 가능
```
> 부모 타입을 다시 자식 타입으로 변환해 확장 기능 사용!

---

### 🧩 추상 클래스 사용

```java
abstract class Animal {
    abstract void sound();
}

class Dog extends Animal {
    void sound() { System.out.println("멍멍"); }
}
```
> 추상 메서드는 반드시 구현(오버라이딩)해야 한다.

---

### 🧱 인터페이스 사용

```java
interface Remocon {
    int MAX_VOL = 100;
    void powerOn();
    void setVolumn(int vol);
}

class Tv implements Remocon {
    private int vol;
    public void powerOn() { System.out.println("TV 켬"); }
    public void setVolumn(int vol) { this.vol = vol; }
}
```
> 인터페이스를 구현(implements)해서 필요한 기능을 작성한다.

---

### 🧪 다중 상속 (인터페이스)

```java
interface A { void methodA(); }
interface B { void methodB(); }

class C implements A, B {
    public void methodA() { System.out.println("methodA"); }
    public void methodB() { System.out.println("methodB"); }
}
```
> 인터페이스는 **다중 상속** 가능! (클래스는 불가능)

---

### 🌐 String.format() 사용 예

```java
double result = 10.0 / 3.0;
String formatted = String.format("%.2f", result);
System.out.println(formatted);  // "3.33"
```
> 소수점 2자리까지 깔끔하게 출력!

---

### 🧩 원화 -> 달러 변환기 (추상 클래스 상속)

```java
class Won2Dollar extends Converter {
    protected double convert(double src) { return src / 1446; }
    protected String getSrcString() { return "원화"; }
    protected String getDestString() { return "달러"; }
}
```
> 환율 변환기를 추상 클래스 상속으로 만든 예시!

---

### 📺 TV/Radio 리모컨 인터페이스

```java
interface Remocon {
    void setVolumn(int vol);
    void powerOn();
    void powerOff();
}
class Tv implements Remocon { /* 구현 내용 */ }
class Radio implements Remocon { /* 구현 내용 */ }
```
> 인터페이스를 통해 **표준화된 리모컨 제어** 제공

---

## ✅ 한 줄 요약 (1-Line Summary)

> **업캐스팅은 확장 막고, 다운캐스팅은 확장 열고, 추상은 미완성, 인터페이스는 약속이다!** 🎯

