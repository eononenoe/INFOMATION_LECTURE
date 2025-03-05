# 01

> **정리**
> 

```jsx
모든 인자 받는 생성자 = 객체를 만들 때 한 번에 모든 값을 설정할 수 있게 해줍니다.
public Profile(String name, String addr, String job, String major) {}
가변인자  = 가변 인자는 메서드나 생성자에서 입력되는 값의 개수가 다를 수 있도록 해줍니다.
public Profile(String... args) {}

getter
정보를 알고 싶을 때: "책의 제목이 뭐야?" → 이럴 때 getTitle()과 같은 getter를 사용
setter
정보를 바꾸고 싶을 때: "책 제목을 바꾸고 싶어" → 이럴 때 setTitle("새로운 제목")과 같은 setter를 사용
```

---

> **C09Ex**
> 

```jsx
package Ch08;

import java.util.Scanner;

//--------------------------------------------
//문제 - 이것이자바다
//--------------------------------------------
//https://scksk.tistory.com/6

//클래스 기본문제
//1~7번 확인하기 

//12번-16번 확인하기

//--------------------------------------------
//--추가(명품자바)
//--------------------------------------------
//https://security-nanglam.tistory.com/213

//--------------------------------------------
//--추가
//--------------------------------------------
//https://iu-corner.tistory.com/entry/JAVA-%EC%9E%90%EB%B0%94-%ED%81%B4%EB%9E%98%EC%8A%A4-%EC%97%B0%EC%8A%B5-%EB%AC%B8%EC%A0%9C-%EB%AA%A8%EC%9D%8C-1

class TV{
	private String name;
	private int year;
	private int size;
	
	TV(String name,int year,int size){
		this.name = name;
		this.year = year;
		this.size = size;
	}
	
	public void show( ) {
	System.out.println(name+"에서 만든 "+year+"년형 "+size+"인치"+name);	
	}
}

class Grade{
	private int math;
	private int science;
	private int english;
	
	Grade(int math,int science,int english){
		this.math = math;
		this.science = science;
		this.english = english;
	}
	public int average() {
		return(math + science + english) / 3;
	}
}

public class C09Ex {
	public static void main(String[] args) {
		TV myTv = new TV("LG",2017,32);
		myTv.show();
		
		System.out.println("---------------");
		
		Scanner sc = new Scanner(System.in);
		System.out.print("수학, 과학, 영어 순으로 3개의 정수 입력>>");
		int math = sc.nextInt();
		int science = sc.nextInt();
		int english = sc.nextInt();
		Grade me = new Grade(math,science,english);
		System.out.println("평균은 "+me.average());
		sc.close();
		
		System.out.println("---------------");

	}
}

```

---

> **C01정보은닉**
> 

```jsx
package Ch09;

//접근 한정자
//멤버 / 클래스의 접근범위를 제한을 위한 예약어
//public		: 모든 클래스에서 접근가능
//private		: 해당 클래스에서만 접근가능
//protected		: 상속 관계를 가지는 경우에 접근가능
//default(기본)	: 동일 패키지에 속한 클래스에서 접근가능

class C01Person{
	private String name;
	private int age;
	String addr;
	public C01Person(String name, int age, String addr) {
		super();
		this.name = name;
		this.age = age;
		this.addr = addr;
	}
	//getter 함수(데이터를 외부로 반환)
	public String getName() {
		return this.name;
	}
	//setter 함수(기존데이터를 수정)
	public void setAge() {
		this.age = age;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public void setName(String name) {
		this.name = name;
	}
}

public class C01정보은닉 {
	public static void main(String[] args) {
		C01Person person1 = new C01Person("홍길동",55,"대구");
		System.out.println(person1.getName());
		
	}
}

```

---

> **C02캡슐화**
> 

```jsx
package Ch09;

//캡슐화란
//특정 목적을 가지는 기능을 구현하는데 필요한 세부기능들을 묶어서 처리하는 방법
//특정 목적을 가지는 기능 구현에 있어서 각 과정의 일부나 전부가 외부로 노출되는 문제 막기 위해
//정보은닉을 수반한다(필수는 아님)
//캡슐화 작업은 각 공정과정에 대한 정확한 이해가 수반되어야 한다

class Engine{
	private void 흡입() {System.out.println("외부로부터 공기를 빨아들인다");}
	private void 압축() {System.out.println("가둔 공기를 압축시킨다");}
	private void 폭발() {System.out.println("일정 수준압축되면 폭발!");}
	private void 배기() {System.out.println("가스를 외부로 보낸다");}
	//캡슐화
	public void EngineStart() {
		흡입();
		압축();
		폭발();
		배기();
	}
}
class Car{
	Engine engine;
	Car(){
		engine = new Engine();
	}
	void run() {
		engine.EngineStart();
	}

}
public class C02캡슐화 {
	public static void main(String[] args) {
		Car car = new Car();
		car.run();
	}
}
```

---

> **C03This**
> 

```jsx
package Ch09;

//this
//클래스 내에서 사용되는 예약어
//생성되는 객체의 위치정보(메모리주소-해시코드값)을 확인하는데 사용

//this : 멤버변수와 지역변수 구별에 사용
//this : 다른생성자 호출 사용

class C03Simple{
	int x;
	int y;
	C03Simple(){
		this(0,0);
		System.out.println("C03Simple()...생성자 호출");
	}
	C03Simple(int x){
		this(x,0);
		System.out.println("C03Simple(int x)...생성자 호출");
//		this.x = x;
	}
	C03Simple(int x, int y){
		System.out.println("C03Simple(int x,int y)...생성자 호출");
		this.x = x;
		this.y = y;
	}
	
	C03Simple getThis() {
		return this;
	}
}
public class C03This {
	public static void main(String[] args) {
		C03Simple ob = new C03Simple();
		System.out.println(ob);
		System.out.println(ob.getThis());
	}
}

```

---

> **C04StringClass**
> 

```jsx
package Ch09;

public class C04StringClass {
	public static void main(String[] args) {
		String str1 = "java";
		String str2 = "java";
		String str3 = new String("java");
		String str4 = new String("java");
		
		System.out.printf("%X\n",System.identityHashCode(str1));
		System.out.printf("%X\n",System.identityHashCode(str2));
		System.out.printf("%X\n",System.identityHashCode(str3));
		System.out.printf("%X\n",System.identityHashCode(str4));
		System.out.println("--------------");
		System.out.println("str1==str2 ? " + (str1==str2));
		System.out.println("str3==str4 ? " + (str3==str4));
		System.out.println("str1==str3 ? " + (str1==str3));
		System.out.println("str2==str4 ? " + (str2==str4));
		System.out.println("--------------");
		System.out.println("str1==str2 ? " + (str1.equals(str2)));
		System.out.println("str3==str4 ? " + (str3.equals(str4)));
		System.out.println("str1==str3 ? " + (str1.equals(str3)));
		System.out.println("str2==str4 ? " + (str2.equals(str4)));
	}
}

```

---

> **C05StringClass**
> 

```jsx
package Ch09;

public class C05StringClass {
	public static void main(String[] args) {
		String str1 = "Java Powerful";
		String str2 = new String("java Programming");
		String str3 = str1 + str2;
		String str4 = str1.concat(str2);
//		
//		System.out.printf("%x\n",System.identityHashCode(str1));
//		System.out.printf("%x\n",System.identityHashCode(str2));
//		System.out.printf("%x\n",System.identityHashCode(str3));
//		System.out.printf("%x\n",System.identityHashCode(str4));
		
//		int i=0;
//		String str  = "";
//		while(i<10) {
//			str +=i;
//			System.out.print("str : " + str + " ");
//			System.out.printf("위치 : %x\n",System.identityHashCode(str));
//			i++;
//		}
		
		//문자열 덧붙이기(메모리 누수 방지 클래스 : StringBuffer , StringBuilder)
		
//		int i=0;
////		String str  = "";
//		StringBuilder str = new StringBuilder("");
//		while(i<10) {
////			str +=i;
//			str.append(i);
//			System.out.print("str : " + str + " ");
//			System.out.printf("위치 : %x\n",System.identityHashCode(str));
//			i++;
//		}
		
		System.out.println("문자열 길이 : " + str1.length());
		System.out.println("한문자 찾기 : " + str1.charAt(2));
		
		System.out.println("인덱스 찾기 : " + str1.indexOf('a'));
		System.out.println("인덱스 찾기 : " + str1.lastIndexOf('a'));
		
		System.out.println("문자열포함 여부 : " + str1.contains("va"));
		System.out.println("문자열포함 여부 : " + str1.contains("abs"));
		
		System.out.println("문자열 자르기 : " + (str1.substring(2,6)));
		
		String str6 = "등산,탁구,축구,골프,독서,영화감상";
		String [] result = str6.split(",");
		
		for(String hobby : result)
			System.out.println(hobby);
	}
}

```

---

> **C06Ex**
> 

```jsx
package Ch09;

class Profile{
	//속성
	String name;
	String addr;
	String job;
	String major;
	//생성자
	//1)디폴트생성자 삽입
	public Profile(){}
	//2)모든 인자 받는 생성자 삽입 -> 각멤버에 대입
	public Profile(String name, String addr, String job, String major) {
		super();
		this.name = name;
		this.addr = addr;
		this.job = job;
		this.major = major;
	}
	
	//3)모든 인자 받는 생성자 삽입(가변인자사용할것) -> , 를기준으로 잘라내어 각속성에 저장
	//ex, "홍길동,대구,프로그래머,컴퓨터공학" ->[홍길동,대구,프로그래머,컴퓨터공학]
	public Profile(String ...args) {
		this.name = args[0];
		this.addr = args[1];
		this.job = args[2];
		this.major = args[3];
	}
	public Profile(String all) {
		String [] arr =  all.split(",");
		this.name = arr[0];
		this.addr = arr[1];
		this.job = arr[2];
		this.major = arr[3];	
	}	
	//기능
	//1) getter and setter 삽입
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	//2) toString  재정의 
	@Override
	public String toString() {
		return "Profile [name=" + name + ", addr=" + addr + ", job=" + job + ", major=" + major + "]";
	}
	
	//3) boolean isContain(String findstr) 함수 완성하기
	boolean isContain(String findstr) {
		//findstr의 문자열이 각멤버인 name,addr,job,major 중 하나라도 포함되어 있으면 true 리턴
		//아니면 false 리턴
		if(this.name.contains(findstr)) {
			return true;
		}else if(this.addr.contains(findstr)) {
			return true;
		}else if(this.job.contains(findstr)) {
			return true;
		}else if(this.major.contains(findstr)) {
			return true;
		}else {
			return false;	
		}
	}

	//4)
	boolean isEquals(String str) {
		//all로 받은 문자열을 , 단위로 잘라내어(split(",")) 각각 나눠진 문자열이
		//"name,addr,job,major" 와 일치 하면 true
		//아니면 false 를 리턴
		String [] arr = str.split(",");
		if(
			arr[0].equals(this.name) &&
			arr[1].equals(this.addr) &&
			arr[2].equals(this.job) &&
			arr[3].equals(this.major)
				
				) {
			return true;
		}
		return false;
	}
	
}

public class C06Ex {

	public static void main(String[] args) {
		Profile hong = new Profile("홍길동,대구,프로그래머,컴퓨터공학");
		System.out.println(hong.toString());
		System.out.println("길동 포함여부 : " + hong.isContain("길동"));	//true
		System.out.println("컴퓨터 포함여부 : " + hong.isContain("컴퓨터"));	//true
		System.out.println("프로필 일치여부 : " + hong.isEquals("홍길동,대구,프로그래머,컴퓨터공학"));//false
		System.out.println("프로필 일치여부 : " + hong.isEquals("홍길동,울산,프로그래머,컴퓨터공학"));//false
	}

}

```

---

> **C01ArrayMain**
> 

```jsx
package Ch10;

import java.util.Arrays;
import java.util.Scanner;

public class C01ArrayMain {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int[] arr1 = new int[5];
		System.out.println("5개의 값을 입력해주세요");
		arr1[0] = sc.nextInt();
		arr1[1] = sc.nextInt();
		arr1[2] = sc.nextInt();
		arr1[3] = sc.nextInt();
		arr1[4] = sc.nextInt();

//		for(int i=0;i<arr1.length;i++) {
//			System.out.println(i + "." + arr1[i]);
//		}
//		System.out.println("----------------");
//		for(int el : arr1) {
//			System.out.println(el);
//		}
//		System.out.println("----------------");
//		Arrays.stream(arr1).forEach(el->System.out.println(el));
//		Arrays.stream(arr1).forEach(System.out::println);
//		System.out.println("----------------");

		// 배열에 입력된 정수중에 최대값과 최소값을 출력
		int max = arr1[0];
		int min = arr1[0];
		for (int i = 0; i < arr1.length; i++) {
			if (arr1[i] > max) {
				max = arr1[i];
			}
			if (arr1[i] < min) {
				min = arr1[i];
			}
		}

		// 결과 출력
		System.out.println("최대값: " + max);
		System.out.println("최소값: " + min);

	}
}

```

---

> **C02ArrayMain**
> 

```jsx
package Ch10;

import java.util.Arrays;

public class C02ArrayMain {
	public static void main(String[] args) {
		// 얕은복사(주소복사)
		int arr1[] = { 10, 20, 30 };
		int arr2[];
		arr2 = arr1;
		arr1[0] = 100;

		Arrays.stream(arr1).forEach(System.out::println);
		System.out.println("--------------------------");
		Arrays.stream(arr2).forEach(System.out::println);

		// 깊은복사(값복사)
		int arr3[] = new int[3];
		for (int i = 0; i < arr1.length; i++)
			arr3[i] = arr1[i];
		
		//Arrays API
		int arr4[] = Arrays.copyOf(arr1,arr1.length);
		
		System.out.println("arr1 : " + arr1);
		System.out.println("arr2 : " + arr2);
		System.out.println("arr3 : " + arr3);
		System.out.println("arr4 : " + arr4);
	}
}

```

---

> **C03ArrayMain**
> 

```jsx
package Ch10;

public class C03ArrayMain {
	public static void main(String[] args) {
		int arr[][] = {
				{10,20,30},
				{40,50,60,65,67},
				{70,80,90,96,11,56},
				{100,110,120,15,22,33,44},
		};
		System.out.println("행의 길이 : " + arr.length);
		System.out.println("행의 길이 : " + arr[0].length);		
		System.out.println("행의 길이 : " + arr[1].length);		
		System.out.println("행의 길이 : " + arr[2].length);		
		System.out.println("행의 길이 : " + arr[3].length);		
		System.out.println("행의 길이 : " + arr[0][1]);
		System.out.println("행의 길이 : " + arr[2][4]);
	}
}

```

---

> **C04ClassArrayMain**
> 

```jsx
package Ch10;

class C04Person{
	String name;
	int age;
	//디폴트생성자
	public C04Person(){}
	
	//모든인자생성자
	public C04Person(String name, int age) {
		super();
		this.name = name;
		this.age = age;
	}
	
	//toString 재정의
	@Override
	public String toString() {
		return "C04Person [name=" + name + ", age=" + age + "]";
	}
	
}

public class C04ClassArrayMain {

	public static void main(String[] args) {
		C04Person list[] = new C04Person[3];
		list[0] = new C04Person();
		list[0].name="홍길동";
		list[0].age=55;
		
		list[1] = new C04Person();
		list[1].name="김영희";
		list[1].age=35;
		
		list[2] = new C04Person();
		list[2].name="김범수";
		list[2].age=40;
		
		for(C04Person person : list)
			System.out.println(person);
	}

}

```

---