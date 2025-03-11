# 01

> **C10Main**
> 

```jsx
package Ch08;

// 홍길동이 		-			사과장수에게 사과를 구매한다
// 구매자    		-			판매자
// 보유금액(속성)				보유금액(속성)
// 사과개수(속성)				사과개수(속성)
//							개당가격(속성)

// 구매하기(기능)				판매하기(기능)
// 1)특정사과장수에게 돈을건넨다->
// (내보유금액에서는 차감)
//							2)돈을 내보유금액에 누적
//							3)사과개수 계산->나의보유사과개수에서차감 -> 사과개수 전달
// 4)나의보유사과개수에 누적

class Buyer{
	private int myMoney;
	private int appleCnt;
	//모든 인자 생성자
	//toString
	public Buyer(int myMoney, int appleCnt) {
		super();
		this.myMoney = myMoney;
		this.appleCnt = appleCnt;
	}
	@Override
	public String toString() {
		return "Buyer [myMoney=" + myMoney + ", appleCnt=" + appleCnt + "]";
	}
	
	public void payment(Seller seller, int money) {
		// 내 보유금액에서 차감
		this.myMoney -= money;
		// seller에 money를 전달하고 리턴되는 사과 개수를 누적
		int appleCnt =seller.receive(money);
		this.appleCnt +=appleCnt;
		
	}
	
}

class Seller{
	private int myMoney;
	private int appleCnt;
	private int price;
	//모든 인자 생성자
	//toString
	public Seller(int myMoney, int appleCnt, int price) {
		super();
		this.myMoney = myMoney;
		this.appleCnt = appleCnt;
		this.price = price;
	}
	@Override
	public String toString() {
		return "Seller [myMoney=" + myMoney + ", appleCnt=" + appleCnt + ", price=" + price + "]";
	}
	
	public int receive(int money) {
		//구매자로부터 전달받은 money를 내보유금액에 누적
		this.myMoney +=money;
		int cnt = money / this.price;
		this.appleCnt-=cnt;
		// 전달받은금액/사과개수 를 리턴
		return cnt;
	}
	
}
public class C10Main {

	public static void main(String[] args) {
		Seller seller = new Seller(10000,100,1000);
		
		Buyer 홍길동 = new Buyer(10000,0);
		Buyer 노홍철 = new Buyer(5000,0);
		
		홍길동.payment(seller, 5000);
		노홍철.payment(seller, 2000);
		
		System.out.println(홍길동);System.out.println("-----");
		System.out.println(노홍철);System.out.println("-----");
		System.out.println(seller);

	}

}

```

---

> **C03GenericMain**
> 

```jsx
package Ch16;
class Person{
	String name;
	String age;
	String addr;
	//생성자
	public Person(String name, String age, String addr) {
		super();
		this.name = name;
		this.age = age;
		this.addr = addr;
	}
}
class Man extends Person{
	//생성자
	public Man(String name, String age, String addr) {
		super(name, age, addr);
		// TODO Auto-generated constructor stub
	}
	//toString
	@Override
	public String toString() {
		return "Man [name=" + name + ", age=" + age + ", addr=" + addr + "]";
	}
}
class Woman extends Person{
	//생성자
	public Woman(String name, String age, String addr) {
		super(name, age, addr);
		// TODO Auto-generated constructor stub
	}
	//toString
	@Override
	public String toString() {
		return "Woman [name=" + name + ", age=" + age + ", addr=" + addr + "]";
	}
	
	
}
class Couple<X extends Person,Y extends Person> {
	private X member1;
	private Y member2;
	//생성자
	public Couple(X member1, Y member2) {
		super();
		this.member1 = member1;
		this.member2 = member2;
	}
	//toString
	@Override
	public String toString() {
		return "Couple [member1=" + member1 + ", member2=" + member2 + "]";
	}

}

public class C03GenericMain {
	public static void main(String[] args) {
		Couple<Man,Woman> couple1 = new Couple<Man,Woman>(new Man("철수","50","대구"),new Woman("영희","45","부산"));
		System.out.println("couple 1 : " + couple1);
		
		Couple<Man,Man> couple2 = new Couple<Man,Man>(new Man("철수","5","대구"),new Man("짱구","5","부산"));
		System.out.println("couple 2 : " + couple2);
		
//		Couple<Double,Integer> couple3 = new Couple<Double,Integer>(100.5,200);
//		System.out.println("couple 3 : " + couple3);
	}
}

```

---

> **C04GenericMain**
> 

```jsx
package Ch16;
class C04Animal{
	String name;
}
class Panda extends C04Animal{
	//생성자
	public Panda(String name) {
		this.name = name;
	}
	//toString
	@Override
	public String toString() {
		return "Panda [name : " + name + "]";
	}
}
class Tiger extends C04Animal{
	//생성자
	public Tiger(String name) {
		this.name = name;
	}
	//toString
	@Override
	public String toString() {
		return "Tiger [name : " + name + "]";
	}
}
public class C04GenericMain {
	//GENERIC
	public static <T extends C04Animal> void PrintByGeneric(T [] arr) {
		for(T el : arr)
			System.out.println(el);
	}
	//OBJECT
	public static void PrintByObject(Object [] animal) {
		for(Object el : animal) {
			System.out.println(el);
		}
		
	}
	public static void main(String[] args) {
		Tiger arr1 [] = {new Tiger("시베리안호랭이"),new Tiger("신사동호랭이"),new Tiger("86호랑이띠")};
		PrintByGeneric(arr1);
		
		Panda arr2 [] = {new Panda("중국팬더"),new Panda("래서팬더"),new Panda("란다")};
		PrintByGeneric(arr2);
		
		Object arr3 [] = {new Panda("중국팬더"),new Tiger("호랭랭"),new Panda("팬더팬더")};
		PrintByObject(arr3);
	}
}

```

---

> **C01ListMain**
> 

```java
package Ch17;

import java.util.ArrayList;
import java.util.List;

public class C01ListMain {
	public static void main(String[] args) {
	List<String> list = new ArrayList();
	//추가
	list.add("HTML/CSS/JS");	//0
	list.add("JQUERY");			//1
	list.add("NODEJS");			//2
	list.add("SCSS");			//3
	
	//조회
	System.out.println("개수 확인 : " + list.size());
	System.out.println("idx로 조회 : " + list.get(2));
	System.out.println("Value로 idx확인 : " + list.indexOf("SCSS"));
	System.out.println("---");
	list.forEach(System.out::println);
	System.out.println("---");
	
	//삭제
	list.remove(0);
	list.remove("JQUERY");
	for(String el : list)
		System.out.println(el);
	
	//전체 삭제
	list.clear();
	}
}

```

---

> **C02Ex**
> 

```java
package Ch17;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class C02Ex {
	static Scanner sc = new Scanner(System.in);

	public static void func1(List<String> list) {
		// ArrayList에 있는 정수값을 입력받는데 전달되는 수중에
		// 짝수의 값만 입력받는 코드를 작성하세요.
		int tmp = 0;
		while (true) {
			System.out.print("입력(종료:-1) :");
			try {
				tmp = sc.nextInt();
			} catch (Exception e) {
				System.out.print("[EXCEPTION] 잘못된 값이 포함되었습니다. 종료됩니다 ");
				System.exit(-1);
			}
			if (tmp == -1)
				break;
			else if (tmp % 2 == 0)
				list.add(String.valueOf(tmp));
			else
				System.out.println("[EXCEPTION]짝수만 입력하세요!");
		}
		System.out.println("입력을 마쳤습니다.");
	}

	public static List<String> func2(List<String> list) {
		// ArrayList에 있는 문자열 중에서 길이가 5보다 큰 문자열만 필터링해서 리턴하는 함수를 만드세요
		List<String> returndList = new ArrayList();
		for (String el : list) {
			if (el.length() > 5) {
				returndList.add(el);
			}
		}
		return returndList;
	}

	public static int func3(List<String> list) {
		// ArrayList에 있는 문자열 중에서 숫자형 데이터만 추출해서 합을 구해보세요
		int sum = 0;
		for (String el : list) {
			sum += Integer.parseInt(el);
		}
		return sum;
	}

	public static void main(String[] args) {
		List<String> li = new ArrayList();
		func1(li);
		
		List<String> returndList = func2(li);
		returndList.forEach(System.out::println);
		int sum = func3(returndList);
		
		System.out.println(sum);
	}
}

```

---

> **C03SetMain**
> 

```java
package Ch17;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

public class C03SetMain {
	public static void main(String[] args) {
		Set<String> set = new HashSet();
		//추가
		set.add("HTML/CSS/JS");	//0
		set.add("JQUERY");			//1
		set.add("NODEJS");			//2
		set.add("SCSS");			//3
		set.add("REACT");
		set.add("JAVA");
		set.add("JSP/SERVELET");
		set.add("STS");
		set.add("SPRING BOOT");		//older
		set.add("SPRING BOOT");		//newer(덮어쓰기)
		
		//확인
		System.out.println("개수 확인 : " + set.size());
		
		//삭제
		set.remove("NODEJS");
		
		//조회(idx x -> Iterator)
//		Iterator<String> iter = set.iterator();
//		while(iter.hasNext())
//			System.out.println(iter.next());
		for(String el : set)
			System.out.println(el);
		
		set.clear();
	}
}

```

---

> **C04Ex**
> 

```java
package Ch17;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;
import java.util.stream.Collectors;

public class C04Ex {
	public static void main(String[] args) {
		//1) 1 ~ 45  까지 숫자를 6개를 랜덤으로 받아(Random클래스를 이용) set에 저장 / 출력
		Random random = new Random();
		Set<Integer> set = new HashSet();
		while(set.size()<6) {
			set.add(random.nextInt(45)+1);
		}
		for(Integer val : set)
			System.out.print(val + " ");
		System.out.println();
		System.out.println("-------------------");
		//2) [추가] 저장된 set의 오름차순정렬을 해보세요 (검색을통해서 해결해봅니다 - 스트림함수사용)
		List<Integer> li = set.stream()
		.sorted()
		.collect(Collectors.toList());
		
		for(Integer val : li)
			System.out.print(val + " ");
		System.out.println();
		System.out.println("-------------------");
		//3)
		List<Integer> list = new ArrayList(set);
		Collections.sort(list);
		for(int num : list)
			System.out.print(num + " ");
	}
}

```

---

> **C05SetMain**
> 

```java
package Ch17;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

class Person{
	String name;
	int age;
	//생성자
	public Person(String name, int age) {
		super();
		this.name = name;
		this.age = age;
	}
	//toString
	@Override
	public String toString() {
		return "Person [name=" + name + ", age=" + age + "]";
	}
	//equals를 재정의해서 name,age가 동일하면 true / 아니면 false
	@Override
	public boolean equals(Object obj) {
		if(obj instanceof Person) {
			Person down = (Person)obj;	//downcasting
			return this.name.equals(down.name) && this.age == down.age;
		}
		return false;
	}
	//hashcode() 재정의 -> HashSet의 동등객체 판단처리
	@Override
	public int hashCode() {
		return Objects.hash(this.name,this.age);
	}
	
}
public class C05SetMain {
	public static void main(String[] args) {
		Set<Person> set = new HashSet();
		
		Person ob1 = new Person("홍길동",55);
		Person ob2 = new Person("남길동",55);
		Person ob3 = new Person("홍길동",55);
		
		System.out.println(ob1.equals(ob2));
		System.out.println(ob1.equals(ob3));
		
		set.add(ob1);
		set.add(ob2);
		set.add(ob3);
		
		System.out.println("SIZE : " + set.size());
	}
}
```

---

> **C06MapMain**
> 

```java
package Ch17;

import java.util.HashMap;
import java.util.Map;

public class C06MapMain {
	public static void main(String[] args) {
		Map<String,Integer> map = new HashMap();
		//추가
		map.put("aaa",1111);
		map.put("bbb",2222);
		map.put("ccc",3333);
		map.put("ddd",4444);
		map.put("ddd",1234);	//중복 key(나중에 put된 값으로 덮어쓰기)
		
		//삭제
		map.remove("aaa");
		
		//확인
		System.out.println("SIZE : " + map.size());
		System.out.println("단건 : " + map.get("bbb"));
		
		//for
		System.out.println("--------------------");
		for(String key : map.keySet()) {
			System.out.println(key+" : " + map.get(key));
		}
		
		
	}
}

```

---

> **C07Ex**
> 

```java
package Ch17;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class C07Ex {
	static Map<String,Object> map = new HashMap();
	//01 함수의 파라미터 형으로 사용되는 경우
	public static void setMap( Map<String,Object> params ) {
		//params console에 출력
		//params를 map 에 저장
		for(String key : params.keySet()) {
			Object value = params.get(key);
			System.out.println(key + " : " + value);
			map.put(key, value);
		}
		
	}
	//02 함수의 리턴형으로 사용되는 경우
	public static Map<String,Object> getMap(){
		return map;
	}
	public static void main(String[] args) {
		//01 파라미터 생성
		Map<String,Object> params = new HashMap();
		//02 데이터 전달
		String [] value ={"정보처리기사","빅데이터분석기사","네트워크 관리사","--"}; 
		params.put("자격증",value);
		setMap(params);
		params.clear();
		//02 데이터 전달		
		List<String> hobby = new ArrayList();
		hobby.add("등산");
		hobby.add("독서");
		hobby.add("게임");
		params.put("취미", hobby);
		setMap(params);

		//03 데이터 확인
		//getMap이용해서 저장된 데이터 확인(출력)
		for(String Key : getMap().keySet()) {
			Object val = C07Ex.map.get(Key);
			System.out.println("KEY : " + Key + "VAL : " + (val instanceof String[]?Arrays.toString((String[])val):val));
		}
		
		
	}
}

```

---

> **C08PropertiesMain**
> 

```java
package Ch17;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class C08PropertiesMain {
	public static void main(String[] args) throws IOException {
		String classPath = System.getProperty("java.class.path");
		System.out.println("classPath : " + classPath);
		String dirPath = System.getProperty("user.dir");
		System.out.println("dirPath : " + dirPath);
		String packagePath = C08PropertiesMain.class.getPackageName();
		System.out.println("packagePath : " +	packagePath);
		
		String filePath = dirPath + File.separator + "src"+File.separator +packagePath + File.separator+"application.properties";
		FileInputStream fin = new FileInputStream(filePath);
		
		Properties properties = new Properties();
		properties.load(fin);
		String url = properties.getProperty("url");
		String username = properties.getProperty("username");
		String password = properties.getProperty("password");
		
		System.out.printf("%s %s %s \n",url,username,password);
	}
}

```

---

> **C01SwingMain**
> 

```java
package Ch18;

import javax.swing.JFrame;

public class C01SwingMain {
	public static void main(String[] args) {
		JFrame frame = new JFrame("첫번째 프레임입니다");
		frame.setBounds(100,100,500,500);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);
	}
}

```

---

> **C02SwingMain**
> 

```java
package Ch18;

import javax.swing.JFrame;

class C02GUI extends JFrame{
	C02GUI(String title){
		super(title);
		setBounds(100,100,500,500);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setVisible(true);
	}
}
public class C02SwingMain {
	public static void main(String[] args) {
		new C02GUI("두번째 프레임입니다.");
	}
}

```

---

> **C03SwingMain**
> 

```java
package Ch18;

import java.awt.Color;

import javax.swing.JFrame;
import javax.swing.JPanel;

class C03GUI extends JFrame{
	C03GUI(String title){
		//Frame
		super(title);
		setBounds(100,100,500,500);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setVisible(true);
		
		//Panel
		JPanel panel = new JPanel();
//		Color col = new Color(71,144,0);
//		panel.setBackground(col);
		
		//Frame(Panel)
		add(panel);
	}
}
public class C03SwingMain {
	public static void main(String[] args) {
		new C03GUI("세번째 프레임입니다.");
	}
}

```

---

> **C04SwingMain**
> 

```java
package Ch18;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

class C04GUI extends JFrame{
	C04GUI(String title){
		//Frame
		super(title);
		setBounds(100,100,245,500);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		//Panel
		JPanel panel = new JPanel();
//		Color col = new Color(71,144,0);
//		panel.setBackground(col);
		panel.setLayout(null);
		
		//Component
		JButton btn1 = new JButton("BTN01");
		btn1.setBounds(10,10,100,30);
		JButton btn2 = new JButton("BTN02");
		btn2.setBounds(120,10,100,30);
		
		JTextField txt1 = new JTextField();
		txt1.setBounds(10,50,210,30);
		
		JTextArea area1 = new JTextArea();
//		area1.setBounds(10,90,210,360);
		
		JScrollPane scroll1 = new JScrollPane(area1);
		scroll1.setBounds(10,90,210,360);
		
		//Panel(Component)
		panel.add(btn1);
		panel.add(btn2);
		panel.add(txt1);
//		panel.add(area1);
		panel.add(scroll1);
		
		//Frame(Panel)
		add(panel);
		
		//Frame
		setVisible(true);
	}
}
public class C04SwingMain {
	public static void main(String[] args) {
		new C04GUI("네번째 프레임입니다.");
	}
}

```

---

> **C05Ex**
> 

```java
package Ch18;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

class GUI extends JFrame {
	GUI(String title) {
		//Frame
		super(title);
		setBounds(100, 100, 400, 370);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		//Panel
		JPanel panel = new JPanel();
		panel.setLayout(null);
		
		//Component
		JButton btn1 = new JButton("파일로 저장");
		btn1.setBounds(270,15,100,30);
		JButton btn2 = new JButton("1:1 요청");
		btn2.setBounds(270,55,100,30);
		JButton btn3 = new JButton("대화기록보기");
		btn3.setBounds(270,95,100,30);
		JTextArea area1 = new JTextArea();
		JScrollPane scroll1 = new JScrollPane(area1);
		scroll1.setBounds(15,15,240,250);
		JTextField txt1 = new JTextField();
		txt1.setBounds(15,280,240,30);
		JButton input = new JButton("입력");
		input.setBounds(270,280,100,30);
		
		
		//Panel(Component)
		panel.add(btn1);
		panel.add(btn2);
		panel.add(btn3);
		panel.add(scroll1);
		panel.add(txt1);
		panel.add(input);
		
		//Frame(Panel)
		add(panel);
		
		//Frame
		setVisible(true);
		
	}
}

public class C05Ex {
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		// Component 참조변수명
		// textarea = area1
		// textarea's scroll = scroll1
		// 파일로저장 : btn1
		// 1:1요청 : btn2
		// 대화기록보기 : btn3
		// 입력 : input
		// textfield : txt1
		new GUI("Chatting Server");
	}

}

```

---