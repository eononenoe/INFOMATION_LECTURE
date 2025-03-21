# 01

> **C01FunctionalInterfaceMain**
> 

```java
package Ch33;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@FunctionalInterface	//함수형인터페이스 선언(Compiler에게 전달)
interface Func1 {
	void say(String message);	//추상메서드
}
@FunctionalInterface	//함수형인터페이스 선언(Compiler에게 전달)
interface Func2 {
	int sum(Integer ...args);	//추상메서드
}
@FunctionalInterface	//함수형인터페이스 선언(Compiler에게 전달)
interface Func3 {
	List<Integer>createListDesc(int ...args);	//추상메서드
}

public class C01FunctionalInterfaceMain {
	public static void main(String[] args) {
		//01
		Func1 func1 = (message)->{System.out.println(message);};
		func1.say("HELLO WORLD");
		
		Func1 func1_1 = System.out::println;
		func1_1.say("HELLO WORLD");
		
		//02
		Func2 func2 = (items)->{
			int sum=0;
			for(Integer li : items) {
				sum+=li;
			}
			return sum;
		};	//{}에 모든 items를 더한값을 리턴
		System.out.println(func2.sum(10,20,30,40,556,6,7,8,9));
		
		Func2 func2_2 = (items)-> {
			//{} 에 모든 items를 더한값을 리턴(reduce)
//			List<Integer> numbers = Arrays.asList(items);
//			Optional<Integer> sum = numbers.stream().reduce((a,b)->a+b);
//			return sum.orElse(0);
//			return Arrays.stream(items).reduce(0,(sum,el)->{return sum + el;});
			return Arrays.stream(items).reduce(0, (sum, el) -> sum + el);
		};
		System.out.println(func2_2.sum(10,20,30,40,556,6,7,8,9));
		
		//원시타입 int[] 받기 -> 내림차순 -> 내림차순 -> int를 Integer로 boxing -> List<Integer변환>
		Func3 func3 = (items)->{
			return Arrays	.stream(items)
					.boxed()
					.sorted((a,b)->{return b-a;})
					.collect(Collectors.toList());
		};
		List<Integer> li = func3.createListDesc(10,100,24,1612,42,123,15,4,1);
		System.out.println(li);
	}
}

```

---

> **C02Ex**
> 

```java
package Ch33;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@FunctionalInterface
interface Functional {
	Integer execute(int... args);
}

class Calc {
	Functional sum; // 합
	Functional sub; // 차
	Functional mul; // 곱
	Functional div; // 나누기

	Calc() {
		// 조건
		// sum,sub,mul,div 각각에 람다&스트림함수를 적절히 이용해서 기능 구현을 합니다
		// 모든 인자를 받을 수 있는 가변인자 처리로 구현합니다
		// 뺄셈, 나눗셈은 큰수에서 작은수로 정렬(sorted)한다음 누적 감산 처리(reduce)를 합니다
		
		// Functional sum 에 대한 람다식 완성 할 것
		sum = (items) -> {
			// reduce를 사용하여 items 배열의 합을 계산
			return Arrays.stream(items).reduce(0, (sum, el) -> sum + el); // 합계를 반환
		};
		// Functional sub 에 대한 람다식 완성 할 것
		sub = (items) -> {
			return Arrays.stream(items)
					.boxed()
					.sorted((a,b)->b-a)
					.reduce(0,(sub, el) -> {return sub < el ? el-sub : sub - el;});
		};
		// Functional mul 에 대한 람다식 완성 할 것
		mul = (items) -> {
			return Arrays.stream(items).reduce(1, (mul, el) -> mul * el);
		};
		// Functional div 에 대한 람다식 완성 할 것
		div = (items) -> {
		    return Arrays.stream(items)
		                 .boxed()
		                 .sorted((a, b) -> b - a)
		                 .reduce((a, b) -> b != 0 ? a / b : 0) 
		                 .orElse(0); 
		};
	}
}

public class C02Ex {
	public static void main(String[] args) {
		Calc calc = new Calc();
		System.out.println("합 : " + calc.sum.execute(10, 20, 30, 40, 50, 60));
		System.out.println("차 : " + calc.sub.execute(1, 4, 2, 9));
		System.out.println("곱 : " + calc.mul.execute(2, 2, 2, 3, 3, 3));
		System.out.println("나누기 : " + calc.div.execute(1, 4, 2, 16));

	}
}

```

---

> **C03FunctionalInterfaceMain**
> 

```java
package Ch33;

import java.util.Arrays;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;

//제공되는 함수형 인터페이스들
//Function<T, R>:
//apply 메서드를 가지고 있어서 하나의 인자(T)를 받아서 결과(R)를 반환하는 함수형 인터페이스 입니다.

//Supplier<T>:
//get 메서드를 가지고 있어서 어떠한 인자도 받지 않고 결과만을 제공하는 함수형 인터페이스 입니다.
//
//Consumer<T>:
//accept 메서드를 가지고 있어서 어떠한 인자를 받아서 결과를 반환하지 않는 함수형 인터페이스 입니다.
//
//Predicate<T>:
//test 메서드를 가지고 있어서 어떠한 인자를 받아서 불리언 결과를 반환하는 함수형 인터페이스 입니다.
//
//UnaryOperator<T>:
//apply 메서드를 가지고 있어서 하나의 인자를 받아서 동일한 타입의 결과를 반환하는 함수형 인터페이스 입니다.
//
//BinaryOperator<T>:
//apply 메서드를 가지고 있어서 두 개의 인자를 받아서 동일한 타입의 결과를 반환하는 함수형 인터페이스 입니다.

public class C03FunctionalInterfaceMain {
	// ============== 01 ==============
	public static Function<Integer, Integer> func1 = x -> x * x;

	// ============== 02 ==============
	public static Function<Integer, Integer> func2 = x -> x + x;

	// ============== 03 ==============
	public static Function<List<Integer>, Integer> func3 = (x) -> x.stream().reduce(0, (sum, el) -> {
		return sum + el;
	});

	// ============== 04 ==============
	public static Function<List<Object>, Integer> func4 = (li) -> {
		// List<Object>로 받은 파라미터 중에 Integer만 추출해서 누적합 구하기
		// 1. Integer형만 필터링(instanceof)
		// 2. 누적합(reduce)
//		return (int) li.stream().filter(obj -> obj instanceof Integer).count();
		return li.stream().filter((item) -> {
			return item instanceof Integer;
		}).map((item) -> {
//			System.out.println(item); 
			return (Integer) item;
		}).reduce(0, (sum, item) -> {
			return sum + item;
		});
	};

	// ============== 05 ==============
	public static Function<List<Object>, List<Integer>> func5 = (li) -> {
		// List<Object>로 받은 파라미터 중에 Integer만 추출해서 누적합 구하기
		// 1. Integer형만 필터링(instanceof)
		// 2. 재구성(Map)
		// 3. 리스트로 변환(collect)
		return li.stream().filter(item -> item instanceof Integer).map(item -> (Integer) item)
				.collect(Collectors.toList());
	};

	// ============== 06 ==============
	public static Function<Integer, Integer> func6 = func1.andThen(func2);

	// ============== 07 ==============
	public static Function<Integer, Integer> func7 = func2.andThen(func1);

	// ============== 08 ==============
	public static Function<List<Integer>, Integer> subFunc = (x) -> {
		return x.stream().reduce(0, (sum, y) -> sum + y);
	};
	public static Function<List<Object>, Integer> func8 = func5.andThen(subFunc);

	// ============== 09 ==============
	public static Function<Integer, Function<Integer, Integer>> func9 = (x) -> {
		System.out.println("첫번째 함수 호출 !  x : " + x);
		;
		return (y) -> {
			System.out.println("두번째 함수 호출 y : " + y + " | 첫번째 함수 호출 x : " + x);
			return y + x;
		};
	};
	// ============== 10 ==============
	public static Function<Integer, Function<Integer, Integer>> func10 = x -> y -> x + y;
	
	// ============== 11 ==============
	public static Function<Integer, Function<Integer,Function<Integer,Integer>>> func11 = x->y->z->x+y+z;
	
	public static void main(String[] args) {
		// 01
		System.out.println("----문제 01 ----");
		System.out.println(func1.apply(10));
		// 02
		System.out.println("----문제 02 ----");
		System.out.println(func2.apply(10));
		// 03
		System.out.println("----문제 03 ----");
		System.out.println(func3.apply(Arrays.asList(10, 20, 30, 40)));
		// 04
		System.out.println("----문제 04 ----");
		System.out.println(func4.apply(Arrays.asList("HELLO", 20, 30, 40, 100, 10.5, true)));
		// 05
		System.out.println("----문제 05 ----");
		System.out.println(func5.apply(Arrays.asList("HELLO", 20, 30, 40, 100, 10.5, true)));
		// 06
		System.out.println("----문제 06 ----");
		System.out.println(func6.apply(5));
		// 07
		System.out.println("----문제 07 ----");
		System.out.println(func7.apply(5));
		// 08
		System.out.println("----문제 08 ----");
		System.out.println(func8.apply(Arrays.asList("HELLO", 20, 30, 40, 100, 10.5, true)));
		// 09
		System.out.println("----문제 09 ----");
		System.out.println(func9.apply(10).apply(20));
		// 10
		System.out.println("----문제 10 ----");
		System.out.println(func10.apply(10).apply(20));
		// 11
		System.out.println("----문제 11 ----");
		System.out.println(func11.apply(10).apply(20).apply(10));
	}
}

```

---

> **C04Ex**
> 

```java
package Ch33;

import java.util.Arrays;
import java.util.List;

import zmq.util.function.Function;

//01 func1완성 - List<String>에 저장된 문자열 리스트에서 길이가 5이상인 문자열의 개수를 반환
//02 func2완성 - List<Integer>에 저장된 숫자들의 제곱한 값의 합을 반환
//03 func3완성 - List<String>에서 각 문자열의 첫 글자를 추출하여 대문자로 변환하여 리턴

public class C04Ex {

	
	public static Function<List<String>,Integer> func1; //
	public static Function<List<String>,Integer> func2; //
	public static Function<List<String>,Integer> func3; //
	
	
	public static void main(String[] args) {
		List<String> list =   Arrays.asList("aaaaaa","bbbbb","cc","ddeeeeee","ee");
		
		int r1 =  func1.apply(list);
		System.out.println("r1 : " + r1);
		
		
		List<Integer> list2 =   Arrays.asList(1,2,3,4,5);
		int r2 =  func2.apply(list2);
		System.out.println("r2 : " + r2);
		
		List<String> list3 =   Arrays.asList("apple","banana","orange");
		List<String> r3 = func3.apply(list3);
		System.out.println("r3 : " + r3);
	}
	
}

```

---

> **C00INFO**
> 

```java
package Ch34;

public class C00INFO {
	//출처: https://ittrue.tistory.com/156 [IT is True:티스토리]
	//	
	//어노테이션이란? (Annotation)
	//어노테이션은 다른 프로그램에게 유용한 정보를 제공하기 위해 사용되는 것으로 주석과 같은 의미를 가진다.
	//어노테이션의 역할
	//
	//컴파일러에게 문법 에러를 체크하도록 정보를 제공한다.
	//프로그램을 빌드할 때 코드를 자동으로 생성할 수 있도록 정보를 제공한다.
	//런타임에 특정 기능을 실행하도록 정보를 제공한다.
	//
	//어노테이션은 @를 사용하여 작성하며, 해당 타겟에 대한 동작을 수행하는 프로그램 외에는 다른 프로그램에게 영향을 주지 않는다.
	// 
	//어노테이션의 종류
	//어노테이션은 크게 세 가지로 구분된다. 자바에서 기본적으로 제공하는 표준 어노테이션과 어노테이션을 정의하는 데 사용되는 메타 어노테이션, 마지막으로 사용자 어노테이션이 있다.
	// 
	// 
	//표준 어노테이션
	//자바에서 기본적으로 제공하는 어노테이션이다.
	//@Override
	//컴파일러에게 메서드를 오버라이딩하는 것이라고 알린다.
	// 
	//@Deprecated
	//앞으로 사용하지 않을 대상임을 알린다.
	// 
	//@FunctionalInterface
	//함수형 인터페이스라는 것을 알린다.
	// 
	//@SuppressWarning
	//컴파일러가 경고 메시지를 나타내지 않는다.
	// 
	//@SafeVaragrs
	//제네릭과 같은 가변 인자의 매개변수를 사용할 때의 경고를 나타내지 않는다.
	// 
	//메타 어노테이션
	//어노테이션에 붙이는 어노테이션으로, 어노테이션을 정의하는 데 사용한다.
	// 
	//@Target
	//어노테이션을 정의할 때 적용 대상을 지정하는 데 사용한다.
	// 
	//@Documented
	//어노테이션 정보를 javadoc으로 작성된 문서에 포함시킨다.
	// 
	//@Inherited
	//어노테이션이 하위 클래스에 상속되도록 한다.
	// 
	//@Retention
	//어노테이션이 유지되는 기간을 정하기 위해 사용한다.
	// 
	//@Repeatable
	//어노테이션을 반복해서 적용할 수 있도록 한다.
	// 
	//사용자 정의 어노테이션
	//사용자가 직접 정의하여 사용하는 어노테이션이다.

}

```

---

> **CustomAnnotation**
> 

```java
package Ch34;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)	//애노테이션의 유지기간(프로그램 동작중인 상태에서만 실행)
@Target({ElementType.TYPE,ElementType.METHOD})
public @interface CustomAnnotation {
	String value() default "";
	int number() default 0;
	boolean isOpen() default false;
}

```

---

> **Main**
> 

```java
package Ch34;
@CustomAnnotation(value = "HELLO WORLD",number=5,isOpen=true)
class Simple{
	String v1;
	int v2;
	boolean v3;
	Simple() {
		CustomAnnotation ref = this.getClass().getAnnotation(CustomAnnotation.class);
		System.out.println("value : " + ref.value());
		System.out.println("number : " + ref.number());
		System.out.println("isOpen: " + ref.isOpen());
		this.v1 = ref.value();
		this.v2 = ref.number();
		this.v3 = ref.isOpen();
	}
	//toStirng
	@Override
	public String toString() {
		return "Simple [v1=" + v1 + ", v2=" + v2 + ", v3=" + v3 +"]";
	}
	
	
}	

public class Main {
	public static void main(String[] args) {
		Simple obj = new Simple();
		System.out.println(obj);
	}
}

```

---