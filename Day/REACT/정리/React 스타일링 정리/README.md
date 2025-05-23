# 🎨 Styled 정리

## 📦 설치하기

Styled Components는 별도 패키지이며, 다음 명령어로 설치합니다:

```bash
npm install styled-components
```

설치 후 `package.json`의 dependencies 항목에 다음과 같이 추가됩니다:

```json
"dependencies": {
  "react": "^18.0.0",
  "react-dom": "^18.0.0",
  "styled-components": "^5.3.5"
}
```

---

## 💡 Styled Components란?

**CSS-in-JS** 방식의 스타일링 도구로, CSS를 JavaScript 안에 작성할 수 있게 해주는 라이브러리입니다.

- 각 컴포넌트에 **고유한 클래스 이름**이 자동 생성되어 **스타일 충돌 방지**
- props를 활용한 **동적 스타일링** 가능
- **전역 네임스페이스 문제** 없이 컴포넌트 단위로 스타일 관리 가능

---

## 🔧 기본 문법

### 1 HTML 엘리먼트 스타일링

```jsx
import styled from "styled-components";

const StyledButton = styled.button`
  font-size: 1rem;
  padding: 10px;
`;
```

### 2 React 컴포넌트 스타일링

```jsx
import styled from "styled-components";
import Button from './Button';

const CustomStyledButton = styled(Button)`
  background: red;
  color: white;
`;
```

- 두 경우 모두 ES6의 **Tagged Template Literal** 문법을 사용
- `styled(...)`는 스타일이 적용된 **새로운 React 컴포넌트**를 반환함

---

## 🧾 고정 스타일링 예제

```jsx
import React from "react";
import styled from "styled-components";

const StyledButton = styled.button`
  padding: 6px 12px;
  border-radius: 8px;
  font-size: 1rem;
  line-height: 1.5;
  border: 1px solid lightgray;
  color: gray;
  background: white;
`;

function Button({ children }) {
  return <StyledButton>{children}</StyledButton>;
}
```

```jsx
import Button from "./Button";

<Button>Default Button</Button>
```

- 출력 예: `<button class="sc-abc123">Default Button</button>`
- 내부 CSS:

```css
.sc-abc123 {
  padding: 6px 12px;
  border-radius: 8px;
  font-size: 1rem;
  ...
}
```

---

## 🌀 가변 스타일링 (props 사용)

### 1 단일 속성 조절

```jsx
const StyledButton = styled.button`
  color: ${(props) => props.color || "gray"};
  background: ${(props) => props.background || "white"};
`;
```

```jsx
<Button color="green" background="pink">Green Button</Button>
```

- `props.color`, `props.background` 값에 따라 스타일 변경
- 기본값은 `||` 연산자 사용

---

### 2 여러 속성 묶어서 변경 (css 함수 사용)

```jsx
import styled, { css } from "styled-components";

const StyledButton = styled.button`
  border: 1px solid lightgray;

  ${(props) =>
    props.primary &&
    css`
      color: white;
      background: navy;
      border-color: navy;
    `}
`;
```

```jsx
<Button primary>Primary Button</Button>
```

- `primary` prop이 true일 때만 해당 CSS 블록 적용
- `css` 함수는 **여러 줄의 스타일을 한 번에** 처리할 때 유용

---

## 💡 ...props 사용

```jsx
function Button({ children, ...props }) {
  return <StyledButton {...props}>{children}</StyledButton>;
}
```

- 전달받은 모든 props를 StyledButton에 자동으로 넘겨줌
- props가 많아질 때 **간결하게 전달 가능**

---

## 📂 전체 코드 예제

```jsx
// Button.js
import React from "react";
import styled, { css } from "styled-components";

const StyledButton = styled.button`
  padding: 6px 12px;
  border-radius: 8px;
  font-size: 1rem;
  line-height: 1.5;
  border: 1px solid lightgray;
  color: ${(props) => props.color || "gray"};
  background: ${(props) => props.background || "white"};

  ${(props) =>
    props.primary &&
    css`
      color: white;
      background: navy;
      border-color: navy;
    `}
`;

function Button({ children, ...props }) {
  return <StyledButton {...props}>{children}</StyledButton>;
}

export default Button;
```

```jsx
// 사용 예
import Button from "./Button";

<Button>Default</Button>
<Button color="green" background="pink">Green</Button>
<Button primary>Primary</Button>
```

---

## 🧠 스타일드 컴포넌트 vs 일반 CSS

| 항목 | Styled Components | 일반 CSS |
|------|-------------------|-----------|
| 스타일 범위 | 컴포넌트에 국한 | 전역으로 퍼짐 |
| 재사용성 | 컴포넌트 단위로 재사용 | 클래스명 중복 시 충돌 가능성 |
| 동적 스타일 | props로 유동적 제어 가능 | 불가능 (JS 연동 필요) |
| 유지보수 | 높은 캡슐화 | 파일 분리 필요 |

---

## 📃 한 줄 요약 (1-Line Summary)

Styled Components는 React에서 CSS를 JS 안에 선언하여 **컴포넌트 단위로 격리된 스타일을 구현**할 수 있는 CSS-in-JS 도구입니다.

## 🎨 실습

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
![이미지](./20.png)
![이미지](./21.png)
![이미지](./22.png)
![이미지](./23.png)
