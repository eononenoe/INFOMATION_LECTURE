# 💬 JAVA Socket 채팅 + Reflection(리플렉션) 완전 정복

---

## 📌 개요 (Overview)

이번 학습에서는

- **Socket 통신 기반 채팅 프로그램** (Console & Swing GUI 버전)
- **Thread로 송수신 분리**
- **Reflection(리플렉션) 기반 클래스 다루기**

까지 배우고 실습했습니다. ✨

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🌐 서버-클라이언트 채팅 프로그램

- 서버는 `ServerSocket`을 열고 대기
- 클라이언트는 `Socket`을 통해 서버에 연결
- **송신**과 **수신**을 각각 **Thread**로 분리해서 동시에 진행
- q를 입력하면 통신 종료

```java
// 서버
ServerSocket server = new ServerSocket(7000);
Socket client = server.accept();

// 송수신 Thread
new Thread(new ServerSendThread(dout)).start();
new Thread(new ServerRecvThread(din)).start();
```

---

### 🖥️ Swing 기반 채팅 GUI

- **서버 UI**와 **클라이언트 UI** 각각 JFrame으로 제작
- `JTextArea` + `JTextField` + `JScrollPane` 조합
- 엔터를 누르면 상대방에게 메시지 전송
- 스크롤은 항상 맨 아래로 자동 이동

```java
area.append("[Client] : " + txt1.getText() + "\n");
dout.writeUTF(txt1.getText());
txt1.setText("");
area.setCaretPosition(area.getDocument().getLength());
```

---

### 🪞 Reflection (리플렉션)

- 실행 중인 클래스 정보를 동적으로 읽고 수정할 수 있는 기능
- `Class`, `Field`, `Method`, `Constructor` 사용
- 런타임에 객체 생성, 메서드 호출, 필드 조작 가능

```java
Class<?> clazz = Class.forName("java.lang.String");
Method[] methods = clazz.getDeclaredMethods();
for(Method m : methods) {
    System.out.println(m);
}
```

```java
Constructor<?> constructor = clazz.getConstructor(String.class);
Object obj = constructor.newInstance("홍길동");
```

---

## ⚠ 주의사항 (Cautions)

- **Socket 통신은 송수신 스레드를 별도로 관리** 해야 끊김 없음
- **모든 스트림은 finally 블록에서 close()** 해야 함
- GUI 작업은 **Event Dispatch Thread(EDT)** 에서 실행되어야 안전
- Reflection은 **성능 저하** 가능성 있음 (빈번한 사용 주의)

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 🌐 채팅 통신
> 두 사람이 **휴대폰으로 문자 주고받기** 📱

---

### 🖥️ GUI 채팅창
> 서로 다른 창구에서 **쪽지 교환하는 창구 직원들** 🏢

---

### 🪞 Reflection
> 마법사가 **거울(Reflection)** 로 사물의 속성/기능을 보는 것 🪞✨  
> (필요할 때 클래스, 메서드, 필드를 동적으로 열람!)

---

## ✅ 한 줄 요약 (1-Line Summary)

> **JAVA로 채팅 프로그램 만들고, Reflection으로 클래스까지 자유자재로 조작하기!** 🚀

