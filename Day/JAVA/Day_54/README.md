# 01

> **ServerSendThread**
> 

```java
package Ch24;

import java.io.DataOutputStream;
import java.util.Scanner;

public class ServerSendThread implements Runnable {
	//OutputStream
	DataOutputStream dout;
	Scanner sc = new Scanner(System.in);
	
	ServerSendThread(DataOutputStream dout) {
		this.dout = dout;
	}
	@Override
	public void run() {
		String send;
		try {
			while(true) {
				//SERVER->CLIENT (송신)
				System.out.print("[CLIENT(q:종료)] :");
				send=sc.nextLine();
				if(send.equals("q")) {
					break;
				}
				dout.writeUTF(send);
				dout.flush();
			}
		}catch(Exception e) {
			System.out.println("[EXCEPTION] 예외발생 ServerSendThread 종료");
		}finally {
			try{dout.close();}catch(Exception e2) {}
		}
	}
}

```

---

> **ServerRecvThread**
> 

```java
package Ch24;

import java.io.DataInputStream;

public class ServerRecvThread implements Runnable {
	//InputStream
	DataInputStream din;
	
	ServerRecvThread(DataInputStream din) {
		this.din = din;
	}
	@Override
	public void run() {
		String recv;
		try {
			while(true) {
				//CLIENT->SERVER (수신)
				recv = din.readUTF();
				if(recv.equals("q"))
					break;
				System.out.println("[CLIENT] : " + recv);	
			}
		}catch(Exception e) {
			System.out.println("[EXCEPTION] 예외발생 ServerRecvThread 종료");
		}finally {
			try {din.close();} catch(Exception e2) {}
		}
	}
}

```

---

> **ClientSendThread**
> 

```java
package Ch24;

import java.io.DataOutputStream;
import java.util.Scanner;

public class ClientSendThread implements Runnable {
	// OutputStream
	DataOutputStream dout;
	Scanner sc = new Scanner(System.in);

	ClientSendThread(DataOutputStream dout) {
		this.dout = dout;
	}

	@Override
	public void run() {
		String send;
		try {
			while (true) {
				System.out.print("[CLIENT] : ");
				// SERVER->CLIENT (송신)
				send = sc.nextLine();
				if (send.equals("q")) {
					break;
				}
				dout.writeUTF(send);
				dout.flush();
			}
		} catch (Exception e) {
			System.out.println("[EXCEPTION] 예외발생 ServerSendThread 종료");
		} finally {
			try {dout.close();} catch (Exception e2) {}
		}
	}
}

```

---

> **ClientRecvThread**
> 

```java
package Ch24;

import java.io.DataInputStream;

public class ClientRecvThread implements Runnable {
	DataInputStream din;
	
	ClientRecvThread(DataInputStream din) {
		this.din = din;
	}
	@Override
	public void run() {
		String recv;
		try {
			while(true) {
				recv = din.readUTF();
				if(recv.equals("q"))
					break;
				System.out.println("[SERVER] : " + recv);
			}
		}catch(Exception e) {
			System.out.println("[EXCEPTION] 예외발생 ClientRecvThread 종료");
		}finally {
			try {din.close();} catch(Exception e2) {}
		}
	}
	
}

```

---

> **Server**
> 

```java
package Ch24;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {

	public static void main(String[] args) throws IOException, InterruptedException {
		// 서버 소켓 생성
		ServerSocket server = new ServerSocket(7000); // 192.168.16.203:7000
		System.out.println("[INFO] SERVER SOCKET LISTENING");

		//1회 응답
		Socket client = server.accept();
		
		System.out.println("\n[SERVER] 연결 시작합니다");
		//INOUT STREAM 
		System.out.println("CLIENT IP : " + client.getInetAddress());
		OutputStream out = client.getOutputStream();
		DataOutputStream dout = new DataOutputStream(out);
		InputStream in = client.getInputStream();
		DataInputStream din = new DataInputStream(in);
		
		//
		ServerSendThread send = new ServerSendThread(dout);
		ServerRecvThread recv = new ServerRecvThread(din);
		
		//
		Thread th1 = new Thread(send);
		Thread th2 = new Thread(recv);
		
		//
		th1.start();
		th2.start();
		
		th1.join();
		th2.join();
		
		//자원제거
		din.close();
		dout.close();
		in.close();
		out.close();
		client.close();
		server.close();
		System.out.println("[SERVER] 연결 종료합니다");
	}
}

```

---

> **Client**
> 

```java
package Ch24;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;

public class Client {
	public static void main(String[] args) throws IOException, InterruptedException {
		
		Socket client = new Socket("192.168.16.203",7000);	
		
		System.out.println("[CLIENT] 연결 시작합니다");
		//INOUT STREAM 
		System.out.println("CLIENT IP : " + client.getInetAddress());
		OutputStream out = client.getOutputStream();
		DataOutputStream dout = new DataOutputStream(out);
		InputStream in = client.getInputStream();
		DataInputStream din = new DataInputStream(in);
		
		//
		ClientSendThread send = new ClientSendThread(dout);
		ClientRecvThread recv = new ClientRecvThread(din);
		
		//
		Thread th1 = new Thread(send);
		Thread th2 = new Thread(recv);
		
		//
		th1.start();
		th2.start();
		
		th1.join();
		th2.join();
		
		//자원제거
		din.close();
		dout.close();
		in.close();
		out.close();
		client.close();
		System.out.println("[CLIENT] 연결 종료합니다");
		
	}
}

```

---

> **ClientRecvThread**
> 

```java
package Ch25;

import java.io.DataInputStream;

public class ClientRecvThread implements Runnable {
	//InputStream
	DataInputStream din;
	Cgui gui;
	ClientRecvThread(DataInputStream din,Cgui gui) {
		this.din = din;
		this.gui = gui;
	}
	@Override
	public void run() {
		String recv;
		try {
			while(true) {
				recv = din.readUTF();
				if(recv.equals("q"))
					break;
//				System.out.println("[SERVER] : " + recv);
				gui.area.append("[SERVER] : " + recv + "\n");
			}
		}catch(Exception e) {
			System.out.println("[EXCEPTION] 예외발생 ClientRecvThread 종료");
		}finally {
			try {din.close();} catch(Exception e2) {}
		}
	}
	
}

```

---

> **ServerRecvThread**
> 

```java
package Ch25;

import java.io.DataInputStream;

public class ServerRecvThread implements Runnable {
	//InputStream
	DataInputStream din;
	Sgui gui;
	ServerRecvThread(DataInputStream din,Sgui gui) {
		this.din = din;
		this.gui = gui;
	}
	@Override
	public void run() {
		String recv;
		try {
			while(true) {
				//CLIENT->SERVER (수신)
				recv = din.readUTF();
				if(recv.equals("q"))
					break;
//				System.out.print("[CLIENT] : " + recv);	
				gui.area.append("[CLIENT] "+recv+"\n");
			}
		}catch(Exception e) {
			System.out.println("[EXCEPTION] 예외발생 ServerRecvThread 종료");
		}finally {
			try {din.close();} catch(Exception e2) {}
		}
	}
}

```

---

> **ClientUI**
> 

```java
package Ch25;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

class Cgui extends JFrame implements ActionListener,KeyListener
{
	
	JTextArea area;
	JScrollPane scroll;
	JTextField txt1;
	
	//소켓 코드 추가
	Socket client;
	DataOutputStream dout;
	DataInputStream din;
	
	Cgui() throws Exception {
		super("Chat Client");	//프레임창 제목		
		JPanel pannel = new JPanel(); //패널 생성		
		pannel.setLayout(null);	//Layout 설정 x	

		area = new JTextArea();	//텍스트영역창
		area.setEditable(false);
		//area.setBounds(10,10,260,240);	//스크롤 추가시 생략	
		scroll = new JScrollPane(area); //area에 스크롤 추가하기
		scroll.setBounds(10,10,260,240);		

		txt1 = new JTextField();			//텍스트입력창 
		txt1.setBounds(10,260,260,30);		//크기
		txt1.addKeyListener(this);			//이벤트 추가(키보드)
	 

		pannel.add(txt1);
		//pannel.add(area);		//스크롤 추가시 생략
		pannel.add(scroll);
		
		add(pannel);			//프레임에 패널 추가
		
		setBounds(100,100,300,350);	//프레임창 위치
		setResizable(false);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); //종료버튼 사용가능상태
		setVisible(true);	//프레임창 보여주기
		
		//소켓 연결
		client = new Socket("192.168.16.203",7002);
		System.out.println("[SERVER] 연결 시작합니다");
		// INOUT STREAM
		System.out.println("CLIENT IP : " + client.getInetAddress());
		dout = new DataOutputStream(client.getOutputStream());
		din = new DataInputStream(client.getInputStream());
		area.append("[SERVER] 에 접속완료했습니다.");
		
		//수신스레드
		ClientRecvThread recv = new ClientRecvThread(din,this);
		Thread th = new Thread(recv);
		th.start();
		
	}

	@Override
	public void actionPerformed(ActionEvent e) {	
	}

	//키를 뗏을때(UNICODE지원)
	@Override
	public void keyTyped(KeyEvent e) {
		//System.out.println("KEYTPYED함수 : " + e.getKeyChar());
		
	}
	//키를 눌렀을때
	@Override
	public void keyPressed(KeyEvent e) {
		//System.out.println("KEYPRESSED함수 : "+e.getKeyChar());
		//System.out.println("KEYPRESSED함수 : "+e.getKeyCode());
		if(e.getKeyCode()==10) //엔터키 입력
		{
			try {
				//Send작업
	
				//1 필드의 내용 ->Area
				area.append("[Client] : "+txt1.getText()+"\n");
	
				//SERVER->CLIENT (송신)
				dout.writeUTF(txt1.getText());
				dout.flush();
				
				//2 필드의 내용 삭제
				txt1.setText("");
				
				//스크롤를 맨 아래로 이동
				area.setCaretPosition(area.getDocument().getLength());
				
			}catch(Exception e2) {
				e2.printStackTrace();
			}
			
		}
	}
	//키를 뗏을때(UNICODE 미지원)
	@Override
	public void keyReleased(KeyEvent e) {
		//System.out.println("KEYRELEASED함수 : "+e.getKeyChar());
		
	}

	 
}

public class ClientUI {

	public static void main(String[] args) throws Exception{
		new Cgui();
	}

}

```

---

> **ServerUI**
> 

```java
package Ch25;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

class Sgui extends JFrame implements ActionListener, KeyListener {

	JTextArea area;
	JScrollPane scroll;
	JTextField txt1;

	// 소켓코드 추가
	ServerSocket server;
	Socket client;
	DataOutputStream dout;
	DataInputStream din;

	Sgui() throws Exception {
		super("Chat Server"); // 프레임창 제목
		JPanel pannel = new JPanel(); // 패널 생성
		pannel.setLayout(null); // Layout 설정 x

		area = new JTextArea(); // 텍스트영역창
		area.setEditable(false); //

		// area.setBounds(10,10,260,240); //스크롤 추가시 생략
		scroll = new JScrollPane(area); // area에 스크롤 추가하기
		scroll.setBounds(10, 10, 260, 240);

		txt1 = new JTextField(); // 텍스트입력창
		txt1.setBounds(10, 260, 260, 30); // 크기
		txt1.addKeyListener(this); // 이벤트 추가(키보드)

		pannel.add(txt1);
		// pannel.add(area); //스크롤 추가시 생략
		pannel.add(scroll);

		add(pannel); // 프레임에 패널 추가

		setBounds(100, 100, 300, 350); // 프레임창 위치
		setResizable(false);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); // 종료버튼 사용가능상태
		setVisible(true); // 프레임창 보여주기

		// 소켓연결-ServerSocket
		// 서버 소켓 생성
		server = new ServerSocket(7003); // 192.168.16.203:7000
		System.out.println("[INFO] SERVER SOCKET LISTENING");

		// 1회 응답
		client = server.accept();

		System.out.println("[SERVER] 연결 시작합니다");
		// INOUT STREAM
		System.out.println("CLIENT IP : " + client.getInetAddress());
		dout = new DataOutputStream(client.getOutputStream());
		din = new DataInputStream(client.getInputStream());
		area.append("[CLIENT] " + client.getInetAddress() + " 접속하셨습니다\n");
		
		//수신스레드 생성
		ServerRecvThread recv = new ServerRecvThread(din,this);
		Thread th = new Thread(recv);
		th.start();
		
	}

	@Override
	public void actionPerformed(ActionEvent e) {
	}

	// 키를 뗏을때(UNICODE지원)
	@Override
	public void keyTyped(KeyEvent e) {
		// System.out.println("KEYTPYED함수 : " + e.getKeyChar());

	}

	// 키를 눌렀을때
	@Override
	public void keyPressed(KeyEvent e){
		//System.out.println("KEYPRESSED함수 : "+e.getKeyChar());
		//System.out.println("KEYPRESSED함수 : "+e.getKeyCode());
		if(e.getKeyCode()==10) //엔터키 입력
		{
			try {
				//1 필드의 내용 ->Area
				area.append("[SERVER] : "+txt1.getText()+"\n");
				
				//SERVER->CLIENT (송신)
				dout.writeUTF(txt1.getText());
				dout.flush();
				
				//2 필드의 내용 삭제
				txt1.setText("");
				
				//스크롤를 맨 아래로 이동
				area.setCaretPosition(area.getDocument().getLength());
			
			}catch(Exception e2) {
				e2.printStackTrace();
			}
			

			
			
		}
	}

	// 키를 뗏을때(UNICODE 미지원)
	@Override
	public void keyReleased(KeyEvent e) {
		// System.out.println("KEYRELEASED함수 : "+e.getKeyChar());

	}

}

public class ServerUI {

	public static void main(String[] args) throws Exception {
		new Sgui();
	}

}

```

---

> **C00INFO**
> 

```java
package Ch29_;

public class C00INFO {
	//Reflect란
	//자바의 Reflection(리플렉션)은 실행 중인 프로그램의 클래스, 인터페이스, 메서드, 필드 등의 정보를 
	//동적으로 얻고 조작할 수 있는 기능을 제공하는 API입니다. 리플렉션을 사용하면 컴파일 시간에 알려지지 않은 
	//클래스에 대한 정보를 얻거나, 클래스의 메서드와 필드에 접근하고 호출할 수 있습니다. 이를 통해 자바의
	//객체 지향적 특성을 활용하여 유연하고 동적인 프로그램을 작성할 수 있습니다.

	//리플렉션을 사용하기 위해 java.lang.reflect 패키지에 있는 클래스와 인터페이스를 활용합니다. 
	//주요한 클래스와 메서드에 대한 간략한 설명은 다음과 같습니다:
	//
//		Class: 클래스의 메타데이터를 나타내는 클래스입니다. Class 객체를 통해 클래스의 이름, 필드, 메서드, 생성자 등의 정보를 얻을 수 있습니다.
//		Field: 클래스의 필드를 나타내는 클래스입니다. Field 객체를 통해 필드의 이름, 타입, 접근 제어자 등의 정보를 얻을 수 있으며, 필드의 값을 읽거나 수정할 수도 있습니다.
//		Method: 클래스의 메서드를 나타내는 클래스입니다. Method 객체를 통해 메서드의 이름, 매개변수 타입, 리턴 타입, 접근 제어자 등의 정보를 얻을 수 있으며, 메서드를 호출할 수도 있습니다.
//		Constructor: 클래스의 생성자를 나타내는 클래스입니다. Constructor 객체를 통해 생성자의 매개변수 타입, 접근 제어자 등의 정보를 얻을 수 있으며, 생성자를 호출하여 객체를 인스턴스화할 수도 있습니다.

	//리플렉션은 일반적인 자바 개발에서는 자주 사용되지 않지만, 프레임워크, 라이브러리, 
	//테스트 도구 등에서 동적인 환경에서의 프로그래밍이 필요한 경우 유용하게 사용될 수 있습니다. 
	//그러나 리플렉션은 성능 상의 이슈가 있으므로, 가능한 경우에는 정적인 방법으로 코드를 작성하는 것이 좋습니다.
}

```

---

> **C01BASIC**
> 

```java
package Ch29_;

import java.lang.reflect.Constructor;
import java.lang.reflect.Method;

public class C01BASIC {

	public static void main(String[] args) throws Exception {
		
		Class<?> clazz =  Class.forName("java.lang.String");
		
		//모든 Field 확인
//		Field[] fields = clazz.getDeclaredFields();
//		for(Field field : fields) {
//			System.out.println(field);
//		}
		
		//모든 생성자 확인
//		Constructor[] constructors =  clazz.getDeclaredConstructors();
//		for(Constructor con : constructors) {
//			System.out.println(con);
//		}
		
		//모든 메서드 확인
		Method [] methods = clazz.getDeclaredMethods();
		for(Method m : methods)
			System.out.println(m);
		
	

	}

}

```

---

> **C02BASIC**
> 

```java
package Ch29_;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

class Simple{
	String name;
	int age;
	String addr;
	public Simple() {}
	public Simple(String name) {this.name = name;}
	public Simple(String name,int age) {this.name = name;this.age = age;}
	public Simple(String name,int age, String addr) {this.name=name;this.age=age;this.addr=addr;}
	//getter and Setter
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	@Override
	public String toString() {
		return "Simple [name=" + name + ", age=" + age + ", addr=" + addr + "]";
	}
	
	//toString 
	
	
}

public class C02BASIC {

	public static void main(String[] args) throws Exception {
		//reflect로  매서드 사용하기
		Simple ob = new Simple();
		ob.setAge(10);

//		System.out.println(Simple.class);
		
		Class<?> clazz = Class.forName( String.valueOf(Simple.class).split(" ")[1] );
//		Method method = clazz.getDeclaredMethod("getAge", null);
//		Object result = method.invoke(ob,null);
//		System.out.println(result);
		
		//reflect로 생성자 사용하기
//		Constructor<?> constructor = clazz.getConstructor(String.class); //인자1 개받는 생성자
//		System.out.println(constructor);
//		Object obj =  constructor.newInstance("홍길동");
//		System.out.println(obj);
		
		//reflect로 field에 값넣기
//		Field field = clazz.getDeclaredField("addr");
//		field.set(ob, "대구");
//		System.out.println(ob);
		
	}

}

```

---

> **C00INFO**
> 

```java
package Ch29_;

public class C00INFO {
	//Reflect란 
	
	//자바의 Reflection(리플렉션)은 실행 중인 프로그램의 클래스, 인터페이스, 메서드, 필드 등의 정보를 
	//동적으로 얻고 조작할 수 있는 기능을 제공하는 API입니다. 리플렉션을 사용하면 컴파일 시간에 알려지지 않은 
	//클래스에 대한 정보를 얻거나, 클래스의 메서드와 필드에 접근하고 호출할 수 있습니다. 이를 통해 자바의
	//객체 지향적 특성을 활용하여 유연하고 동적인 프로그램을 작성할 수 있습니다.

	//리플렉션을 사용하기 위해 java.lang.reflect 패키지에 있는 클래스와 인터페이스를 활용합니다. 
	//주요한 클래스와 메서드에 대한 간략한 설명은 다음과 같습니다:
	//
//		Class: 클래스의 메타데이터를 나타내는 클래스입니다. Class 객체를 통해 클래스의 이름, 필드, 메서드, 생성자 등의 정보를 얻을 수 있습니다.
//		Field: 클래스의 필드를 나타내는 클래스입니다. Field 객체를 통해 필드의 이름, 타입, 접근 제어자 등의 정보를 얻을 수 있으며, 필드의 값을 읽거나 수정할 수도 있습니다.
//		Method: 클래스의 메서드를 나타내는 클래스입니다. Method 객체를 통해 메서드의 이름, 매개변수 타입, 리턴 타입, 접근 제어자 등의 정보를 얻을 수 있으며, 메서드를 호출할 수도 있습니다.
//		Constructor: 클래스의 생성자를 나타내는 클래스입니다. Constructor 객체를 통해 생성자의 매개변수 타입, 접근 제어자 등의 정보를 얻을 수 있으며, 생성자를 호출하여 객체를 인스턴스화할 수도 있습니다.

	//리플렉션은 일반적인 자바 개발에서는 자주 사용되지 않지만, 프레임워크, 라이브러리, 
	//테스트 도구 등에서 동적인 환경에서의 프로그래밍이 필요한 경우 유용하게 사용될 수 있습니다. 
	//그러나 리플렉션은 성능 상의 이슈가 있으므로, 가능한 경우에는 정적인 방법으로 코드를 작성하는 것이 좋습니다.
}

```

---

> **C01BASIC**
> 

```java
package Ch29_;

import java.lang.reflect.Constructor;
import java.lang.reflect.Method;

public class C01BASIC {

	public static void main(String[] args) throws Exception {
		
		Class<?> clazz =  Class.forName("java.lang.String");
		
		//모든 Field 확인
//		Field[] fields = clazz.getDeclaredFields();
//		for(Field field : fields) {
//			System.out.println(field);
//		}
		
		//모든 생성자 확인
//		Constructor[] constructors =  clazz.getDeclaredConstructors();
//		for(Constructor con : constructors) {
//			System.out.println(con);
//		}
		
		//모든 메서드 확인
//		Method [] methods = clazz.getDeclaredMethods();
//		for(Method m : methods)
//			System.out.println(m);
		
	

	}

}

```

---

> **C02BASIC**
> 

```java
package Ch29_;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

class Simple{
	String name;
	int age;
	String addr;
	public Simple() {}
	public Simple(String name) {this.name = name;}
	public Simple(String name,int age) {this.name = name;this.age = age;}
	public Simple(String name,int age, String addr) {this.name=name;this.age=age;this.addr=addr;}
	//getter and Setter
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	@Override
	public String toString() {
		return "Simple [name=" + name + ", age=" + age + ", addr=" + addr + "]";
	}
	
	//toString 
	
	
}

public class C02BASIC {

	public static void main(String[] args) throws Exception {
		//reflect로  매서드 사용하기
//		Simple ob = new Simple();
//		ob.setAge(10);
//
//		System.out.println(Simple.class);
//		
//		Class<?> clazz = Class.forName( String.valueOf(Simple.class).split(" ")[1] );
//		Method method = clazz.getDeclaredMethod("getAge", null);
//		Object result = method.invoke(ob,null);
//		System.out.println(result);
		
//		//reflect로 생성자 사용하기
//		Constructor<?> constructor = clazz.getConstructor(String.class); //인자1 개받는 생성자
//		System.out.println(constructor);
//		Object obj =  constructor.newInstance("홍길동");
//		System.out.println(obj);
//		
//		//reflect로 field에 값넣기
//		Field field = clazz.getDeclaredField("addr");
//		field.set(ob, "대구");
//		System.out.println(ob);
		
	}

}

```

---