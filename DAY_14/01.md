# 01

> **PPT 제작**
> 

![스크린샷_16-1-2025_121946_.png](3team.png)

---

> **Codding Test 01**
> 

```java
// 짝수는 싫어요

class Solution {
    public int[] solution(int n) {
        
        int array[] = new int[(n+1)/2];
        int index=0;
        for(int i=1;i<=n;i++){
            if (i%2!=0){
                array[index] = i;
                index++;
            }
        }
        return array;
     }
}
```

---

> **Codding Test 02**
> 

```jsx
//  피자 나눠 먹기(3)

class Solution {
    public int solution(int slice, int n) {
    int answer = 0;
    if (n%slice==0) {
        answer = n/slice;
    } else {
        answer = n/slice+1;
    }
        return answer;
    }
}
```

---

> **Codding Test 03**
> 

```jsx
// 대소문자 바꿔서 출력하기

import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String input = sc.next();
        String result = "";
        
        for(int i=0; i<input.length(); i++){
            char c = input.charAt(i);
            
            if(c > 96 && c < 123) {
                result += (char)(c-32);
            } else if(c > 64 && c <= 91) {
                result += (char)(c+32);
            }
        }
        System.out.println(result);
    }
}
```

---

> **Codding Test 04**
> 

```jsx
// 문자열 반복해서 출력하기

import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String str = sc.next();
        int n = sc.nextInt();
        
        for (int i=0;i<n;i++){
            System.out.printf("%s",str);
        }
    }
}
```

---

> **Codding Test 05**
> 

```jsx
// a와 b 출력하기

import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int a = sc.nextInt();
        int b = sc.nextInt();

        System.out.println("a = "+a);
        System.out.println("b = "+b);
    }
}
```

---

> **Codding Test 06**
> 

```jsx
//문자열 출력하기

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

> **Codding Test 07**
> 

```jsx
// 특수문자 출력하기

import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        System.out.println("!@#$%^&*(\\'\"<>?:;");
    }
}
```

---

> **Codding Test 08**
> 

```jsx
// 덧셈식 출력하기

import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int a = sc.nextInt();
        int b = sc.nextInt();

        System.out.printf("%d + %d = %d",a,b,a+b);
    }
}
```

---

> **Codding Test 09**
> 

```jsx
// 문자열 붙여서 출력하기

import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String a = sc.next();
        String b = sc.next();
        
        String result1 = a.trim()+b;
        System.out.println(result1);
    }
}
```