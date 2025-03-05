# 01

> **C08 정리_문제**
> 

```jsx
--------------------------------------------------------
정리
--------------------------------------------------------
기본 연산자 : + , - , * , / , %
증감 연산자 :  ++ , --  변수의 값을 1증가 or 1감소
비교 연산자 : == , > ,>= , < , <= != 두 피연산자를 비교한뒤 참거짓에따라 boolean값을 전달
논리 연산자 : && , || , !  , 논리곱 , 논리합 , 논리 부정 계산후 boolean값을 전달
복합 대입 연산자 : = , += , -= , *= , /= , %= , 오른쪽값을 왼쪽 공간에 대입
삼항 연산자 : (조건식) ? A : B ; 조건식이 true이면 A를 실행 false 이면 B를 실행

--------------------------------------------------------
문제
--------------------------------------------------------
1. 다음 코드에서 컴파일 에러가 발생하는 위치와 이유를 설명해보세요

[예시]
----------------------------
byte b = 5;						//1
b = -b;							//2
int result = 10 / b;			//3
System.out.println(result);		//4 
----------------------------

2. 다음 코드를 실행했을 때 출력 결과는 무엇입니까?

[예시]
----------------------------
int x = 10;
int y = 20;
int z = (++x) + (y--);
System.out.println(z);
 
----------------------------

3. 다음 코드 실행시 출력 결과로 5를 기대했는데 4가 나왔습니다
어디서 잘못됬는지 확인하고 고쳐보세요
 

[예시]
----------------------------
int var1 = 5;
int var2 = 2;
double var3 = (1.0*var1) / var2;
int var4=(int)(var3 * var2);
System.out.println(var4);
----------------------------

4 다음 코드는 비교 연산자와 논리 연산자의 복합 연산식입니다
연산식의 출력 결과를 빈칸에 넣으세요

[예시]
----------------------------
 int x = 10;
 int y = 5;
 System.out.println( (x>7) && (y<=5) );
 -> (			)
 System.out.println( x%3 ==2) || (y%2 !=1) );
 -> (			)
----------------------------

5 대입 연산자와 산술연산자로 구성된 실행문을
복합대입연산자로 바꿔서 작성해보세요
[예시]
----------------------------
 int value = 0;
 value = value + 10; ->(   );
 value = value - 10; ->(   );
 value = value * 10; ->(   );
 value = value / 10; ->(   );
----------------------------

6. 다음 코드를 실행했을 때 출력 결과는 무엇인지 적어보세요 

[예시]
----------------------------
 int score = 85;
 String result = (!(score>90)) ? "가" : "나";
 System.out.println(result);
----------------------------

[답]

1. b = -b;, 부호 연산을 하므로 결과는 int 타입이 됨
확인 문제 정답 649 정답편
2. 31 
3. var1/var2는 정수 연산이므로 결과는 정수 2, 그래서 변수 var3에는 2.0이 저장
(int)(var3 * var2)는 (int)(2.0 * 2)이므로 결과는 4, 그래서 변수 var4는 4가 저장

4. true, false

5. 
value += 10;
 value -= 10;
 value *= 10;
 value /= 10;
6. 가

```

---

> **C01IF**
> 

```jsx
package Ch06;

import java.util.Scanner;

public class C01IF {

	public static void main(String[] args) {
		
		//-----------------------
		//단순 IF	
		//-----------------------
//		Scanner sc = new Scanner(System.in);
//		System.out.print("나이 : " );
//		int age = sc.nextInt();
//		if(age >= 8)
//			System.out.println("학교에 다닙니다.");
//		
//		System.out.println("첫번째 IF 코드 블럭 종료..");
//		
//		if(age<8)
//			System.out.println("학교에 다니지 않습니다.");
//		
//		System.out.println("두번째 IF 코드 블럭 종료..");	
//		System.out.println("프로그램을 종료합니다");
//		
//		sc.close();
		
		
		//-----------------------
		//IF-ELSE	
		//-----------------------
		
//		Scanner sc = new Scanner(System.in);
//		System.out.print("나이 : " );
//		int age = sc.nextInt();
//		
//		if(age >= 8)
//			System.out.println("학교에 다닙니다.");
//		else
//			System.out.println("학교에 다니지 않습니다.");
//
//		System.out.println("프로그램을 종료합니다");
//		
//		sc.close();
		
		//-----------------------
		//1 문제
		//-----------------------
		// 정수 한개값을 입력받아 3의 배수이면 해당 수를 출력하세요
		// 3의 배수이면서 5의 배수라면 출력 - 
		// 순서도도 그려보세요 - 
		
//		Scanner sc = new Scanner(System.in);
//		System.out.print("정수입력 : " );
//		int num = sc.nextInt();
//		
//		if(num%3==0) {
//			System.out.printf("%d 는 3의 배수입니다\n",num);
//			
//			if(num%5==0) {
//				System.out.printf("%d 는 5의 배수입니다\n",num);
//			}
//		}
//		
//		sc.close();
		
		
		//-----------------------
		//2 문제
		//-----------------------
		// 두개의 정수를 입력받아 큰 수 출력
		
//		Scanner sc = new Scanner(System.in);
//		System.out.print("두개 정수 입력 : ");
//		int n1 = sc.nextInt();
//		int n2 = sc.nextInt();
//		
//		if(n1>=n2) {
//			System.out.println("큰수 : " + n1);
//		}else {
//			System.out.println("큰수 : " + n2);
//		}
//
//		sc.close();
//		
		//-----------------------
		//3 문제(☆)
		//-----------------------
//		// 세 개의 정수를 입력받아 큰 수 출력
//		Scanner sc = new Scanner(System.in);
//		System.out.print("세 개 정수 입력 : ");
//		int n1 = sc.nextInt();
//		int n2 = sc.nextInt();
//		int n3 = sc.nextInt();
//		
//		int max = n1;	//최대값(max)이 n1이라고 가정 시작 - !
//		
//		if(max<n2){
//			max=n2;
//		}
//		if(max<n3) {
//			max=n3;
//		}
//
//		System.out.println("큰 수 : " + max);
//		sc.close();
		

//		// 세 개의 정수를 입력받아 큰 수 출력
//		Scanner sc = new Scanner(System.in);
//		System.out.print("세 개 정수 입력 : ");
//		int n1 = sc.nextInt();
//		int n2 = sc.nextInt();
//		int n3 = sc.nextInt();
//			
//		
//		//n1이 제일 큰경우(n1>n2 && n1>n3) 
//		//n2이 제일 큰경우(n2>n1 && n2>n3)
//		//n3이 제일 큰경우(n3>n1 && n3>n2)
//		if(n1>=n2 && n1>=n3) 
//			System.out.println("큰 수 : " + n1);
//		
//		else if(n2>=n1 && n2>=n3)
//			System.out.println("큰 수 : " + n2);
//		
//		else
//			System.out.println("큰 수 : " + n3);
//	
//
//		sc.close();
		
		
//		//-----------------------
//		//4 문제
//		//-----------------------
//		// 세개의 정수를 입력받아 해당수의 합과 평균을 출력
//		Scanner sc = new Scanner(System.in);
//		System.out.print("세 개 정수 입력 : ");
//		int n1 = sc.nextInt();
//		int n2 = sc.nextInt();
//		int n3 = sc.nextInt();
//		
//		int sum = n1 + n2 + n3;
//		double avg = (double)sum/3;
//		
//		System.out.println("합 : " + sum + " 평균 : " + avg);
//		
//		sc.close();
		
		//-----------------------
		//5 문제
		//-----------------------
//		입력한 수가 짝수이고, 3의 배수라면 출력 (n%2==0 && n%3==0)
//		입력한 수가 홀수이고, 5의 배수라면 출력 (n%2==1 && n%5==0)
		
//		Scanner sc = new Scanner(System.in);
//		int n = sc.nextInt();
//
//		//01
////		if(n%2==0 && n%3==0)
////			System.out.printf("%d 는 짝수이면서 3의배수입니다\n",n);
////			
////		if(n%2==1 && n%5==0)
////			System.out.printf("%d 는 홀수이면서 5의배수입니다\n",n);
//		
//		if(n%2==0) {
//			
//			if(n%3==0)
//				System.out.printf("%d 는 짝수이면서 3의배수입니다\n",n);
//			
//		}else {
//			
//			if(n%5==0)
//				System.out.printf("%d 는 홀수이면서 5의배수입니다\n",n);
//		}
//		
//		sc.close();
		
		
		//-----------------------
		//IF - ELSE IF - ELSE
		//-----------------------
		//과목1,2,3,4 중 하나라도 40점 미만이면 불합격
		//과목평균이 100점만점 기준으로 60점 미만이면 불합격
		//아니면 합격
		
//		Scanner sc = new Scanner(System.in);
//		int 과목1 = sc.nextInt();
//		int 과목2 = sc.nextInt();
//		int 과목3 = sc.nextInt();
//		int 과목4 = sc.nextInt();
//		double 평균 = (double)(과목1 + 과목2 + 과목3 + 과목4)/4;
//		
//		if(과목1<40) {
//			System.out.println("불합격");
//		}
//		else if(과목2<40)	// 과목1>=40 && 과목2<40
//		{
//			System.out.println("불합격");
//		}
//		else if(과목3<40)	// 과목1>=40 && 과목2>=40 && 과목3<40
//		{
//			System.out.println("불합격");
//		}
//		else if(과목4<40) // 과목1>=40 && 과목2>=40 && 과목3>=40 && 과목4<40
//		{
//			System.out.println("불합격");
//		}
//		else if(평균<60) // 과목1>=40 && 과목2>=40 && 과목3>=40 && 과목4>=40 && 평균<60
//		{
//			System.out.println("불합격");
//		}
//		else // 과목1>=40 && 과목2>=40 && 과목3>=40 && 과목4>=40 && 평균>=60
//		{
//			System.out.println("합격");
//		}
		
		// 문제
		
		// 시험 점수를 입력받아
		// 90 ~ 100점은 A,
		// 80 ~ 89점은 B,
		// 70 ~ 79점은 C,
		// 60 ~ 69점은 D,
		// 나머지 점수는 F를 출력하는 프로그램을 작성하시오.
//		Scanner sc = new Scanner(System.in);
//		System.out.print("점수를 입력해주세요 : ");
//		int score = sc.nextInt();
//		
//		if (score > 89) {
//			System.out.println("A");
//		} else if(score > 79){
//			System.out.println("B");
//		} else if(score > 69){
//			System.out.println("B");
//		} else if(score >= 60){
//			System.out.println("C");
//		} else {
//			System.out.println("F");
//		}
//		sc.close();
		
		
		// 문제
		
		// 나이별로 요금을 부과하는 else if문을 만드세요
		// 8세 미만	: 요금은 1000원
		// 14세 미만	: 요금은 2000원
		// 20세 미만	: 요금은 2500원
		// 20세 이상	: 요금은 3000원
		Scanner sc = new Scanner(System.in);
		System.out.print("나이를 입력해주세요 : ");
		int age = sc.nextInt();
		if (age >= 20) {
			System.out.println("요금은 3000원");
		} else if (age >= 14) {
			System.out.println("요금은 2500원");
		} else if (age >= 8) {
			System.out.println("요금은 2000원");
		} else {
			System.out.println("요금은 1000원");
		}
		
	}

}

```

---

> **C02SWITCH**
> 

```jsx
package Ch06;

import java.util.Scanner;

public class C02SWITCH {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		System.out.print("몇 등입니까? ");
		int ranking = sc.nextInt();
		char medalColor;
		switch (ranking) {
		case 1:
			medalColor = 'G';
			System.out.println("메달색상 : G");
			break;
		case 2:
			medalColor = 'S';
			System.out.println("메달색상 : S");
			break;
		case 3:
			medalColor = 'B';
			System.out.println("메달색상 : B");
			break;
		default:
			medalColor = 'C';
			System.out.println("메달색상 : C");
		}
		System.out.println(ranking + "등 메달의 색은 " + medalColor + " 입니다.");
	}
}

```

---

> **C03SWITCH**
> 

```jsx
package Ch06;

import java.util.Scanner;

public class C03SWITCH {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int num = 0;
		while(true) {
			System.out.println("------------ JOIN MENU ------------");
			System.out.println("1 이메일 인증");
			System.out.println("2 개인정보 입력");
			System.out.println("3 회원가입 요청");
			System.out.println("4 종료");
			System.out.println("------------ MAIN MENU ------------");
			System.out.print("번호 입력 : ");
			num = sc.nextInt();
			switch(num) {
			case 1:
				System.out.println("이메일 인증처리 작업 - ");
				break;
			case 2:
				System.out.println("이메일 개인정보 입력 작업 - ");
				break;
			case 3:
				System.out.println("회원가입 처리 작업 - ");
				break;
			case 4:
				System.out.println("JOIN 메뉴 종료 - ");
				System.exit(-1);
				break;
			default:
				System.out.println("잘못된 메뉴번호를 입력하셨습니다 -");
				break;
			}
		}
	}
}

```

---

> **C01While**
> 

```jsx
package Ch07;

import java.util.Scanner;

public class C01While {

	public static void main(String[] args) {
		
		// 10번반복 - "HELLO WORLD"
		// 탈출용 변수 : i=0
		// 탈출용 조건식 : i<10
		// 탈출용 연산식 : i++
//		while(조건식) {
//			조건식이 true 인동안 실행되는 종속문장
//		}
		
		//01 기본 - HELLO WORLD 10회 반복
//		int i=0;
//		while(i<10) {
//			System.out.println("HELLO WORLD");
//			i++;
//		}
		
		//02 기본 - HELLO WORLD N회 반복
//		Scanner sc = new Scanner(System.in);
//		int n = sc.nextInt();
//		int i=0;
//		while(i<n) {
//			System.out.println("HELLO WORLD");
//			i++;
//		}
		
		//03 기본 - 1부터 10까지의 합
		
//		int i = 1;		//탈출용 변수
//		int sum = 0;	//누적합 변수
//		while(i<=10)	//탈출용 조건식 
//		{
//			System.out.println("i : " + i);
//			sum = sum + i;
//			i++;		//탈출용 연산식
//		}
//		System.out.println("SUM : " + sum);
		
		//04 기본 - 1부터 N까지 합
		
//		Scanner sc  = new Scanner(System.in);
//		int i = 1;		//탈출용 변수
//		int sum = 0;	//누적합 변수
//		int n = sc.nextInt();
//		while(i<=n)	//탈출용 조건식 
//		{
//			System.out.println("i : " + i);
//			sum = sum + i;
//			i++;		//탈출용 연산식
//		}
//		System.out.println("SUM : " + sum);	
		
		
		//05 기본 - N부터 M까지 합(N<M) - N>=M 인경우 N과 M을 Swap하고 진행합니다
		
//		Scanner sc  = new Scanner(System.in);
//
//		int n = sc.nextInt();	//시작값
//		int m = sc.nextInt();	//종료값
//		
//		if(n>=m) {
//			//잘못 입력한경우(시작값(n)이 끝값(m)보다 큰경우 , (5,3)...)
//			int tmp = n;
//			n = m;
//			m = tmp;
//		}
//		
//		int i = n;		//탈출용 변수
//		int sum = 0;	//누적합 변수
//		while(i<=m)	//탈출용 조건식 
//		{
//			System.out.println("i : " + i);
//			sum += i;		//sum = sum + i; 
//			i++;		//탈출용 연산식
//		}
//		System.out.println("SUM : " + sum);	
		
		
		//06 N - M까지 수중(N<M) 짝수의합, 홀수의 합을 각각 구해서 출력하세요
		//예시)
		//n= 3(키보드로 입력된 값)
		//m = 7(키보드로 입력된 값)
		//짝수의 합 : 10
		//홀수의 합 : 15
//		Scanner sc = new Scanner(System.in);
//		System.out.print("n값 과 m값 입력해주세요 : ");
//		int n = sc.nextInt();
//		int m = sc.nextInt();
//		if (n>=m) {
//			int tmp = n;
//			n = m;
//			m = tmp;
//		}
//		int i = n;
//		int odd_sum = 0;		// 홀수합
//		int even_sum = 0;		// 짝수합
//		while(i<=m) {
//			System.out.println("i : " + i);
//			if(i%2==0)
//				even_sum+=i;
//			else
//				odd_sum+=i;
//			i++;
//		}
//		System.out.println("짝수 합 : " + even_sum);
//		System.out.println("홀수 합 : " + odd_sum);
		
		
		//07 1 - N 까지 수중에 4의 배수를 출력하고 4의배수가 아닌 나머지의 합을 구하세요
//		Scanner sc = new Scanner(System.in);
//		System.out.print("n값 입력해주세요 : ");
//		int n = sc.nextInt();
//		int i = 1;
//		int sum = 0;
//		while(i<=n) {
//			if(i % 4 == 0)
//				System.out.println("i : " + i);
//			else
//				sum += i;
//			i++;
//		}
//		System.out.println("sum : " + sum);
		
		//08 구구단 N단을 출력합니다(2<=N<=9)
		Scanner sc = new Scanner(System.in);
		System.out.print("n 입력 : ");
		int n = sc.nextInt();
		while(n<2 || n>9) {
			System.out.print("구구단의 범위는 2 - 9 사이값을 입력하셔야됩니다");
			System.out.print("n 입력 : ");
			n = sc.nextInt();
		}
		int i =1;
		while(i<10) {
			System.out.printf("%d X %d = %d\n",n,i,n*i);
			i++;
		}
	}
}

```

---