# 01

> **C06정리&문제**
> 

```jsx
	정수 타입 		: byte,short,int ,long
	char 타입 	: ' ' 
	String 타입 	: " "
	실수 타입 		: double , float
	논리 타입 		: boolean

	확인 문제1

	정수타입 
	1byte : byte
	2byte : char / short
	4byte : int 
	8byte : long 

	실수타입
	4byte : float
	8byte : double

	논리타입
	1byte : boolean

	확인문제2
	
	
	맞는 코드인지 틀린 코드인지 확인 
	byte var = 200;							( x	)
	char var='AB';							( x )
	char var=65;							( o	)
	long var=50000000000;					( x )	
	float var = 3.14						( x	)
	double var = 100.0						( o	)
	String var = "나의직업은 "개발자" 입니다.";	( x )
	boolean var = 0;						( x	)
	int v2 = 1e2;							( x )
	float =1e2f;							( x )
	
```

---

> **C01TypeChange**
> 

```jsx
package Ch03;

public class C01TypeChange {
	public static void main(String[] args) {
		// (자료)형변환
		// 연산시 일치하지 않는 자료형을 일치시키는 작업
		
		// 자동형변환(암시적 형변환)	: 컴파일러에 의해 자동 형변환
		// 강제형변환(명시적 형변환)	: 프로그래머에 의해 강제 형변환
		
		// 자동형변환(=)
		// '변수 연산처리'시 범위가 넓은 공간에 작은값이 대입되는 경우
		// '리터럴 상수 연산처리'시 리터럴값에 따른 형변환 여부 결정
		// byte > short,char > int > long > float > double
		
		byte byteValue = 10;
		int intValue = byteValue;
		System.out.println("intValue : " + intValue);
		
		char charValue = '가';
		intValue = charValue;
		System.out.println("가 의 유니코드 : " + intValue);
		
		intValue = 50;
		long longValue = intValue;
		System.out.println("longValue : " + longValue);
		
		long Value = 100;
		float floatValue = longValue;
		System.out.println("floatValue : " + floatValue);
		
		floatValue = 100.5F;
		double doubleValue = floatValue;
		System.out.println("doubleValue : " + doubleValue);
		
	}
}

```

---

> **C02TypeChange**
> 

```jsx
package Ch03;

public class C02TypeChange {
	public static void main(String[] args) {
		
		// 강제 형변환
		// 좁은범위공간에 큰값을 넣으려고 하는경우
		// 기본적으로 불가능하기 때문에 강제로 자료형을 바꾸어 전달한다
		// 데이터 손실의 염려가 있다
		
		int intValue = 44032;
		char charValue = (char)intValue;
		System.out.println((int)charValue);
		
		long longValue = 500;
		intValue = (int)longValue;
		System.out.println(intValue);
		
		// 데이터 손실!
		double doubleValue = 3.14;
		intValue = (int)doubleValue;
		System.out.println(intValue);
	}
}

```

---

> **C03TypeChange**
> 

```jsx
package Ch03;

public class C03TypeChange {
	public static void main(String[] args) {
		int num1 = 129;				// 00000000 00000000 00000000 10000001
		int num2 = 130;				// 00000000 00000000 00000000 10000010
		byte ch1 = (byte)num1;		// 마지막 1byte만 존재 10000001
		byte ch2 = (byte)num2;		// 마지막 1byte만 존재 10000010
		
		System.out.printf("%d\n",ch1);
		System.out.printf("%d\n",ch2);
	}
}

```

---

> **C04TypeChange**
> 

```jsx
package Ch03;

public class C04TypeChange {
	public static void main(String[] args) {
		// 정수 연삭식(int 보다 작은 변수자료형(short, char ,byte))
		// int 로 자동 형변환
//		byte x = 10 ;
//		byte y = 20;
//		byte result1 = (byte)(x + y);
//		
//		int result2 = x + y;
//		System.out.println(result1);
//		System.out.println(result2);
		
		// 정수 연산식(int 보다 큰 변수자료형(long))
		// 큰 타입으로 자동 형 변환
//		byte var1 = 10;
//		int var2 = 100;
//		long var3 = 1000L;
//		int result = (int) (var1 + var2 + var3);
//		
//		long result2 = var1 + var2 + var3;
//		System.out.println(result2);
		
		// 실수 연산식
		// 큰 타입으로 자동 형 변환
		int intvar = 10;
		float flvar = 3.3F;
		double dbvar = 5.5;
		int result3 = (int) (intvar + flvar + dbvar);
		double result4 = intvar + flvar + dbvar;
		System.out.println(result3);
		System.out.println(result4);
	}
}
```

---

> **C05TypeChange**
> 

```jsx
package Ch03;

public class C05TypeChange {
	public static void main(String[] args) {
		int num1 = 10, num2 = 4;
		double dnum1 = (double) num1 / num2;
		double dnum2 = (num1*1.0) / num2;
		double dnum3 = num1 / num2;
		System.out.println("dnum1 : " + dnum1);
		System.out.println("dnum2 : " + dnum2);
		System.out.println("dnum3 : " + dnum3);
	}
}
```

---

> **C06TypeChange**
> 

```jsx
package Ch03;

public class C06TypeChange {
	public static void main(String[] args) {
		// short vs char
		// char 와 short는 같은 size(2byte)를 가지나
		// short는 양,음수를 지원 / char는 양수만 지원
		// short char간의 데이터교환시 동일한 값을 저장하더라도
		// 표현하는 범위가 다르기 때문에 각각 다른값이 나올수도 있다.
		char n1 = 60000;
		short n2 = (short)n1;
		System.out.println(n2);
		
		int n3 = (char)n2;
		System.out.println(n3);
	}
}
```

---

> **C07StringTypeChange**
> 

```jsx
package Ch03;

public class C07StringTypeChange {
	public static void main(String[] args) {
		// -------------------
		// 문자열 + 문자열
		// -------------------
//		System.out.println("문자열1" + "문자열2");
//		System.out.println("문자열1" + "문자열2");			// 문자열 + 문자열
//		System.out.println("문자열1" + ',' + "문자열2");	// 문자열 + 문자 + 문자열
//		System.out.println("문자열1" + 2);				// 문자열 + 숫자
//		System.out.println("문자열1" + ',' + '!');
//		System.out.println(',' + '!' + "문자열");
//		System.out.println("문자열1" + "문자열2");

		// -------------------
		// 문자열 -> 숫자형 변환
		// -------------------
		// 문자열 -> 숫자형으로 변환(정수)
		// int n1 = "10";
		
		System.out.println("10"+"20");		// 문자열 연결
		int n1 = Integer.parseInt("10");	// 웹개발코드시 폼으로부터 전달받은 값
		int n2 = Integer.parseInt("20");
		System.out.println(n1 + n2);
		
		// 문자열 -> 숫자형으로 변환(실수)
		double n3 = Double.parseDouble("10.5");
		double n4 = Double.parseDouble("20.4");
		System.out.println(n3+n4);
		
		short n5 = Short.parseShort("5");
		short n6 = Short.parseShort("6");
		
		System.out.println(n5+n6);
	}
}

```

---

> **C08정리_문제**
> 

```jsx
--------------------------------------------------------
정리
--------------------------------------------------------
자동 타입 변환
- 컴파일에 의한 자동 형변환
- 큰 공간에 작은자료형의 값을 넣을때 발생
- 데이터 손실이 최소화 되는 방향으로 자료형이 결정된다

강제 타입 변환
- 프로그래머에 의한 강제 형변환
- 작은 공간에 큰 자료형의 값을 저장(데이터 손실발생)

문자열 결합 연산
- 문자열과  + 연산을 하면 다른 피연산자도 문자열로 변환되어 문자열 결합이 일어난다

Integer.parseInt() : 문자열을 정수 int 타입으로 변환
Double.parseDouble() : 문자열을 실수 double로 변환

--------------------------------------------------------
문제
--------------------------------------------------------
1. 자동 타입 변환에 대한 내용입니다 컴파일 에러가 발생하는 것은 무엇입니까

[예시]
----------------------------
byte byteValue = 10;
char charValue = 'A';
----------------------------
1) int intValue = byteValue;
2) int intValue = charValue;
3) short shortValue = charValue;
4) double doubleValue = byteValue;

2. 강제 타입 변환에 대한 내용입니다. 컴파일 에러가 발생하는 것은 무엇입니까

[예시]
----------------------------
int intValue = 10;
char charValue = 'A';
double doubleValue = 5.7;
String strValue = "A";
----------------------------
1) double var = (double)intValue;
2) byte var = (byte) intValue;
3) int var = (int)doubleVale;
4) char var = (Char)strValue;

3. 연산식에서의 타입 변환에 대한 내용입니다. 컴파일 에러가 발생하는 것은 무엇입니까?

[예시]
----------------------------
byte byteValue = 10;
float floatValue = 2.5;
double doubleValue = 2.5;
----------------------------
1) byte result = byteValue + byteValue;
2) int result = 5 + byteValue;
3) float result = 5 + floatValue;
4) double result = 5 + doubleValue;

4. 다음 코드에서 컴파일 에러가 발생하는 위치와 이유를 설명해 보세요
[예시]
----------------------------
short s1 = 1;
short s2 = 2;
int i1 = 3;
int i2 = 4;
short result = s1 + s2; 
int result = i1 + i2;
----------------------------

5. 알파벳 a의 유니코드는 97이고 b의 유니코드는 98입니다.
따라서 a의 유니코드에 1을 더하면 b의 유니코드가 되므로
다음과 같이 코드를 작성했습니다. 실행결과는 b가 출력되어야 하는데 
컴파일 에러가 발생하였습니다. 무엇이 문제이고, 어떻게 수정하면 좋을지
적어보세요

[예시]
----------------------------
char c1 = 'a';
char c2 = c1 + 1; 
System.out.println(c2);
----------------------------

6. 자바에서 / 는 나눗셈 연산자 입니다 x/y 는 x 를 y 로 나누는 연산을 수행합니다
빈칸에 들어갈 타입은 무엇이며 출력되는 결과와 그 이유를 설명해 보세요
[예시]
----------------------------
int x = 5;
int y = 2;
____ result = x/y; 
System.out.println(result);
----------------------------

7. 6번 문제에서 출력되는 결과로 2.5가 나오게 하고 싶습니다 빈칸에 들어갈 코드를
작성하세요
[예시]
----------------------------
int x = 5;
int y = 2;
____ result = _____________; 
System.out.println(result);
----------------------------

8. 두 실수를 덧셈 연산하고 소수점 이하 자리를 버리고 싶습니다
빈칸에 들어갈 코드를 작성해 보세요

[예시]
----------------------------
double var1 = 3.5;
double var2 = 2.7;
int result = _____________;
----------------------------

9. var1 부터 var4까지 + 연산을 수행해서 int 타입 result변수에 9가 저장되도록
빈칸에 들어갈 코드를 작성해보세요
[예시]
----------------------------
long var1 = 2L;
float var2 = 1.8f;
double var3 = 2.5;
String var4 = "3.9";
int result =_______________;
System.out.println(result);
----------------------------

10. 다음코드를 실행했을 때 출력 결과를 적어보세요
[예시]
----------------------------
String str1 = 2 + 3 + "";
String str2 = 2 + "" + 3;
String str3 = "" + 2 + 3;
System.out.println(str1);
System.out.println(str2);
System.out.println(str3);
----------------------------

11. 문자열을 기본 타입으로 변환하려고 합니다
빈칸에 알맞은 코드를 작성해 보세요
[예시]
----------------------------
 byte value =	_________("10");
 int value = 	_________("100);
 float value =	_________("20.5");
 double value =	_________("3.14159");
----------------------------

[답]
1. 3 char 타입의 양의 허용 범위가 short 타입보다 더 큼

2. 4 문자열을 char 타입으로 강제 타입 변환(캐스팅)할 수 없음

3. 1 연산의 결과는 int 타입임

4. 5 연산의 결과는 int 타입임

5. 연산의 결과는 int 타입인데 , char 타입 변수 c2 에 저장했기 때문

char c2 = (char) (c1 + 1);

6. int 2, 연산의 결과는 int 타입임

7. double, (double)x / y 또는 x / (double)y 또는 (double)x / (double)y

8. (int) (var1 + var2)

9. 
(int)var1 + (int)(var2 + var3) + (int)Double.parseDouble(var4) 또는
(int)(var1 + (int)var2 + var3 + Double.parseDouble(var4)) 또는
(int)(var1 + var2 + (int)var3 + Double.parseDouble(var4)) 또는
(int)(var1 + var2 + var3 + (int)Double.parseDouble(var4))

10.실행결과
5
23
23

11. 
Byte.parseByte
 Integer.parseInt
 Float.parseFloat
 Double.parseDouble 
```

---