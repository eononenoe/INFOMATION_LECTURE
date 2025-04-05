# 📚 JAVA 기초 정리

---

## 📌 개요 (Overview)

JAVA는 **절차지향**(C)과 **객체지향**(C++) 개념을 모두 가지고 있는 프로그래밍 언어입니다.  
컴퓨터는 **계산(COMPUTE)** 을 수행하는 기계이며,  
**Programming**은 프로그램(미리, 쓰다)을 작성하는 것을 의미합니다.

---

## 💡 핵심 개념 요약 (Key Concepts)

### JAVA 언어 특징
- **절차지향** : 순서대로 명령을 수행, 함수 중심
- **객체지향** : 데이터와 동작을 하나로 묶어 객체 중심으로 처리

### 기본 프로그램 구조
- `package` : 패키지 구분
- `class` : 클래스 영역 (객체지향 문법 적용)
- `main` 메서드 : 프로그램 최초 실행 영역 (절차지향 문법 적용)

### 출력문
- `System.out.print()` : 출력
- `System.out.println()` : 출력 후 줄바꿈
- `System.out.printf()` : 서식을 이용한 출력
  - `%d` : 정수
  - `%f` : 실수
  - `%c` : 문자
  - `%s` : 문자열

### 진수 체계
- **2진수** : 0과 1로 표현
- **8진수** : 0으로 시작 (ex: `0255`)
- **16진수** : 0x로 시작 (ex: `0xAD`)
- 변환 서식:
  - `%d` : 10진수
  - `%o` : 8진수
  - `%x`, `%X` : 16진수

### 음수 표현 (2의 보수법)
- CPU는 뺄셈 대신 **2의 보수**를 이용해 덧셈으로 처리
- 1의 보수 : 비트 반전
- 2의 보수 : 1의 보수 + 1

### 변수와 자료형
- **변수** : 값을 저장하는 공간
- **자료형** : 데이터 타입을 지정
  - 정수 : `byte`, `short`, `int`, `long`
  - 실수 : `float`, `double`
  - 문자 : `char`
  - 문자열 : `String`

---

## ⚠ 주의사항 (Cautions)

- JAVA에서는 **문자(`char`)** 자료형도 2바이트를 사용합니다.
- 8진수는 0, 16진수는 0x를 붙여서 표현합니다.
- CPU는 직접 뺄셈을 하지 않고 **2의 보수** 덧셈으로 처리합니다.
- `System.out.printf`의 포맷문자를 잘못 사용하면 출력 결과가 이상해질 수 있습니다.

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 📦 JAVA 코드 예시

#### C00HelloWorld
```java
package Ch00;

public class C00HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello world");
    }
}
```

#### C01SystemOut
```java
package Ch01;

public class C01SystemOut {
    public static void main(String[] args) {
        System.out.print("HELLOWORLD\n");
        System.out.printf("%d %d %d\n", 10, 20, 30);
        System.out.printf("%f %f %f\n", 10.1, 20.1, 30.1);
        System.out.printf("%c %c %c\n", 'A', 'B', 'C');
        System.out.printf("%s %s %s\n", "This is", "String", "Test");
        System.out.println("HELLOWORLD");
    }
}
```

#### C01진수
```java
package Ch02;

public class C01진수 {
    public static void main(String[] args) {
        System.out.printf("10진수 : %d\n", 0b00001111);
        System.out.printf("10진수 : %d\n", 173);
        System.out.printf("10진수 : %d\n", 0255);
        System.out.printf("10진수 : %d\n", 0xAD);

        System.out.printf("8진수 : %o\n", 173);
        System.out.printf("8진수 : %o\n", 0255);
        System.out.printf("8진수 : %o\n", 0xAD);

        System.out.printf("16진수 : %X\n", 173);
        System.out.printf("16진수 : %x\n", 173);
        System.out.printf("16진수 : %X\n", 0255);
        System.out.printf("16진수 : %x\n", 0255);
        System.out.printf("16진수 : %X\n", 0xAD);
        System.out.printf("16진수 : %x\n", 0xAD);
    }
}
```

#### C02음수
```java
package Ch02;

public class C02음수 {
    public static void main(String[] args) {
        // 컴퓨터는 2의 보수를 사용하여 음수를 표현합니다.
    }
}
```

#### C03변수_자료형
```java
package Ch02;

public class C03변수_자료형 {
    public static void main(String[] args) {
        int num1;
        num1 = 10;
        int num2 = 4;
        int num3 = num1 + num2;
        System.out.println(num3);
    }
}
```

#### C04자료형
```java
package Ch02;

public class C04자료형 {
    public static void main(String[] args) {
        // 정수형: byte, short, int, long
        // 실수형: float, double
        // 문자형: char
        // 문자열형: String
    }
}
```

### 🎯 비유

- **변수**는 "물건을 넣는 상자" 같아요. 상자에 무엇이 들어있는지 이름(변수명)을 붙여 기억해요.
- **2진수**는 "전구의 켜짐(1)/꺼짐(0)"으로 생각할 수 있어요.
- **2의 보수**는 "빌린 돈을 갚기 위해 계산하는 방법"과 비슷해요!

---

## ✅ 한 줄 요약 (1-Line Summary)

> **JAVA는 절차지향과 객체지향을 결합한 언어로, 다양한 데이터 표현과 관리를 위해 변수, 자료형, 진수, 보수 개념을 이해하는 것이 중요하다!** 🚀
