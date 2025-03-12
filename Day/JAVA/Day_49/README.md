# 01

> **C06SwingEventMain**
> 

```java
package Ch18;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

class C06GUI extends JFrame implements ActionListener{
	JButton btn1;
	JButton btn2;
	JButton btn3;
	JButton input;
	C06GUI(String title) {
		//Frame
		super(title);
		setBounds(100, 100, 410, 370);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		//Panel
		JPanel panel = new JPanel();
		panel.setLayout(null);
		
		//Component
		btn1 = new JButton("파일로 저장");
		btn1.setBounds(270,15,110,30);
		btn2 = new JButton("1:1 요청");
		btn2.setBounds(270,55,110,30);
		btn3 = new JButton("대화기록보기");
		btn3.setBounds(270,95,110,30);
		JTextArea area1 = new JTextArea();
		JScrollPane scroll1 = new JScrollPane(area1);
		scroll1.setBounds(15,15,240,250);
		JTextField txt1 = new JTextField();
		txt1.setBounds(15,280,240,30);
		input = new JButton("입력");
		input.setBounds(270,280,110,30);
		
		//event listener add
		btn1.addActionListener(this);
		btn2.addActionListener(this);
		btn3.addActionListener(this);
		input.addActionListener(this);
		
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

	@Override
	public void actionPerformed(ActionEvent e) {
//		System.out.println("클릭!");
		if(e.getSource()==btn1) {
			System.out.println("파일로 저장 클릭");
		}else if(e.getSource()==btn2) {
			System.out.println("1:1 요청 클릭");
		}else if(e.getSource()==btn3) {
			System.out.println("대화기록보기 클릭");
		}else if(e.getSource()==input) {
			System.out.println("입력 클릭");
		}
	}
}

public class C06SwingEventMain {
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
		new C06GUI("Chatting Server");
	}

}

```

---

> **C07SwingEventMain**
> 

```java
package Ch18;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.text.BadLocationException;

class C07GUI extends JFrame implements ActionListener, KeyListener, MouseListener {
	JButton btn1;
	JButton btn2;
	JButton btn3;
	JButton input;
	JTextField txt1;
	JTextArea area1;

	C07GUI(String title) {
		// Frame
		super(title);
		setBounds(100, 100, 410, 370);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

		// Panel
		JPanel panel = new JPanel();
		panel.setLayout(null);

		// Component
		btn1 = new JButton("파일로 저장");
		btn1.setBounds(270, 15, 110, 30);
		btn2 = new JButton("1:1 요청");
		btn2.setBounds(270, 55, 110, 30);
		btn3 = new JButton("대화기록보기");
		btn3.setBounds(270, 95, 110, 30);
		area1 = new JTextArea();
		JScrollPane scroll1 = new JScrollPane(area1);
		scroll1.setBounds(15, 15, 240, 250);
		txt1 = new JTextField();
		txt1.setBounds(15, 280, 240, 30);
		input = new JButton("입력");
		input.setBounds(270, 280, 110, 30);

		// event listener add
		btn1.addActionListener(this);
		btn2.addActionListener(this);
		btn3.addActionListener(this);
		input.addActionListener(this);
		txt1.addKeyListener(this);
		area1.addMouseListener(this);

		// Panel(Component)
		panel.add(btn1);
		panel.add(btn2);
		panel.add(btn3);
		panel.add(scroll1);
		panel.add(txt1);
		panel.add(input);

		// Frame(Panel)
		add(panel);

		// Frame
		setVisible(true);

	}

	@Override
	public void actionPerformed(ActionEvent e) {
//		System.out.println("클릭!");
		if (e.getSource() == btn1) {
			System.out.println("파일로 저장 클릭");
		} else if (e.getSource() == btn2) {
			System.out.println("1:1 요청 클릭");
		} else if (e.getSource() == btn3) {
			System.out.println("대화기록보기 클릭");
		} else if (e.getSource() == input) {
			System.out.println("입력 클릭");
		}
	}

	@Override
	public void keyTyped(KeyEvent e) {
//		System.out.println("keyTyped..." + e.getKeyChar());
//		System.out.println("keyTyped..." + e.getKeyCode());
	}

	@Override
	public void keyPressed(KeyEvent e) {
//		System.out.println("keyPressed..." + e.getKeyChar());
		System.out.println("keyPressed..." + e.getKeyCode());
		if (e.getSource() == txt1) {
			if (e.getKeyCode() == 10) {
				String message = txt1.getText();
				System.out.println(message);
				area1.append(message + "\n");
				txt1.setText("");
			}
		}
	}

	@Override
	public void keyReleased(KeyEvent e) {
//		System.out.println("keyReleased..."+e.getKeyChar());
//		System.out.println("keyReleased..."+e.getKeyCode());
	}

	@Override
	public void mouseClicked(MouseEvent e) {
		try {
//			System.out.println("mouseClicked..." + e.getPoint());
			int offset = area1.viewToModel(e.getPoint());
//			System.out.println("mouseClicked...offset : " + offset);
			int row;
			row = area1.getLineOfOffset(offset);
//			System.out.println("mouseClick... row : " + row);
			int startOffset = area1.getLineStartOffset(row);
			int endOffset = area1.getLineEndOffset(row);
//			System.out.printf("%d %d\n",startOffset,endOffset);
			String str = area1.getText(startOffset,endOffset-startOffset);
			System.out.println(str);
		} catch (BadLocationException e1) {
			e1.printStackTrace();
		}
		

	}

	@Override
	public void mousePressed(MouseEvent e) {
		// TODO Auto-generated method stub

	}

	@Override
	public void mouseReleased(MouseEvent e) {
		// TODO Auto-generated method stub

	}

	@Override
	public void mouseEntered(MouseEvent e) {
		// TODO Auto-generated method stub

	}

	@Override
	public void mouseExited(MouseEvent e) {
		// TODO Auto-generated method stub

	}
}

public class C07SwingEventMain {
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
		new C07GUI("Chatting Server");
	}

}

```

---

> **C01높이입력삼각형**
> 

```java
package Test;

import java.util.Scanner;

public class C01높이입력삼각형 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		System.out.print("높이 입력 : ");
		int height = sc.nextInt();
		for (int i = 0; i < height; i++) {
			for (int j = 0; j < (height - 1) - i; j++) {
				System.out.print(" ");
			}
			for (int k = 0; k <= 2 * i; k++) {
				System.out.print("*");
			}
			System.out.println();
		}

	}
}

```

---

> **C02높이입력다이아몬드**
> 

```java
package Test;

import java.util.Scanner;
// Scanner 클래스 호출

public class C02높이입력다이아몬드 {
	// public = JVM이 접근하기위해서 사용
	// class = 객체를 생성하기 위한 틀
	// C02높이입력다이아몬드 = 클래스명
	public static void main(String[] args) {
		// public = JVM이 접근하기위해서 사용
		// static = 객체를 생성하지 않은 채로 바로 작업을 수행해야 하기 때문에 사용
		// void = 메인 메서드를 호출하는 JVM에서 반환값을 요구하지 않으니 사용
		// main = 프로그램이 실행될 때 가장 먼저 실행되는 코드블록
		// String[] args = 프로그램 실행시 전달된 입력값을 받을 수 있는 변수
		Scanner sc = new Scanner(System.in);
		// Scanner = 사용자 입력을 받을 수 있는 클래스
		// sc: Scanner = 객체 이름 객체를 사용하여 사용자의 입력을 받을 수 있다
		// new Scanner(System.in) = 시스템의 표준 입력(키보드 입력)을 받아오는 Scanner 객체를 생성

		int height;
		// height = 사용자로부터 입력받을 다이아몬드의 높이를 저장할 변수
		while (true) {
			// 무한 반복문 시작 사용자가 올바른 입력을 할 때까지 계속 반복
			System.out.print("높이 : ");
			// 사용자에게 "높이 : "를 출력하여 입력을 요구
			height = sc.nextInt();
			// Scanner 객체 sc를 사용해 사용자가 입력한 값을 정수로 받아 height 변수에 저장
			if (height % 2 != 0) {
				// height가 홀수일 때만 계속 진행 (짝수 입력을 거부)
				break;
				// height가 홀수면 반복문을 탈출하고 다이아몬드 별 찍기 실행
			} else {
				System.out.println("홀수값만 입력해주세요.");
				// height가 짝수일 경우 "홀수값만 입력해주세요." 메세지 출력
			}
		}
		
//		height = 7 로 가정
//		------
//		윗부분
//		------
//		i(행)					space(공백)						star(별)
//		================================================================================
//		0						(height / 2) - 0 = 3			0 * 2 = 0
//		1						(height / 2) - 1 = 2			1 * 2 = 2
//		2						(height / 2) - 2 = 1			2 * 2 = 4
//		3						(height / 2) - 3 = 0			3 * 2 = 6
//		---------------------------------------------------------------------------------
//		i<height				space = 0						star = 0
//								space++							star++
//								space < (height / 2) - i		star <= i * 2
//		-------
//		아랫부분
//		-------
//		i(행)					space(공백)						star(별)
//		================================================================================
//		4						4 - (height / 2) = 1			((height - 1) * 2) - 2 * 4 = 4
//		5						5 - (height / 2) = 2			((height - 1) * 2) - 2 * 5 = 2
//		6						6 - (height / 2) = 3			((height - 1) * 2) - 2 * 6 = 0
//		---------------------------------------------------------------------------------
//		i >= height / 2 + 1		space = 0						star = 0
//								space++							star++
//								space < i - height / 2			star <= ((height - 1) * 2) - 2 * i
		
		int i = 0;
		// i는 다이아몬드 작동 시 현재 줄의 번호를 뜻함.
		for (i = 0; i < height; i++) {
			// height 만큼 반복 height가 다이아몬드의 전체 높이
			if (i <= (height / 2)) {
				// i가 다이아몬드의 중간(높이/2)보다 작거나 같으면 윗부분 해당
				for (int space = 0; space < (height / 2) - i; space++) {
					// 높이 / 2 - i는 공백의 개수를 계산, i가 커질수록 공백이 줄어듬
					System.out.print(" ");
					// 공백을 하나씩 출력
				}
				for (int star = 0; star <= i * 2; star++) {
					// i가 0일 때는 별 1개, i가 1일 때는 별 3개, 이렇게 별의 개수가 점점 증가식
					System.out.print("*");
					// 별을 하나씩 출력
				}
			} else {
				// i가 중간보다 크면 아랫부분 해당
				for (int space = 0; space < i - height / 2; space++) {
					// i - height / 2는 공백의 개수를 계산, i가 커질수록 공백이 증가
					System.out.print(" ");
					// 공백을 하나씩 출력
				}
				for (int star = 0; star <= ((height - 1) * 2) - 2 * i; star++) {
					// 별을 출력하는 반복문
					System.out.print("*");
					// 별을 하나씩 출력
				}
			}
			System.out.println();
			// 한 줄을 출력한 후 다음 줄로 넘어감
		}
	}
}
```

---

> **Main**
> 

```java
package Test;

class Buyer {
	private int myMoney;
	private int appleCnt;
	

	public Buyer(int myMoney, int appleCnt) {
		super();
		this.myMoney = myMoney;
		this.appleCnt = appleCnt;
	}

	public void payment(Seller seller, int money) {
		this.myMoney -= money;
		int appleCnt = seller.receive(money);
		this.appleCnt = appleCnt;
	}

	@Override
	public String toString() {
		return "Buyer [myMoney=" + myMoney + ", appleCnt=" + appleCnt + "]";
	}
}

class Seller {
	private int myMoney;
	private int appleCnt;
	private int price;
	

	public Seller(int myMoney, int appleCnt, int price) {
		super();
		this.myMoney = myMoney;
		this.appleCnt = appleCnt;
		this.price = price;
	}

	public int receive(int money) {
		int cnt = money/this.price;
		this.myMoney += money;
		this.appleCnt -= cnt;
		return cnt;
	}

	@Override
	public String toString() {
		return "Seller [myMoney=" + myMoney + ", appleCnt=" + appleCnt + ", price=" + price + "]";
	}

}

public class main {

	public static void main(String[] args) {
		Buyer 홍길동 = new Buyer(10000, 0);
		Buyer 철수 = new Buyer(20000, 0);

		Seller 사과장수 = new Seller(100000, 100, 1000);

		홍길동.payment(사과장수, 5000);
		철수.payment(사과장수, 12000);

		System.out.println(홍길동);
		System.out.println(철수);
		System.out.println(사과장수);
	}
}

```

---