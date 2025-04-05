# 📚 JAVA 자료형과 상수 정리

---

## 📌 개요 (Overview)

이 문서에서는 JAVA에서 사용하는 **자료형**과 **상수(Constant)** 에 대해 학습합니다.  
자료형은 데이터를 저장할 때 크기와 타입을 결정하는 요소이고, 상수는 변하지 않는 고정된 값을 의미합니다.

---

## 💡 핵심 개념 요약 (Key Concepts)

### 자료형(Data Types)

#### 🔢 정수형 (Integer Types)
- `byte` : 1byte, 음수/양수
- `short` : 2byte, 음수/양수
- `char` : 2byte, **양수만** 저장 (0~65535)
- `int` : 4byte, **기본 정수형**
- `long` : 8byte, 큰 정수 표현

#### 🔢 실수형 (Floating Point Types)
- `float` : 4byte, 소수점 아래 6~9자리
- `double` : 8byte, 소수점 아래 15~18자리 (**기본 실수형**)

#### 🔠 문자형 (Character Type)
- `char` : 2byte, 유니코드 문자 저장

#### 📜 문자열형 (String Type)
- `String` : 클래스 타입, **동적 공간 할당**  
  (참조형 변수: 실제 데이터는 메모리에 따로 저장)

#### 🔘 논리형 (Boolean Type)
- `boolean` : `true` 또는 `false` 저장

---

### 상수(Constant)

- **리터럴 상수** : 이름 없는 값. 예) `100`, `"Hello"`
- **심볼릭 상수** : `final` 키워드로 선언된 이름 있는 상수
- **리터럴 접미사** :
  - `L, l` : long형 지정
  - `F, f` : float형 지정
  - 예) `10L`, `3.14F`

---

## ⚠ 주의사항 (Cautions)

- `byte` 자료형 범위는 -128 ~ 127! 범위를 넘으면 에러나거나 값이 바뀔 수 있어요.
- `char`는 부호가 없는 2byte 정수이기 때문에 음수를 표현할 수 없습니다.
- `long` 리터럴은 꼭 `L`을 붙여야 합니다. (`10000000000L`)
- `float`는 `F`를 붙이지 않으면 기본적으로 `double`로 인식합니다.
- 부동소수점(floating point)은 오차가 발생할 수 있습니다. (0.1을 여러 번 더하면 1이 안 될 수 있음!)

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 📦 C04자료형 예시

```java
package Ch02;

public class C04자료형 {
    public static void main(String[] args) {
        
        // 정수형 int 예시
        int n1 = 0b10101101; // 2진수
        int n2 = 173;        // 10진수
        int n3 = 0255;       // 8진수
        int n4 = 0xad;       // 16진수
        System.out.printf("%d %d %d %d\n", n1, n2, n3, n4);

        // byte 범위 초과
        byte n5 = (byte) 129;
        System.out.println(n5);  // 오버플로우 발생

        // short와 char 차이
        char ch1 = 60000;
        short sh1 = (short) ch1;
        System.out.printf("%d\n", sh1); // 음수 출력 (overflow)

        // long 자료형 사용
        long l1 = 10000000000L;
        long l2 = 20L;
        
        // 실수형 정밀도 비교
        float f1 = 0.123456789123456789F;
        double d1 = 0.123456789123456789;
        System.out.println(f1); // float
        System.out.println(d1); // double

        // 문자형 char 다루기
        char c1 = 'a';
        System.out.println(c1);          // 'a'
        System.out.println((int)c1);     // 97

        char c2 = 98;
        System.out.println(c2);           // 'b'

        char c3 = (char) ('b' + 1);
        System.out.println(c3);           // 'c'

        // 문자열 String
        String name = "홍길동";
        String job = "프로그래머";
        System.out.println(name);
        System.out.println(job);

        // boolean 사용 예시
        boolean flag = (10 > 11);
        if (flag) {
            System.out.println("참인 경우 실행");
        } else {
            System.out.println("거짓인 경우 실행");
        }
    }
}
```

---

### 🔒 C05상수 예시

```java
package Ch02;

public class C05상수 {
    public static void main(String[] args) {
        
        // 리터럴 상수
        int a = 100; 

        // 심볼릭 상수
        final int b = 200;

        final double PI = 3.14;
        double result = PI * 4 * 4;
        System.out.println("원의 넓이 : " + result);

        // 리터럴 접미사
        long l = 10000000000L; // L 붙여야 에러 안남
        float f = 3.14F;       // F 붙여야 float으로 인식

        // 지수표현
        double exp = 1e-3; // 0.001
        System.out.println(exp);
    }
}
```

---

### 🎯 비유

- **자료형**은 다양한 크기의 컵이에요. 물(데이터)을 담기 위해 크기에 맞는 컵을 골라야 해요.
- **상수**는 절대 바뀌지 않는 약속입니다. (예: 원주율 3.14처럼!)

---

## ✅ 한 줄 요약 (1-Line Summary)

> **JAVA에서는 다양한 자료형을 통해 데이터를 정확히 저장하고, `final`을 이용해 변하지 않는 상수값을 선언하여 코드의 안정성과 가독성을 높입니다!** 🚀
