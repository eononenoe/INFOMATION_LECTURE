# 01

> **정리**
> 

```jsx
업캐스팅: 자식 클래스 객체를 부모 클래스 타입으로 바꾼다. (예: 고양이 → 동물)
다운캐스팅: 부모 클래스 객체를 자식 클래스 타입으로 바꾼다. (예: 동물 → 고양이)

abstract : 미완성 된거를 표시하기 위함

String.format() : 사용Ex) double result = num1 / num2; String results = String.format("%.3f",result)

interface = 변수를 만들어도 상수화가 된다 static fianl = 최종 고정값 ex) int MAX_VOL = 100;
```

---

> **C06UpDownCastingMain**
> 

```jsx
package Ch12;
class Super{
	int n1;
}
class Sub extends Super{
	int n2;
}

public class C06UpDownCastingMain {
	public static void main(String[] args) {
		//NoCasting (자료형의 일치)
		Super ob1 = new Super();
		ob1.n1 = 10;
		Sub ob2 = new Sub();
		ob2.n1 = 10;
		ob2.n2 = 20;
		
		//Upcasting (상위클래스 참조변수 = 하위클래스형 객체)(자동형변환)
		//상속관계로 연결된 모든 하위객체를 연결할 수 있다
		Super ob3 = new Sub();
		ob3.n1=100;
//		ob3.n2=200;
		Super ob4 = ob2;
		ob4.n1=100;
//		ob4.n2=200;
		
		//Downcasting(하위클래스 참조변수 = 상위클래스형 객체)(강제형변환)
		//Upcasting된 상태에서 확장된 멤버에 접근하기 위한 용도
//		Sub ob5 = (Sub)ob1;
		Sub ob6 = (Sub)ob3;	
	}
}

```

---

> **C07UpDownCastingMain**
> 

```jsx
package Ch12;

class A {
	int a;

	public A(int a) {
		this.a = a;
	}

	@Override
	public String toString() {
		return "A [a=" + a + "]";
	}
}

class B extends A {
	int b;

	public B(int a, int b) {
		super(a);
		this.b = b;
	}

	@Override
	public String toString() {
		return "B [b=" + b + ", a=" + a + "]";
	}
}

class C extends A {
	int c;

	public C(int a, int c) {
		super(a);
		this.c = c;
	}

	@Override
	public String toString() {
		return "C [c=" + c + ", a=" + a + "]";
	}
}

class D extends B {
	int d;

	public D(int a, int b, int d) {
		super(a, b);
		this.d = d;
	}

	@Override
	public String toString() {
		return "D [d=" + d + ", b=" + b + ", a=" + a + "]";
	}
}

class E extends B {
	int e;

	public E(int a, int b, int e) {
		super(a, b);
		this.e = e;
	}

	@Override
	public String toString() {
		return "E [e=" + e + ", b=" + b + ", a=" + a + "]";
	}
}

class F extends C {
	int f;

	public F(int a, int c, int f) {
		super(a, c);
		this.f = f;
	}

	@Override
	public String toString() {
		return "F [f=" + f + ", c=" + c + ", a=" + a + "]";
	}
}

class G extends C {
	int g;

	public G(int a, int c, int g) {
		super(a, c);
		this.g = g;
	}

	@Override
	public String toString() {
		return "G [g=" + g + ", c=" + c + ", a=" + a + "]";
	}
}

public class C07UpDownCastingMain {

	public static void UpDownCastTestFunc(A obj,int ...arg) {
		// A-G를 받아 모든 속성 출력
		obj.a=arg[0];
		if(obj instanceof B) {
			B down = (B)obj;	//Downcasting(확장된 멤버에 접근위해)
			down.b=arg[1];
		}if(obj instanceof C) {
			C down = (C)obj;
			down.c=arg[1];		//Downcasting(확장된 멤버에 접근위해)
		}if(obj instanceof D) {
			D down = (D)obj;
			down.b=arg[1];
			down.d=arg[2];
		}if(obj instanceof E) {
			E down = (E)obj;
			down.b=arg[1];
			down.e=arg[2];
		}if(obj instanceof F) {
			F down = (F)obj;
			down.c=arg[1];
			down.f=arg[2];
		}if(obj instanceof G) {
			G down = (G)obj;
			down.c=arg[1];
			down.g=arg[2];
		}
		System.out.println(obj);
	}

	public static void main(String[] args) {
		A ob1 = new A(0);
		B ob2 = new B(0, 0);
		C ob3 = new C(0, 0);
		D ob4 = new D(0, 0, 0);
		E ob5 = new E(0, 0, 0);
		F ob6 = new F(0, 0, 0);
		G ob7 = new G(0, 0, 0);

		UpDownCastTestFunc(ob1,10); // No casting (A)
		UpDownCastTestFunc(ob2,10,20); // Upcasting (B to A)
		UpDownCastTestFunc(ob3,30,40); // Upcasting (C to A)
		UpDownCastTestFunc(ob4,50,60,70); // Upcasting (D to A)
		UpDownCastTestFunc(ob5,80,90,100); // Upcasting (E to A)
		UpDownCastTestFunc(ob6,110,120,130); // Upcasting (F to A)
		UpDownCastTestFunc(ob7,140,150,160); // Upcasting (G to A)
	}
}

```

---

> **C08UpDownCastingMain**
> 

```jsx
package Ch12;

class C08Super{
	void func1() {System.out.println("C08.Super.func1() Call!");}
	void func2() {}
}
class C08Sub extends C08Super{
	void func2() {System.out.println("C08.Sub.func2() Call!");}
}

public class C08UpDownCastingMain {
	public static void main(String[] args) {

		C08Super ob1 = new C08Super();		//No casting
		ob1.func1();
		
		System.out.println("-------------");
		C08Sub ob2 = new C08Sub();			//No casting
		ob2.func1();
		ob2.func2();
		
		System.out.println("-------------");
		C08Super ob3 = new C08Sub();		//Upcasting
		ob3.func1();
		ob3.func2();
		
		//Upcasting 상태에서
		//확장된(멤버추가) 멤버변수 접근 가능하다? X -> Downcasting -> 접근
		//확장된(멤버추가) 멤버함수 접근 가능하다? X -> Downcasting -> 접근
		//재정의된 메서드 접근 가능? O X
	}
}

```

---

> **Ex01**
> 

```jsx
package Ch12.ex;

// Exercise 1: Basic Upcasting
class Animal {
    void makeSound() {
        System.out.println("동물이 소리를 냅니다");
    }
}

class Dog extends Animal {
    void makeSound() {
        System.out.println("멍멍!");
    }
    
    void fetch() {
        System.out.println("강아지가 공을 가져옵니다!");
    }
}

public class Ex01BasicUpCasting {
    public static void main(String[] args) {
        System.out.println("=== 연습문제 1: 기본 업캐스팅 ===");
        // 문제: 다음 코드를 완성하세요
        // 1. Dog 인스턴스를 생성하세요
        // 2. 생성한 Dog 인스턴스를 Animal 타입으로 업캐스팅하세요
        Animal dog = new Dog();
        // 3. 업캐스팅된 참조로 makeSound() 메서드를 호출해보세요
        dog.makeSound();
        // 4. 업캐스팅된 참조로 fetch() 메서드를 호출해보고 결과를 확인하세요
//      dog.fetch();
    }
} 
```

---

> **Ex02**
> 

```jsx
package Ch12.ex;

// Exercise 2: Method Access
class Vehicle {
    void start() {
        System.out.println("탈것의 시동을 겁니다");
    }
}

class Car extends Vehicle {
    void start() {
        System.out.println("자동차의 시동을 겁니다");
    }
    
    void turboBoost() {
        System.out.println("자동차가 터보로 가속합니다!");
    }
}

public class Ex02MethodAccess {
    public static void main(String[] args) {
        System.out.println("=== 연습문제 2: 메서드 접근 ===");
        // 문제: 다음 단계를 수행하는 코드를 작성하세요
        // 1. Car 인스턴스를 생성하세요
        // 2. 생성한 Car 인스턴스를 Vehicle 타입으로 업캐스팅하세요
        Vehicle Car = new Car();
        // 3. 업캐스팅된 참조로 start() 메서드를 호출해보세요
        Car.start();
        // 4. 업캐스팅된 참조로 turboBoost() 메서드 호출을 시도해보세요
//        Car.turboBoost();
        // 5. 다시 Car 타입으로 다운캐스팅한 후 turboBoost() 메서드를 호출해보세요
        Car newCar = (Car) Car;
        newCar.turboBoost();
        

        
        // 실행 결과 예시:
        // 자동차의 시동을 겁니다
        // 컴파일 에러: turboBoost() 메서드는 Vehicle 타입에서 접근 불가
        // 자동차가 터보로 가속합니다!
    }
} 
```

---

> **Ex03**
> 

```jsx
package Ch12.ex;

// Exercise 3: Multi Level
class Shape {
    void draw() {
        System.out.println("도형을 그립니다");
    }
}

class Circle extends Shape {
    void draw() {
        System.out.println("원을 그립니다");
    }
    
    void calculateArea() {
        System.out.println("원의 넓이를 계산합니다");
    }
}

class ColoredCircle extends Circle {
    void draw() {
        System.out.println("색칠된 원을 그립니다");
    }
    
    void applyColor() {
        System.out.println("원에 색을 칠합니다");
    }
}

public class Ex03MultiLevel {
    public static void main(String[] args) {
        System.out.println("=== 연습문제 3: 다중 레벨 ===");
        // 문제: 다음 단계를 수행하는 코드를 작성하세요
        // 1. ColoredCircle 인스턴스를 생성하고 Shape 타입으로 업캐스팅하세요
        Shape one = new ColoredCircle();
        // 2. 업캐스팅된 참조로 draw() 메서드를 호출해보세요
        one.draw();
        // 3. Shape -> Circle로 다운캐스팅하고 calculateArea() 메서드를 호출해보세요
        Circle two = (Circle)one;
        two.calculateArea();
        // 4. Circle -> ColoredCircle로 다운캐스팅하고 applyColor() 메서드를 호출해보세요
        ColoredCircle three = (ColoredCircle)two;
        three.applyColor();
        // 5. 각 단계에서 어떤 메서드에 접근 가능한지 확인해보세요
        

        // 실행 결과 예시:
        // 색칠된 원을 그립니다
        // 원의 넓이를 계산합니다
        // 원에 색을 칠합니다
        
   
    }
} 
```

---

> **C01AbstractMain**
> 

```jsx
package Ch13;

//일반 클래스 상속관계
class Super1{
	void func() {}	// 완성된 함수
}
class Sub1 extends Super1{
	void func() {System.out.println("Overrided..Sub1.func()...Call!");}
}
//추상 클래스 상속관계

abstract class Super2{
	abstract void func();
}
class Sub2 extends Super2{
	@Override
	void func() {
		System.out.println("Overrided..Sub2.func()...Call!");
	}
}
public class C01AbstractMain {
	public static void main(String[] args) {
		//01
//		Super1 ob1 = new Super1();	// 상위클래스형으로 객체생성 가능
//		Sub1 ob2 = new Sub1();		// 하위클래스형으로 객체생성 가능 
//		Super1 ob3 = new Sub1();	// Upcasting 가능
//		ob3.func();					// 재정의된 함수 접근 가능
		
		//02
//		Super2 ob1 = new Super2();	// 상위클래스형으로 객체생성 불가능
		Sub2 ob2 = new Sub2();		// 하위클래스형으로 객체생성 가능 (미완성된함수->함수)
		Super2 ob3 = new Sub2();	// Upcasting 가능
		ob3.func();					// 재정의된 함수 접근 가능
	}
}

```

---

> **C02Ex**
> 

```jsx
package Ch13;

//다음은 단위를 변환하는 추상 클래스 Converter이다.
import java.util.Scanner;

abstract class Converter {
   abstract protected double convert(double src); // 추상 메소드
   abstract protected String getSrcString(); // 추상 메소드
   abstract protected String getDestString(); // 추상 메소드
   protected double ratio; // 비율
   public void run() {
      Scanner scanner = new Scanner(System.in);
      System.out.println(getSrcString()+"을 "+getDestString()+"로 바꿉니다.");
      System.out.print(getSrcString()+"을 입력하세요>> ");
      double val = scanner.nextDouble();
      double res = convert(val);
      System.out.println("변환 결과: "+res+getDestString()+"입니다");
      scanner.close();
   }
}

//원화 -> 달러 
class Won2Dollar extends Converter{
	//ratio 
	// void run()
	
	public Won2Dollar() {
		super();
	}
	public Won2Dollar(double ratio) {
		super();
		this.ratio = ratio;
	}	
	@Override
	protected double convert(double src) {
		return Math.round(src/ratio);
	}

	@Override
	protected String getSrcString() {
		return "원화";
	}
	@Override
	protected String getDestString() {
		return "달러";
	}
	
}
public class C02Ex {

	public static void main(String[] args) {

		//[3번] Converter 클래스를 상속받아 원화를 달러로 변환하는 Won2Dollar 클래스를 작성하라. main() 메소드와 실행 결과는 다음과 같다.
		   Won2Dollar toDollar = new Won2Dollar(1446); // 1달러는 1446원
		   toDollar.run();
		   
		   //결과
//		   원을 달러로 바꿉니다.
//		   원을 입력하세요>> 24000
//		   변환 결과: 20.0달러입니다

	}

}

```

---

> **Won2Yuan**
> 

```jsx
package Ch14;

public class Won2Yuan extends Converter {
	public void won2Yuan() {
	}

	public Won2Yuan(double ratio) {
		super();
		this.ratio = ratio;
	}

	@Override
	protected double convert(double src) {
		String c = Double.toString(src/ratio);
		int d = c.indexOf(".")+3;
		String e = "";
		if(c.length()== d) {
			e = c.substring(0, d-1)+0;
		} else {
			e = c.substring(0, d);
		}
		
		return Double.parseDouble(e);
	}

	@Override
	protected String getSrcString() {
		return "원화";
	}

	@Override
	protected String getDestString() {
		return "위안";
	}

}

```

---

> **C03InterfaceMain**
> 

```jsx
package Ch13;

interface Remocon {
	int MAX_VOL = 100; // public static final
	int MIN_VOL = 0; // public static final

	void setVolumn(int vol);

	// Tv, Radio 각각 메서드 완성시켜주세요
	// MAX_VOL / MIN_VOL 을 적용해서 각각최대볼륨 최소볼륨제한해주세요 - !
	// 구현하는 클래스에서 외부로부터 받는 vol을 저장할 멤버변수(vol)를 지정해주세요
	// vol값이 100을 초과할때는 최대볼륨값으로 적용 (print : 최대볼륨으로 설정합니다)
	// vol값이 0미만일때는 최소볼륨값으로 적용 (print : 최소볼륨으로 설정합니다)
	// 0<=vol<=100사이이면 멤버변수 vol에 저장해주시고 현재볼륨을 출력해줍니다(print : 현재볼륨 : n)
	void powerOn(); // abstract function

	void powerOff(); // abstract function

}
interface Browser{
	void SearchURL(String url);
}
class Tv implements Remocon {
	private int vol;

	@Override
	public void powerOn() {
		System.out.println("TV를 켭니다");

	}

	@Override
	public void powerOff() {
		System.out.println("TV를 끕니다");
	}

	@Override
	public void setVolumn(int vol) {
		if (vol > MAX_VOL) {
			vol = MAX_VOL;
			System.out.println("최대볼륨으로 설정합니다");
		} else if (vol < MIN_VOL) {
			vol = MIN_VOL;
			System.out.println("최소볼륨으로 설정합니다");
		} else if (vol >= MIN_VOL || vol <= MAX_VOL) {
			this.vol = vol;
			System.out.println("현재볼륨 : " + this.vol);
		}
	};

}

class SmartTv extends Tv implements Browser {
	@Override
	public void SearchURL(String url) {
		System.out.println(url + "로 이동합니다");
		
	}

}

class Radio implements Remocon {
	private int vol;

	@Override
	public void powerOn() {
		System.out.println("RADIO를 켭니다");

	}

	@Override
	public void powerOff() {
		System.out.println("RADIO를 끕니다");
	}

	@Override
	public void setVolumn(int vol) {
		if (vol > MAX_VOL) {
			vol = MAX_VOL;
			System.out.println("최대볼륨으로 설정합니다");
		} else if (vol < MIN_VOL) {
			vol = MIN_VOL;
			System.out.println("최소볼륨으로 설정합니다");
		} else if (vol >= MIN_VOL || vol <= MAX_VOL) {
			this.vol = vol;
			System.out.println("현재볼륨 : " + this.vol);
		}
	};
}

public class C03InterfaceMain {
	public static void TurnOn(Remocon controller) {
		controller.powerOn();
	}

	public static void TurnOff(Remocon controller) {
		controller.powerOff();
	}

	public static void setVolumn(Remocon controller, int vol) {
		controller.setVolumn(vol);
	}
	public static void Internet(Browser browser,String url) {
		browser.SearchURL(url);
	}

	public static void main(String[] args) {
		Tv tv1 = new Tv();
		SmartTv smartTv1 = new SmartTv();
		Radio radio1 = new Radio();

		TurnOn(tv1);
		setVolumn(tv1, 110);
		TurnOff(tv1);

		System.out.println("----------------");

		TurnOn(radio1);
		setVolumn(radio1, 110);
		TurnOff(radio1);

		System.out.println("----------------");

		TurnOn(smartTv1);
		Internet(smartTv1,"www.naver.com");
	}
}

```

---

> 
> 

```jsx

```

---

> 
> 

```jsx

```

---

> 
> 

```jsx

```

---

> 
> 

```jsx

```

---