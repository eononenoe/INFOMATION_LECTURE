# 📚 JAVA Scanner 사용과 기본 연산자 정리

---

## 📌 개요 (Overview)

이번 파트에서는  
- 사용자 입력을 받을 수 있는 **Scanner** 사용법  
- 기본 **산술/비교/논리/비트/시프트 연산자**  
를 정리합니다.

입력을 받아 계산하거나 조건문을 만들기 위해 꼭 필요한 내용입니다! 🚀

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🖊 Scanner 사용법
- `Scanner sc = new Scanner(System.in);` : 키보드 입력을 받을 준비
- 입력 받기
  - `nextInt()` : 정수 입력
  - `nextDouble()` : 실수 입력
  - `next()` : 문자열(띄어쓰기 전까지)
  - `nextLine()` : 문자열(띄어쓰기 포함)

- **주의** : `nextInt()` 다음에 `nextLine()`을 사용하면 `\n`(엔터)이 남아서 버퍼를 비워야 함 → `sc.nextLine();` 한 번 호출

---

### ➕ 기본 산술 연산자
- `+`, `-`, `*`, `/`, `%`
- `%` 나머지 연산은 **짝홀수 구분**, **배수 판별**, **자리수 제한** 등에 활용됨

---

### 📝 대입 연산자
- `=`, `+=`, `-=`, `*=`, `/=`, `%=` 등

---

### 🔍 비교 연산자
- `==`, `!=`, `>`, `<`, `>=`, `<=`

---

### 🔗 논리 연산자
- `&&` : AND (양쪽 모두 참이어야 참)
- `||` : OR (한쪽만 참이면 참)
- `!` : NOT (참이면 거짓, 거짓이면 참)

---

### 🔥 증감 연산자
- `++a` : 전위 증가
- `a++` : 후위 증가
- `--a` : 전위 감소
- `a--` : 후위 감소

---

### 🎯 삼항 연산자
- `(조건식) ? 참결과 : 거짓결과;`
- 예: `int result = (score > 90) ? 1 : 0;`

---

### ⚡ 비트 연산자
- `&` : AND
- `|` : OR
- `^` : XOR
- `~` : NOT

---

### ➡️ 시프트 연산자
- `<<` : 왼쪽 쉬프트 (곱하기 효과)
- `>>` : 오른쪽 쉬프트 (나누기 효과)

---

## ⚠ 주의사항 (Cautions)

- `Scanner` 사용 시 타입별로 정확히 구분해야 한다.
- `nextInt()` 다음에 `nextLine()` 쓰려면 버퍼 비워야 함.
- `%` 연산 결과로 끝자리, 배수 등을 쉽게 구할 수 있음.
- 비트 연산, 쉬프트 연산은 **이진수**를 기반으로 한다.

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 📦 Scanner 기본 사용 (C01Scanner)

```java
Scanner sc = new Scanner(System.in);

System.out.printf("num1 입력 : ");
int num1 = sc.nextInt();
System.out.printf("num2 입력 : ");
int num2 = sc.nextInt();

int sum = num1 + num2;
System.out.printf("%d + %d = %d\n", num1, num2, sum);

sc.close();
```

---

### 📦 띄어쓰기 포함 문자열 입력 (C02Scanner, C03Scanner)

```java
Scanner sc = new Scanner(System.in);

System.out.print("정수 입력 : ");
int num = sc.nextInt();
sc.nextLine(); // 버퍼 비우기

System.out.print("문자열 입력(띄어쓰기 포함) : ");
String text = sc.nextLine();
System.out.println("입력한 문자열 : " + text);

sc.close();
```

---

### 📦 이름, 나이, 주소 입력받기 (C04Scanner)

```java
Scanner sc = new Scanner(System.in);

System.out.print("이름을 입력하세요 : ");
String name = sc.next();

System.out.printf("%s 님의 나이를 입력하세요 : ", name);
int age = sc.nextInt();
sc.nextLine();

System.out.printf("%s 님의 주소를 입력하세요 : ", name);
String addr = sc.nextLine();

System.out.printf("%s님의 나이는 %d세 주소는 %s 입니다.\n", name, age, addr);

sc.close();
```

---

### ➕ 산술 연산자 사용 예시 (C01BASIC)

```java
int a = 10, b = 20;
System.out.println("a+b=" + (a + b));
System.out.println("a-b=" + (a - b));
System.out.println("a*b=" + (a * b));
System.out.println("b/a=" + (b / a)); // 몫
System.out.println("a%b=" + (a % b)); // 나머지
```

---

### 🎯 삼항 연산자 문제 예시 (C02Ex)

```java
Scanner sc = new Scanner(System.in);

System.out.print("국어/영어/수학 점수를 입력 : ");
int kor = sc.nextInt();
int eng = sc.nextInt();
int math = sc.nextInt();

double avg = (double)(kor + eng + math)/3;
String result = (kor>=40 && eng>=40 && math>=40 && avg>=70) ? "합격" : "불합격";

System.out.println("시험결과 : " + result);

sc.close();
```

---

### 🎲 난수 생성과 % 연산 (C03Percent)

```java
Random rnd = new Random();
while (true) {
    System.out.println(rnd.nextInt(45) + 1);  // 1~45 난수
    Thread.sleep(500);
}
```

---

### ⚡ 비트 연산자 사용 (C04BitArith)

```java
int num1 = 15;
int num2 = 20;

System.out.println("AND : " + (num1 & num2));
System.out.println("OR  : " + (num1 | num2));
System.out.println("XOR : " + (num1 ^ num2));
System.out.println("NOT : " + (~num1));
```

---

### ➡️ 시프트 연산자 사용 (C05ShiftArch)

```java
int num1 = 15;
System.out.println("왼쪽 쉬프트 3칸 : " + (num1 << 3));  // 15 * 2^3 = 120
System.out.println("오른쪽 쉬프트 3칸 : " + (num1 >> 3)); // 15 / 2^3 = 1
```

---

### 🎯 비유로 쉽게 이해하기

- **Scanner** : 전화기! 입력을 읽어오는 통로 📞
- **산술 연산자** : 숫자 계산하는 계산기! ➕➖✖️➗
- **논리 연산자** : OX 퀴즈를 풀 때 필수! ✅❌
- **비트 연산자** : 컴퓨터는 모든 것을 0과 1로 이해한다! ⚡
- **시프트 연산자** : 숫자를 빠르게 곱하거나 나누는 터보 기어! 🚀

---

## ✅ 한 줄 요약 (1-Line Summary)

> **JAVA 입력은 Scanner로, 계산은 산술/논리/비트 연산으로! 각각의 연산자 의미와 사용법을 정확히 이해하자!** 🚀
