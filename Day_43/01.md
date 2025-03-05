# 01

> **02While**
> 

```jsx
package Ch07;

import java.util.Scanner;

public class C02While {
	
	public static void main(String[] args) {
		//*******
		// *****
		//  ***
		//   *		
		//   *
		//  ***
		// *****		
		//*******
		
		
		int i=0;
		while(i<7) {
			
			if(i<4) {
				//공백
				int j=0;
				while(j<i) {
					System.out.print(" ");
					j++;
				}
				//별
				int k=0;
				while(k<=6-2*i) {
					System.out.print("*");
					k++;
				}				
			}else {
				//공백
				int j=0;
				while(j<6-i) {
					System.out.print(" ");
					j++;
				}
				//별
				int k=0;
				while(k<=2*i-6) {
					System.out.print("*");
					k++;
				}	
			}
			
			System.out.println();
			i++;
		}
	}
}

```

---

> **C03Continue_Break**
> 

```jsx
package Ch07;

import java.util.Scanner;

public class C03Continue_Break {

	public static void main(String[] args) {

		//--------------------------
		// 1 break
		//--------------------------
		// -1을 입력하기 전까지 정수값을 누적하여 합을 구하고 출력
//		Scanner sc = new Scanner(System.in);
//		int n;
//		int sum = 0;
//		while(true) {
//			
//			n=sc.nextInt();
//			if(n==-1)
//				break;
//			
//			sum+=n;
//		}
//		System.out.println("SUM : " + sum);
//		
//		sc.close();
		//--------------------------
		// 모든 반복문 탈출 : flag
		//--------------------------
		// 7 x 7 = 49 출력 이후 모든 반복문 탈출
//		boolean flag = false;
//		int dan = 2;
//		while (dan < 10) {
//			
//			int i = 1;
//			while (i < 10) {
//				System.out.printf("%d x %d = %d\n", dan, i, dan * i);
//				// 7 x 7 = 49 출력 이후 모든 반복문 탈출
//				if(dan==7 && i==7) {
//					flag=true;
//					break;
//				}
//				i++;
//			}
//			
//			System.out.println();
//
//			if(flag)
//				break;
//			dan++;
//		}
		
		//--------------------------
		// :EXIT
//		//--------------------------
//		int dan = 2;
//		
//		Exit:
//		while (dan < 10) {
//			
//			int i = 1;
//			while (i < 10) {
//				System.out.printf("%d x %d = %d\n", dan, i, dan * i);
//				// 7 x 7 = 49 출력 이후 모든 반복문 탈출
//				if(dan==7 && i==7) {
//					break Exit;
//				}
//				i++;
//			}
//	
//			System.out.println();
//			dan++;
//		}
		
		//--------------------------
		// continue
		//--------------------------
		// 1부터 10까지의 수중에 3의 배수를 제외한 합 출력
		int i=1;
		int sum = 0;
		while(i<=10) {
			
			if(i%3==0) {
				i++;
				continue;
			}
			System.out.println("i : " + i);
			sum+=i;
			i++;
		}
		System.out.println("SUM : " + sum);
		

		
	}

}

```

---

> **C04For**
> 

```jsx
package Ch07;

public class C04For {

	public static void main(String[] args) {

		
//		int i=0;	//탈출용 변수 선언
//		while(i<10) //탈출용 조건식
//		{
//			System.out.println("HELLO WORLD");
//			i++;	//탈출용 연산식
//		}
		
//		for(int i=0;i<10;i++){
//			System.out.println("HELLO WORLD");
//		}
		
		//1-10까지합
		//1-N까지합
		//N-M까지합(N<M)
		//2단 구구간
		//N단 구구단(2<=N<=9)
		//2-9 구구단
		//2-N 구구단
		//N-M 구구단
		//별찍기
		
		
//		int i=0;
//		while(i<4) {
//			int j=0;
//			while(j<i+1) {	
//				System.out.print("*");
//				j++;
//			}
//			System.out.println();
//			i++;
//		}
		
//		for(int i=0;i<4;i++) {	
//			for(int j=0;j<i+1;j++) 
//				System.out.print("*");
//			System.out.println();
//		}
		
		
		
//		int i=0;
//		while(i<4) {
//			//공백
//			int j=0;
//			while(j<3-i) {
//				System.out.print(" ");
//				j++;
//			}
//			//별
//			int k=0;
//			while(k<=2*i) {
//				System.out.print("*");
//				k++;
//			}
//			System.out.println();
//			i++;
//		}
		
		for(int i=0;i<4;i++) {
			for(int j=0;j<3-i;j++) {
				System.out.print(" ");
			}
			for(int k=0;k<=2*i;k++) {
				System.out.print("*");
			}
			System.out.println();
		}
		

	}

}

```

---

> **C05기타반복처리**
> 

```jsx
package Ch07;

import java.util.ArrayList;
import java.util.List;

public class C05기타반복처리 {
	public static void main(String[] args) {
		//Collection 객체를 이용 - 저장
		List<String> lists = new ArrayList();
		lists.add("JAVA");
		lists.add("JSP/SERVLET");
		lists.add("SPRING STS");
		lists.add("SPRINGBOOT");
		lists.add("REACT");
		lists.add("ORACLE");
		
		//기본 for
		for(int i=0;i<lists.size();i++) {
			System.out.println(lists.get(i));
		}
		System.out.println("----------------");
		//개량 for
		for(String subject : lists) {
			System.out.println(subject);
		}
		System.out.println("----------------");
		//Stream forEach
		lists.stream().forEach((item)->{System.out.println(item);});
	}

}

```

---

> **00INFO**
> 

```jsx
package Ch08;

public class C00INFO {
	//1 객체 - Object
	// 존재(독점적이고 배타적인 공간을 차지)하는 사물(Object)
	
	//2 객체
	//속성(Attribute) : 객체마다 구별되는 데이터(저장 - 변수처리)
	//기능(Function) : 객체가 수행할 수 있는 공통 Action(기능 - 매서드 처리)
	
	//3 객체 지향
	//현실 세계의 여러 객체의 정보(속성/기능)중에 필요한 일부만 추출(추상화)하여
	//문제 해결을 하기 위한 요소단위로 적재(저장)하기 위해 고안된 문법
	
	//4 클래스?
	// 동일한 종류의 객체에 필요한 메모리공간을 제공하기 위해 선언된 자료형
	// 클래스로 객체를 생성하기 전에는 기본적으로 메모리공간을 차지하지 않는다
	
	//(Document화)
	// 클래스 자료형에 의해 객체가 정의되는 순간 클래스에서 선언한 속성과 기능대로
	// 공간형성이 이루어 진다
	
	//5 자바의 메모리 영역
	//1) 스택영역				: {} 내세에서 생성되고 소멸되는 영역(int,double..)
	//2) 클래스영역(==메서드)영역	: 공유메모리 영역(생성자, 일반메서드, static메서드, static변수)
	//3) 힙영역				: 객체 저장 영역(new 예약어 사용시 할당)

	//6 코드 해석
	//Scanner sc = new Scanner(System.in);
	
	//new		: 힙(Heap) 영역에 객체 저장
	//Scanner	: 객체에 필요한 초기값을 부여하기 위한 생성자메서드
	//Scanner sc : Scanner라는 클래스 자료형으로 정의된 참조변수 sc
	
	// 힙메모리 영역에 Scanner에 필요한 초기값이 담긴 객체를 생성하고
	// 현위치(main stack)에 Scanner 자료형으로 만든 sc 참조변수에 생성된 Scanner 객체의
	// "시작 메모리 주소"를 저장
	
}

```

---

> **C01Main**
> 

```jsx
package Ch08;

public class C01Main {
	public static void main(String[] args) {
		C01Person hong = new C01Person();
		hong.name = "홍길동";
		hong.age = 15;
		hong.height = 177.5f;
		hong.weight = 70.5;
		
		System.out.printf("%s %d %f %f\n",hong.name, hong.age, hong.height, hong.weight);
	}

}

```

---

> **C01Person**
> 

```jsx
package Ch08;

public class C01Person {
	// 속성
	String name;
	int age;
	float height;
	double weight;
}

```

---

> **C02PersonMain**
> 

```jsx
package Ch08;

class C02Person {
	// 속성
	String name;
	int age;
	float height;
	double weight;
}

public class C02PersonMain {
	public static void main(String[] args) {
		C02Person hong = new C02Person();
		hong.name = "홍길동";
		hong.age = 15;
		hong.height = 177.5f;
		hong.weight = 70.5;
		
		System.out.printf("%s %d %f %f\n",hong.name, hong.age, hong.height, hong.weight);

	}
}

```

---

> **C03PersonMain**
> 

```jsx
package Ch08;

class C03Person {
	// 속성
	String name;
	int age;
	float height;
	double weight;
	// 기능
	void talk() {System.out.printf("%s 님이 말합니다.\n",this.name);}
	void walk() {System.out.printf("%s 님이 걷습니다.\n",this.name);}
	// 속성정보 확인
	void showInfo() {
		System.out.printf("%s %d %f %f\n",this.name, this.age, this.height, this.weight);
	}
	// 객체정보 확인(toString)
	@Override
	public String toString() {
		return "C03Person [name=" + name + ", age=" + age + ", height=" + height + ", weight=" + weight + "]";
	}
}

public class C03PersonMain {
	public static void main(String[] args) {
		C03Person hong = new C03Person();
		hong.name = "홍길동";
		hong.age = 15;
		hong.height = 177.5f;
		hong.weight = 70.5;
		
		hong.talk();
		hong.walk();
		hong.showInfo();
		
		System.out.println(hong.toString());
		System.out.println(hong);

	}
}

```

---

> **C04MethodMain**
> 

```jsx
package Ch08;

import java.util.Scanner;

class MethodTest {
	// 속성
	Scanner sc = new Scanner(System.in);
	
	// 기능
	public int sum1(int n1, int n2) {
		return n1 + n2;
	}
	public int sum2() {
		return sc.nextInt() + sc.nextInt();
	}
	public void sum3(int n1, int n2) {
		System.out.println(n1 + n2);
	}
	public void sum4() {
		System.out.println(sc.nextInt() + sc.nextInt());
	}
}
public class C04MethodMain {
	public static void main(String[] args) {
		MethodTest sumCalc = new MethodTest();
		System.out.println(sumCalc.sum1(10,20));
		System.out.println(sumCalc.sum2());
		sumCalc.sum3(10,20);
		sumCalc.sum4();
	}
}
```

---

> **C05LocalVarMain**
> 

```jsx
package Ch08;

// 멤버변수		: 클래스 내부에서 - 메서드영역 바깥에서 생성
//				  생성된 객체의 개별 정보 저장

//	static 변수	: 동일 클래스로부터 만든 여러객체간 공유하는 멤버변수

// 지역변수		: 매서드 영역내(파라미터, 매개변수도 포함)에서 
//				  (or 매서드 영역내의 {}범위에서 포함)
//				  생성되는 변수
//				  (파라미터, 일반변수)

class C05Simple{
	int num=10;	//멤버변수
	void Func1() {
		System.out.println("멤버변수 num : " + num);
		int num=5;
		System.out.println("Func1's 지역변수 num : " + num);
		num++;
		this.num++;
	}
	
	void Func2() {
		System.out.println("멤버변수 num : " + num);
		if(true) {
			int num = 100;
			System.out.println("Func2's if안 지역변수 num : " + num);
		}
		System.out.println("num : " + num);
		while(num<15) {
			System.out.println("Func2's while안 멤버변수num : " + num);
			num++;
		}
	}
	void Func3(int num) {
		this.num = num;
		System.out.println("Func3's num : " + num);
	}
}

public class C05LocalVarMain {
	public static void main(String[] args) {
		C05Simple obj = new C05Simple();
		obj.Func1();
		obj.Func2();
		obj.Func3(30);
	}
}

```

---

> **C06MethodOverloadingMain**
> 

```jsx
package Ch08;

class C06Simple{
	int sum(int x, int y) {
		System.out.println("int sum(int x, int y");
		return x + y;
	}
	int sum(int x, int y, int z) {
		System.out.println("int sum(int x, int y, int z)");
		return x + y + z;
	}
	int sum(double x, double y, double z) {
		System.out.println("int sum(double x, double y, double z");
		return (int)(x + y + z);
	}
}

public class C06MethodOverloadingMain {
	public static void main(String[] args) {
		C06Simple obj = new C06Simple();
		obj.sum(10, 20);
		obj.sum(10, 20, 30);
		obj.sum(10.5, 20.5, 30.5);
		C06Simple obj2 = new C06Simple();
		
	}
}

```

---

> **C07가변인자**
> 

```jsx
package Ch08;

class C07Simple{
	
	int sum(int ...arg) {
		System.out.println(arg);
		int s=0;
		for(int item : arg) {
			System.out.println(item);
			s+=item;
		}
		return s;
	}
}

public class C07가변인자 {

	public static void main(String[] args) {
		C07Simple ob = new C07Simple();
		ob.sum(10,20,30,40,50);
		System.out.println();
		ob.sum(10,20,30,40,50,80,90,100,110);
		
	}

}

```

---

> **C08ConstructorMain**
> 

```jsx
package Ch08;

//생성자메서드
//객체 생성시 한번만 호출되는 메서드
//생성된 객체 내에서는 사용이 불가능
//객체 생성시에 필요한 메모리공간 형성과 "초기값 부여"에 사용
//생성자 메서드 이름은 클래스 이름과 동일하며 반환자료형은 가지지 않는다

// 생성자 함수를 클래스 내에 명시하지 않으면(코드삽입x) 컴파일러에 의해 주입되는
// 생성자가 있는데 이를 디폴트 생성자 한다

class C08Simple {
	// 속성
	int n1;
	double n2;
	boolean n3;
	String n4;

	C08Simple(){
		System.out.println("C08Simple() 생성자 호출 - 디폴트생성자");
	}
	C08Simple(int n1) {
		this.n1 = n1;
		System.out.println("C08Simple(int n1) 생성자 호출!");
	}

	C08Simple(int n1, double n2) {
		this.n1 = n1;
		this.n2 = n2;
		System.out.println("C08Simple(int n1,double n2) 생성자 호출!");
	}

	C08Simple(int n1, double n2, boolean n3) {
		this.n1 = n1;
		this.n2 = n2;
		this.n3 = n3;
		System.out.println("C08Simple(int n1,double n2,boolean n3) 생성자 호출!");
	}
//	C08Simple(int n1,double n2,boolean n3,String n4) {
//		this.n1 = n1;
//		this.n2 = n2;
//		this.n3 = n3;
//		this.n4 = n4;
//		System.out.println("C08Simple(int n1,double n2,boolean n3,String n4) 생성자 호출!");
//	}
	public C08Simple(int n1, double n2, boolean n3, String n4) {
		super();
		this.n1 = n1;
		this.n2 = n2;
		this.n3 = n3;
		this.n4 = n4;
	}
	// toString재정의
	@Override
	public String toString() {
		return "C08Simple [n1=" + n1 + ", n2=" + n2 + ", n3=" + n3 + ", n4=" + n4 + "]";
	}

}

public class C08ConstructorMain {

	public static void main(String[] args) {
		C08Simple ob0 = new C08Simple();
		
		C08Simple ob1 = new C08Simple(10);
		C08Simple ob2 = new C08Simple(10, 10.5);
		C08Simple ob3 = new C08Simple(10, 10.5, true);
		C08Simple ob4 = new C08Simple(10, 10.5, true, "홍길동");

		System.out.println(ob1);
		System.out.println(ob2);
		System.out.println(ob3);
		System.out.println(ob4);
	}

}

```

---