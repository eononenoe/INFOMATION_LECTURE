## NODE
> index.js
```js
console.log("HELLO WORLD");
console.log(1+2);

// LODASH
import _ from 'lodash';
console.log("lodash",_)
```
---
## REACT01
### src
> App.js
```js
import {Element1,Element2} from "./01JSX/JSX_Basic";
import {Element3,Element4} from "./01JSX/JSX_Basic";


function App() {
  const headerTitle = "HEADER TITLE";
  const mainTitle = "MAIN TITLE";
  const footerTitle = "FOOTER TITLE"
  return (
    <div className="App">
      <div className="header" style={{fontSize:"30px",backgroundColor:"orange"}}>
        {headerTitle}
        <Element1/>
        <Element2/>
        </div>
      <div className='main'>{mainTitle}</div>
      <div className='footer'>
       <Element3 auth={"ROLE_USER"} name={"홍길동"}/>
       <hr/>
       <Element4 auth={"ROLE_ADMIN"} name={"홍길동"}/>
      </div>
    </div>
  );
}

export default App;
```
---
> App.test.js
```js
import { render, screen } from '@testing-library/react';
import App from './App';

test('renders learn react link', () => {
  render(<App />);
  const linkElement = screen.getByText(/learn react/i);
  expect(linkElement).toBeInTheDocument();
});
```
---
> index.js
```js
import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
```
---
> reportWebVitals.js
```js
const reportWebVitals = onPerfEntry => {
  if (onPerfEntry && onPerfEntry instanceof Function) {
    import('web-vitals').then(({ getCLS, getFID, getFCP, getLCP, getTTFB }) => {
      getCLS(onPerfEntry);
      getFID(onPerfEntry);
      getFCP(onPerfEntry);
      getLCP(onPerfEntry);
      getTTFB(onPerfEntry);
    });
  }
};

export default reportWebVitals;
```
---
> setupTests.js
```js
// jest-dom adds custom jest matchers for asserting on DOM nodes.
// allows you to do things like:
// expect(element).toHaveTextContent(/react/i)
// learn more: https://github.com/testing-library/jest-dom
import '@testing-library/jest-dom';
```
---
### src/01JSX
> JSX_Basic.jsx
```jsx
//01 기본 JSX요소 생성
export const Element1 = () => <h1>HELLO WORLD - 1</h1>

//02 function 예약어로 Export
export function Element2() {
    return <h2>HELLO WORLD - 2</h2>
}

//03 외부 인자 받기
export function Element3(props) {
    if (props.auth === "ROLE_ADMIN") {
        return <h2>HELLO ADMIN , NAME : {props.name}</h2>
    }
    if (props.auth === "ROLE_USER") {
        return <h2>HELLO USER , NAME : {props.name}</h2>
    }
}

//03 외부 인자 받기(구조분해 할당) const {auth,name} = props
export function Element4({auth,name}) {
    if (props.auth === "ROLE_ADMIN") {
        return <h2>HELLO ADMIN , NAME : {name}</h2>
    }
    if (props.auth === "ROLE_USER") {
        return <h2>HELLO USER , NAME : {name}</h2>
    }
}
```
---
## REACT02
### src
> App.js
```js
import logo from './logo.svg';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;
```
---
> App.test.js
```js
import { render, screen } from '@testing-library/react';
import App from './App';

test('renders learn react link', () => {
  render(<App />);
  const linkElement = screen.getByText(/learn react/i);
  expect(linkElement).toBeInTheDocument();
});
```
---
> index.js
```js
import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
```
---
> reportWebVitals.js
```js
const reportWebVitals = onPerfEntry => {
  if (onPerfEntry && onPerfEntry instanceof Function) {
    import('web-vitals').then(({ getCLS, getFID, getFCP, getLCP, getTTFB }) => {
      getCLS(onPerfEntry);
      getFID(onPerfEntry);
      getFCP(onPerfEntry);
      getLCP(onPerfEntry);
      getTTFB(onPerfEntry);
    });
  }
};

export default reportWebVitals;
```
---
> setupTests.js
```js
// jest-dom adds custom jest matchers for asserting on DOM nodes.
// allows you to do things like:
// expect(element).toHaveTextContent(/react/i)
// learn more: https://github.com/testing-library/jest-dom
import '@testing-library/jest-dom';
```
---