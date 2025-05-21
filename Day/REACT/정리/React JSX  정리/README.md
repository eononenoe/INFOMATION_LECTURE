# ⚛️ React JSX 정리

## 📌 JSX 개요

**JSX (JavaScript XML)**는 JavaScript에 **XML 형태의 태그 문법을 확장한 것**입니다.  
React에서 UI를 구성할 때, HTML처럼 코드를 작성할 수 있게 해줍니다.

```jsx
const element = <h1>Hello, world!</h1>;
```

- 위 코드는 HTML이 아닌 **JSX 문법**입니다.
- JSX는 **React 엘리먼트**를 생성하며, 최종적으로는 JavaScript 코드로 **변환(babel)**됩니다.
- React에서 JSX는 필수는 아니지만, **코드 가독성**과 **에러 디버깅** 측면에서 강력한 이점을 제공합니다.

---

## 💡 JSX 핵심 특징 요약

| 항목 | 설명 |
|------|------|
| XML과 유사한 문법 | HTML 태그처럼 작성하지만 실제로는 JavaScript 코드 |
| JavaScript 표현식 사용 | `{}` 중괄호를 사용하여 변수, 함수 호출, 연산 등 가능 |
| 바벨(Babel) 변환 | JSX는 실행 전 Babel이 `React.createElement()` 형태로 변환 |
| React 엘리먼트 생성 | 실제 DOM이 아닌, React가 추적 가능한 가상 요소 생성 |

---

## 🧾 JSX 문법 정리

### 1 `class` → `className` 사용

JSX는 HTML이 아닌 JavaScript 문법이므로 `class`는 **예약어**입니다.  
따라서 반드시 `className`을 사용해야 합니다.

```jsx
<div className="App">
  <div className="black-nav">
    <h4>블로그</h4>
  </div>
</div>
```

---

### 2 변수는 `{}` 중괄호로 감싸기

```jsx
let post = "블로그 글 제목";

<h4>{post}</h4>
```

- 표현식만 가능: `{post}`, `{1 + 2}`, `{함수()}` 등은 OK  
- 조건문, 반복문 등은 JSX 외부에서 작성해야 함

---

### 3 인라인 스타일은 객체 형태로 작성

```jsx
<h4 style={{ color: 'red', fontSize: '16px' }}>블로그</h4>
```

- **스타일 객체**는 JS 문법이므로 `{}`로 한 번, 객체로 한 번 더 감싸야 함  
- 속성명은 **카멜케이스** (예: `font-size` → `fontSize`)

---

### 4 여러 JSX 요소는 반드시 하나의 부모 태그로 감싸야 함

```jsx
// 올바르지 않은 예시
return (
  <h4>제목</h4>
  <p>내용</p>
);

// 올바른 예시 (div 또는 Fragment 사용)
return (
  <>
    <h4>제목</h4>
    <p>내용</p>
  </>
);
```

- `<>...</>`는 `React.Fragment`의 축약형으로, 불필요한 태그 없이 그룹화 가능

---

### 5 JSX 내부 조건문 처리

JSX 안에서는 `if` 사용 불가능 → 대신 **삼항 연산자**, **논리 연산자** 활용

```jsx
{isLogin ? <h2>환영합니다!</h2> : <h2>로그인 해주세요</h2>}
{show && <p>이 문장은 show가 true일 때만 보입니다.</p>}
```

---

### 6 JSX 안에서 배열 출력 (`map`)

```jsx
const posts = ['글1', '글2', '글3'];

{posts.map((item, idx) => <h4 key={idx}>{item}</h4>)}
```

- JSX에서 리스트를 렌더링할 땐 반드시 `key` 속성 필요 (React가 DOM 변화를 추적할 때 사용)

---

## 🧪 JSX 예제 코드 모음

###  1. 기본 JSX 사용

```jsx
const element = <h1>Hello, JSX!</h1>;
```

###  2. 함수형 컴포넌트에서 JSX 반환

```jsx
function Welcome(props) {
  return <h1>안녕하세요, {props.name}님!</h1>;
}
```

###  3. 중첩 구조

```jsx
function App() {
  return (
    <div>
      <header>
        <h1>블로그</h1>
      </header>
      <main>
        <p>글 목록</p>
      </main>
    </div>
  );
}
```

---

## ⚠ 주의사항 (Cautions)

- **JSX는 JavaScript의 일부**이기 때문에 HTML과 다르게 동작하는 문법이 존재함
  - `class` → `className`
  - `for` → `htmlFor`
- 태그는 반드시 닫아야 함 (`<br />`, `<img />`, `<input />` 등)
- 조건문과 반복문은 JSX 외부에서 처리하거나 표현식으로 작성

---

## ✨ 추가로 알아두면 좋은 고급 문법

### 1. JSX + 조건부 렌더링 + map + 이벤트 핸들링 예시

```jsx
function List({ items }) {
  return (
    <ul>
      {items.length === 0 ? (
        <li>항목이 없습니다.</li>
      ) : (
        items.map((item, idx) => (
          <li key={idx} onClick={() => alert(item)}>
            {item}
          </li>
        ))
      )}
    </ul>
  );
}
```

---

### 2. 컴포넌트 안에 컴포넌트 작성

```jsx
function Header() {
  return <h1>My Blog</h1>;
}

function App() {
  return (
    <div>
      <Header />
      <p>글 목록입니다</p>
    </div>
  );
}
```

---

## 🧠 비유로 이해하기

JSX는 **HTML처럼 보이지만 실제로는 JS 객체로 변환**되는 코드입니다.  
즉, HTML의 탈을 쓴 JavaScript이며, React는 이를 활용해 DOM 구조를 효율적으로 관리합니다.

```js
// JSX
const element = <h1>Hello</h1>;

// 실제 변환 형태 (Babel)
const element = React.createElement('h1', null, 'Hello');
```

---

## 📃 한 줄 요약 (1-Line Summary)

JSX는 JavaScript 코드 안에서 HTML처럼 UI를 구성할 수 있게 해주는 React 전용 확장 문법입니다.

