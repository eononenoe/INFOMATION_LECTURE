# 📚 JAVA 타입 변환(Type Change) 정리

---

## 📌 개요 (Overview)

프로그래밍을 할 때 서로 다른 자료형끼리 연산하거나 대입할 때 **타입 변환**이 발생합니다.  
타입 변환은 **자동 변환(암시적 변환)** 과 **강제 변환(명시적 변환)** 두 가지로 구분됩니다.  
또한 문자열과 숫자 간 변환도 많이 사용됩니다.

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🔄 타입 변환 (Type Change)

- **자동 형변환** (Implicit Conversion)
  - 작은 크기의 자료형 → 큰 크기의 자료형으로 자동 변환
  - 예: `byte → short → int → long → float → double`
  
- **강제 형변환** (Explicit Conversion)
  - 큰 크기의 자료형 → 작은 크기의 자료형으로 명시적 변환
  - `(자료형)`을 사용하여 직접 변환
  - 데이터 손실 가능성 있음

- **문자열 ↔ 숫자 변환**
  - `Integer.parseInt("문자열")` : 문자열 → 정수
  - `Double.parseDouble("문자열")` : 문자열 → 실수
  - `Short.parseShort("문자열")`, `Float.parseFloat("문자열")` 등

---

## ⚠ 주의사항 (Cautions)

- `char`와 `short`는 둘 다 2byte지만, **char는 음수 표현 불가**.
- `byte` 연산은 결과가 자동으로 `int`가 됨!
- 문자열 결합시 `+` 연산자는 양쪽을 모두 문자열로 처리함.
- 강제 변환시 데이터 손실 주의 (예: `double → int`는 소수점 손실).

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 📦 C06정리&문제 - 기본 타입 분류
- 정수 타입 : `byte`, `short`, `int`, `long`
- 문자 타입 : `char`
- 문자열 타입 : `String`
- 실수 타입 : `float`, `double`
- 논리 타입 : `boolean`

### 📦 자동 형변환 예제 (C01TypeChange.java)

```java
byte byteValue = 10;
int intValue = byteValue;
System.out.println(intValue);

char charValue = '가';
intValue = charValue;
System.out.println("가의 유니코드: " + intValue);

intValue = 50;
long longValue = intValue;
System.out.println(longValue);

longValue = 100L;
float floatValue = longValue;
System.out.println(floatValue);

floatValue = 100.5F;
double doubleValue = floatValue;
System.out.println(doubleValue);
```

### 📦 강제 형변환 예제 (C02TypeChange.java)

```java
int intValue = 44032;
char charValue = (char)intValue;
System.out.println(charValue);

long longValue = 500;
intValue = (int)longValue;
System.out.println(intValue);

double doubleValue = 3.14;
intValue = (int)doubleValue;
System.out.println(intValue);  // 소수점 이하 버림
```

### 📦 데이터 손실 예제 (C03TypeChange.java)

```java
int num1 = 129;
int num2 = 130;
byte ch1 = (byte)num1;
byte ch2 = (byte)num2;

System.out.printf("%d\n", ch1);  // -127
System.out.printf("%d\n", ch2);  // -126
```

### 📦 연산시 타입 변환 예제 (C04TypeChange.java)

```java
byte x = 10;
byte y = 20;
byte result1 = (byte)(x + y);  // int로 변환된 후 다시 byte로
System.out.println(result1);   // 30

long var1 = 1000L;
int var2 = 100;
byte var3 = 10;
long result2 = var1 + var2 + var3;
System.out.println(result2);   // long형 결과

int intvar = 10;
float flvar = 3.3F;
double dbvar = 5.5;
double result4 = intvar + flvar + dbvar;
System.out.println(result4);   // 18.8
```

### 📦 정수/실수 나누기 예제 (C05TypeChange.java)

```java
int num1 = 10, num2 = 4;
double dnum1 = (double) num1 / num2;
double dnum2 = (num1 * 1.0) / num2;
double dnum3 = num1 / num2;
System.out.println(dnum1);  // 2.5
System.out.println(dnum2);  // 2.5
System.out.println(dnum3);  // 2 (정수끼리 나누어서)
```

### 📦 char vs short 차이 예제 (C06TypeChange.java)

```java
char n1 = 60000;
short n2 = (short)n1;
System.out.println(n2);  // -5536 (overflow 발생)

int n3 = (char)n2;
System.out.println(n3);  // 60000
```

### 📦 문자열 ↔ 숫자 변환 예제 (C07StringTypeChange.java)

```java
System.out.println("10" + "20");  // 문자열 연결

int n1 = Integer.parseInt("10");
int n2 = Integer.parseInt("20");
System.out.println(n1 + n2);  // 30

double n3 = Double.parseDouble("10.5");
double n4 = Double.parseDouble("20.4");
System.out.println(n3 + n4);  // 30.9

short n5 = Short.parseShort("5");
short n6 = Short.parseShort("6");
System.out.println(n5 + n6);  // 11
```

---

### 🎯 C08정리_문제 - 확인 퀴즈

#### ✅ 자동 타입 변환
1. **컴파일 에러가 발생하는 것** : `3) short shortValue = charValue;`

#### ✅ 강제 타입 변환
2. **컴파일 에러가 발생하는 것** : `4) char var = (Char)strValue;` (문자열은 char로 변환 불가)

#### ✅ 연산식 타입 변환
3. **컴파일 에러가 발생하는 것** : `1) byte result = byteValue + byteValue;` (결과가 int)

#### ✅ 기타 문제 요약
- **4번** : `short result = s1 + s2;` 에러 (결과가 int)
- **5번** : `char c2 = (char)(c1 + 1);`로 수정
- **6번** : `int result = x / y;` 결과 2
- **7번** : `double result = (double)x / y;`
- **8번** : `int result = (int)(var1 + var2);`
- **9번** : 다양한 방법으로 캐스팅 (예시 제공)
- **10번 실행결과** :
  ```
  5
  23
  23
  ```
- **11번 문자열 변환 코드** :
  ```java
  Byte.parseByte("10");
  Integer.parseInt("100");
  Float.parseFloat("20.5");
  Double.parseDouble("3.14159");
  ```

---

## ✅ 한 줄 요약 (1-Line Summary)

> **JAVA 타입 변환은 프로그램의 흐름을 자연스럽게 만들지만, 자동 변환과 강제 변환의 차이와 주의사항을 이해하는 것이 중요하다!** 🚀
