# 02

> **C01Scanner**
> 

```jsx
package Ch04;

import java.util.Scanner;

public class C01Scanner {
	public static void main(String[] args) {

		// 자동 import : ctrl + shift + o
		// 자동 formatting : ctrl + shift + f
		
		// 스트림
		// System.in : 표준입력 스트림
		// System.out : 표준출력 

		// 코드 해석
		// new Scanner(System.in) : 표준입력 스트림을 연결한 Scanner 객체 생성
		// Scanner sc : 생성된 Scanner 객체의 위치정보(메모리주소)를 저장한 참조변수 sc
		Scanner sc = new Scanner(System.in);
		// 표준입력스트림에 연결된 Scanner객체를 생성 이후 위치정보를 main Stack영역의 Scanner sc 참조변수에 초기화

		System.out.printf("num1 입력 : ");
		int num1 = sc.nextInt(); // 엔터(\n), 스페이스바
		System.out.printf("num2 입력 : ");

		int num2 = sc.nextInt();
		System.out.printf("num3 입력 : ");

		int num3 = sc.nextInt();
		System.out.printf("num4 입력 : ");

		int num4 = sc.nextInt();

		int sum = num1 + num2 + num3 + num4;
		System.out.printf("%d + %d + %d + %d = %d \n", num1, num2, num3, num4, sum);
		sc.close();
	}
}

```

---

> **C02Scanner**
> 

```jsx
package Ch04;

import java.util.Scanner;

public class C03Scanner {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
//		System.out.print("정수 입력 : ");
//		int num1 = sc.nextInt();
//		System.out.println("입력된 정수 값 : "+num1);

//		System.out.print("실수 입력 : ");
//		double num2 = sc.nextDouble();
//		System.out.println("입력된 실수 값 : "+num2);
		
//		System.out.print("문자열 입력 : ");
//		String str1 = sc.next();					// 문자열 입력받기 기능함수, 띄어쓰기는 포함하지 않는다
//		System.out.println("입력된 문자열 :" + str1);

//		System.out.print("입력 : ");
//		String s1 = sc.next();
//		String s2 = sc.next();
//		String s3 = sc.next();
//		System.out.printf("문자열 : %s %s %s\n", s1,s2,s3);
		
		System.out.print("문자열 입력(띄어쓰기 포함) : ");
		String str2 = sc.nextLine();
		System.out.println("문자열 : " + str2);
	}
}

```

---

> **C03Scanner**
> 

```jsx
package Ch04;

import java.util.Scanner;

public class C03Scanner {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		System.out.print("정수 입력 : ");
		int num1 = sc.nextInt();
		System.out.println("입력된 정수 값 : "+num1);
		
		sc.nextLine();	// 다른 next 후 nextline 사용할려면 버퍼 걸린게 풀어야함

		System.out.print("문자열 입력(띄어쓰기 포함) : ");
		String str2 = sc.nextLine();
		System.out.println("문자열 : " + str2);

//		System.out.print("실수 입력 : ");
//		double num2 = sc.nextDouble();
//		System.out.println("입력된 실수 값 : "+num2);
		
//		System.out.print("문자열 입력 : ");
//		String str1 = sc.next();					// 문자열 입력받기 기능함수, 띄어쓰기는 포함하지 않는다
//		System.out.println("입력된 문자열 :" + str1);

//		System.out.print("입력 : ");
//		String s1 = sc.next();
//		String s2 = sc.next();
//		String s3 = sc.next();
//		System.out.printf("문자열 : %s %s %s\n", s1,s2,s3);

	}
}

```

---

> **C04Scanner**
> 

```jsx
package Ch04;

import java.util.Scanner;

public class C04Scanner {

	public static void main(String[] args) {
		// 이름을 입력하세요? 홍길동
		// 홍길동 님의 나이를 입력하세요? 35
		// 홍길동 님의 주소를 입력하세요? 대구광역시 달서구 000
		// 홍길동 님의 나이는 35세 주소는 대구광역시 ~~ 입니다
		
		Scanner sc = new Scanner(System.in);
		
		System.out.print("이름을 입력하세요 : ");
		String name = sc.next();
		
		System.out.printf("%s 님의 나이를 입력하세요 : ",name);
		int age = sc.nextInt();
		sc.nextLine();
		
		System.out.printf("%s 님의 주소를 입력하세요 : ",name);
		String addr = sc.nextLine();
		System.out.printf("%s님의 나이는 %d세 주소는 %s 입니다.",name,age,addr);
	}
}
```

---

> **C01BASIC**
> 

```jsx
package Ch05;

public class C01BASIC {

	public static void main(String[] args) {
		//-------------------------
		//기본 산술 연산자
		//-------------------------
//		int a = 10, b = 20, c;
//		System.out.println("a+b="+ (a + b));
//		System.out.println("a-b="+ (a - b));
//		System.out.println("a*b="+ (a * b));
//		System.out.println("b/a="+ (b / a)); //나누기 - 몫
//		System.out.println("a%b="+ (a % b));//나누기 - 나머지(1.짝홀수구분,2.배수구분,3.자리수제한,4.끝자리구하기)
//		System.out.println("-a="+ -a);

		
		//문제	
//		두수를 입력 받아 두수의 합/차/곱을 출력하는 프로그램을 만들어보세요
//		Scanner 를 사용합니다

		//-------------------------
		//대입 연산자
		//-------------------------
		//LV = RV;
		//공간 = 값(우선 처리);		
		
		

		//-------------------------
		//복합 대입 연산자(기본 산술연산 + 대입)
		//-------------------------
//		int a = 10;
//		a += 10; //a = a + 10;
//		a -= 5; // a = a-5;
//		a *= 3; // a = a*3;
//		System.out.println("a="+a);

		//-------------------------
		//비교 연산자
		//-------------------------
//		int a =10;
//		int b=20;
//		System.out.println("A == B : "+ (a == b)); // a=b
//		System.out.println("A  > B : "+ (a > b));
//		System.out.println("A  < B : "+ (a < b));
//		System.out.println("A >= B : "+ (a >= b));
//		System.out.println("A <= B : "+ (a <= b));
//		System.out.println("A != B : "+ (a != b));
		
	
		
		//-------------------------
		//논리 연산자
		//-------------------------
		//AND 연산자	&& :  (true)&&(true) = true , 그외는 거짓
		//- &&기호를 기준으로 왼/오른쪽 둘다 true 이면 true
		//OR 연산자	|| :  t||t = t, t||f =t, f||t=t, f||f=f
		//- ||기호를 기준으로 왼/오른쪽 중 하나만 true 이면 true
		//! 연산자
		//- true이면 false, false 이면 true

//		int a=10;int b=20;
//		System.out.println((a>=b)&&(a>5));
//		System.out.println((a!=b)&&(b>15));
//		
//		System.out.println((a>=b)||(a>5));
//		System.out.println((a!=b)||(b>15));
//		System.out.println((a==b)||(a<=5));
//		
//		System.out.println("false AND false = " + (true && true));
//		System.out.println("false AND true = " + (false && true));
//		System.out.println("true AND false = " + (true && false));
//		System.out.println("true AND true =  " + (false && false));
		
//		int n1 = 100;
//		int n2 = 200;
//		boolean n3 = (n1<100) && (n2++>0);
//		System.out.printf("%d %d %b\n",n1,n2,n3);
		

		
		//-------------------------
		//논리 부정 연산자
		//-------------------------
//		boolean play = true;
//		System.out.println(play);
//
//		play = !play;
//		System.out.println(play);
//
//		play = !play;
//		System.out.println(play);
//		

		
		

		//-------------------------
		//증감연산자
		//-------------------------
		//++a(--a) : 전치 연산자 : 먼저 값 1증가(1감소) 이후 다른 연산자 처리
		//a++(a--) : 후치 연산자 : 다른 연산자 처리 먼저 한 후 1증가(1감소)
//		int a = 10, b = 10, c, d=0;
//		
//		c = --a + b++;
//		d = a-- + ++b;
//		System.out.printf("a=%d , b=%d , c=%d, d=%d", a, b, c, d);
		
	

		//-------------------------
		//삼항 연산자
		//-------------------------
		// (조건식)? 참인경우 실행코드 : 거짓인경우 실행코드;		
		int score = 85;
		char grade = (score > 90) ? 'A' : ((score > 80) ? 'B' : 'C');
		System.out.println(score + "점은 " + grade + "등급입니다.");

	}
	

}

```

---

> **C02Ex**
> 

```jsx
package Ch05;

import java.util.Scanner;

public class C02Ex {

	public static void main(String[] args) {

		// 1.문제(삼항연산자)
		// 키보드로 국어/영어/수학 점수를 입력받아 각각의부분점수가 40점이상이고
		// 총점수 평균이 70점이상이면 '합격'
		// 미만이면 '불합격'을 출력합니다
		
//		Scanner sc = new Scanner(System.in);
//		System.out.print("국어/영어/수학 점수를 입력 : ");
//		int kor,eng,math;
//		kor = sc.nextInt();
//		eng = sc.nextInt();
//		math = sc.nextInt();
//		double avg = (double)(kor + eng + math)/3;
//		String result =  (kor>=40&&eng>=40&&math>=40&&avg>=70) ? "합격" : "불합격";
//		System.out.println("시험결과 : " + result);
//		sc.close();

		// 2.미니문제(%연산자)
		// 키보드로 부터 정수값 2 를 입력받아
		// 두수의 합이 짝수이면 "짝수입니다"
		// 홀수이면 "홀수입니다" 를 출력하세요~
		
//		Scanner sc = new Scanner(System.in);
//		System.out.print("정수값을 입력해주세요 : ");
//		int even = sc.nextInt();
//		int odd = sc.nextInt();
//		String distinction = (even + odd) % 2 != 0 ? "홀수" : "짝수";
//		System.out.println(distinction + "입니다");
//		sc.close();

		// 3.문제
		// 국어 / 영어 / 수학 점수를 입력받아서
		// 국어 점수가 40점이상
		// 영어 점수가 40점이상
		// 수학 점수가 40점이상이면서 전체평균이 60점이상이면 합격을 출력
		// 아니면 불합격을 출력하세요
		// 삼항연산자와 논리연산자를 이용합니다.

	}
}

```

---

> **C03Percent**
> 

```jsx
package Ch05;

import java.util.Random;
import java.util.Scanner;

public class C03Percent {

	public static void main(String[] args) {
		// %연산자

		// 01 홀수/짝수

		// Scanner 객체 생성 후
		// 정수를 num1 에 저장 다음
		// 짝홀수 확인하세요

//		Scanner sc = new Scanner(System.in);
//		int num1 = sc.nextInt();
//
//		 String result = (num1%2==0)?"짝수입니다":"홀수입니다";
//		 System.out.println("결과 : " + result);

//		 ====================================================

		// 02 배수 구하기

		// 세 정수를 받아서 세 수의 합이 5의 배수인 경우
		// 5의배수입니다 를 출력
		// 아닌 경우 5의배수가 아닙니다 를 출력

//		Scanner sc = new Scanner(System.in);
//		int n1,n2,n3,sum;
//		n1=sc.nextInt();
//		n2=sc.nextInt();
//		n3=sc.nextInt();
//		sum=n1+n2+n3;
//		String result = (sum%5==0)?"5의배수입니다":"5의 배수가 아닙니다";
//		System.out.println("RESULT : " +result);

//		 ====================================================

		// 03 수의범위
		/*
		 * N%2 = 0,1 N%3 = 0,1,2 N%4 = 0-3 N%9 = 0-8 N%10 = 0-9 수%100 = 0 ~99
		 */

		// 난수생성
//		Random rnd = new Random();
		
//		while (true) {
//			System.out.println(rnd.nextInt(45)  + 1); //N%5 과 동일 (0~44)
//			Thread.sleep(500);
//		}

		// 02 Math.random();
//		while (true) {
//			System.out.println( (int)(Math.random()*100)%45 + 1 );
//			System.out.println((int)(Math.random()*100)%16);
//			Thread.sleep(500);
//		}

//		 ====================================================

		// 04 끝자리수

//		int num = 56789;

//		System.out.println("오른쪽 끝 1자리 : " + (num % 10));
//		System.out.println("오른쪽 끝 2자리 : " + (num % 100));
//		System.out.println("오른쪽 끝 3자리 : " + (num % 1000));
//		System.out.println("오른쪽 끝 4자리 : " + (num % 10000));
//		System.out.println();
//		System.out.println("왼쪽 끝 1자리 : " + (num / 10000));
//		System.out.println("왼쪽 끝 2자리 : " + (num / 1000));
//		System.out.println("왼쪽 끝 3자리 : " + (num / 100));
//		System.out.println("왼쪽 끝 4자리 : " + (num / 10));

		// 정수 하나를 입력받아 거꾸로 저장해보세요(반복문법 이후 풀어보기)%,/연산 동시이용할 것
		// 예

//		입력: 1234
//		저장
//		int reverse = 4321;
//		출력 : 4321

	}
}

```

---

> **C04BitArith**
> 

```jsx
package Ch05;

public class C04BitArith {
	public static void main(String[] args) {
		int num1 = 15;			//00000000 00000000 0000000 00001111
		int num2 = 20;			//00000000 00000000 0000000 00010100
		int num3 = num1&num2;	//00000000 00000000 0000000 00000100 = 4
		int num4 = num1|num2;	//00000000 00000000 0000000 00011111 = 31
		int num5 = num1^num2;	//00000000 00000000 0000000 00011011 = 27
		int num6 = ~num1;		//11111111 11111111 1111111 11110000 = -16
		
		System.out.println("AND 비트 연산 결과 : " + num3);
		System.out.println("OR 비트 연산 결과 : " + num4);
		System.out.println("XOR 비트 연산 결과 : " + num5);
		System.out.println("NOT 비트 연산 결과 : " + num6);
	}
}	

```

---

> **C05ShiftArch**
> 

```jsx
package Ch05;

public class C05ShiftArch {
	public static void main(String[] args) {
		int num1 = 15;		//00000000 00000000 00000000 00001111
		int num2 = 20;		//00000000 00000000 00000000 00010100
		int num3 = num1<<3; //00000000 00000000 00000000 01111000
		int num4 = num1>>3; //00000000 00000000 00000000 00000001
		int num5 = num2<<3; //00000000 00000000 00000000 10100000
		int num6 = num2>>3; //00000000 00000000 00000000 00000010
		
//		System.out.println("<<Shift 연산결과 :" + num3);
//		System.out.println(">>Shift 연산결과 :" + num4);
	}
}	

```

---