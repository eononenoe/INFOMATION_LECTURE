~~~markdown
# 📚 HTML 기초와 실습 예제 정리

---

# 📌 개요 (Overview)

**HTML**은 웹사이트의 구조를 만드는 언어입니다.  
**CSS**는 스타일을 지정하는 스타일 시트 언어입니다.  
**JavaScript**는 웹사이트의 CSS와 HTML 요소들을 동적으로 동작하게 하는 기능 언어입니다.

✅ HTML, CSS는 데이터 기반 언어가 아니고, JavaScript는 데이터 기반 언어입니다.

---

# 💡 핵심 개념 요약 (Key Concepts)

## 🏗️ HTML 기본 구조

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>문서 제목</title>
</head>
<body>
  <!-- 본문 내용 -->
</body>
</html>
```

- `<!DOCTYPE html>`: HTML5 문서임을 선언
- `<html>`: 문서의 시작
- `<head>`: 메타데이터 영역
- `<body>`: 사용자에게 보여지는 본문 영역

## 📚 기본 태그

- 제목 태그: `<h1>` ~ `<h5>` (숫자가 클수록 글씨가 작아짐)
- 줄바꿈: `<br />`
- 수평선: `<hr />`
- 단락: `<p>`
- 블록요소: `<div>`
- 인라인요소: `<span>`
- 리스트: `<ul>`, `<ol>`, `<li>`
- 표: `<table>`, `<tr>`, `<th>`, `<td>`, `rowspan`, `colspan`
- 링크: `<a>`
- 이미지: `<img>`
- iframe: `<iframe>` (페이지 내에 다른 페이지 불러오기)

## ⚙️ Emmet 문법

- `div>ul>li*3` : div 안에 ul, ul 안에 li 3개 생성
- 형제 태그: `+` 사용 (ex: `ul+ol`)
- 부모 태그로 이동: `^` 사용
- 클래스 지정: `.classname`
- ID 지정: `#idname`
- 텍스트 삽입: `{텍스트}`
- 반복: `*숫자`

---

# 🧪 실습 예제 모음 (Examples)

## 01BASIC.html
- HTML 문서의 기본 골격 만들기

## 02BASIC.html
- `<h1>` ~ `<h5>` 제목 태그 연습
- `<hr />`, `<br />` 사용법
- `<p>`, `<div>`, `<span>` 기본 설명

## 03UI_LIST.html
- `<ul>` 무순서 리스트
- `<ol>` 순서 리스트 (type 옵션 사용)
- 중첩 리스트 구조 연습

## 04UI_LIST 문제.html
- 복합 리스트 구조 연습 (ul+ol 혼합)

## 05Emmet.html
- Emmet 단축키 사용법 실습 (div>ul>li, div>p+ul 등)

## 06TABLE.html
- `<table>` 기본 구조 및 border 설정
- `rowspan`, `colspan` 실습

## 07TABLE 문제.html
- 고급 테이블 구조 실습 (한국의 차 테이블 만들기)

## 08A.html
- `<a>` 링크 태그 활용 (같은 탭/새 탭 열기)
- 버튼 스타일 적용 (CSS 적용)
- iframe 활용해 다른 페이지 연결

## 09A.html
- 상단 고정 메뉴 + 내부 링크 이동 연습

## 10IMAGE.html
- `<img>` 태그 사용법 (링크 연결 포함)

## 11IMAGE.html
- `<img>` 사이즈 조정 (CSS 적용)

---

# ⚠ 주의사항 (Cautions)

- HTML 단일태그는 `<hr />`, `<br />`, `<img />` 처럼 슬래시 `/`를 포함하여 닫는다.
- 중첩구조 작성 시 부모-자식 관계를 정확히 구분해야 한다.
- Emmet 사용 시 `>`, `+`, `^` 등을 잘 활용해 구조를 빠르게 만든다.
- 표를 만들 때 `rowspan`, `colspan`을 사용할 때는 합쳐지는 영역에 주의해야 한다.
- `<iframe>` 사용 시 보안 정책(CSP)이나 크로스 도메인 정책을 주의해야 한다.

---

# ✅ 한 줄 요약 (1-Line Summary)

> HTML은 웹페이지의 뼈대를 설계하는 첫걸음이다! 🏗️🖥️
~~~

