## 03
### src
> App.js
```js
import MyComponent from './02COMPONENT/MyComponent';

function App() {

  return (

    <div className="App">
        <MyComponent />
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
  // <React.StrictMode>
    <App />
  // </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
//reportWebVitals();
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
> CustomComponent.jsx
```jsx
const CustomComponent = () => {
    return (
        <h2> CUSTOM_COMPONENT...</h2>
    )
}

export default CustomComponent;
```
---
> JSX_Basic.jsx
```jsx
//01 기본 JSX요소 생성
export const Element1 = ()=> <h1>HELLO WORLD - 1</h1>

//02 function예약어로 Export
export function Element2() {
    return <h2>HELLO WORLD - 2</h2>
}

//03 외부 인자 받기
export function Element3(props) {
    if(props.auth === "ROLE_ADMIN") {
        return <h2>HELLO ADMIN , NAME : {props.name}</h2>
    }
    if(props.auth === "ROLE_USER") {
        return <h2>HELLO USER  , NAME : {props.name}</h2>
    }
}
//03 외부 인자 받기(구조분해 할당)  const {auth,name} = props
export const Element4  = ({auth,name}) => {
    if(auth === "ROLE_ADMIN") {
        return <h2>HELLO ADMIN , NAME : {name}</h2>
    }
    if(auth === "ROLE_USER") {
        return <h2>HELLO USER  , NAME : {name}</h2>
    }
}

//04 반복문 처리
export const Element5 = (props)=>{
    const list = props.list; // ['a','b','c']
    return (
        <div className="items">
        
            {list.map((item,index)=>{
                console.log(item);
                return <div key={index} >{item}</div>
            })}

        </div>
    );
}


//05 기본 컴포넌트 EXPORT
const DefaultComponent1 = ()=>{
    return <h1>DEFAULT COMPONENT1</h1>
}
const DefaultComponent2 = ()=>{
    return <h1>DEFAULT COMPONENT2</h1>
}

export default {
    DefaultComponent1,
    DefaultComponent2
};
```
---
> JSX_Event.jsx
```jsx
//01
function handleClick_01() {
    console.log("clicked...");
}

export function Component_01() {
    return (
        <div>
            <h1>HELLO WORLD - 1</h1>
            <button onClick={handleClick_01}>CLICK ME</button>
        </div>
    );
}

//02

export function Component_02() {
    function handleClick_02() {
        console.log("clicked...02...");
    }
    return (
        <div>
            <h1>HELLO WORLD - 2</h1>
            <button onClick={handleClick_02}>CLICK ME</button>
        </div>
    );

}

export function Component_03() {

    function handleClick_03(event) {
        console.log("keydown..",event.target.value);
    } 
    return (
        <div>
            <h1>HELLO WORLD - 3</h1>
            <input type="text" onKeyDown={handleClick_03} />
        </div>
    );

}
```
---
### src/02COMPONENT
> MyComponent.jsx
```jsx
import {useState,useEffect} from 'react';

const MyComponent = () => {
    //let count = 0;
    const [count,setCount] = useState(0);

    const handleclick = () => {
        setCount(count + 1);
        // console.log("Button Clicked...", count);
    }  
    //최초 1회 실행
    useEffect(()=>{
        console.log('init setting');
    } , []); 
    //count state가 변경될때마다 실행
    useEffect(()=>{
        console.log('count state changed', count);
    } , [count]);



    return (
        <div>
            <h1>TITLE</h1>
            <h2>SUB_TITLE</h2>
            <hr/>
            <button onClick={handleclick}>BUTTON COUNT : {count}</button>
        </div>
    )
}

export default MyComponent;
```
---
## 04
### src
> App.js
```js
import logo from "./logo.svg";
import "./App.css";
import onClickTest from "./Event/01onClick";
import onMouseTest from "./Event/02onMouse";
import onKeyTest from "./Event/03onKey";
import onChangeTest from "./Event/04onChange";
import onFormTest from "./Event/05formEvent";
import onScrollTest from "./Event/06onScroll";

function App() {
  return (
    <div className="App">
      {/* 01 Onclick */}
      <onClickTest.MyComponent />
      <hr />
      {/* 01 OnMouse */}
      <onMouseTest.MyComponent1 />
      <onMouseTest.MyComponent2 />
      <hr />
      {/* 01 onKeyboard */}
      <onKeyTest.MyComponent1 />
      <onKeyTest.MyComponent2 />
      <onKeyTest.MyComponent3 />
      <hr />
      {/* 01 onChange */}
      <onChangeTest.MyComponent />
      <hr />
      {/* 01 onForm */}
      <onFormTest.MyComponent />
      <hr />
      {/* 01 onScroll */}
      <onScrollTest.MyComponent />
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
### src/Event
> 01onClick.js
```js
function handleClick(event) {
  console.log("clicked! event obj : ", event.target);
}
function MyComponent() {
  return <button onClick={handleClick}>Click me</button>;
}
export default {
  MyComponent,
};
```
---
> 02onMouse.js
```js
//01 mouseEnter
function handleMouseEnter(event) {
  console.log("mouse entered!",event);
}

function MyComponent1() {
  return (
    <div
      onMouseEnter={handleMouseEnter}
      style={{ width: "150px", height: "150px", border: "1px solid" }}
    >
      MouseEnter Test
    </div>
  );
}

//02 onMouseLeave
function handleMouseLeave(event) {
  console.log("mouse left!");
}

function MyComponent2() {
  return (
    <div
      onMouseLeave={handleMouseLeave}
      style={{ width: "150px", height: "150px", border: "1px solid" }}
    >
      MouseEnter Leave
    </div>
  );
}

export default {
  MyComponent1,
  MyComponent2,
};
```
---
> 03onKey.js
```js
// keydown
function handleKeyDown(event) {
  console.log("key down!", event.keyCode);
}

function MyComponent1() {
  return <div>KEYDOWN : <input type="text" onKeyDown={handleKeyDown} /></div>;
}

//keyup
function handleKeyUp(event) {
  console.log("key up! ", event.keyCode);
}

function MyComponent2() {
  return <div>KEYUP : <input type="text" onKeyUp={handleKeyUp} /></div>;
}

//keypress
function handleKeyPress(event) {
  console.log("key pressed! key : ", event.key);
}

function MyComponent3() {
  return <div>KEYPRESS : <input type="text" onKeyPress={handleKeyPress} /></div>;
}

export default {
  MyComponent1,
  MyComponent2,
  MyComponent3,
};
```
---
> 04onChange.js
```js
import {useState} from 'react';

const MyComponent = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const handleUsernameChange = (event) => {
        setUsername(event.target.value);
        console.log("username : ", event.target.value);
    }   
    const handlePasswordChange = (event) => {
        setPassword(event.target.value);
        console.log("password : ", event.target.value);
    }
    const handleSubmit = (event) => {
      event.preventDefault();
      console.log("username : ", username, " password : ", password);
    }
    return (
      <form onSubmit={handleSubmit}>
        USERNAME : <input type="text" name="username" onChange={handleUsernameChange} /> <br/>
        PASSWORD : <input type="password" name="password" onChange={handlePasswordChange} /> <br/>
        <button type="submit" >Submit</button>
      </form>
      
    );
  }
  export default{
    MyComponent,
}
```
---
> 05formEvent.js
```js
function handleSubmit(event) {
  event.preventDefault();
  console.log("form submitted!");
}
function MyComponent() {
  return (
    <form onSubmit={handleSubmit}>
      <input type="text" />
      <button type="submit">Submit</button>
    </form>
  );
}
export default {
  MyComponent,
};
```
---
> 06onScroll.js
```js
function handleScroll(event) {
  console.log("scrolled! ",event.target.scrollTop);
}

function MyComponent() {
  return (
    <div
      style={{ height: "100px", overflow: "scroll" }}
      onScroll={handleScroll}
    >
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
      <p>Nullam pharetra velit id bibendum consectetur.</p>
      <p>Donec dignissim ante vel est molestie, at rutrum sapien euismod.</p>
    </div>
  );
}
export default {
  MyComponent,
};
```
---
## 05
### src
> App.js
```js
import Basic01 from './Condition/01Basic';

function App() {
  return (
    <div className="App">
      <Basic01.Component01 isAuth={false} />
      <hr/>
      <Basic01.Component02 isAuth={false} />
      <hr/>
      <Basic01.Component03 items={['a','b','c']} />
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
### src/Condition
> 01Basic.jsx
```jsx
//01IF
const Component01 = ({ isAuth }) => {
  if (isAuth) return <h1>인증 되었습니다.</h1>;
  else return <h1>로그인이 필요합니다</h1>;
};

//02삼항연산자
const Component02 = ({ isAuth }) => {
  return (
    <>
      {isAuth ? (
        <>
          <h1>인증완료</h1>
          <h2>user1 계정 로그인 - </h2>
        </>
      ) : (
        <h1>로그인 필요</h1>
      )}
    </>
  );
};

//03 && 연산자
const Component03 = ({items}) => {
    return (
        <div className="items">
             {items.length>0 && items.map((item,idx)=>{
                return <li key={idx}>{item}</li>
             })}   
        </div>
    );
};

export default {
  Component01,
  Component02,
  Component03,
};
```
---