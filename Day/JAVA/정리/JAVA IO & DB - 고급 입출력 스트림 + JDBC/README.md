# 💾 JAVA IO & DB - 고급 입출력 스트림 + JDBC

---

## 📌 개요 (Overview)

이번에는 Java 입출력 스트림과 데이터베이스 연동(JDBC)에 대해 배웠어요!

- 문자 변환 스트림 (OutputStreamWriter, InputStreamReader)
- 한 줄 단위 파일 읽기/쓰기 (BufferedReader, PrintWriter)
- 객체 직렬화(ObjectStream)
- DataInputStream / DataOutputStream
- MySQL DB 연결하고 데이터 INSERT/SELECT/UPDATE/DELETE
- Swing + DB 연동 (메모장 + 데이터베이스 저장)

까지 실습했습니다! 🚀

---

## 💡 핵심 개념 요약 (Key Concepts)

### 📝 문자 변환 스트림

```java
OutputStream out = new FileOutputStream("test.txt");
OutputStreamWriter writer = new OutputStreamWriter(out);
BufferedWriter bufferedWriter = new BufferedWriter(writer);

bufferedWriter.write("문자 변환 스트림 사용");
bufferedWriter.flush();
bufferedWriter.close();
```
- **바이트** → **문자** 변환하는 데 사용
- **BufferedWriter**로 쓰기 속도 개선

---

### 📚 한 줄 단위로 파일 쓰기 / 읽기

```java
// 쓰기
PrintWriter pout = new PrintWriter(new BufferedWriter(new FileWriter("test2.txt")));
pout.println("HELLO");
pout.println("WORLD");
pout.close();

// 읽기
BufferedReader bin = new BufferedReader(new FileReader("test2.txt"));
String line;
while ((line = bin.readLine()) != null) {
    System.out.println(line);
}
bin.close();
```
- 파일을 **라인(line)** 단위로 읽고 쓸 수 있음

---

### 📦 객체 직렬화(ObjectOutputStream)

```java
ObjectOutputStream oout = new ObjectOutputStream(new FileOutputStream("board.db"));
oout.writeObject(new Board(1, "제목", "내용", "작성자", new Date()));
oout.close();

// 역직렬화
ObjectInputStream oin = new ObjectInputStream(new FileInputStream("board.db"));
Board board = (Board) oin.readObject();
System.out.println(board);
oin.close();
```
- **객체**를 파일에 통째로 저장하고 복원할 수 있음

---

### 📊 DataInputStream / DataOutputStream

```java
// 저장
DataOutputStream dout = new DataOutputStream(new FileOutputStream("test3.txt"));
dout.writeUTF("홍길동");
dout.writeDouble(95.5);
dout.writeInt(100);
dout.close();

// 읽기
DataInputStream din = new DataInputStream(new FileInputStream("test3.txt"));
System.out.println(din.readUTF());
System.out.println(din.readDouble());
System.out.println(din.readInt());
din.close();
```
- **원시 자료형 (int, double, UTF)** 저장/복원할 때 사용

---

### 🛢️ JDBC를 통한 데이터베이스 연결

```java
Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/testdb", "root", "1234"
);

// INSERT 예시
PreparedStatement pstmt = conn.prepareStatement("insert into tbl_std values(?,?,?)");
pstmt.setString(1, "홍길동");
pstmt.setInt(2, 20);
pstmt.setString(3, "서울");
pstmt.executeUpdate();
conn.close();
```
- `Class.forName()`으로 드라이버 로딩
- `Connection`, `PreparedStatement`로 DB 작업

---

### 🎨 Swing + DB 연동

```java
// 메모 입력
String text = area1.getText();
PreparedStatement pstmt = conn.prepareStatement("insert into tbl_memo values(null, ?, now())");
pstmt.setString(1, text);
pstmt.executeUpdate();
```
- 입력한 메모를 **DB에 저장**
- 저장된 메모들을 읽어와 **GUI에 표시**

---

## ⚠ 주의사항 (Cautions)

- **Stream**은 사용 후 꼭 `close()` 하기 (메모리 누수 방지)
- **ObjectOutputStream** 사용 시, 클래스는 반드시 `implements Serializable`
- **DB URL, ID, PW** 하드코딩 금지 (보안 주의!)
- **SQLException** 발생 시 `try-catch-finally` 필수
- MySQL은 반드시 **로컬 서버 켜기**!

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 📝 문자 변환 스트림
> **바이트**를 **문자**로 해석하는 통역사 🧑‍🏫

---

### 📚 한 줄 단위 읽기/쓰기
> **책을 한 줄 한 줄 읽고 적는 것** 📖✏️

---

### 📦 객체 직렬화
> 사람을 사진 찍어 저장하고 다시 보는 것 📸

---

### 📊 DataInputStream
> 데이터 타입을 구분해서 꺼내오는 **슈퍼 마켓** 🎁

---

### 🛢️ JDBC
> 프로그램이 **DB와 통신하는 전화선** ☎️

---

### 🎨 Swing + DB
> **메모 앱**을 직접 만들어서, 입력한 내용을 **DB에 저장**하는 프로젝트 📝

---

## ✅ 한 줄 요약 (1-Line Summary)

> **파일과 DB를 자유자재로 다루는 능력! JAVA IO & JDBC 마스터!** 🚀

