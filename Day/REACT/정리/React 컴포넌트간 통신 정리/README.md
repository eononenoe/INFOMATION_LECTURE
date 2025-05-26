
# 🔄 컴포넌트 간 통신  정리

## 📌 개요

React에서 컴포넌트 간 상태를 공유하거나 이벤트를 전달하려면 부모-자식 관계에 따라 **props 전달 체인**이 필요합니다.  
하지만 컴포넌트 계층이 깊어질수록 유지보수가 어려워지고, 중간 컴포넌트가 불필요하게 복잡해질 수 있습니다.  
이를 해결하기 위해 **Context API**가 등장했습니다.

---

## 🚧 기존 방식의 한계 (Props Drilling)

```jsx
<A>
  <B>
    <C>
      <D>
        <E />
      </D>
    </C>
  </B>
</A>
```

- A의 상태를 E에서 변경하려면 `A → B → C → D → E` 까지 **props로 함수를 전달**
- 반대로 E의 이벤트로 A의 상태를 변경하려면 **함수를 계속 내려야 함**
- 너무 복잡하고 추적이 어려워짐

---

## 🚀 Context API란?

- 전역처럼 사용할 수 있는 **React 내장 전역 상태 관리 시스템**
- `Provider`를 통해 데이터를 공급
- `Consumer`, `this.context`, `useContext()`로 데이터 접근

---

## 🧱 기본 구조

1. **Context 생성**

```js
const PersonContext = React.createContext();
export const { Provider, Consumer } = PersonContext;
export default PersonContext;
```

2. **Context 공급자 (Provider)**

```jsx
<Provider value={{ persons, add }}>
  <App />
</Provider>
```

3. **데이터 소비자 (Consumer, this.context, useContext)**

```jsx
// Consumer 방식
<Consumer>
  {({ persons }) => <ul>{persons.map(p => <li>{p.name}</li>)}</ul>}
</Consumer>

// 클래스 컴포넌트
static contextType = PersonContext;
this.context.persons

// 함수 컴포넌트
const { persons } = useContext(PersonContext);
```

---

## 💡 다양한 Context 소비 방법

| 방법 | 사용 위치 | 설명 |
|------|-----------|------|
| `<Consumer>` | 함수/클래스 모두 | JSX 내부에서 함수로 사용 |
| `this.context` | 클래스 컴포넌트 전용 | static contextType 필요 |
| `useContext(Context)` | 함수형 컴포넌트 | 가장 간단하고 선호되는 방식 |

---

## 💥 실습 예시: PersonContext 사용

### 🧪 1. PersonContext.js

```js
import React from "react";
const PersonContext = React.createContext();
export const { Provider, Consumer } = PersonContext;
export default PersonContext;
```

### 🧪 2. App.js

```jsx
import { Provider } from './contexts/PersonContext';

function App() {
  const [persons, setPersons] = useState([
    { id: 0, name: "Mark", age: 38 },
    { id: 1, name: "Hanna", age: 27 }
  ]);

  function add() {
    setPersons([...persons, { id: 2, name: "React", age: 10 }]);
  }

  return (
    <Provider value={{ persons, add }}>
      <Example1 />
      <Example2 />
      <Example3 />
    </Provider>
  );
}
```

### 🧪 3. Example1.jsx (Consumer)

```jsx
<Consumer>
  {({ persons }) => (
    <ul>
      {persons.map(p => <li>{p.name}</li>)}
    </ul>
  )}
</Consumer>
```

### 🧪 4. Example2.jsx (Class Component)

```jsx
class Example2 extends React.Component {
  render() {
    const { persons } = this.context;
    return (
      <ul>
        {persons.map(p => <li>{p.name}</li>)}
      </ul>
    );
  }
}
Example2.contextType = PersonContext;
```

### 🧪 5. Example3.jsx (useContext)

```jsx
const { persons, add } = useContext(PersonContext);
return (
  <>
    <ul>{persons.map(p => <li>{p.name}</li>)}</ul>
    <button onClick={add}>추가</button>
  </>
);
```

---

## 🧠 핵심 요약

- `props drilling`을 피하기 위해 Context API 사용
- `Provider`는 데이터를 공급
- `Consumer`, `this.context`, `useContext`는 데이터를 소비
- 전역 상태처럼 작동하지만 컴포넌트 단위에서 **선택적으로 분리 사용** 가능

---

## 📃 한 줄 요약

**Context API는 깊은 컴포넌트 계층에서 props 없이 데이터를 공유할 수 있는 React의 전역 상태 전달 시스템입니다.**

## 🔄 실습

![이미지](./0.png)
![이미지](./1.png)
![이미지](./2.png)
![이미지](./3.png)
![이미지](./4.png)
![이미지](./5.png)
![이미지](./6.png)
![이미지](./7.png)
![이미지](./8.png)
![이미지](./9.png)
![이미지](./10.png)
![이미지](./11.png)
![이미지](./12.png)
![이미지](./13.png)
![이미지](./14.png)
![이미지](./15.png)
![이미지](./16.png)
![이미지](./17.png)
![이미지](./18.png)
![이미지](./19.png)