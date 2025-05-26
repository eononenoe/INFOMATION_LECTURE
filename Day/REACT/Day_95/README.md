## 06
### src
> App.js
```js
import {BrowserRouter as Router,Routes,Route} from 'react-router-dom'
import Home from './Components/Home'
import About from './Components/About'
import Contact from './Components/Contact'
function App() {
  return (
    <div className="App">
     

     <Router>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/about" element={<About />} />
          <Route path="/contact/:name/:age" element={<Contact />} />
        </Routes>
     </Router>
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
// reportWebVitals();
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
### src/Components
> About.jsx
```jsx
import {Link} from 'react-router-dom';
import {useLocation} from 'react-router-dom';
const About  = ()=>{
    //
    const location = useLocation();
    const query = new URLSearchParams(location.search);
    console.log("query",query);
    return (
        <div>
            <nav>
                <ul>
                    <li> <Link to="/">Home</Link>           </li>
                    <li> <Link to="/about">About</Link>     </li>
                    <li> <Link to="/contact">Contact</Link>     </li>
                </ul>
            </nav>
            <h1>About</h1>
            Param : {query.get("name")} ,{query.get("age")} <br/>
          
            <p>Welcome to the About page!</p>
        </div>
    )
}

export default About;
```
---
> Contact.jsx
```jsx
import {Link,useNavigate,useParams} from 'react-router-dom';

const Contact  = ()=>{
    const {name,age} = useParams();

    const navigate = useNavigate();
    const handleHome = ()=>{
        console.log("Home");
        navigate("/");
    }
    const handleAbout = ()=>{
        console.log("About");
        navigate("/about?name=Hong&age=20");
    }
    const handleContact = ()=>{
        console.log("Contact");
        navigate("/contact");
    }
    return (
        <div>
            <nav>
                <ul>
                    <li> <button onClick={handleHome}> HOME      </button>   </li>
                    <li> <button onClick={handleAbout}> ABOUT     </button>   </li>
                    <li> <button onClick={handleContact}> CONTACT   </button>   </li>
                </ul>
            </nav>
            <h1>Contact</h1>
            name : {name} , age : {age} <br/>
            <p>Welcome to the Contact page!</p>
        </div>
    )
}

export default Contact;
```
---
> Home.jsx
```jsx
import {Link} from 'react-router-dom';

const Home  = ()=>{
    
    return (
        <div>
            <nav>
                <ul>
                    <li> <Link to="/">Home</Link>           </li>
                    <li> <Link to="/about?name=aaa&age=80">About</Link>     </li>
                    <li> <Link to="/contact/Jung/80">Contact</Link>     </li>

                </ul>
            </nav>
            <h1>HOME</h1>
            <p>Welcome to the home page!</p>
        </div>
    )
}

export default Home;
```
---
## 07
### src
> App.js
```js
import Parent_01 from "./Components/Parent_01";
import Parent_02 from "./Components/Parent_02";
import MyProvider from "./Components/MyProvider";
function App() {
  return (
    <MyProvider>
      <div className="App">
          <h1>부모에서 자식으로 전달</h1>
          <Parent_01 />
          <hr />
          <Parent_02 />
      </div>
    </MyProvider>
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
// import reportWebVitals from './reportWebVitals';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  // <React.StrictMode>
    <App />
  // </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
// reportWebVitals();
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
### src/Components
> MyContext.jsx
```jsx
import React from 'react';
const AppContext = React.createContext();
export default AppContext;
```
---
> MyProvider.jsx
```jsx
import {useState} from 'react';
import AppContext from './MyContext';

const MyProvider = ({children}) => {
    console.log(children);
    const [globalState, setGlobalState] = useState('KOREA_01'); //PROVIDER에서 관리하는 상태값
    const value = {globalState,setGlobalState} // 컴포넌트로 전달하기 위한 객체 생성
    return (
        <AppContext.Provider value={value}>
            {children}
        </AppContext.Provider>
    )

}

export default MyProvider;
```
---
> Parent_01.jsx
```jsx
import {useState,useContext} from 'react';
import Son_01 from './Son_01';
import MyContext from './MyContext'
//상위컴포넌트 -> 하위컴포넌트(props사용)
const Parent_01 = ()=>{
    const [name, setName] = useState('홍길동');
    const {globalState,setGlobalState} = useContext(MyContext); //PROVIDER에서 관리하는 상태값
    return (
        <div>
            <h1>Parent_01</h1>
            전역변수 : {globalState} <br/>
            전역변수 변경 : <button onClick={(e)=>{ setGlobalState('Parent_01 변경!') }}>변경하기</button>
            <hr />
            <Son_01 name={name} />
        </div>
    )
}
export default Parent_01;
```
---
> Parent_02.jsx
```jsx
import {useContext} from 'react';
import MyContext from './MyContext'
import {useState} from 'react';
import Son_02 from './Son_02';
//하위컴포넌트 -> 상위컴포넌트 전달(CallBack함수 전달)
const Parent_02 = ()=>{
    const [name, setName] = useState('홍길동');
    const {globalState,setGlobalState} = useContext(MyContext); //PROVIDER에서 관리하는 상태값
    const handleNameChange = (name)=>{
        setName(name);
    }

    return (
        <div>
            <h1>Parent_02</h1>
            부모가 가지는 상태값 : {name} <br/>
            전역변수 : {globalState} <br/>
            전역변수 변경 : <button >변경하기</button>
            <hr />
            <Son_02 name={name} handleNameChange={handleNameChange} />
        </div>
    )
}
export default Parent_02;
```
---
> Son_01.jsx
```jsx
import {useState,useContext} from 'react';
import MyContext from './MyContext'

const Son_01 = ({name}) => {  
    const {globalState,setGlobalState} = useContext(MyContext); //PROVIDER에서 관리하는 상태값
    return (
        <div>
            <h1>Son_01</h1>
            전역변수 : {globalState} <br/>
            전역변수 변경 : <button onClick={(e)=>{ setGlobalState('Son_01 변경!') }}>변경하기</button> <br/>
            부모로부터 전달된 내용 확인 : {name}
        </div>
    )
}
export default Son_01;
```
---
> Son_02.jsx
```jsx
const Son_02 = ({name,handleNameChange}) => {  
    return (
        <div>
            <h1>Son_02</h1>
            부모로부터 전달된 내용 자식에서 확인 : {name} <br/>
            <input type="text" placeholder='변경할 이름입력' onChange={(e)=>{handleNameChange(e.target.value)}} />
            <button>이름변경</button>
        </div>
    )
}
export default Son_02;
```
---