# 🍪 JSP 쿠키(Cookie) 완벽 가이드

**쿠키(Cookie)**는 사용자의 웹 브라우저에 정보를 저장하는 작은 데이터입니다.  
브라우저가 꺼져도 정보가 유지되며, **로그인 상태 유지, 장바구니 등**에 사용돼요.

---

## 📌 개요 (Overview)

| 구분         | 설명 |
|--------------|------|
| 저장 위치     | 클라이언트 (브라우저에 저장됨) |
| 생성 위치     | 서버 (JSP에서 생성하여 응답 시 전송) |
| 구분 방법     | 쿠키 이름과 값 쌍 (`name=value`) |
| 만료 설정     | 설정된 시간까지 유지, 기본은 브라우저 종료 시 삭제 |

---

## 💡 쿠키 사용 흐름

1. 서버에서 쿠키 생성 → 클라이언트로 전송 (`Set-Cookie`)
2. 클라이언트가 쿠키 저장
3. 다음 요청 시 클라이언트가 쿠키를 다시 서버에 전송 (`Cookie`)
4. 서버가 쿠키 정보 읽고 처리

---

## 🔨 쿠키 관련 메서드 요약

| 메서드 | 설명 |
|--------|------|
| `new Cookie(name, value)` | 쿠키 객체 생성 |
| `setMaxAge(seconds)` | 쿠키 유효 시간 설정 (초 단위) |
| `addCookie(cookie)` | 응답에 쿠키 추가 |
| `getCookies()` | 요청에서 모든 쿠키 배열 가져오기 |
| `cookie.getName()` | 쿠키 이름 가져오기 |
| `cookie.getValue()` | 쿠키 값 가져오기 |

---

## ✍ 쿠키 설정 예제 (`setCookie.jsp`)

```jsp
<%
Cookie cookie = new Cookie("username", "홍길동");
cookie.setMaxAge(60 * 60); // 1시간 유지
response.addCookie(cookie); // 클라이언트로 전송
%>
<p>쿠키 설정 완료!</p>
```

---

## 🔍 쿠키 읽기 예제 (`getCookie.jsp`)

```jsp
<%
Cookie[] cookies = request.getCookies();
if (cookies != null) {
    for (Cookie c : cookies) {
        if (c.getName().equals("username")) {
            out.println("쿠키 값: " + c.getValue());
        }
    }
}
%>
```

---

## ❌ 쿠키 삭제 예제 (`deleteCookie.jsp`)

```jsp
<%
Cookie cookie = new Cookie("username", "");
cookie.setMaxAge(0); // 0초 설정 시 즉시 삭제
response.addCookie(cookie);
%>
<p>쿠키 삭제 완료!</p>
```

---

## 💡 쿠키 예제 비유

> 🧁 쿠키는 웹사이트가 **사용자의 주머니에 쪽지를 넣는 것**  
> 다음에 웹사이트에 올 때, 주머니에 있던 쪽지를 보여주는 것과 같아요!

---

## ⚠ 주의사항 (Cautions)

- 쿠키는 **클라이언트에 저장**되므로 민감한 정보는 저장하면 안 돼요!
- **사이즈 제한(약 4KB)** 이 있고, **개수 제한**도 있어요 (도메인당 약 20개).
- 유효 기간이 없으면 **브라우저 종료 시 삭제**돼요.
- 쿠키는 **도메인 단위로 공유**돼요. 서브도메인 간에는 기본적으로 공유되지 않음.

---

## ✅ 한 줄 요약 (1-Line Summary)

> 🍪 JSP의 쿠키는 **클라이언트 브라우저에 정보를 저장**해서 다음 방문 때 기억하게 해주는 기능입니다!

---
