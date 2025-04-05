# 🛠️ JAVA Network, Thread, Swing, JDBC 고급 입출력 + 분산 트랜잭션 정리

---

## 📌 개요 (Overview)

이번 학습에서는 Java의 진짜 실무 기술인

- **Network 프로그래밍(Socket)**
- **Swing UI 개발**
- **DB 연동 (JDBC + Transaction)**
- **Thread(다중작업 처리)**
- **분산 트랜잭션 처리(XA)**

를 모두 경험했습니다! 😎

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🌐 Network Programming (Server/Client)

- **서버는** `ServerSocket`을 열고 기다림
- **클라이언트는** `Socket`을 통해 서버에 연결
- **DataInputStream**, **DataOutputStream** 으로 데이터 송수신

```java
ServerSocket server = new ServerSocket(7000);
Socket client = server.accept();
DataOutputStream dout = new DataOutputStream(client.getOutputStream());
dout.writeUTF("Welcome!");
```

---

### 🖥️ Swing UI + DB 연결

- **JTextArea**로 메모 입력
- **파일로 저장/불러오기** 가능
- 메모를 **MySQL DB**에 저장 (INSERT, UPDATE, DELETE, SELECT)
- DB 조회결과를 **JTable**로 보여주고 클릭하여 입력창에 불러오기

```java
PreparedStatement pstmt = conn.prepareStatement("INSERT INTO tbl_memo VALUES (null, ?, now())");
pstmt.setString(1, area1.getText());
pstmt.executeUpdate();
```

---

### 💾 JDBC 트랜잭션 관리 (TX)

- `setAutoCommit(false)` 로 수동 트랜잭션 시작
- `commit()` 또는 `rollback()` 으로 처리

```java
conn.setAutoCommit(false);
try {
    pstmt.executeUpdate();
    conn.commit();
} catch (Exception e) {
    conn.rollback();
}
```

---

### ⚡ 분산 트랜잭션 (Distributed Transaction, XA)

- **두 개 이상의 DB** 작업을 하나의 트랜잭션으로 처리
- `XAResource`, `Xid`를 이용하여 2PC (2-Phase Commit) 진행

```java
XAResource xaResource = xaConnection.getXAResource();
xaResource.start(xid, XAResource.TMNOFLAGS);
...
xaResource.end(xid, XAResource.TMSUCCESS);
xaResource.prepare(xid);
xaResource.commit(xid, false);
```

---

### 🧵 Thread & Synchronization (멀티스레드 + 동기화)

- 여러 개의 `Runnable`을 Thread로 실행
- `synchronized` 키워드로 임계 영역(공유 데이터 보호) 설정
- `wait()/notifyAll()` 사용해 스레드 간 협력

```java
synchronized(lock) {
    counter++;
    lock.notifyAll();
    lock.wait(5);
}
```

---

## ⚠ 주의사항 (Cautions)

- **ServerSocket/Socket**은 사용 후 반드시 `close()` 해야 함
- **트랜잭션 실패 시 rollback** 꼭 처리
- **멀티스레드 환경**에서는 공유 변수 보호를 위해 `synchronized` 필수
- **분산 트랜잭션**은 XA를 지원하는 DB에서만 가능
- Swing UI는 반드시 **EDT(Event Dispatch Thread)** 에서 업데이트!

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 🌐 네트워크
> 전화기를 들고 친구에게 '여보세요~' 하는 것 ☎️

---

### 🖥️ Swing
> **도화지에 버튼과 글씨판**을 그리고 그 위에서 대화하는 것 🎨

---

### 💾 트랜잭션
> 돈을 송금할 때, 출금과 입금이 **둘 다** 성공해야만 되는 것 💸

---

### ⚡ 분산 트랜잭션
> 두 개 은행계좌 사이에 돈을 옮기려는 슈퍼 영웅 🦸‍♂️

---

### 🧵 멀티스레드
> 여러 사람이 한 개 주방을 공유해서 요리하는 것 🍳

---

## ✅ 한 줄 요약 (1-Line Summary)

> **JAVA로 실전 네트워크 + UI + DB + 멀티스레드 + 트랜잭션 완전정복!** 🚀

