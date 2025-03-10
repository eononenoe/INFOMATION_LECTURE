# 01

> **C04InterfaceMain**
> 

```java
package Ch13;

interface Tire{
	void run();
}
class 한국타이어 implements Tire{
	public void run(){System.out.println("한국타이어가 굴러갑니다");};
}
class 금호타이어 implements Tire{
	public void run(){System.out.println("금호타이어가 굴러갑니다");};
}
class Car{
	Tire FL;
	Tire FR;
	Tire BL;
	Tire BR;
	Car(){
		FL = new 한국타이어();
		FR = new 한국타이어();
		BL = new 한국타이어();
		BR = new 한국타이어();
	}
	void start() {
		FL.run();
		FR.run();
		BL.run();
		BR.run();
	}
	
}
public class C04InterfaceMain {
	
	public static void main(String[] args) {
		Car car = new Car();
		car.start();
		car.FL = new 금호타이어();
		car.BR = new 금호타이어();
		System.out.println();
		car.start();		
	}
	
}

```

---

> **C05InterfaceMain**
> 

```jsx
package Ch13;

interface A{
	void ab();
}
interface B{
	void ab();
}

class C{
	
}
class D{

}
class E extends C implements A,B{

	@Override
	public void ab() {
		System.out.println("ABAB");
	}

}

public class C05InterfaceMain {

	public static void main(String[] args) {
		E ob = new E();
		ob.ab();
	}
}

```

---

> **C01ObjectMain**
> 

```jsx
package Ch14;

class A{
	int x;
	int y;
	
	@Override
	public String toString() {
		return "A [x=" + x + ", y=" + y + "]";
	}
	
	
}

public class C01ObjectMain {

	public static void main(String[] args) {
		A ob1 = new A();
		System.out.println(ob1);
		System.out.println(ob1.toString());
		
		
		Object ob2 = new Object();
		System.out.println(ob2);
		System.out.println(ob2.toString());	
		

	}

}

```

---

> **C02ObjectMain**
> 

```jsx
package Ch14;

class C02Simple{
	int n;
	C02Simple(int n){
		this.n = n;
	}
	@Override
	public boolean equals(Object obj) {
		//		
		if(obj instanceof C02Simple) {
			C02Simple down = (C02Simple)obj;
			return this.n==down.n;
		}
		
		return false;
	}
	
}
public class C02ObjectMain {
	public static void main(String[] args) {
		C02Simple ob1 = new C02Simple(10);
		C02Simple ob2 = new C02Simple(10);
		C02Simple ob3 = new C02Simple(20);
	
		
		System.out.println(ob1.equals(ob2));
		System.out.println(ob1.equals(ob3));
		
		String str1 = new String("JAVA");
		String str2 = new String("JAVA");
		System.out.println(str1.equals(str2));
		
	}

}

```

---

> **C03ObjectMain**
> 

```jsx
package Ch14;

import java.util.Objects;

class C03Simple{
	int n;
	C03Simple(int n){
		this.n = n;
	}
	
	@Override
	public boolean equals(Object obj) {
		//		
		if(obj instanceof C03Simple) {
			C03Simple down = (C03Simple)obj;
			return this.n==down.n;
		}
		
		return false;
	}

	@Override
	public int hashCode() {
		return  Objects.hash(this.n);
	}
}
public class C03ObjectMain {
	
	public static void main(String[] args) {
		C03Simple ob1 = new C03Simple(1);
		System.out.println(ob1.toString());
		System.out.printf("%x\n",System.identityHashCode(ob1));
		
		C03Simple ob2 = new C03Simple(9);
		System.out.println(ob2.toString());
	}
}

```

---

> **C04WrapperMain**
> 

```jsx
package Ch14;

public class C04WrapperMain {

	public static void main(String[] args) {
		//Boxing(기본자료형 -> Wrapper Class)
		Integer ob1 = new Integer(100);
		Integer ob2 = new Integer("100");
		Integer ob3 = Integer.valueOf("300");
		System.out.println(ob1 + ob2 + ob3);
		
		//UnBoxing
		int n1 = ob1.intValue();
		int n2 = ob2.intValue();
		int n3 = ob3.intValue();
		System.out.println(n1 + n2 + n3);
		
		//Auto Boxing
		Integer ob4 = 100;
		

		
		int n4 = ob1 + ob2 + ob3;
	}

}

```

---

> **C05DateMain**
> 

```jsx
package Ch14;

import java.time.DayOfWeek;
import java.time.LocalDateTime;

public class C05DateMain {

	public static void main(String[] args) {
		
		//Date
//		Date d1 = new Date();
//		System.out.println(d1);
//		System.out.println(d1.getYear()+1900);
//		System.out.println(d1.getMonth()+1);
//		System.out.println(d1.getDay());//0-6(일-토)
//		System.out.println(d1.getHours());
//		System.out.println(d1.getMinutes());
//		System.out.println(d1.getSeconds());
//		System.out.println(d1.getTime());
		
		//Calendar
//		Calendar cal = Calendar.getInstance();
//		System.out.println(cal);
//		System.out.println(cal.get(Calendar.YEAR));
//		System.out.println(cal.get(Calendar.MONTH)+1);
//		System.out.println(cal.get(Calendar.DAY_OF_MONTH));
//		System.out.println(cal.get(Calendar.DAY_OF_WEEK)); 	//요일
//															// 1-7(일-토)
//		System.out.println(cal.get(Calendar.HOUR_OF_DAY));
//		System.out.println(cal.get(Calendar.MINUTE));
//		System.out.println(cal.get(Calendar.SECOND));
		
		//LocalDateTime	
		LocalDateTime now = LocalDateTime.now();

        // 연, 월, 일, 시, 분, 초 가져오기
        int year = now.getYear();
        int month = now.getMonthValue();  // 월 (1~12)
        int day = now.getDayOfMonth();    // 일 (1~31)
        int hour = now.getHour();         // 시 (0~23)
        int minute = now.getMinute();     // 분 (0~59)
        int second = now.getSecond();     // 초 (0~59)
        DayOfWeek dayOfWeek = now.getDayOfWeek();
        // 결과 출력
        System.out.println("연: " + year);
        System.out.println("월: " + month);
        System.out.println("일: " + day);
        System.out.println("시: " + hour);
        System.out.println("분: " + minute);
        System.out.println("초: " + second);
        System.out.println("요일: " + dayOfWeek);
		
	}

}

```

---

> **C06SimpleDateFormatMain**
> 

```jsx
package Ch14;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

public class C06SimpleDateFormatMain {

	public static void main(String[] args) throws ParseException {
		Scanner sc = new Scanner(System.in);
		System.out.print("YYYY/MM/DD 입력 : ");
		String ymd = sc.next();

		//포매터 객체 생성(입력용)
		SimpleDateFormat fmtin =new SimpleDateFormat("yyyy/MM/dd");//y,M,d,h,m,s
		System.out.println(ymd);
		Date date = fmtin.parse(ymd);
		System.out.println(date);
		
		//포매터 객체 생성(출력용)
		SimpleDateFormat fmtout =new SimpleDateFormat("yyyy~MM~dd");//y,M,d,h,m,s
		System.out.println(fmtout.format(date) );
	}

}

```

---

> **C07LocalDateTimeFormatMain**
> 

```jsx
package Ch14;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;

public class C07LocalDateTimeFormatMain {

	public static void main(String[] args) {

		// 날짜정보 Fomatting
		Scanner sc = new Scanner(System.in);
        System.out.print("YYYY/MM/DD 입력 : ");
        String ymd = sc.next(); // 날짜 문자열 입력

        // 입력용 포매터
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");

        // 문자열을 LocalDate로 변환
        LocalDate date = LocalDate.parse(ymd, inputFormatter);
        System.out.println("입력된 날짜: " + date);

        // 출력용 포매터
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy~MM~dd");

        // 포맷 변경 후 출력
        System.out.println("변환된 날짜: " + date.format(outputFormatter));

        sc.close();

		// 날짜시간 포매팅
//		Scanner sc = new Scanner(System.in);
//		System.out.print("YYYY/MM/DD HH:MM:SS 입력 : ");
//		String ymd = sc.nextLine(); // 날짜 문자열 입력
//
//		// 입력용 포매터
//		DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
//
//		// 문자열을 LocalDate로 변환
//		LocalDateTime dateTime = LocalDateTime.parse(ymd, inputFormatter);
//		System.out.println("입력된 날짜시간: " + dateTime);
//
//		// 출력용 포매터
//		DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy~MM~dd HH-mm-ss");
//
//		// 포맷 변경 후 출력
//		System.out.println("변환된 날짜시간: " + dateTime.format(outputFormatter));
//
//		sc.close();

	}

}

```

---

> **C01NullpointerExceptionMain**
> 

```jsx
package Ch15;

public class C01NullpointerExceptionMain {

	public static void main(String[] args) {
		
		try {
			String str = null;
			System.out.println(str.toString());	
		}catch(NullPointerException e) {
//			System.out.println("예외발생 : "  + e);
//			System.out.println(e.getCause());
//			System.out.println(e.toString());
//			System.out.println(e.getStackTrace());
			e.printStackTrace();	
		}
		
		System.out.println("HELLOWROLD");
		System.out.println("HELLOWROLD");

	}

}

```

---

> **C02ArrayIndexBoundExceptionMain**
> 

```jsx
package Ch15;

public class C02ArrayIndexBoundExceptionMain {

	public static void main(String[] args) {
		int [] arr = {10,20,30};
		
		try {
		for(int i=0;i<4;i++) 	
			System.out.println(arr[i]);
		}catch(ArrayIndexOutOfBoundsException e) {
			System.out.println("예외발생! " + e.getMessage());
		}
		
		System.out.println("HELLO WORLD");
	}

}

```

---

> **C03ClassCastExceptionMain**
> 

```jsx
package Ch15;

class Animal{}
class Dog extends Animal{}
class Cat extends Animal{}

public class C03ClassCastExceptionMain {
	
	public static void changeDog(Animal animal) {
		try {
			Dog down = (Dog)animal;
		}catch(ClassCastException e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
	}
	
	public static void main(String[] args) {
		
		Animal poppi = new Dog();
		Animal tori = new Cat();
		
		changeDog(tori);
		changeDog(poppi);
		
		System.out.println("HELLO WORLD");
				
	}
	
}

```

---

> **C04ExceptionMain**
> 

```jsx
package Ch15;

public class C04ExceptionMain {

	public static void main(String[] args) {

		String str = null;
		try {
//			str.toString(); // NULL 예외발생

			int arr[] = { 10, 20, 30 };
//			arr[5] = 100; // Bound Exception 발생

//			Integer.parseInt("a1234"); // Parse Exception발생

			Animal animal = new Dog();
			//Cat yummi = (Cat) animal; // Cast Exception;
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
//		} catch (NullPointerException e) {
//			System.out.println(e.getMessage());
//		} catch (ArrayIndexOutOfBoundsException e2) {
//			System.out.println(e2.getMessage());
//		} catch (NumberFormatException e3) {
//			System.out.println(e3.getMessage());
//		} catch (ClassCastException e4) {
//			System.out.println(e4.getMessage());
//		}
		
		finally {
			//자원정리 작업
			System.out.println("Finally Test..");
		}
		
		System.out.println("HELLOWORLD");

	}
}

```

---

> **C05ThrowAndThrowsMain**
> 

```jsx
package Ch15;

import java.io.FileInputStream;
import java.io.FileNotFoundException;

class A {

	public void Ex1() throws NullPointerException{

		System.out.println("Ex1 process..1");
//		throw new NullPointerException("Ex1 NULL Exception");

	}
}

class B {
	public void Ex2() throws NullPointerException{

		System.out.println("Ex2 process..1");
		throw new NullPointerException("Ex2 NULL Exception");

	}
}

public class C05ThrowAndThrowsMain {

	public static void main(String[] args)  {
		System.out.println("실행코드1");
		System.out.println("실행코드2");
		A a = new A();
		B b = new B();
		try {
			a.Ex1();
			b.Ex2();
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
	

		System.out.println("실행코드3");
	}

}

```

---

> **C01GenericMain**
> 

```jsx
package Ch16;

class 민트초코{
	@Override
	public String toString() {
		return "민트초코";
	}
}

class 호빵재료{
	
}
class 야채 extends 호빵재료{
	@Override
	public String toString() {
		return "야채";
	}
}
class 슈크림 extends 호빵재료{
	@Override
	public String toString() {
		return "슈크림";
	}	
}
class 팥  extends 호빵재료{
	@Override
	public String toString() {
		return "단팥";
	}	
}

class 호빵 <T extends 호빵재료>{
	private T meterial;
	호빵(T meterial){
		this.meterial = meterial;
	}
	//toString 재정의 
	@Override
	public String toString() {
		return "호빵 [meterial=" + meterial + "]";
	}
	
}
public class C01GenericMain {

	public static void main(String[] args) {
		호빵<팥> ob1 = new 호빵<팥>(new 팥());
		System.out.println(ob1);
		
		호빵<슈크림> ob2 = new 호빵<슈크림>(new 슈크림());
		System.out.println(ob2);
		
		호빵<야채> ob3 = new 호빵<야채>(new 야채());
		System.out.println(ob3);

//		호빵<민트초코> ob4 = new 호빵<민트초코>(new 민트초코());
//		System.out.println(ob4);
		
	}

}

```

---

> **C02Ex**
> 

```jsx
package Ch16;
abstract class 팝콘재료{
	
}

class 캬라멜 extends 팝콘재료{
	@Override
	public String toString() {
		return "캬라멜 []";
	}
	
}
class 버터옥수수 extends 팝콘재료{
	@Override
	public String toString() {
		return "버터옥수수 []";
	}
}

class PopCorn<T extends 팝콘재료>{
	private T meterial;
	public PopCorn(T meterial) {
		this.meterial = meterial;
	}
	@Override
	public String toString() {
		return "PopCorn [meterial=" + meterial + " 맛 팝콘]";
	}
	
}

public class C02Ex {

	public static void main(String[] args) {
		PopCorn<캬라멜> ob1 = new PopCorn<캬라멜>(new 캬라멜());
		System.out.println(ob1);
		
		PopCorn<버터옥수수> ob2 = new PopCorn<버터옥수수>(new 버터옥수수());
		System.out.println(ob2);
	}
}

```

---