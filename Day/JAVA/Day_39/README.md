# 01

> **C04자료형.java**
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
		// -----------------
		// 정수 int - 4byte 정수 부호 o
		// -----------------
//		int n1 = 0b10101101;	//2진수값
//		int n2 = 173;			//10진정수값
//		int n3 = 0255;			//8진수
//		int n4 = 0xad;			//16진수
//		System.out.printf("%d %d %d %d\n",n1,n2,n3,n4);

		// -----------------
		// 정수 byte - 1byte 정수 부호 o
		// -----------------
//		byte n5 = (byte)-129;
//		byte n6 = -30;
//		byte n7 = 30;
//		byte n8 = 127;
//		byte n9 = (byte)129;					//왜 ?? 컴파일에러가??
//		System.out.printf("%d\n",n9);	//왜 ??
//		System.out.println(0b10101101);	//왜 ?? 음수아니야??
//		System.out.println(Integer.toBinaryString(-129));

//		byte a = 10;
//		byte b = 20;
//		byte c = a + b;

		// -----------------
		// 정수 short - 2byte 정수 부호 o | char - byte 정수 부호 x (양수만)
		// -----------------
//		char n1 = 65535;	//(0~2^16-1)	(0~65535)
//		short n2 = 32767;	//(-2^15 ~ +2^15-1)(-32768 ~ + 32767)
//		char n3 = 60000;
//		short n4 = (short)n3;		//문제발생... 왜??
//		System.out.printf("%d\n",n4);

		// -----------------
		// 정수 long - 8byte 정수 부호 o
		// -----------------
//		long n1 = 10000000000L;
//		long n2 = 20;	//L,l (리터럴접미사) : long 자료형 사용하여 값
//		
//		long n3 = 10000000000L;	//문제발생.. 왜?
//		long n4 = 10000000000L;

		// -----------------
		// 실수
		// -----------------
		// 유리수와 무리수의 통칭
		// 소숫점이하값을 가지는 수 123.456
		// float : 4byte 실수(6-9자리)
		// double : 8byte 실수(15-18자리),기본자료형
		
		// 정밀도 확인
//		float n1 = 0.123456789123456789F;	//f,F:float형 접미사
//		double n2 = 0.123456789123456789;
//		
//		System.out.println(n1);
//		System.out.println(n2);
		
		// 오차 확인
//		float num = 0.1F;
//		for(int i=0;i<=1E5;i++) {
//				num=num+0.1F;
//				System.out.println(i);
//		}
//		System.out.println("num : "  + num);
		
		//--------------------
		//단일문자 char 2byte 정수
		//--------------------
//		char ch1 = 'a';
//		System.out.println(ch1);
//		System.out.println((int)ch1); // 011000001
//	
//		
//		char ch2 = 98;
//		System.out.println(ch2);
//		System.out.println((int)ch2); // 011000010
//		
//		char ch3 = 'b'+1;
//		System.out.println(ch3);
//		System.out.println((int)ch3); // 011000011
//		
//		byte ch4 = 'c'+2;
//		System.out.println((char)ch4);
//		System.out.println(ch4); // 011000011
		
//		char ch5  = 0xac00;
//		char ch6 = 44032;
		
//		System.out.println(ch5);
//		System.out.println(ch6);
//		System.out.println((char)(0b1010110000000000+1));
		 
//		char ch6 = 0xac00+1;
//		System.out.printf("%c %c\n", ch5,ch6);
//		
//		// \\u :유니코드값 이스케이프문자
//		System.out.printf("%c\n", '\uAC93');
		
//		System.out.printf("TEST : %c\n", '\uabcd');
		
		
//		char n = 10;
//		System.out.printf("HELLO %c WORLD", n);
		
		
		//--------------------
		//문자열 : String (클래스자료형)
		//--------------------
		
		//기본자료형(원시타입)
//		byte n1;
//		short n2;
//		double n3;
//		long n4;
		
		//클래스자료형
		//클래스자료형으로 만든변수는 '참조변수'라고 하고
		//참조변수는 데이터가 저장된 위치정보(메모리주소값)이 저장된다.
//		int n1 = 10;
//		byte n2 = 20;
//		char n3 = 40;
//		
//		String name = "홍길동";
//		String job = "프로그래머";
//		System.out.println(name);
//		System.out.println(job);

		//--------------------
		//boolean : 논리형(true/false 저장)
		//--------------------
		
//		boolean flag = (10>11); 	// 참(긍정)
//		if(flag) 
//		{
//			System.out.println("참인경우 실행");
//		}
//		else 
//		{
//			System.out.println("거짓인경우 실행");
//		}
		
	}
	
}

```

---

> **C05상수**
> 

```jsx
package Ch02;

public class C05상수 {
	public static void main(String[] args) {
		
//		리터럴 상수 : 이름부여 x , 상수 Pool에 저장, 단순한 수치, 값
//		심볼릭 상수 : 이름부여 o , final 예약어 사용
		
//		리터럴 접미사 : 리터럴 상수가 저장되는 자료형을 지정
//		l,L : long 자료형
//		f,F : float 자료형
		
//		int a = 'a';
//		System.out.println((int)a);
//		System.out.println((char)a);
		
//		int n1 = 100; 		// 100은 리터럴 상수
//		final int n2 = 200;	// n2는 심볼릭 상수
		
//		final double PI = 3.14;
//		double result = PI*4*4;
		
//		double a = 1e-3;
//		System.out.println(a);
	}
}

```