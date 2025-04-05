# 🔐 JSP 로그인 처리 & 📁 파일 다운로드 정리 

---

## 📌 개요 (Overview)

웹 애플리케이션에서 로그인 기능과 파일 다운로드 기능은 가장 많이 사용되는 기능 중 하나예요.  
JSP에서는 `session`, `request`, `response`, 그리고 입출력 스트림을 이용해 이 두 가지를 쉽게 구현할 수 있어요!

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🔐 로그인 처리 흐름

1. **로그인 폼 (`login_form.jsp`)**  
   - 사용자의 아이디와 패스워드를 입력 받는 화면.
   - 이미 로그인한 경우 메인 페이지로 리다이렉트!

2. **로그인 처리 (`login.jsp`)**  
   - `request.getParameter()`로 입력값을 받아와 유효성 검사 수행
   - 사용자 정보 확인 후 세션에 로그인 정보 저장
   - 성공 시 메인 페이지로 이동

3. **메인 페이지 (`main.jsp`)**  
   - 로그인 상태(`session`)가 없으면 로그인 페이지로 다시 이동

4. **로그아웃 처리 (`logout.jsp`)**  
   - `session.invalidate()`를 통해 세션 무효화
   - 로그인 페이지로 리다이렉트

#### ✅ 사용된 session 속성
- `isAuth`: 인증 상태 여부 (true/false)
- `role`: 사용자 권한 (예: ROLE_ADMIN)
- `session.setMaxInactiveInterval(30)`: 세션 유지 시간 설정 (초 단위)

---

### 📁 파일 다운로드 흐름

#### 📄 단일 파일 다운로드 (`04Download_SingleFile.jsp`)

- `FileInputStream`으로 파일 읽기
- `ServletOutputStream`으로 사용자 브라우저에 전송
- `Content-Type`과 `Content-Disposition`으로 다운로드 설정

```jsp
response.setHeader("Content-Type","application/octet-stream;charset=utf-8");
response.setHeader("Content-Disposition","attachment; filename=TEST.txt");
```

📌 주의: `JSP Writer(out)` 스트림을 clear()하고 `ServletOutputStream`을 사용해야 함

#### 📦 ZIP 파일 다운로드 (`05Download_zip.jsp`)

- 디렉토리 내의 모든 파일을 반복해서 읽기
- `ZipOutputStream`으로 묶어서 압축 파일 전송

```jsp
ZipEntry zipEntry = new ZipEntry(file.getName());
zout.putNextEntry(zipEntry);

while(true){
    int data = in.read();
    if(data==-1) break;
    zout.write((byte)data);
}
```

🛠 반드시 `zout.closeEntry()`, `zout.flush()`, `zout.close()`를 호출해 마무리해야 해요!

---

## ⚠ 주의사항 (Cautions)

- `request.setAttribute()`는 한 번의 요청에서만 유효합니다.
- 로그인 처리는 반드시 세션을 사용해야 사용자의 인증 상태를 유지할 수 있어요.
- 파일 다운로드 시 `response`의 스트림 관리가 중요해요. `PrintWriter`와 `OutputStream`을 동시에 사용하면 안 됩니다.
- 파일 다운로드는 브라우저의 캐시 또는 보안 설정에 따라 동작이 달라질 수 있어요.

---

## 🧪 예제 또는 비유 (Examples or Analogies)

| 기능             | 비유 설명                                |
|------------------|-------------------------------------------|
| 로그인           | 도서관 입장 카드 만들기 (세션에 정보 저장)     |
| 로그아웃         | 도서관 퇴장하며 카드 반납 (세션 파기)         |
| 파일 다운로드     | 책 복사해서 집에 가져가는 느낌 (파일 전송)     |
| ZIP 다운로드     | 책 여러 권을 한 봉지에 넣어주는 느낌 (압축 전송) |

---

## ✅ 한 줄 요약 (1-Line Summary)

> JSP에서 로그인은 세션으로 인증 상태를 유지하고, 파일 다운로드는 응답 헤더 설정과 스트림 제어로 완성된다! 🚀

---

