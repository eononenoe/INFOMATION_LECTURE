# 📚 JAVA while문과 반복 패턴 연습 정리

---

## 📌 개요 (Overview)

이번 파트에서는 **while문**을 활용해 반복문을 작성하고,  
구구단 출력, 별 찍기(피라미드/역피라미드) 등의 다양한 패턴을 만들어봅니다! 🚀

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🔄 while문 기본 구조
```java
while (조건식) {
    // 조건이 참일 동안 반복할 코드
}
```

- while문은 **조건이 true일 때**만 반복합니다.
- 내부에 **반복 변수의 변화 코드**를 꼭 넣어야 합니다. (무한루프 방지)

---

### 🌟 패턴별 핵심 흐름

| 패턴 설명 | 바깥 반복 (i) | 안쪽 반복 (j, k) |
|:---------|:------------|:----------------|
| 구구단 출력 | 단(dan) 반복 | 곱(i) 반복 |
| 별 찍기 (직사각형) | 행 반복 (i) | 별 반복 (j) |
| 별 찍기 (삼각형) | 행 반복 (i) | 별 개수 `i+1` |
| 별 찍기 (역삼각형) | 행 반복 (i) | 별 개수 `h-i` |
| 별 찍기 (피라미드) | 행 반복 (i) | 공백(j) + 별(k) |
| 별 찍기 (역피라미드) | 행 반복 (i) | 공백(j) + 별(k) |
| 다이아몬드 만들기 | 위쪽은 피라미드, 아래쪽은 역피라미드 |

---

## ⚠ 주의사항 (Cautions)

- **중첩 while문**에서는 안쪽 루프가 끝나야 바깥 루프가 한번 돈다!
- **별 찍기 패턴**은 공백과 별을 구분해서 정확히 관리해야 한다.
- **입력값(h)** 은 별 찍기의 높이나 크기를 결정한다.

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 📦 구구단 출력 예시

#### 2단 ~ 9단 출력

```java
int dan = 2;
while (dan < 10) {
    int i = 1;
    while (i < 10) {
        System.out.printf("%d x %d = %d\n", dan, i, dan * i);
        i++;
    }
    System.out.println();
    dan++;
}
```

---

#### 9단 ~ 2단 거꾸로 출력

```java
int dan = 9;
while (dan > 1) {
    int i = 9;
    while (i > 0) {
        System.out.printf("%d x %d = %d\n", dan, i, dan * i);
        i--;
    }
    System.out.println();
    dan--;
}
```

---

### 📦 별 찍기 기본 예제

#### 직사각형 별 찍기 (4행 5열)

```java
int i = 0;
while (i < 4) {
    int j = 0;
    while (j < 5) {
        System.out.print("*");
        j++;
    }
    System.out.println();
    i++;
}
```

---

#### 삼각형 별 찍기 (높이 h)

```java
Scanner sc = new Scanner(System.in);
int h = sc.nextInt();

int i = 0;
while (i < h) {
    int j = 0;
    while (j <= i) {
        System.out.print("*");
        j++;
    }
    System.out.println();
    i++;
}
```

---

#### 역삼각형 별 찍기 (높이 h)

```java
Scanner sc = new Scanner(System.in);
int h = sc.nextInt();

int i = 0;
while (i < h) {
    int j = 0;
    while (j < h - i) {
        System.out.print("*");
        j++;
    }
    System.out.println();
    i++;
}
```

---

### 📦 피라미드 별 찍기

```java
Scanner sc = new Scanner(System.in);
int h = sc.nextInt();

int i = 0;
while (i < h) {
    int j = 0;
    while (j < (h - 1) - i) {
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

### 📦 역피라미드 별 찍기

```java
Scanner sc = new Scanner(System.in);
int h = sc.nextInt();

int i = 0;
while (i < h) {
    int j = 0;
    while (j < i) {
        System.out.print(" ");
        j++;
    }
    int k = 0;
    while (k <= ((h - 1) * 2) - 2 * i) {
        System.out.print("*");
        k++;
    }
    System.out.println();
    i++;
}
```

---

### 📦 다이아몬드 별 찍기

```java
Scanner sc = new Scanner(System.in);
int h = sc.nextInt();
int i = 0;
while (i < h) {
    if (i <= h / 2) {
        int j = 0;
        while (j < (h / 2) - i) {
            System.out.print(" ");
            j++;
        }
        int k = 0;
        while (k <= 2 * i) {
            System.out.print("*");
            k++;
        }
    } else {
        int j = 0;
        while (j <= i - (h / 2 + 1)) {
            System.out.print(" ");
            j++;
        }
        int k = 0;
        while (k <= ((h - 1) * 2) - 2 * i) {
            System.out.print("*");
            k++;
        }
    }
    System.out.println();
    i++;
}
```

---

## ✅ 한 줄 요약 (1-Line Summary)

> **while문은 조건이 true일 동안 계속 반복! 반복 변수 관리를 정확히 하고 다양한 별 패턴도 자유자재로 만들어보자!** 🌟
