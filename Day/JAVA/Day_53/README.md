# 01

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
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Reader;
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
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.text.BadLocationException;

class Memo{
	private int id;
	private String text;
	private LocalDateTime createdAt;
	Memo(){}
	public Memo(int id, String text, LocalDateTime createdAt) {
		super();
		this.id = id;
		this.text = text;
		this.createdAt = createdAt;
	}
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
	@Override
	public String toString() {
		return "Memo [id=" + id + ", text=" + text + ", createdAt=" + createdAt + "]";
	}
	//toString
	//getter and setter
	//모든 인자생성자
	//디폴트 생성자
}

class SelectFrame extends JFrame implements MouseListener,ActionListener {
	
	C07GUI mainUi;
	JTable table;
	JScrollPane scroll;
	JPanel panel;
	JButton btn1;
	String selectedText;
	SelectFrame(C07GUI mainUi){
		super("SELECT 결과");
		this.mainUi = mainUi;
		
		setBounds(100,100,500,500);
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		
		//panel
		panel = new JPanel();
		panel.setLayout(null);
		
		//
		btn1 = new JButton("선택");
		btn1.setBounds(410,10,70,30);
		btn1.addActionListener(this);

		panel.add(btn1);
		
		//frame(panel)
		add(panel);
		
		//event
		
		
		setVisible(false);
	}
	void select(Connection conn , PreparedStatement pstmt , ResultSet rs) {
		
		if(scroll!=null) {
			panel.remove(table);
			panel.remove(scroll);
		}
		
		//component
		String [] columns = {"ID","TEXT","CREATED_AT"};
		List<String[]>data = new ArrayList();
		

		try {
			
			//SQL 준비
			pstmt = conn.prepareStatement("select * from tbl_memo");
			
			//SQL 실행
			List<Memo> list = new ArrayList();
			Memo memo;
			rs =  pstmt.executeQuery();
			if(rs!=null) {
				while(rs.next()) {
					memo = new Memo();
					memo.setId(rs.getInt("id"));
					memo.setText(rs.getString("text"));
					Timestamp timestamp = rs.getTimestamp("createdAt");
					memo.setCreatedAt(timestamp.toLocalDateTime());
					list.add(memo);
					
					data.add(new String[] {rs.getString("id"),rs.getString("text"),rs.getString("createdAt")});
					
				}
			}
			list.forEach(System.out::println);
			
			//------------------------------------------
			
			String[][] arr = new String[data.size()][];
			//for 값복사
			for(int i=0;i<data.size();i++) {
				arr[i]=data.get(i);
				System.out.println(data.get(i));
			}
			table = new JTable(arr,columns);
			table.addMouseListener(this);
//			table.setBounds(10,10,400,400);
			
			scroll = new JScrollPane(table);
			scroll.setBounds(10,10,400,400);
			//panel(component)
//			panel.add(table);
			panel.add(scroll);
			
		}catch(Exception e3) {
			e3.printStackTrace();
		}finally {
			try {rs.close();}catch(Exception e2) {}
			try {pstmt.close();}catch(Exception e2) {}
		}
		
	}
	@Override
	public void mouseClicked(MouseEvent e) {
		int selectedRow = table.getSelectedRow();
		selectedText = table.getValueAt(selectedRow, 1).toString();
		System.out.println("CLICKED.." + selectedText);
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
	@Override
	public void actionPerformed(ActionEvent e) {
		if(e.getSource()==btn1) {
			//mainUI에 selectedText를 전달
			mainUi.area1.setText(selectedText);
			//현재프레임은 종료
//			dispose();
		}
		
	}
	
}

class C07GUI extends JFrame implements ActionListener, KeyListener, MouseListener {
	JButton btn1;
	JButton btn2;
	JButton btn3;	//INSERT
	JButton btn4;	//UPDATE
	JButton btn5;	//DELETE
	JButton btn6;	//SELECTONE
	
	JButton input;
	JTextField txt1;
	JTextArea area1;
	
	Writer out;
	
	// DB CONN DATA
	static String id = "root";
	static String pw = "1234";
	static String url = "jdbc:mysql://localhost:3306/testdb";

	// JDBC참조변수
	static Connection conn = null;
	static PreparedStatement pstmt = null;
	static ResultSet rs = null;
	
	//SELECT FRAME
	SelectFrame selectFrame;
	
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

		btn3 = new JButton("INSERT");// INSERT : btn3
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
		
		//DB CONN
		// DB 연결코드
		Class.forName("com.mysql.cj.jdbc.Driver");
		System.out.println("Driver Loading Success...");
		conn = DriverManager.getConnection(url, id, pw);
		System.out.println("DB CONNECTED...");
		
		//SELECT FRAME
		selectFrame = new SelectFrame(this);
	}

	@Override
	public void actionPerformed(ActionEvent e) {

//		System.out.println("클릭!");
		if (e.getSource() == btn1) {
			System.out.println("저장하기");
			String contents = area1.getText();
			
			//파일탐색기 열기
			JFileChooser fileChooser = new JFileChooser();
			fileChooser.setDialogTitle("파일 저장 위치를 선택하세요");
			fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
			
			File defaultDirPath = new File("C:\\IOTEST");
			if(defaultDirPath.exists())
				fileChooser.setCurrentDirectory(defaultDirPath);
			
			int selectedVal = fileChooser.showSaveDialog(null);
			System.out.println("selectedVal : " + selectedVal);
			
			if(selectedVal == JFileChooser.APPROVE_OPTION) {
				File selectedFile = fileChooser.getSelectedFile();
				System.out.println("selectedFile : " + selectedFile);
				
				//파일확장자 추가
				String filePath = selectedFile.toString();
				if(!selectedFile.toString().endsWith(".txt")) {
					filePath = selectedFile.toString()+".txt";
				}
				System.out.println("filePath : " + filePath);
				
//				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
//				String filename = LocalDateTime.now().format(formatter);
				
				try {
					out = new FileWriter(filePath);
					out.write(contents);
					out.flush();
				}catch(Exception e1) {
					e1.printStackTrace();
				}finally {
					try {out.close();} catch (IOException e1) {e1.printStackTrace();}
				}
			}
					
			
		} else if (e.getSource() == btn2) {
			
			System.out.println("불러오기");
			//파일탐색기 열기
			JFileChooser fileChooser = new JFileChooser();
			fileChooser.setDialogTitle("파일을 선택하세요");
			fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
		 
			File defaultDirPath = new File("C:\\IOTEST");
			if(defaultDirPath.exists())
				fileChooser.setCurrentDirectory(defaultDirPath);
			
	
			int selectedVal = fileChooser.showSaveDialog(null);
			System.out.println("selectedVal : " + selectedVal);
			if(selectedVal == JFileChooser.APPROVE_OPTION) {
				File selectedFile = fileChooser.getSelectedFile();
				System.out.println("selectedFile : " + selectedFile);
				
				try {
					
					Reader fin =new FileReader(selectedFile.toString()); 
					StringBuffer buffer = new StringBuffer();
					while(true) {
						int data = fin.read();
						if(data==-1) 
							break;
						buffer.append((char)data);
					}
					area1.setText("");
					area1.append(buffer.toString());
					fin.close();
				}catch(Exception e1) {
					e1.printStackTrace();
				}
				
				
			}
	
		} 
		else if (e.getSource() == btn3) 
		{
			System.out.println("INSERT");
			
			try {
				
				pstmt = conn.prepareStatement("insert into tbl_memo values(null,?,now())");
				pstmt.setString(1,area1.getText());
				int result=pstmt.executeUpdate();
				
				if(result>0) {
					System.out.println("[INFO] INSERT 성공");
					JOptionPane.showMessageDialog(null, "INSERT 성공","INSERT 확인창",JOptionPane.INFORMATION_MESSAGE);	
				}
				else {
					System.out.println("[INFO] INSERT 실패");
					JOptionPane.showMessageDialog(null, "INSERT 실패","INSERT 확인창",JOptionPane.ERROR_MESSAGE);	
				}
				
				
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}finally {
				try {pstmt.close();}catch(Exception e1) {e1.printStackTrace();}
			}
			
			
		} 
		else if (e.getSource() == btn4) {
			
		}
		else if (e.getSource() == btn5) {
			
		}
		else if (e.getSource() == btn6) {
			selectFrame.setVisible(true);
			//전체 조회 가져와서 CONSOLE에 출력
			selectFrame.select(conn, pstmt, rs);
	
		}
		
		else if (e.getSource() == input) 
		{
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
			String str = area1.getText(startOffset,endOffset-startOffset );
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
		
		new C07GUI("Chatting UI");

	}

}

```

---

> **C08Tx**
> 

```java
package Ch21;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class C08Tx {

	//DB CONN DATA
	static String id = "root";
	static String pw = "1234";
	static String url = "jdbc:mysql://localhost:3306/testdb";
	
	//JDBC참조변수
	static Connection conn = null;
	static PreparedStatement pstmt = null;
	static ResultSet rs = null;
	
	
	public static void main(String[] args) {
		
		try {
			//DB 연결
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("Driver Loading Success...");
			conn = DriverManager.getConnection(url,id,pw);
			System.out.println("DB CONNECTED...");
			
			//
			System.out.println("INSERT 시작....");
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement("insert into tbl_std values('a',1,'a')");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("insert into tbl_std values('b',1,'a')");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("insert into tbl_std values('a',1,'a')");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("insert into tbl_std values('d',1,'a')");
			pstmt.executeUpdate();
			conn.commit();
			System.out.println("INSERT 종료....");
		}catch(Exception e) {
			e.printStackTrace();
			try{conn.rollback();}catch(Exception e3) {}
		}finally {
			try {pstmt.close();}catch(Exception e2) {}
			try {conn.close();}catch(Exception e2) {}
		}
		
		
	}

}

```

---

> **C09분산Tx**
> 

```java
package Ch21;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.XAConnection;
import javax.transaction.xa.XAResource;
import javax.transaction.xa.Xid;

import com.mysql.cj.jdbc.MysqlXADataSource;

public class C09분산Tx {
	
	public static void main(String[] args) throws Exception{
		//트랜잭션은 기본적으로 단일 Connection 에서 여러 Sql처리시 Tx 설정할 수있다
		//만약 여러 Connection 에서 각기 다른 sql문을 사용할 때 분산된 여러 Connection
		//의 sql을 하나의 트랜잭션으로 묶어주어야한다

		
        // 첫 번째 DB1에 대한 XADataSource 설정
        MysqlXADataSource xaDataSource1 = new MysqlXADataSource();
        xaDataSource1.setUrl("jdbc:mysql://localhost:3306/bookdb");
        xaDataSource1.setUser("root");
        xaDataSource1.setPassword("1234");
        
        //생략
        MysqlXADataSource xaDataSource2 = new MysqlXADataSource();
        xaDataSource2.setUrl("jdbc:mysql://localhost:3306/testdb");
        xaDataSource2.setUser("root");
        xaDataSource2.setPassword("1234");
        
        //------------------------------------
        // XAConnection 및 Connection 가져오기
        //------------------------------------
        XAConnection xaConnection1 = xaDataSource1.getXAConnection();
        Connection conn1 = xaConnection1.getConnection();
        XAResource xaResource1 = xaConnection1.getXAResource();

        XAConnection xaConnection2 = xaDataSource2.getXAConnection();
        Connection conn2 = xaConnection2.getConnection();
        XAResource xaResource2 = xaConnection2.getXAResource();
        
        // 트랜잭션 식별자 (XID) 생성
        Xid xid1 = createXid(100, 1); // 첫 번째 DB용 XID	(100 branchId , 1 GlobalId)
        Xid xid2 = createXid(100, 2); // 두 번째 DB용 XID    

        
        try {
            // 첫 번째 DB 트랜잭션 시작
            xaResource1.start(xid1, XAResource.TMNOFLAGS);
            PreparedStatement pstmt1 = conn1.prepareStatement("insert into tbl_user values('a','1')");
            pstmt1.executeUpdate();
            PreparedStatement pstmt2 = conn1.prepareStatement("insert into tbl_user values('b','1')");
            pstmt2.executeUpdate();
            PreparedStatement pstmt3 = conn1.prepareStatement("insert into tbl_user values('c','1')");
            pstmt3.executeUpdate();
            xaResource1.end(xid1, XAResource.TMSUCCESS);
            

            // 두 번째 DB 트랜잭션 시작
            xaResource2.start(xid2, XAResource.TMNOFLAGS);
            PreparedStatement pstmt4 = conn2.prepareStatement("INSERT INTO tbl_std values('a','1','a')");
            pstmt4.executeUpdate();
            PreparedStatement pstmt5 = conn2.prepareStatement("INSERT INTO tbl_std values('b','2','b')");//!!!!!!!!!!!
            pstmt5.executeUpdate();
            PreparedStatement pstmt6 = conn2.prepareStatement("INSERT INTO tbl_std values('c','2','c')");
            pstmt6.executeUpdate();
            xaResource2.end(xid2, XAResource.TMSUCCESS);

            // 2-Phase Commit 준비
            int prepare1 = xaResource1.prepare(xid1);
            int prepare2 = xaResource2.prepare(xid2);

            // 커밋
            if (prepare1 == XAResource.XA_OK && prepare2 == XAResource.XA_OK) {
                xaResource1.commit(xid1, false);
                xaResource2.commit(xid2, false);
                System.out.println("Transaction committed successfully.");
            } else {
                throw new Exception("Prepare failed for one or both databases.");
            }

        } catch (Exception e) {
            // 롤백
            xaResource1.rollback(xid1);
            xaResource2.rollback(xid2);
            System.out.println("Transaction rolled back due to an error.");
            e.printStackTrace();
        } finally {
            // 자원 해제
            conn1.close();
            conn2.close();
            xaConnection1.close();
            xaConnection2.close();
        }
        //-----------
        
		
	}
	
	//----------------------------
    private static Xid createXid(int bid, int tid) {
        return new Xid() {
            private int formatId = 1;
            private byte[] branchQualifier = new byte[] { (byte) tid };
            private byte[] globalTransactionId = new byte[] { (byte) bid };

            @Override
            public int getFormatId() {
                return formatId;
            }

            @Override
            public byte[] getBranchQualifier() {
                return branchQualifier;
            }

            @Override
            public byte[] getGlobalTransactionId() {
                return globalTransactionId;
            }
        };
        
    }
    
}	

```

---

> **C01Server**
> 

```java
package Ch22;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class C01Server {

	public static void main(String[] args) throws IOException {
		// 서버 소켓 생성
		ServerSocket server = new ServerSocket(7000); // 192.168.16.203:7000
		System.out.println("[INFO] SERVER SOCKET LISTENING");

		while (true) {
			//
			Socket client = server.accept();
			//
			System.out.println("CLIENT IP : " + client.getInetAddress());
			OutputStream out = client.getOutputStream();
			DataOutputStream dout = new DataOutputStream(out);
			dout.writeUTF("[INFO] WELCOME TO SERVER");
			dout.flush();
			dout.close();
			out.close();
			client.close();
		}

//		server.close();
//		System.out.println("서버 종료합니다");
	}

}

```

---

> **C01Client**
> 

```java
package Ch22;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.Socket;
import java.net.UnknownHostException;

public class C01Client {
	
	public static void main(String[] args) throws UnknownHostException, IOException {
		//Socket client = new Socket("IP",7000);
		Socket client = new Socket("192.168.16.11",7000);
		
		InputStream in =  client.getInputStream();
		DataInputStream din = new DataInputStream(in);
		String recv = din.readUTF();
		System.out.println(recv);
		
		din.close();
		in.close();
		client.close();
	}
}

```

---

> **C02Server**
> 

```java
package Ch22;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Scanner;

public class C02Server {

	public static void main(String[] args) throws IOException {
		// 서버 소켓 생성
		ServerSocket server = new ServerSocket(7002); // 192.168.16.203:7000
		System.out.println("[INFO] SERVER SOCKET LISTENING");

		//1회 응답
		Socket client = server.accept();
		
		System.out.println("[SERVER] 연결 시작합니다");
		//INOUT STREAM 
		System.out.println("CLIENT IP : " + client.getInetAddress());
		OutputStream out = client.getOutputStream();
		DataOutputStream dout = new DataOutputStream(out);
		InputStream in = client.getInputStream();
		DataInputStream din = new DataInputStream(in);
		
		//내용교환(q:종료)
		Scanner sc = new Scanner(System.in);
		String recv=null;
		String send=null;
		while(true) {
			//SERVER->CLIENT (송신)
			System.out.print("[SERVER(q:종료)] :");
			send=sc.nextLine();
			if(send.equals("q")) {
				break;
			}
			dout.writeUTF(send);
			dout.flush();
			//CLIENT->SERVER (수신)
			recv = din.readUTF();
			if(recv.equals("q"))
				break;
			System.out.println("[CLIENT ] : " + recv);	
		}
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

> **C02Client**
> 

```java
package Ch22;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.Scanner;

public class C02Client {
	public static void main(String[] args) throws UnknownHostException, IOException {
		
		Socket client = new Socket("192.168.16.203",7002);	
		
		System.out.println("[CLIENT] 연결 시작합니다");
		//INOUT STREAM 
		System.out.println("CLIENT IP : " + client.getInetAddress());
		OutputStream out = client.getOutputStream();
		DataOutputStream dout = new DataOutputStream(out);
		InputStream in = client.getInputStream();
		DataInputStream din = new DataInputStream(in);
		
		//내용교환(q:종료)
		Scanner sc = new Scanner(System.in);
		String recv=null;
		String send=null;
		
		while(true) {
			//CLIENT->SERVER (수신)
			recv = din.readUTF();
			if(recv.equals("q"))
				break;
			System.out.println("[SERVER ] : " + recv);	
			
			//SERVER->CLIENT (송신)
			System.out.print("[CLIENT(q:종료)] :");
			send=sc.nextLine();
			if(send.equals("q")) {
				break;
			}
			dout.writeUTF(send);
			dout.flush();

		}
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

> **C01ThreadMain**
> 

```java
package Ch23;

public class C01ThreadMain {
	public static void main(String[] args) throws InterruptedException {
		for(int i=0;i<5;i++) {
			System.out.println("TASK01...");
			Thread.sleep(500);
		}
		for(int i=0;i<5;i++) {
			System.out.println("TASK02...");
			Thread.sleep(500);
		}
	}
}

```

---

> **C02ThreadMain**
> 

```java
package Ch23;

public class C02ThreadMain {
	public static void main(String[] args) {
		// Runnable Interface 스레드분할

		// 01 작업객체 생성
		C02Worker1 w1 = new C02Worker1();
		C02Worker2 w2 = new C02Worker2();

		// 02 메인스레드에서 분리
		Thread th1 = new Thread(w1);
		Thread th2 = new Thread(w2);

		// 03 스레드 실행
		th1.start();
		th2.start();

		// Thread class 스레드 분할(익명 클래스사용)
		new Thread() {
			@Override
			public void run() {
				for (int i = 0; i < 5; i++) {
					System.out.println("TASK03...");
					try {
						Thread.sleep(500);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}.start();

		for (int i = 0; i < 5; i++) {
			System.out.println("MAIN THREAD...");
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}

```

---

> **C02Worker1**
> 

```java
package Ch23;

public class C02Worker1 implements Runnable {
	@Override
	public void run() {
		for (int i = 0; i < 5; i++) {
			System.out.println("TASK01...");
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}
```

---

> **C02Worker2**
> 

```java
package Ch23;

public class C02Worker2 implements Runnable {
	@Override
	public void run() {
		for (int i = 0; i < 5; i++) {
			System.out.println("TASK02...");
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}
```

---

> **C03SwingMain**
> 

```java
package Ch23;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

class C03GUI extends JFrame implements ActionListener, KeyListener {
	//
	JButton btn1;
	JButton btn2;
	JButton btn3;
	JButton btn4;
	JTextField txt1;
	JTextArea area1;
	JTextArea area2;

	Thread th1;
	Thread th2;

	C03GUI() {
		super(); // 상위클래스 생성자 호출

		setTitle("THREAD 확인하기");

		// 패널 추가
		JPanel pan1 = new JPanel();

		// 컴포넌트 객체 생성
		btn1 = new JButton("시작");
		btn2 = new JButton("중지");

		btn3 = new JButton("시작");
		btn4 = new JButton("중지");
		txt1 = new JTextField();
		area1 = new JTextArea();
		area2 = new JTextArea();
		JScrollPane scroll1 = new JScrollPane(area1);
		JScrollPane scroll2 = new JScrollPane(area2);

		// 컴포넌트 위치 지정
		scroll1.setBounds(50, 50, 190, 280);
		scroll2.setBounds(300, 50, 190, 280);
		// area1.setBounds(50,50,190,280); // Scroll추가시 제거
		txt1.setBounds(50, 350, 190, 30);
		btn1.setBounds(50, 400, 80, 30);
		btn2.setBounds(160, 400, 80, 30);
		btn3.setBounds(300, 400, 80, 30);
		btn4.setBounds(410, 400, 80, 30);

		// 컴포넌트를 리스너에 등록
		btn1.addActionListener(this);
		btn2.addActionListener(this);
		btn3.addActionListener(this);
		btn4.addActionListener(this);
		txt1.addKeyListener(this);

		// 기타설정
		area1.setEditable(false);

		// 패널에 컴포넌트 추가
		pan1.add(btn1);
		pan1.add(btn2);
		pan1.add(btn3);
		pan1.add(btn4);
		pan1.add(txt1);
		// pan1.add(area1); // Scroll추가시 제거
		pan1.add(scroll1);
		pan1.add(scroll2);

		// 레이아웃 null
		pan1.setLayout(null);

		// 패널을 프레임에 추가
		add(pan1);
		setBounds(100, 100, 600, 500);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setResizable(false);
		setVisible(true);
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		if (e.getSource() == btn1) {
			System.out.println("btn1..clicked"); // 시작
			C03Worker1 w1 = new C03Worker1(this);
			th1 = new Thread(w1);
			th1.start();
		}
		if (e.getSource() == btn2) {
			System.out.println("btn2..clicked"); // 종료
			if (th1 != null) {
				th1.interrupt();
				th1 = null;
			}
		}
		if (e.getSource() == btn3) {
			System.out.println("btn3..clicked"); // 시작
			C03Worker2 w2 = new C03Worker2(this);
			th2 = new Thread(w2);
			th2.start();
		}
		if (e.getSource() == btn4) {
			System.out.println("btn4..clicked");
			if (th2 != null) {
				th2.interrupt();
				th2 = null;
			}
		}
	}

	@Override
	public void keyTyped(KeyEvent e) {
		// TODO Auto-generated method stub

	}

	@Override
	public void keyPressed(KeyEvent e) {
		// System.out.println(e.getKeyChar());
		// System.out.println(e.getKeyCode());
		if (e.getKeyCode() == 10) // 엔터키 입력
		{
			String tmp = txt1.getText();
			area1.append(tmp + "\n");
			txt1.setText("");
		}

	}

	@Override
	public void keyReleased(KeyEvent e) {
		// TODO Auto-generated method stub

	}

}

public class C03SwingMain {

	public static void main(String[] args) {
		new C03GUI();

	}

}

```

---

> **C03Worker1**
> 

```java
package Ch23;

public class C03Worker1 implements Runnable {
	C03GUI gui;
	C03Worker1(C03GUI gui) {
		this.gui = gui;
	}
	@Override
	public void run() {
		while(true) {
			try {
				gui.area1.append("WORKER01....\n");
				Thread.sleep(500);
			}catch(InterruptedException e) {
				e.printStackTrace();
				break;
			}
		}
		System.out.println("WORKER01 INTERRUPTED...");
	}
}

```

---

> **C03Worker2**
> 

```java
package Ch23;

public class C03Worker2 implements Runnable {
	C03GUI gui;
	C03Worker2(C03GUI gui) {
		this.gui = gui;
	}
	@Override
	public void run() {
		while(true) {
			try {
				gui.area2.append("WORKER02....\n");
				Thread.sleep(500);
			}catch(InterruptedException e) {
				e.printStackTrace();
				break;
			}
		}
		System.out.println("WORKER02 INTERRUPTED...");
	}
}

```

---

> **C04ThreadMain_Ex_문제코드**
> 

```java
package Ch23;

class IncrementThread implements Runnable {
	private static int counter = 0;

	public int getCounter() {
		return counter;
	}

	@Override
	public void run() {
		for (int i = 0; i < 100000; i++) {
			counter++; // 공유변수값증가
			System.out.println(Thread.currentThread().getName() + "s counter : " + counter);
		}
	}

}

public class C04ThreadMain_Ex_문제코드 {

	public static void main(String[] args) throws InterruptedException {

		
		IncrementThread incrementThread1 = new IncrementThread();
		IncrementThread incrementThread2 = new IncrementThread();
		IncrementThread incrementThread3 = new IncrementThread();
		IncrementThread incrementThread4 = new IncrementThread();

		Thread thread1 = new Thread(incrementThread1);
		Thread thread2 = new Thread(incrementThread2);
		Thread thread3 = new Thread(incrementThread3);
		Thread thread4 = new Thread(incrementThread3);

		thread1.setName("TH1");
		thread2.setName("TH2");
		thread3.setName("TH3");
		thread4.setName("TH4");

		thread1.start();
		thread2.start();
		thread3.start();
		thread4.start();
		//메인 스레드가 thread1,thread2의 작업이 모두 완료될 때까지 대기하도록 설정
		thread1.join();
		thread2.join();
		thread3.join();
		thread4.join();

		System.out.println("Final value: " + incrementThread1.getCounter());

	}
}

```

---

> **C05ThreadMain_Ex_임계영역설정**
> 

```java
package Ch23;

class IncrementThread implements Runnable {
	private static int counter = 0;

	private static final Object lock = new Object();

	public int getCounter() {
		return counter;
	}

	@Override
	public void run() {
		for (int i = 0; i < 100000; i++) {
			synchronized (lock) {
				//작업내용
				counter++; // 공유변수값증가
				System.out.println(Thread.currentThread().getName() + "s counter : " + counter);
				
				try {
					if(i<=99999) {
						lock.notifyAll();	//다른스레드에게 알림
						lock.wait(5);		//잠깐 대기
					}
				}catch(InterruptedException e) {
					e.printStackTrace();
					break;
				}
			}
		}
	}

}

public class C05ThreadMain_Ex_임계영역설정 {

	public static void main(String[] args) throws InterruptedException {

		IncrementThread incrementThread1 = new IncrementThread();
		IncrementThread incrementThread2 = new IncrementThread();
		IncrementThread incrementThread3 = new IncrementThread();
		IncrementThread incrementThread4 = new IncrementThread();

		Thread thread1 = new Thread(incrementThread1);
		Thread thread2 = new Thread(incrementThread2);
		Thread thread3 = new Thread(incrementThread3);
		Thread thread4 = new Thread(incrementThread3);

		thread1.setName("TH1");
		thread2.setName("TH2");
		thread3.setName("TH3");
		thread4.setName("TH4");

		thread1.start();
		thread2.start();
		thread3.start();
		thread4.start();
		// 메인 스레드가 thread1,thread2의 작업이 모두 완료될 때까지 대기하도록 설정
		thread1.join();
		thread2.join();
		thread3.join();
		thread4.join();

		System.out.println("Final value: " + incrementThread1.getCounter());

	}
}

```

---