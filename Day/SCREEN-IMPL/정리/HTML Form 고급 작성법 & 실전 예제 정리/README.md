# 📚 HTML/CSS 추가 정리 (12~17)

---

# 📌 개요 (Overview)

이번에는 **HTML의 비디오 삽입, Form 요소, Bootstrap을 이용한 폼 디자인**까지 다양한 예제를 새롭게 정리했습니다. 새로운 부분만 추려 깔끔하게 정리합니다!

---

# 💡 핵심 개념 요약 (Key Concepts)

## 🎥 비디오 삽입

### 배경 비디오 삽입
```html
<video autoplay muted loop>
  <source src="./video/earth.mp4" type="video/mp4">
</video>
```
- **autoplay** : 자동 재생
- **muted** : 음소거
- **loop** : 반복 재생

### 유튜브 영상 삽입
```html
<iframe width="560" height="315" src="https://www.youtube.com/embed/8mt5oWcs_9M?autoplay=1&mute=1" allowfullscreen></iframe>
```
- 유튜브 링크 뒤에 `?autoplay=1&mute=1` 추가하면 자동 재생+음소거 가능

---

## 📝 Form 기본 구조

### 기본 폼 작성
```html
<form action="/test.jsp" method="get">
  <input type="text" name="userid">
  <input type="password" name="password">
  <input type="submit" value="가입">
</form>
```
- **action**: 데이터를 보낼 서버 주소
- **method**: 데이터 전송 방식 (GET/POST 등)

### 다양한 입력 요소
- `input type="text", "password", "radio", "checkbox"`
- `select` + `option` 조합으로 드롭다운 메뉴 생성
- `button`, `a href="javascript:void(0)"` 등으로 동작 제어 가능

---

## 🎨 폼 스타일링 (CSS)

### 기본 스타일링 예시
```css
form {
  width: 380px;
  margin: 50px auto;
  padding: 20px;
  border: 1px solid gray;
}
input, select, button {
  width: 100%;
  margin-top: 5px;
}
```

- 폼 가로폭 조정
- 입력창, 버튼 통일된 스타일 부여

---

## 🚀 Bootstrap을 활용한 폼 디자인

### Bootstrap CDN 연결
```html
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
```

### Bootstrap 적용 폼 예시
```html
<form class="container mt-5">
  <div class="mb-3">
    <label for="exampleInputEmail1" class="form-label">이메일 주소</label>
    <input type="email" class="form-control" id="exampleInputEmail1">
  </div>
  <div class="mb-3">
    <label for="exampleInputPassword1" class="form-label">비밀번호</label>
    <input type="password" class="form-control" id="exampleInputPassword1">
  </div>
  <button type="submit" class="btn btn-primary">로그인</button>
</form>
```

- `class="form-control"`로 input 스타일 자동 적용
- `btn btn-primary`로 파란색 버튼 만들기

---

# 🧪 예제 또는 비유 (Examples or Analogies)

- 🎬 **비디오 삽입**은 웹페이지를 살아 움직이게 하는 배경 효과처럼 생각!
- 📝 **폼(Form)**은 사용자가 웹사이트에 정보를 입력하는 문서 양식이라 보면 됨.
- 🎨 **Bootstrap**은 "옷 입히는 디자이너"처럼 기본 HTML을 멋지게 꾸며주는 프레임워크.

---

# ⚠ 주의사항 (Cautions)

- `<form>` 안에서 `button` 기본 동작은 **submit**이기 때문에 필요시 `type="button"` 설정 필요
- 영상 삽입 시 파일 경로 또는 링크 주소 정확히 입력해야 작동
- Bootstrap 사용시 기존 CSS와 충돌 날 수 있으니 주의!

---

# ✅ 한 줄 요약 (1-Line Summary)

> "HTML 비디오, Form, Bootstrap으로 웹페이지를 더욱 역동적이고 멋지게 만들어보자! 🚀"
~~~

