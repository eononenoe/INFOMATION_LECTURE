~~~markdown
# 📚 Java Coding Test 문제 모음

---

# 📌 개요 (Overview)

이번 문서는 다양한 **Java 코딩테스트 문제**를 간단하고 깔끔한 풀이와 함께 정리했습니다.

---

# 💡 문제 목록 (Key Problems)

## 01. 짝수는 싫어요
```java
class Solution {
    public int[] solution(int n) {
        int[] array = new int[(n + 1) / 2];
        int index = 0;
        for (int i = 1; i <= n; i++) {
            if (i % 2 != 0) {
                array[index++] = i;
            }
        }
        return array;
    }
}
```

---

## 02. 피자 나눠 먹기 (3)
```java
class Solution {
    public int solution(int slice, int n) {
        return (n % slice == 0) ? n / slice : n / slice + 1;
    }
}
```

---

## 03. 대소문자 바꿔서 출력하기
```java
import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String input = sc.next();
        String result = "";

        for (int i = 0; i < input.length(); i++) {
            char c = input.charAt(i);
            if (Character.isUpperCase(c)) {
                result += Character.toLowerCase(c);
            } else {
                result += Character.toUpperCase(c);
            }
        }
        System.out.println(result);
    }
}
```

---

## 04. 문자열 반복해서 출력하기
```java
import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String str = sc.next();
        int n = sc.nextInt();

        for (int i = 0; i < n; i++) {
            System.out.print(str);
        }
    }
}
```

---

## 05. a와 b 출력하기
```java
import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int a = sc.nextInt();
        int b = sc.nextInt();

        System.out.println("a = " + a);
        System.out.println("b = " + b);
    }
}
```

---

## 06. 문자열 출력하기
```java
import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String a = sc.next();
        System.out.println(a);
    }
}
```

---

## 07. 특수문자 출력하기
```java
public class Solution {
    public static void main(String[] args) {
        System.out.println("!@#$%^&*(\\'\"<>?:;");
    }
}
```

---

## 08. 덧셈식 출력하기
```java
import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int a = sc.nextInt();
        int b = sc.nextInt();

        System.out.printf("%d + %d = %d", a, b, a + b);
    }
}
```

---

## 09. 문자열 붙여서 출력하기
```java
import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String a = sc.next();
        String b = sc.next();

        System.out.println(a.trim() + b);
    }
}
```
## 01. 문자열 돌리기
```java
import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String a = sc.next();
        for(int b = 0; b < a.length(); b++) {
            char c = a.charAt(b);
            System.out.println(c);
        }
    }
}
```

---

## 02. 홀짝 구분하기
```java
import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        if(n % 2 == 0) {
            System.out.printf("%d is even", n);
        } else {
            System.out.printf("%d is odd", n);
        }
    }
}
```
---

# ⚠ 주의사항 (Cautions)

- Java Scanner 사용 시 `next()`는 공백을 기준으로 끊어 읽습니다.
- 특수문자를 출력할 때는 `\\`(이스케이프 문자)를 주의해야 합니다.
- 문자열 결합은 `+` 또는 `StringBuilder`를 사용할 수도 있습니다.

---

# ✅ 한 줄 요약 (1-Line Summary)

> 간단한 Java 문제 풀이로 알고리즘 감각을 키우자! 💻🚀
~~~

