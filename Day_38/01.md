# 01

> **JAVA**
> 

```jsx
Programming    Language
pro+           gram
-미리,사전의    -쓰다,적다

COMPUTE : 계산하다
COMPUTER : 계산기

JAVA 언어 : 절차지향 문법(C) + 객체지향 문법(C++)

절차지향 : 순차적으로 명령을 실행하는 방식으로, 함수 중심으로 작업을 처리
객체지향 : 객체를 중심으로 데이터와 그에 관련된 동작을 캡슐화하여 관리하는 방식
```

---

> **C00HelloWorld**
> 

```jsx
package Ch00; // 패키지 구별코드

public class C00HelloWorld // 클래스 영역 (객체지향 문법 적용 범위)
{

	public static void main(String[] args) // 메서드 영역(절차지향 문법 적용 범위)
	{
		// 메서드 종류
		// 라이브러리 메서드 : 미리 만들어져 제공되는 메서드
		// 사용자정의 메서드 : 개발자에 의해 만들어지는 메서드
		// main. 메서드 : 최초 실행 메서드
		System.out.println("Hello world");
	}
}

```

---

> **C01SystemOut**
> 

```jsx
package Ch01;

public class C01SystemOut {
	public static void main(String[] args) {
//	System.out.println();
//	\n : 개행, 줄바꿈
//	\b : 백스페이스
//	\t : 탭길이(기본 8칸만큼 커서 이동)
	System.out.print("HELLOWORLD\n");
	System.out.print("HELLOWORLD\n");
	System.out.print("HELLOWORLD\n");
	
//	format : 형식, 서식
//	%d : 10진수 정수 서식문자
//	%f : 10진수 실수 서식문자
//	%d : 한문자 서식문자
//	%s : 문자열 서식문자
	System.out.printf("%d %d %d \n",10,20,30);
	System.out.printf("%f %f %f \n",10.1,20.1,30.1);
	System.out.printf("%c %c %c \n",'A','B','C');
	System.out.printf("%s %s %s \n","This is","String","Test");
	System.out.printf("%d.%s %d \n",1,"국어",100);
	
//	println()
	System.out.println("HELLOWORLD");
	System.out.println("HELLOWORLD");
	System.out.println("HELLOWORLD");
	
	}
}

```

---

> **C01진수**
> 

```jsx
package Ch02;

public class C01진수 {
	public static void main(String[] args) {
//		10진수			2진수
//		0			   0
//		1			   1
//		2			  10
//		3			  11
//		4			 100
//		5			 101
//		6			 110
//		7			 111
//		8			1000
//		9			1001
//		------------------------------
//		1bit : 2^1 = 2(0~1)
//		2bit : 2^2 = 4(0~3)
//		3bit : 2^3 = 8(0~7)
//		4bit : 2^4 = 16(0~15)
//		5bit : 2^5 = 32(0~31)
//		6bit : 2^6 = 64(0~63)
//		7bit : 2^7 = 128(0~127)
//		8bit : 2^8 = 256(0~255)
//		9bit : 2^9 = 512(0~511)
//		10bit: 2^19 =1024(0~1023)
//		--------------------------------
//		1	1	1	1	1	1	1	1
//		*	*	*	*	*	*	*	*
//		2^7	2^6	2^5	2^4	2^3	2^2	2^1	2^0
//
//		128	64	32	16	8	4	2	1

		// 2진수 - > 10진수
		// 10101100 = 128 + 32 + 8 + 4
		// 10011010 = 128 + 16 + 8 + 2
		// 01101001 = 64 + 32 + 8 + 1
		// 10010010 = 128 + 16 + 2

		// 10진수 -> 2진수
		// 192 -> 11000000
		// 224 -> 11100000
		// 252 -> 11111100
		// 12 -> 00001100
		// 15 -> 00001111

		// %d : 10진수 서식문자
		// %o : 8진수 서식문자
		// %x : 16진수 서식문자
		// 코드 이쁘게 정리하기 : ctrl + shift + f

		System.out.printf("10진수 : %d\n", 0b00001111);
		System.out.printf("10진수 : %d\n", 173); // 10진수
		System.out.printf("10진수 : %d\n", 0255); // 8진수 (0 :8진수를 의미하는 접두사)
		System.out.printf("10진수 : %d\n", 0xAD); // 16진수(0x:16진수를 의미하는 접두사)

		System.out.printf("8진수 : %o\n", 173); // 10진수
		System.out.printf("8진수 : %o\n", 0255); // 8진수 (0 :8진수를 의미하는 접두사)
		System.out.printf("8진수 : %o\n", 0xAD); // 16진수(0x:16진수를 의미하는 접두사)

		System.out.printf("16진수 : %X\n", 173); // 10진수
		System.out.printf("16진수 : %x\n", 173); // 10진수
		System.out.printf("16진수 : %X\n", 0255); // 8진수 (0 :8진수를 의미하는 접두사)
		System.out.printf("16진수 : %x\n", 0255); // 8진수 (0 :8진수를 의미하는 접두사)
		System.out.printf("16진수 : %X\n", 0xAD); // 16진수(0x:16진수를 의미하는 접두사)
		System.out.printf("16진수 : %x\n", 0xAD); // 16진수(0x:16진수를 의미하는 접두사)
	}
}

```

---

> **C02음수**
> 

```jsx
package Ch02;

/*
 컴퓨터(CPU)는 구조상 덧셈연산를 할 수 있다(o)
 컴퓨터(CPU)는 구조상 뺄셈연산를 할 수 있다(x)
 컴퓨터(CPU)에서 뺄셈 요청시 뺄셈처리는 할 수 있다(o)
 보수개념을 도입해서 뺄셈처리를 수행하기 때문에 가능
 
 7 - 4 = 3
 7 + 6 = '1'3 = 3
 
 77 - 32 = 45
 77 + 68 = '1'45 = 45
 
  0000 0101 = 5
  1111 1010 = -6(1의 보수)
 +0000 0001 =   (2의 보수)
 +1111 1011 = -5(2의 보수)
 ---------------
  0000 0000 = 0
  
 ===============
  0000 0000 = 0
  
 ------------
 00000000 = 0
 00000001 = 1
 00000010 = 2
 00000011 = 3
 ..
 01111111 = 127
 10000000 = -128 
 10000001 = -128+1
 10000010 = -128+2
 10000011 = -128+3
 ..
 11111111 = -128+127 = -1
 00000001 = 1    
    

    
 //문제

 음수값임을 고려하여 풉니다
 10 진수 	-> 2진수
 111 		-> 0110 1111
 -111 		-> 1001 0001
 96		-> 0110 0000
 -96		-> 1010 0000
 31 		-> 0001 1111
 -31		-> 1110 0001 
		
 2진수		-> 10진수
 10101111 	-> -128 + 32 + 8 + 4 + 2 + 1
 00110101	-> 32 + 16 + 4 + 1
 11001100	-> -128 + 64 + 8 + 4
 10101010	-> -128 + 32 + 8 + 2
  
 */
public class C02음수 {
	public static void main(String[] args) {

	}
}

```

---

> **C03변수_자료형**
> 

```jsx
package Ch02;

public class C03변수_자료형 {
	public static void main(String[] args) {
		
//		Data(수,자료) : 선 저장 / 후 처리
//	    변수 : 개발자의 유지보수 측면에서 바뀔 예정이 큰 수
//		변수명 : 저장되어져 있는 변수 공간에 접근하기 위한 문자 형태의 주소
//		자료형 : Data(수,자료)를 저장하기 위한 공간을 형성하는 예약어(+제약조건)

//		lv(공간) = rv(값) rv를 먼저(저장 or 연산) 처리 한 다음 lv 에 대입
		
		int num1;					// 4byte 정수 공간 형성 + num1 이름 부여(변수 정의)
		num1 = 10;					// 10 리터널 상수값 상수 Pool 에 저장, num1공간에 값 대입(복사)
		int num2 = 4;				// 4 리터널 상수값 상수 pool 에 저장, 4byte 정수 공간 num2에 초기값으로 대입
									// num2에 4로 초기화
		int num3 = num1 + num2;		// num1의 값과 num2안의 값의 + 연산결과 값을 4byte 정수 공간 num3에 초기화
		System.out.println(num3);	// num3안의 값을 println
	}
}

```

---

> **C04자료형**
> 

```jsx
package Ch02;
// === 정수 ===
// byte	(1byte) : 음수양수
// short	(2byte) : 음수, 양수
// char	(2byte) : 양수값 지원
// int		(4byte) : 기본 / 음수양수
// long	(8byte) : 음수양수

// === 실수 ===
// float	(4byte)
// double	(8byte) : 기본

// === 단일문자 ===
// char		(2byte)

// === 문자열 ===
// String 클래스 자료형 : 동적공간 할당

// primitive
// 원시타입
// 기본자료형
// 선 공간 형성

public class C04자료형 {
	public static void main(String[] args) {
		
	}
}

```

---