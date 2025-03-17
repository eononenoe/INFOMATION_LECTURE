# 01

> **C01CharConvertStreamMain**
> 

```java
package Ch20;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;

public class C01CharConvertStreamMain {

	public static void main(String[] args) throws Exception{
		String str = "문자 변환 스트림 사용";
		
		OutputStream out = new FileOutputStream("C:\\IOTEST\\test.txt");
		OutputStreamWriter wout = new OutputStreamWriter(out);
		BufferedWriter bout = new BufferedWriter(wout);
		bout.write(str);
		bout.flush();
		bout.close();
		
//		InputStream in = new FileInputStream("C:\\IOTEST\\test.txt");
//		BufferedInputStream bin =  new BufferedInputStream(in);
//		InputStreamReader rin = new InputStreamReader(bin);
//		while(true) {
//			int data = rin.read();
//			if(data==-1)
//				break;
//			System.out.print((char)data);
//		}
		
		
	}
}

```

---

> **C02ReadLineMain**
> 

```java
package Ch20;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.io.Writer;

public class C02ReadLineMain {
	
	public static void main(String[] args) throws Exception{
		
		Writer out = new FileWriter("C:\\IOTEST\\test2.txt");
		BufferedWriter bout = new BufferedWriter(out);	
		PrintWriter pout = new PrintWriter(bout);
		pout.println("HELLO");
		pout.println("HELLO");
		pout.println("HELLO");
		pout.flush();
		pout.close();
		
		
//		Reader in = new FileReader("C:\\IOTEST\\test2.txt");
//		BufferedReader bin = new BufferedReader(in);
//		
//		while(true) {
//			String data = bin.readLine();
//			if(data==null)
//				break;
//			System.out.println(data);
//		}
		
		
		
	}
}

```

---

> **C03DataInoutStreamMain**
> 

```java
package Ch20;

import java.io.DataInputStream;
import java.io.FileInputStream;

public class C03DataInoutStreamMain {

	public static void main(String[] args) throws Exception{
		
//		FileOutputStream out = new FileOutputStream("c:\\IOTEST\\test3.txt");
//		DataOutputStream dout = new DataOutputStream(out);
//		dout.writeUTF("홍길동");
//		dout.writeDouble(95.5);
//		dout.writeInt(100);
//		dout.flush();
//		dout.close();
		
		FileInputStream in = new FileInputStream("c:\\IOTEST\\test3.txt");
		DataInputStream din = new DataInputStream(in);
		String name= din.readUTF();
		System.out.println(name);
		double weight = din.readDouble();
		System.out.println(weight);
		int data = din.readInt();
		System.out.println(data);
		
	}
}

```

---

> **C04ObjectStreamMain**
> 

```java
package Ch20;

import java.io.FileInputStream;
import java.io.ObjectInputStream;
import java.io.Serializable;
import java.util.Date;

class Board implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private int bno;
	private String title;
	private String content;
	private String writer;
	private Date date;
	public Board(int bno, String title, String content, String writer, Date date) {
		super();
		this.bno = bno;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.date = date;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "Board [bno=" + bno + ", title=" + title + ", content=" + content + ", writer=" + writer + ", date="
				+ date + "]";
	}
	
	//All Args Constructor
	//Getter and Setter
	//toString
	
	
}

public class C04ObjectStreamMain {
	
	
	public static void main(String[] args) throws Exception{
		
//		FileOutputStream out = new FileOutputStream("c:\\IOTEST\\board.db");
//		ObjectOutputStream oout = new ObjectOutputStream(out);
//		oout.writeObject(new Board(1,"제목1","하2","홍길동",new Date()));;
//		oout.writeObject(new Board(2,"제목2","하3","남길동",new Date()));;
//		oout.flush();
//		oout.close();
//		out.close();
		
		//
		FileInputStream in = new FileInputStream("c:\\IOTEST\\board.db");
		ObjectInputStream oin = new ObjectInputStream(in);

 		Object obj =  oin.readObject();
		Board down = (Board)obj;
		System.out.println(down);
 		Object obj2 =  oin.readObject();
		Board down2 = (Board)obj2;
		System.out.println(down2);
		//더이상 읽을것이 없으면 java.io.EOFException 발생 
 		Object obj3 =  oin.readObject();
		Board down3 = (Board)obj3;
		System.out.println(down3);

	}

}

```

---

> **C01DBConn**
> 

```java
package Ch21;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class C01DBConn {
	public static void main(String[] args) {
		// DB CONN DATA
		String id = "root";
		String pw = "1234";
		String url = "jdbc:mysql://localhost:3306/testdb";

		// JDBC참조변수
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		//
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("Driver Loading Succeses...");
			conn = DriverManager.getConnection(url, id, pw);
			System.out.println("DB CONNECTED...");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}

```

---

> **C02Insert**
> 

```java
package Ch21;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class C02Insert {
	public static void main(String[] args) {
		// DB CONN DATA
		String id = "root";
		String pw = "1234";
		String url = "jdbc:mysql://localhost:3306/testdb";

		// JDBC참조변수
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		//
		try {
			//DRIVER 메모리 적재
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("Driver Loading Succeses...");
			//CONNECTION
			conn = DriverManager.getConnection(url, id, pw);
			System.out.println("DB CONNECTED...");
			//SQL 쿼리 준비
			String name = args[0];
			int age = Integer.parseInt(args[1]);
			String addr = args[2];
//			pstmt=conn.prepareStatement("insert into tbl_std values('?',?,'?')");
//			pstmt.setString(1, name);
//			pstmt.setInt(2, age);
//			pstmt.setString(3, addr);
			
			pstmt=conn.prepareStatement("insert into tbl_std values('"+name+"',"+age+",'"+addr+"')");
			//SQL 실행
			int result = pstmt.executeUpdate();
			
			if(result>0)
				System.out.println("INSERT 성공");
			else
				System.out.println("INSERT 실패");
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}

```

---

> **C03Update**
> 

```java
package Ch21;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class C03Update {

	public static void main(String[] args) {
		//DB CONN DATA
		String id = "root";
		String pw = "1234";
		String url = "jdbc:mysql://localhost:3306/testdb";
		
		//JDBC참조변수
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("Driver Loading Success...");
			conn = DriverManager.getConnection(url,id,pw);
			System.out.println("DB CONNECTED...");
			//sql 쿼리 준비
			String name =args[0];
			int age = Integer.parseInt(args[1]);
			String addr = args[2];
			pstmt=conn.prepareStatement("update tbl_std set age=?,addr=? where name=?");
			pstmt.setInt(1, age);
			pstmt.setString(2,addr);
			pstmt.setString(3, name);

			
			//실행
			int result = pstmt.executeUpdate();
			System.out.println("레코드 생성갯수 : " + result);
			if(result>0)
				System.out.println("UPDATE 성공");
			else
				System.out.println("UPDATE 실패");
		}catch(Exception e) {
			e.printStackTrace();
		}finally {	
			try { conn.close();} catch (SQLException e) {e.printStackTrace(); }
		}
	}

}

```

---

> **C04Delete**
> 

```java
package Ch21;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class C04Delete {

	public static void main(String[] args) {
		//DB CONN DATA
		String id = "root";
		String pw = "1234";
		String url = "jdbc:mysql://localhost:3306/testdb";
		
		//JDBC참조변수
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//
		//tbl_std 에 삭제 코드 넣어보세요(단일삭제하기)

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("Driver Loading Success...");
			conn = DriverManager.getConnection(url,id,pw);
			System.out.println("DB CONNECTED...");
			//sql 쿼리 준비
			String name =args[0];
//			int age = Integer.parseInt(args[1]);
//			String addr = args[2];
			pstmt=conn.prepareStatement("delete from tbl_std where name=?");
			pstmt.setString(1, name);

			
			//실행
			int result = pstmt.executeUpdate();
			System.out.println("레코드 생성갯수 : " + result);
			if(result>0)
				System.out.println("DELETE 성공");
			else
				System.out.println("DELETE 실패");
		}catch(Exception e) {
			e.printStackTrace();
		}finally {	
			try { conn.close();} catch (SQLException e) {e.printStackTrace(); }
		}
	}

}

```

---

> **C05Select**
> 

```java
package Ch21;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class C05Select {

	public static void main(String[] args) {
		//DB CONN DATA
		String id = "root";
		String pw = "1234";
		String url = "jdbc:mysql://localhost:3306/testdb";
		
		//JDBC참조변수
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("Driver Loading Success...");
			//DB 연결
			conn = DriverManager.getConnection(url,id,pw);
			System.out.println("DB CONNECTED...");
			//SQL 준비
			pstmt = conn.prepareStatement("select * from tbl_std");
			
			//SQL 실행
			rs = pstmt.executeQuery();
			if(rs!=null) {
				while(rs.next()) {
					System.out.print(rs.getString("name")+" ");
					System.out.print(rs.getInt("age")+" ");
					System.out.print(rs.getString("addr")+"\n");
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {	
			try { rs.close();} catch (SQLException e) {e.printStackTrace(); }
			try { pstmt.close();} catch (SQLException e) {e.printStackTrace(); }
			try { conn.close();} catch (SQLException e) {e.printStackTrace(); }
		}
	}

}

```

---

> **C06Ex**
> 

```java
package Ch21;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

class ChargeStation {
	private int no;
	private String section;
	private String station;
	private String name;
	private int zipcode;
	private String address;

	// Getter and Setter
	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getSection() {
		return section;
	}

	public void setSection(String section) {
		this.section = section;
	}

	public String getStation() {
		return station;
	}

	public void setStation(String station) {
		this.station = station;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getZipcode() {
		return zipcode;
	}

	public void setZipcode(int zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Override
	public String toString() {
		return "ChargeStation [no=" + no + ", section=" + section + ", station=" + station + ", name=" + name
				+ ", zipcode=" + zipcode + ", address=" + address + "]";
	}

	public ChargeStation(int no, String section, String station, String name, int zipcode, String address) {
		super();
		this.no = no;
		this.section = section;
		this.station = station;
		this.name = name;
		this.zipcode = zipcode;
		this.address = address;
	}

	// toString

	// 모든 인자 생성자

}

public class C06Ex {
	// DB CONN DATA
	static String id = "root";
	static String pw = "1234";
	static String url = "jdbc:mysql://localhost:3306/testdb";

	// JDBC참조변수
	static Connection conn = null;
	static PreparedStatement pstmt = null;
	static ResultSet rs = null;

	public static void connect() throws Exception {
		// DB 연결코드
		Class.forName("com.mysql.cj.jdbc.Driver");
		System.out.println("Drvier Loading Succeses...");
		conn = DriverManager.getConnection(url, id, pw);
		System.out.println("DB CONNECTED...");
	}

	public static void Select() throws Exception {
		// 전체 조회
		// SQL 준비
		pstmt = conn.prepareStatement("select * from chargestation");

		// SQL 실행
		rs = pstmt.executeQuery();
		if (rs != null) {
			while (rs.next()) {
				System.out.print(rs.getInt("순번") + "\t");
				System.out.print(rs.getString("행정구역") + "\t");
				System.out.print(rs.getString("지사") + "\t");
				System.out.print(rs.getString("시설명") + "\t");
				System.out.print(rs.getInt("우편번호") + "\t");
				System.out.print(rs.getString("주소") + "\n");
			}
		}
		freeConnection(pstmt, rs);
	}

	public static void SelectOne(int obj) throws Exception {
		// 전체 조회
		// SQL 준비
		pstmt = conn.prepareStatement("select * from chargestation where 순번=?");
		pstmt.setInt(1, obj);

		// SQL 실행
		rs = pstmt.executeQuery();
		if (rs != null) {
			while (rs.next()) {
				System.out.print(rs.getInt("순번") + "\t");
				System.out.print(rs.getString("행정구역") + "\t");
				System.out.print(rs.getString("지사") + "\t");
				System.out.print(rs.getString("시설명") + "\t");
				System.out.print(rs.getInt("우편번호") + "\t");
				System.out.print(rs.getString("주소") + "\n");
			}
		}
		freeConnection(pstmt, rs);
	}

	public static void Insert(ChargeStation obj) throws Exception {
		// ChargeStation 객체를 받아 내용 insert
		pstmt = conn.prepareStatement("insert into chargeStation values(?,?,?,?,?,?)");
		pstmt.setInt(1, obj.getNo());
		pstmt.setString(2, obj.getSection());
		pstmt.setString(3, obj.getStation());
		pstmt.setString(4, obj.getName());
		pstmt.setInt(5, obj.getZipcode());
		pstmt.setString(6, obj.getAddress());

		int result = pstmt.executeUpdate();
		if (result > 0)
			System.out.println("[INFO] INSERT 성공!");
		else
			System.out.println("[ERROR] INSERT 실패!");
		freeConnection(pstmt);
	}

	public static void Update(ChargeStation obj) throws Exception {
		// 수정
		pstmt = conn.prepareStatement("update chargeStation set 행정구역=?,지사=?,시설명=?,우편번호=?,주소=?  where 순번=?");

		pstmt.setString(1, obj.getSection());
		pstmt.setString(2, obj.getStation());
		pstmt.setString(3, obj.getName());
		pstmt.setInt(4, obj.getZipcode());
		pstmt.setString(5, obj.getAddress());
		pstmt.setInt(6, obj.getNo());

		// 실행
		int result = pstmt.executeUpdate();
		System.out.println("레코드 생성갯수 : " + result);
		if (result > 0)
			System.out.println("UPDATE 성공");
		else
			System.out.println("UPDATE 실패");
		freeConnection(pstmt);
	}

	public static void Delete(int obj) throws Exception {
		// 삭제
		pstmt = conn.prepareStatement("delete from chargeStation where 순번=?");
		pstmt.setInt(1, obj);
		int result = pstmt.executeUpdate();

		if (result > 0)
			System.out.println("DELETE 성공");
		else
			System.out.println("DELETE 실패");
		freeConnection(pstmt);

	}

	// 자원제거용 함수 오버로딩
	public static void freeConnection(Connection conn) throws Exception {
	}

	public static void freeConnection(PreparedStatement pstmt) throws Exception {
		pstmt.close();
	}

	public static void freeConnection(PreparedStatement pstmt, ResultSet rs) throws Exception {
		pstmt.close();
		rs.close();
	}

	public static void main(String[] args) {
		try {
			connect();
//			Insert(new ChargeStation(201, "대구광역시", "대구지사", "대구가스", 10101, "대구"));

//			Select();		//전체조회
			SelectOne(198); // 단건조회
//			Update(new ChargeStation(198, "부산광역시", "대현동지사", "정현가스", 5030921, "대구"));		//업데이트
//			Delete(201);		//삭제

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}

```

---

> **C07SwingAddDBMain**
> 

```java
package Ch21;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.text.BadLocationException;

class Memo {
	private int id;
	private String text;
	private LocalDateTime createdAt;

	// toStirng
	@Override
	public String toString() {
		return "Memo [id=" + id + ", text=" + text + ", createdAt=" + createdAt + "]";
	}

	// getter and setter
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	// 모든 인자 생성자
	public Memo(int id, String text, LocalDateTime createdAt) {
		super();
		this.id = id;
		this.text = text;
		this.createdAt = createdAt;
	}

	// 디폴트 생성자
	public Memo() {
	}
}

class C07GUI extends JFrame implements ActionListener, KeyListener, MouseListener {
	JButton btn1;
	JButton btn2;
	JButton btn3; // INSERT
	JButton btn4; // UPDATE
	JButton btn5; // DELETE
	JButton btn6; // SELECTONE

	// DB CONN DATA
	static String id = "root";
	static String pw = "1234";
	static String url = "jdbc:mysql://localhost:3306/testdb";

	// JDBC참조변수
	static Connection conn = null;
	static PreparedStatement pstmt = null;
	static ResultSet rs = null;

	JButton input;
	JTextField txt1;
	JTextArea area1;

	Writer out;

	C07GUI(String title) throws ClassNotFoundException, SQLException {
		// frame
		super(title);
		setBounds(100, 100, 410, 400);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

		// Panel
		JPanel panel = new JPanel();
		panel.setLayout(null);

		// Component 참조변수명
		area1 = new JTextArea(); // textarea = area1
		area1.setBounds(10, 10, 260, 280);
		// textarea's scroll = scroll1
		JScrollPane scroll1 = new JScrollPane(area1);
		scroll1.setBounds(10, 10, 250, 280);

		btn1 = new JButton("저장하기");// 파일로저장 : btn1
		btn1.setBounds(270, 10, 110, 30);

		btn2 = new JButton("불러오기");// 1:1요청 : btn2
		btn2.setBounds(270, 50, 110, 30);

		btn3 = new JButton("INSERT");// 대화기록보기 : btn3
		btn3.setBounds(270, 90, 110, 30);

		btn4 = new JButton("UPDATE");
		btn4.setBounds(270, 130, 110, 30);

		btn5 = new JButton("DELETE");
		btn5.setBounds(270, 170, 110, 30);

		btn6 = new JButton("SELECT");
		btn6.setBounds(270, 210, 110, 30);

		input = new JButton("입력"); // 입력 : input
		input.setBounds(270, 300, 110, 30);

		txt1 = new JTextField(); // textfield : txt1
		txt1.setBounds(10, 300, 250, 30);

		// event listener add
		btn1.addActionListener(this);
		btn2.addActionListener(this);
		btn3.addActionListener(this);
		btn4.addActionListener(this);
		btn5.addActionListener(this);
		btn6.addActionListener(this);
		input.addActionListener(this);
		txt1.addKeyListener(this);
		area1.addMouseListener(this);

		// panel(component)
//		panel.add(area1);
		panel.add(scroll1);
		panel.add(btn1);
		panel.add(btn2);
		panel.add(btn3);
		panel.add(btn4);
		panel.add(btn5);
		panel.add(btn6);
		panel.add(input);
		panel.add(txt1);

		// frame(panel)
		add(panel);

		// frame
		setVisible(true);

		// DB연결코드
		Class.forName("com.mysql.cj.jdbc.Driver");
		System.out.println("Drvier Loading Succeses...");
		conn = DriverManager.getConnection(url, id, pw);
		System.out.println("DB CONNECTED...");

	}

	@Override
	public void actionPerformed(ActionEvent e) {

//		System.out.println("클릭!");
		if (e.getSource() == btn1) {
			System.out.println("저장하기");
			String contents = area1.getText();

			// 파일탐색기 열기
			JFileChooser fileChooser = new JFileChooser();
			fileChooser.setDialogTitle("파일 저장 위치를 선택하세요");
			fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);

			File defaultDirPath = new File("C:\\IOTEST");
			if (defaultDirPath.exists())
				fileChooser.setCurrentDirectory(defaultDirPath);

			int selectedVal = fileChooser.showSaveDialog(null);
			System.out.println("selectedVal : " + selectedVal);

			if (selectedVal == JFileChooser.APPROVE_OPTION) {
				File selectedFile = fileChooser.getSelectedFile();
				System.out.println("selectedFile : " + selectedFile);

				// 파일확장자 추가
				String filePath = selectedFile.toString();
				if (!selectedFile.toString().endsWith(".txt")) {
					filePath = selectedFile.toString() + ".txt";
				}
				System.out.println("filePath : " + filePath);

//				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
//				String filename = LocalDateTime.now().format(formatter);

				try {
					out = new FileWriter(filePath);
					out.write(contents);
					out.flush();
				} catch (Exception e1) {
					e1.printStackTrace();

				} finally {
					try {
						out.close();
					} catch (IOException e1) {
						e1.printStackTrace();
					}
				}
			}

		} else if (e.getSource() == btn2) {
			System.out.println("불러오기");

			// 파일탐색기 열기
			JFileChooser fileChooser = new JFileChooser();
			fileChooser.setDialogTitle("파일을 선택하세요");
			fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);

			File defaultDirPath = new File("C:\\IOTEST");
			if (defaultDirPath.exists())
				fileChooser.setCurrentDirectory(defaultDirPath);

			int selectedVal = fileChooser.showSaveDialog(null);
			System.out.println("selectedVal : " + selectedVal);
			if (selectedVal == JFileChooser.APPROVE_OPTION) {

			}

		} else if (e.getSource() == btn3) {
			System.out.println("INSERT");
			try {
				pstmt = conn.prepareStatement("insert into tbl_memo values(null,?,now())");
				pstmt.setString(1, area1.getText());
				int result = pstmt.executeUpdate();

				if (result > 0) {
					System.out.println("[INFO] INSERT 완료!");
					JOptionPane.showMessageDialog(null, "INSERT 성공", "INSERT 확인창", JOptionPane.INFORMATION_MESSAGE);
				} else {
					System.out.println("[INFO] INSERT 실패!");
					JOptionPane.showMessageDialog(null, "INSERT 실패", "INSERT 확인창", JOptionPane.ERROR_MESSAGE);
				}
			} catch (SQLException el) {
				el.printStackTrace();
			} finally {
				try {
					pstmt.close();
				} catch (Exception el) {
					el.printStackTrace();
				}
			}
		} else if (e.getSource() == btn4) {
			System.out.println("UPDATE");
		} else if (e.getSource() == btn5) {
			System.out.println("DELETE");
		} else if (e.getSource() == btn6) {
			System.out.println("SELECT");
			try {
				// SQL 준비
				pstmt = conn.prepareStatement("select * from tbl_memo");
				// SQL 실행
				List<Memo> list = new ArrayList();
				Memo memo;
				rs = pstmt.executeQuery();
				if (rs != null) {
					while (rs.next()) {
						memo = new Memo();
						memo.setId(rs.getInt("id"));
						memo.setText(rs.getString("text"));
						Timestamp timestamp = rs.getTimestamp("createdAt");
						memo.setCreatedAt(timestamp.toLocalDateTime());
						list.add(memo);
					}
				}
				list.forEach(System.out::println);
			} catch (SQLException e3) {
				e3.printStackTrace();
			} finally {
				try {rs.close();} catch (Exception e2) {}
				try {pstmt.close();} catch (Exception e2) {}
			}
		} else if (e.getSource() == input) {
			System.out.println("입력");
		}

	}

	@Override
	public void keyTyped(KeyEvent e) {
//		System.out.println("keyTyped..."+e.getKeyChar());
//		System.out.println("keyTyped..."+e.getKeyCode());

	}

	@Override
	public void keyPressed(KeyEvent e) {
//		System.out.println("keyPressed..."+e.getKeyChar());	
//		System.out.println("keyPressed..."+e.getKeyCode());
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
//		System.out.println("keyReleased..."+e.getKeyChar());
	}

	@Override
	public void mouseClicked(MouseEvent e) {
		try {

//			System.out.println("mouseClicked..." + e.getPoint());
			int offset = area1.viewToModel(e.getPoint());
//			System.out.println("mouseClicked...offset : " + offset);
			int row = area1.getLineOfOffset(offset);
//			System.out.println("mouseClicked...row : " + row);
			int startOffset = area1.getLineStartOffset(row);
			int endOffset = area1.getLineEndOffset(row);
//			System.out.printf("%d %d\n", startOffset,endOffset);
			String str = area1.getText(startOffset, endOffset - startOffset);
			System.out.println(str);

		} catch (BadLocationException e1) {
			// TODO Auto-generated catch block
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

public class C07SwingAddDBMain {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		new C07GUI("Chatting UI");

	}

}

```

---