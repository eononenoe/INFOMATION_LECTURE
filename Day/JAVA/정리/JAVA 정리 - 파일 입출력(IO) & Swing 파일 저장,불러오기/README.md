# 📚 JAVA 정리 - 파일 입출력(IO) & Swing 파일 저장/불러오기

---

## 📌 개요 (Overview)

이번 파트에서는

- 파일에 **텍스트 저장/불러오기 (Writer/Reader)**
- 파일에 **바이트 단위 입출력 (InputStream/OutputStream)**
- **버퍼(Buffer)**를 활용한 빠른 복사
- **Swing UI**를 통한 텍스트 파일 저장/불러오기 기능 구현

을 학습했습니다! 🎯

---

## 💡 핵심 개념 요약 (Key Concepts)

### ✏️ 파일 쓰기 (Writer)

```java
Writer fout = new FileWriter("C:\\IOTEST\\test1.txt", true);
fout.write("Hello World\n");
fout.flush();
fout.close();
```
- **true** : 이어쓰기(append), **false** : 덮어쓰기(overwrite)

---

### 📖 파일 읽기 (Reader)

```java
Reader fin = new FileReader("C:\\IOTEST\\test1.txt");
int data;
while((data = fin.read()) != -1) {
    System.out.print((char)data);
}
fin.close();
```
- 한 글자씩 읽고 출력

---

### 💾 파일 복사 (Reader + Writer)

```java
Reader fin = new FileReader("source.txt");
Writer fout = new FileWriter("dest.txt");

int data;
while((data = fin.read()) != -1) {
    fout.write((char)data);
}
fin.close();
fout.close();
```
- 원본 파일 → 새 파일로 복사

---

### ⚡ 고속 복사 (버퍼 사용)

```java
char[] buf = new char[1024];
while((data = fin.read(buf)) != -1) {
    fout.write(buf, 0, data);
}
```
- 버퍼를 이용하면 속도가 훨씬 빨라진다.

---

### 📦 바이트 단위 파일 입출력 (InputStream/OutputStream)

```java
InputStream in = new FileInputStream("source.zip");
OutputStream out = new FileOutputStream("dest.zip");

byte[] buf = new byte[4096];
int data;
while((data = in.read(buf)) != -1) {
    out.write(buf, 0, data);
}
in.close();
out.close();
```
- 바이너리 파일(엑셀, ZIP 등)은 **InputStream/OutputStream** 사용!

---

### 🎨 Swing을 이용한 파일 저장/불러오기

```java
// 저장하기 버튼
JFileChooser fileChooser = new JFileChooser();
int result = fileChooser.showSaveDialog(null);
if(result == JFileChooser.APPROVE_OPTION){
    File file = fileChooser.getSelectedFile();
    Writer fout = new FileWriter(file);
    fout.write(area1.getText());
    fout.close();
}

// 불러오기 버튼
result = fileChooser.showOpenDialog(null);
if(result == JFileChooser.APPROVE_OPTION){
    File file = fileChooser.getSelectedFile();
    Reader fin = new FileReader(file);
    StringBuffer buffer = new StringBuffer();
    int data;
    while((data = fin.read()) != -1) {
        buffer.append((char)data);
    }
    area1.setText(buffer.toString());
    fin.close();
}
```
- `JFileChooser`로 파일 다이얼로그 띄우기
- 선택한 파일에 저장하거나 불러오기

---

## ⚠ 주의사항 (Cautions)

- **FileWriter** 생성시 두 번째 인자 `true/false`로 이어쓰기 여부 설정 주의
- **Reader/Writer**는 텍스트 파일 전용, 바이너리는 InputStream/OutputStream 사용
- **버퍼를 쓰면 무조건 빠르다** (특히 큰 파일 복사할 때!)
- **Swing**에서 파일을 다룰 때는 반드시 예외처리 (try-catch-finally) 해줄 것!

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### ✏️ Writer 예시

> 파일에 '일기' 쓰듯이 한 줄 한 줄 저장!

```java
Writer fout = new FileWriter("diary.txt");
fout.write("오늘은 즐거운 하루였다\n");
fout.close();
```

---

### 📦 InputStream 예시

> ZIP 파일, 엑셀파일 복사할 때는 **InputStream/OutputStream**!

```java
InputStream in = new FileInputStream("data.zip");
```

---

### 🎨 Swing 파일 저장 흐름

> [파일 선택 창] → [파일 저장] → [텍스트 저장 완료]

---

### 🛠 파일 복사 버퍼 유무 비교

| 방법 | 특징 | 속도 |
|:----|:----|:----|
| 버퍼 없이 한 바이트씩 읽기 | 느림 | 🐢 |
| 버퍼 배열로 묶어 읽기 | 빠름 | 🚀 |

---

## ✅ 한 줄 요약 (1-Line Summary)

> **파일은 버퍼로 빠르게, Swing은 JFileChooser로 편하게 다루자!** 🚀📦🖱️

