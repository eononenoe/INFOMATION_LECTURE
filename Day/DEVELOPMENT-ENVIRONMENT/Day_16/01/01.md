# 01


> PPT 제작
> 

![3조.jpg](image.jpg)

---

> **Codding Test 01**
> 

```jsx
// 문자열 돌리기

import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String a = sc.next();
        for(int b=0;b<a.length();b++){
            char c = a.charAt(b);
            System.out.println(c);
        }
    }
}
```

---

> **Codding Test 02**
> 

```jsx
// 홀짝 구분하기

import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        if(n % 2 == 0) {
            System.out.printf("%d is even",n);
        } else {
            System.out.printf("%d is odd",n);
        }
    }
}
```

---
