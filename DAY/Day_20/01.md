# 01

> **HTML**
> 

```jsx
HTML : 웹사이트의 구조를 만들 수 있다
CSS : 스타일을 지정하는 방식을 규정하는 스타일 시트 언어
JavaScript : 웹사이트의 CSS와 HTML 구성요소들이 동작할 수 있도록 하는 기능
HTML,CSS : 데이터 기반 언어 X
JavaScript : 데이터 기반 언어
```

---

> **01BASIC.html**
> 

```jsx
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <!-- ex) <h1> <h1> = <h2> <h2> : Rename -->
    <!-- shift + alt 방향키 복사 붙여넣기 -->

    <!-- 
    <!DOCTYPE html>         : 이 문서가 HTML5 문서임을 선언
    <html lang="ko">     : HTML문서의 시작을 나타내며 lang 속성을 이용하여 문서의 기본언어가 한국어임을 명시
    <head>               : 문서의 메타데이터와 제목등을 포함하는 머리말
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    : 반응형 웹 디자인을 위한 뷰포트 설정
    : width=device-width : 뷰포트의 너비를 디바이스의 너비만큼 설정
    : initial-scale=1.0  : 페이지가 처음 로드될때 기본 확대/축소 수준을 지정
    <title>Document</title>
    <body>               : 문서의 본문, 브라우저에 ViewPort(웹페이지를 사용자가 보는영역)에 표시되는 내용
    -->
</body>

</html>
```

---

> **02BASIC.html**
> 

```jsx
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <!--  제목 -->
    <h1>HELLOWORLD</h1>
    <h2>HELLOWORLD</h2>
    <h3>HELLOWORLD</h3>
    <h4>HELLOWORLD</h4>
    <h5>HELLOWORLD</h5>

    <!-- 수평줄<hr> -->
    <!-- 단일태그 뒤에 / 넣어야한다 -->
    <hr />
    <!-- 줄바꿈<br/> -->
    HELLOWORLD<br />
    HELLOWORLD<br />
    HELLOWORLD<br />
    HELLOWORLD<br />
    HELLOWORLD<br />

    <hr />
    <!-- 단락태그(P), 블럭형 대표태그(div), 라인형대표태그(span) -->
    <h1>HTML</h1>
    <p>
    하이퍼 텍스트 마크업 언어(영어: Hyper Text Markup Language, HTML, 문화어: 초본문표식달기언어,
    하이퍼본문표식달기언어)는 웹 페이지 표시를 위해 개발된 지배적인 마크업 언어다. 또한, HTML은 제목,
    단락, 목록 등과 같은 본문을 위한 구조적 의미를 나타내는 것뿐만 아니라 링크, 인용과 그 밖의 항목
    으로 구조적 문서를 만들 수 있는 방법을 제공한다. 그리고 이미지와 객체를 내장하여 대화형 양식을
    </p>
    생성하는 데 사용될 수 있다. <div style = "background-color: orange;width: 280px;height: 300px;">은 웹 페이지 콘텐츠 안의 꺾쇠 괄호</div>에 둘러싸인 "태그"로 되어있는
    HTML 요소 형태로 작성한다. HTML은 웹 브라우저와 같은 HTML 처리 장치의 행동에 영향을 주는 자바스크립트,
    본문과 그 밖의 항목의 외관과 배치를 정의하는 <span style = "background-color: royalblue;width: 500px;height: 300px;"> 같은 스크립트를 포함하거나 불러올 수 있다.</span> HTML과
    CSS 표준의 공동 책임자인 W3C는 명확하고 표상적인 마크업을 위하여 CSS의 사용을 권장한다.

</body>

</html>
```

---

> **03UI_LIST.html**
> 

```jsx
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <!-- UL태그 : 리스트형 구조 생성 태그 -->

    <!-- 기본형 : 순서번호가 없는 리스트 (EMMET 단축 : ul>li*4{list$})-->
    <ul>
        <li>LIST1</li>
        <li>LIST2</li>
        <li>LIST3</li>
        <li>LIST4</li>
        <li>LIST5</li>
    </ul>
    <hr />

    <!-- OL태그 : 순서번호가 있는 리스트 type=a,i,1 -->
    <!-- ol>li*4{list} -->
    <!-- <ol type="i"= 로마식> -->
    <!-- <ol type="A"= ABCD> -->
    <ol type="1"> 
        <li>list</li>
        <li>list</li>
        <li>list</li>
        <li>list</li>
    </ol>
    <hr/>
    <h4>정보처리산업기사 과정평가형</h4>
    <ol>
        <li>
            SW 응용기초 활용
            <ol type="A">
                <li>
                    네트워크 기초 활용하기
                    <ul>
                        <li>네트워크 계층 구조 확인</li>
                        <li>라우팅 프로토콜 설정</li>
                        <li>기타 프로토콜 확인
                        </li>
                    </ul>
                </li>
                <li>미들웨어 기초 활용하기</li>
                <li>데이터베이스 기초 활용하기</li>
            </ol>
        </li>
        <li>
            개발자 환경 구축
            <ol type="A">
                <li>운영체제 기초 활용하기</li>
                <li>기본 개발환경 구축하기</li>
            </ol>
        </li>
        <li>
            화면 설계
            <ol type="A">
                <li>UI 요구사항 확인하기</li>
                <li>UI 설계하기</li>
            </ol>
        </li>
        <li>화면 구현</li>
        <li>프로그램</li>
        <li>UI 테스트</li>
        <li>프로그래밍 언어 활용</li>
        <li>프로그래밍 언어 응용</li>
        <li>데이터 입출력 구현</li>
        <li>SQL 활용</li>
        <li>요구사항 확인</li>
        <li>서버프로그램 구현</li>
        <li>통합 구현</li>
        <li>애플리케이션 테스트 수행</li>
        <li>애플리케이션 배포</li>
        <li>애플리케이션 테스트 관리</li>
    </ol>

</body>

</html>
```

---

> **04UI_LIST 문제.html**
> 

```jsx
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <h4>정보처리산업기사 문제</h4>
    <ul>
        <li>2023학년도 수강과목</li>
        <ol type="1">
            <li>HTML/CSS/JS</li>
            <li>JQUERY</li>
            <li>REACT</li>
            <li>BOOTSTRAP</li>
        </ol>
        <li>학년</li>
        <ol type="A">
            <li>1학년</li>
            <ul>
                <li>HTML/CSS/JS/JQuery</li>
            </ul>
            <li>2학년</li>
            <ul>
                <li>BootStrap / Clone Coding</li>
            </ul>
            <li>3학년</li>
            <ul>
                <li>React Redux</li>
            </ul>
            <li>4학년</li>
            <ul>
                <li>Type Script/Next.js</li>
            </ul>
        </ol>
        <li>백엔드 언어</li>
        <ol type="I">
            <li>JAVA</li>
            <li>JSP</li>
            <li>Servlet</li>
            <li>Spring</li>
            <li>Spring Boot</li>
        </ol>

    </ul>

</body>

</html>
```

---

> **05Emmet.html**
> 

```jsx
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <!-- 자식 요소 선택 : '>' | > : ul 태그 안에 li 태그 만들겠다 -->
    <!-- div>ul>li -->
    <div>
        <ul>
            <li></li>
        </ul>
    </div>

    <!-- div/p/ul/li -->
    <div>
        <p>
        <ul>
            <li>

            </li>
        </ul>
        </p>
    </div>

    <!-- 형제노드 : '+' -->
    <!-- div>ul+ol -->
    <div>
        <ul></ul>
        <ol></ol>
    </div>

    <!-- div>p+div+span -->
    <div>
        <p></p>
        <div></div>
        <span></span>
    </div>

    <!-- div>ul>li>a+ul -->
    <div>
        <ul>
            <li>
                <a href=""></a>
                <ul></ul>
            </li>
        </ul>
    </div>

    <!-- 상위태그로 이동 : '^' -->
    <!-- div>ul>li^p -->
    <div>
        <ul>
            <li></li>
        </ul>
        <p></p>
    </div>

    <!-- 메뉴구조 만들기 -->
    <!-- div>ul>li>a{MAINMENU $}>ul>li*4{SEBMENU$} -->
    <div>
        <ul>
            <li>
                <a href="">MAINMENU 1
                    <ul>
                        <li>SEBMENU1</li>
                        <li>SEBMENU2</li>
                        <li>SEBMENU3</li>
                        <li>SEBMENU4</li>
                    </ul>
                </a>
            </li>
        </ul>
    </div>

    <!-- 클래스 선택자 : '.' -->
    <!-- .c1 -->
    <div class='c1'></div>
    <!-- .abc -->
    <div class="abc"></div>

    <!-- ID 선택자 : "#" -->
    <!-- #wrapper -->
    <div id="wrapper"></div>
    <!-- aftr 추가 -->
    <!-- div>ol[type='I' date-name='비타500']>li*4{MENU_$} -->
    <div>
        <ol type="I" date-name="비타500">
            <li>MENU_1</li>
            <li>MENU_2</li>
            <li>MENU_3</li>
            <li>MENU_4</li>
        </ol>
    </div>
    <!-- 시작번호 선택 -->
    <!-- div>ul>li*8{TEXT $@5} -->
    <div>
        <ul>
            <li>TEXT 5</li>
            <li>TEXT 6</li>
            <li>TEXT 7</li>
            <li>TEXT 8</li>
            <li>TEXT 9</li>
            <li>TEXT 10</li>
            <li>TEXT 11</li>
            <li>TEXT 12</li>
        </ul>
    </div>

    <!-- 문서 전체 구조 Emmet 만들기 -->
    <!-- .wrapper>header>.top-header+nav^main>section*3^footer -->
    <div class="wrapper">
        <header>
            <div class="top-header"></div>
            <nav>
                <!-- ul.main-menu>li*4.a{$_mainmenu}+ul>li*5>a{$_submenu} -->
                <ul class="main-menu">
                    <li class="a">1_mainmenu</li>
                    <li class="a">2_mainmenu</li>
                    <li class="a">3_mainmenu</li>
                    <li class="a">4_mainmenu</li>
                    <ul>
                        <li><a href="">1_submenu</a></li>
                        <li><a href="">2_submenu</a></li>
                        <li><a href="">3_submenu</a></li>
                        <li><a href="">4_submenu</a></li>
                        <li><a href="">5_submenu</a></li>
                    </ul>
                </ul>
            </nav>
        </header>
        <main>
            <section></section>
            <section></section>
            <section></section>
        </main>
        <footer></footer>
    </div>

</body>

</html>
```

---

> **06TABLE.html**
> 

```jsx
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <table border="1" width="400px" height="300px">
        <tr>
            <th>열이름1</th>
            <th>열이름2</th>
            <th>열이름3</th>
        </tr>
        <tr>
            <td>값1</td>
            <td>값2</td>
            <td>값3</td>
        </tr>
    </table>
    <hr />
    <!-- rowspan : 행병합 -->
    <!-- table>tr*5>td*4{$} -->
    <style>
        .tbl_rowspan td{
            width: 35px; height: 35px; border: 1px solid;
            text-align:center;
        }
      </style>
     <table border="1" width="100px" height="100px">
        <tr>
            <td rowspan="2">1</td>
            <td>2</td>
            <td>3</td>
            <td>4</td>
        </tr>
        <tr>
             <td>5</td> 
            <td rowspan="2">2</td>
            <td>3</td>
            <td rowspan="4">4</td>
        </tr>
        <tr>
            <td>1</td>
             <td>2</td> 
            <td>3</td>
             <td>4</td> 
        </tr>
        <tr>
            <td>1</td>
            <td>2</td>
            <td>3</td>
             <td>4</td>
        </tr>
        <tr>
            <td>1</td>
            <td>2</td>
            <td>3</td>
             <td>4</td>
        </tr>
     </table>
     <br/>
     <hr>

    <!-- colspan : 열병합 -->
    <!-- table>tr*5>td*4{$} -->
    <style>
        .tbl_colspan td {
            width: 35px;
            height: 35px;
            border: 1px solid;
            text-align: center;
        }
    </style>
    <table border="1" width="100px" height="100px">
        <tr>
            <td colspan="2">1</td>
            <!-- <td>2</td> -->
            <td>3</td>
            <td>4</td>
        </tr>
        <tr>
            <td>5</td>
            <td colspan="3">2</td>
            <!-- <td>3</td> -->
            <!-- <td >4</td> -->
        </tr>
        <tr>
            <td>1</td>
            <td>2</td>
            <td>3</td>
            <td>4</td>
        </tr>
        <tr>
            <td colspan="4">1</td>
            <!-- <td>2</td> -->
            <!-- <td>3</td> -->
            <!-- <td>4</td> -->
        </tr>
        <tr>
            <td>1</td>
            <td>2</td>
            <td>3</td>
            <td>4</td>
        </tr>
    </table>

</body>

</html>
```

---

> **07TABLE 문제.html**
> 

```jsx
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <style>
        th{
            border-color: red;
            border-style: solid;
            border-width: 1.5px;
        }
        td{
            border-color: red;
            border-style: solid;
            border-width: 1.5px;
        }
        .tbl_colspan{width: 35px;height: 35px;border: 1px solid;text-align: center;
        }
        .tbl_rowspan{width: 35px;height: 35px;border: 1px solid;text-align: center;
        }
    </style>
    <table border="1" width="600px" height="80px">
        <tr>
            <th colspan="6">한국의 차</th>
        </tr>
        <tr>
            <td rowspan="6">뿌리차</td>
            <td>인삼차</td>
            <td rowspan="10">과일차</td>
            <td>수정과</td>
            <td rowspan="5">잎차</td>
            <td>뽕잎차</td>
        </tr>
        <tr>
            <td>당귀차</td>
            <td>유자차</td>
            <td>감잎차</td>
        </tr>
        <tr>
            <td>생강차</td>
            <td>구기자차</td>
            <td>솔잎차</td>
        </tr>
        <tr>
            <td>값1</td>
            <td>값2</td>
            <td>값3</td>
        </tr>
        <tr>
            <td>값1</td>
            <td>값2</td>
            <td>값3</td>
        </tr>
        <tr>
            <td>값1</td>
            <td>값2</td>
            <td rowspan="4">기타</td>
            <td>값4</td>
        </tr>
        <tr>
            <td rowspan="3">곡물차</td>
            <td>값2</td>
            <td>값3</td>
            <td>값4</td>
        </tr>
        <tr>
            <td>값1</td>
            <td>값2</td>
            <td>값4</td>
        </tr>
        <tr>
            <td>값1</td>
            <td>값2</td>
            <td>값4</td>
        </tr>

    </table>
</body>

</html>
```

---

> **08A.html**
> 

```jsx
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        a{
            text-decoration: none;
            color: black;

        }
        .btn{
            /*block태그전환*/
            display: block;
            /*가로세로*/
            width: 100px;
            height: 35px;
            /*테두리*/
            border: 1px solid;
            border-radius: 12px;
            /*글자크기*/
            font-size: .9rem;
            font-weight: 600;
            /*그림자*/
            box-shadow: 3px 3px 3px lightgray;
            /*배치(가운데)*/
            display: flex;
            justify-content: center;
            align-items: center;
            /*여백*/
            margin: 10px;
            /*글자색*/
            color:black;
        }
        .btn-primary{
            background-color: royalblue;
        }
        .btn-secondary{
            background-color: orange;
        }
    </style>
</head>
<body>
    <a href="./02BASIC.html" class="btn btn-primary">TEST1</a>
    <a href="https://naver.com" class="btn btn-secondary">NAVER</a>
    <a href="https://naver.com" target="_blank">NAVER_새탭열기</a>
    <hr/>

    <div>
        <a href="./02BASIC.html" target="frm1">02.BASIC.html 로 이동</a>
        <a href="https://www.daum.net" target="frm1">다음으로 이동</a>
        <a href="https://naver.com" target="_blank">NAVER 열기</a>
    </div>
    <iframe namme="frm1" src="" frameborder="0" width="400px" height="400px" style="border: 1px solid;"></iframe>
    
</body>
</html>
```

---

> **09A.html**
> 

```jsx
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
        }

        header {
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 50px;
            border: 1px solid;
            background-color: white;
            z-index: 5;
        }

        main {
            position: relative;
            top: 120px;
        }

        main section {
            margin-top: 50px;
        }
    </style>
</head>

<body>
    <!-- .wrapper>header^main>section*3^footer -->
    <div class="wrapper">
        <header
            style="height: 100px;border: 1px solid; display: flex; justify-content: center;align-items: center;gap: 15px;">
            <a href="#html">HTML</a> |
            <a href="#css">CSS</a> |
            <a href="#js">JS</a>
        </header>
    </div>
    <main>
        <section>
            <!-- HTML -->
            <h1>HTML</h1>
            <a name="html"></a>
            <p>
                Lorem ipsum dolor sit amet consectetur adipisicing elit. Rem perfer
                endis similique officiis, libero obcaecati repellat quod dolores aliq
                uam odio magni. Unde sed veniam a corrupti, cumque soluta odio quia re
                iciendis magnam laborum et expedita voluptate illo, laudantium obcaecati
                odit non? Beatae omnis maxime quos nihil delectus id. Blanditiis, sapient
                Lorem ipsum dolor sit amet consectetur adipisicing elit. Rem perfer
                endis similique officiis, libero obcaecati repellat quod dolores aliq
                uam odio magni. Unde sed veniam a corrupti, cumque soluta odio quia re
                iciendis magnam laborum et expedita voluptate illo, laudantium obcaecati
                odit non? Beatae omnis maxime quos nihil delectus id. Blanditiis, sapient
                Lorem ipsum dolor sit amet consectetur adipisicing elit. Rem perfer
                endis similique officiis, libero obcaecati repellat quod dolores aliq
                uam odio magni. Unde sed veniam a corrupti, cumque soluta odio quia re
                iciendis magnam laborum et expedita voluptate illo, laudantium obcaecati
                odit non? Beatae omnis maxime quos nihil delectus id. Blanditiis, sapient
            </p>
        </section>
        <section>
            <!-- CSS -->
            <h1>CSS</h1>
            <a name="css"></a>
            <p>
                Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis qua
                m nostrum consequuntur enim nemo eum! Corporis provident ipsam, nam ob
                caecati officia rerum consequuntur. Culpa, voluptate. Voluptatibus nisi totam optio expedita.
                Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis qua
                m nostrum consequuntur enim nemo eum! Corporis provident ipsam, nam ob
                caecati officia rerum consequuntur. Culpa, voluptate. Voluptatibus nisi totam optio expedita.
                Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis qua
                m nostrum consequuntur enim nemo eum! Corporis provident ipsam, nam ob
                caecati officia rerum consequuntur. Culpa, voluptate. Voluptatibus nisi totam optio expedita.
            </p>
        </section>
        <section>
            <!-- JS -->
            <h1>JS</h1>
            <a name="js"></a>
            <p>
                e cupiditate esse, voluptatem asperiores nisi ea officia libero tempora co
                mmodi placeat odit tenetur illo. Atque quisquam nemo corrupti accusamus al
                iquam, velit dolorum culpa earum facere nobis cupiditate deleniti expedita
                voluptates ab quasi molestias perspiciatis eaque cumque corporis odio minima beatae ratione. Quia,
                culpa aspernatur aliquid cumque incidunt accusamus? Impedit, sapiente doloribus.
                e cupiditate esse, voluptatem asperiores nisi ea officia libero tempora co
                mmodi placeat odit tenetur illo. Atque quisquam nemo corrupti accusamus al
                iquam, velit dolorum culpa earum facere nobis cupiditate deleniti expedita
                voluptates ab quasi molestias perspiciatis eaque cumque corporis odio minima beatae ratione. Quia,
                culpa aspernatur aliquid cumque incidunt accusamus? Impedit, sapiente doloribus.
                e cupiditate esse, voluptatem asperiores nisi ea officia libero tempora co
                mmodi placeat odit tenetur illo. Atque quisquam nemo corrupti accusamus al
                iquam, velit dolorum culpa earum facere nobis cupiditate deleniti expedita
                voluptates ab quasi molestias perspiciatis eaque cumque corporis odio minima beatae ratione. Quia,
                culpa aspernatur aliquid cumque incidunt accusamus? Impedit, sapiente doloribus.
            </p>
        </section>
    </main>
    <footer></footer>
</body>

</html>
```

---

> **10IMAGE.html**
> 

```jsx
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <div>
        <!-- <img src="./images/새 프로젝트.png" width="500px" height="500px" alt="오류다"> -->
        <!-- <img src="./images/새 프로젝트.png" alt="오류다"> -->
    </div>
    <div>
        <a href="https://naver.com">
            <img width=200px src="./images/새 프로젝트 (1).png" alt="오류">
        </a>
    </div>
</body>
</html>
```

---

> **11IMAGE.html**
> 

```jsx
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        img{
            width: 150px;
            height: 350px;
        }
    </style>
</head>
<body>
    <div>
        <img src="./images/home_24dp_5F6368_FILL0_wght400_GRAD0_opsz24.png" alt="">
    </div>
    <div>
        <img src="./images/home_24dp_5F6368_FILL0_wght400_GRAD0_opsz24.svg" alt="">
    </div>
</body>
</html>
```