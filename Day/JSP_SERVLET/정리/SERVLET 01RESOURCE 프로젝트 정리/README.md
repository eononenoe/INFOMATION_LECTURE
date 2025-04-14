# 📚 RESOURCE 프로젝트 정리

---

## 📌 개요 (Overview)

이 프로젝트는 **Resource(리소스) 설정**을 연습하는 예제야!  
DB 연결 정보를 Java 코드에 직접 쓰지 않고,  
**context.xml** 같은 설정 파일에 미리 등록해서 관리하는 기술을 연습하는 거야! 🛠️

**예시:**
- DB 접속 정보(아이디/비번)를 코드에 쓰지 않고 서버에 등록하기 📋
- 필요할 때 서버에 등록된 리소스 이름을 통해 연결 가져오기 🎯

---

## 💡 핵심 개념 요약 (Key Concepts)

| 역할 | 설명 |
|:---|:---|
| Resource(리소스) | 서버에 등록된 DB 연결정보를 의미한다. |
| context.xml | 톰캣 서버에 DB 연결정보(Resource)를 등록하는 설정 파일 |
| JNDI | Resource를 이름으로 찾아서 사용하는 기술 |
| MysqlDbUtils/OracleDbUtils | DB 연결을 담당하는 자바 유틸리티 클래스 |

---

## 🧪 주요 클래스 & JSP 주석 추가 버전

---

### 📄 MysqlDbUtils.java

```java
public static MysqlDbUtils getInstance() {
    // JNDI를 통해 context.xml에 등록된 DB 연결을 찾아온다
}
public int insert(UserDto userDto) { }
public UserDto selectOne(String username) { }
```

> 📌 **MysqlDbUtils**는 context.xml에 등록된 Resource로부터 DB 커넥션을 가져와서 회원가입/로그인 처리를 한다.

---

### 📄 Home.java

```java
public void doGet(HttpServletRequest req, HttpServletResponse resp) 
        throws ServletException, IOException {
    // index.jsp 또는 main.jsp로 이동
}
```

> 📌 **Home 서블릿**은 메인화면 요청을 처리한다.

---

### 📄 Join.java

```java
public void doPost(HttpServletRequest req, HttpServletResponse resp) 
        throws ServletException, IOException {
    // 회원가입 처리 (DB 저장)
}
```

> 📌 **Join 서블릿**은 사용자 입력을 받아서 DB에 회원정보를 저장한다.

---

### 📄 Login.java

```java
public void doPost(HttpServletRequest req, HttpServletResponse resp) 
        throws ServletException, IOException {
    // 로그인 처리 (DB 조회 후 세션 저장)
}
```

> 📌 **Login 서블릿**은 DB에서 사용자 정보를 조회해서 세션을 생성해준다.

---

### 📄 JSP 파일 요약

- **index.jsp** : 메인 링크 페이지
- **main.jsp** : 로그인 성공 후 메인 페이지
- **user/join.jsp** : 회원가입 폼
- **user/login.jsp** : 로그인 폼

---

## ⚠️ 주의사항 (Cautions)

- **context.xml의 Resource 등록 필수**  
  👉 리소스를 등록하지 않으면 DB 연결이 안된다.

- **web.xml 매핑 주의**  
  👉 서블릿 URL 매핑이 올바르지 않으면 요청이 실패한다.

- **JNDI 이름 정확히 맞춰야 한다**  
  👉 context.xml에 등록된 이름과 코드에서 찾는 이름이 다르면 오류 발생한다.

---

## 🧪 예제 또는 비유 (Examples or Analogies)

- **Resource는 호텔방 예약!**  
  👉 미리 서버에 DB 연결방을 준비해두고, 사용할 때마다 방이름으로 찾아서 사용하는 것과 같다. 🏨

- **context.xml은 비상연락망!**  
  👉 서버가 필요한 모든 연결정보를 미리 저장해두는 역할을 한다.

---

## ✅ 한 줄 요약 (1-Line Summary)

> **DB 연결정보를 코드에 직접 쓰지 않고 Resource로 관리하는 서블릿+JSP 실습 프로젝트! 🚀**

---
