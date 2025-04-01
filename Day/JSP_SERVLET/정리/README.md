# 📘 JSP 문법 및 Request 처리 정리

## 📌 JSP 구성 요소

### 1. 선언문 (`<%! %>`)
- **한 줄 요약**: 서블릿 클래스의 멤버 변수/함수를 정의하는 공간
- **설명**: JSP가 서블릿 클래스로 변환될 때 멤버로 포함됨
- **예시**
    ```jsp
    <%! 
        String name = "HONG GIL DONG"; 
        public String testFunc(){
            return "name : " + name;
        } 
    %>
    <%= testFunc() %>
    ```

---

### 2. 스크립틀릿 (`<% %>`)
- **한 줄 요약**: JSP 내부에서 Java 로직을 실행
- **설명**: 지역 변수, 조건문, 반복문 등 service 메서드 내부에서 처리됨
- **예시**
    ```jsp
    <% 
        String str1 = "HELLO1";
        String str2 = "HELLO2";
        String str3 = str1 + str2;
        for(int i=0;i<10;i++){
            System.out.println(i);
        }
    %>
    ```

---

### 3. 표현식 (`<%= %>`)
- **한 줄 요약**: 자바 실행 결과를 HTML로 출력
- **예시**
    ```jsp
    <%= name %> 
    <%= testFunc() %>
    ```

---

## 📌 GET / POST 요청 처리

### 4. GET 방식 (`method="get"`)
- **특징**: URL에 파라미터가 포함됨, 빠르지만 보안에 취약
- **예시**
    ```html
    <form action="C01Request_Process.jsp" method="get">
        <input type="text" name="username"/>
        ...
    </form>
    ```
- **서버 처리**
    ```jsp
    String username = request.getParameter("username");
    ```

---

### 5. POST 방식 (`method="post"`)
- **특징**: 데이터가 HTTP Body에 포함됨, 보안상 안전
- **문자 인코딩 필수 설정**
    ```jsp
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    ```

---

### 6. EL(Expression Language)
- **한 줄 요약**: JSP의 데이터를 간결하게 표현
- **예시**
    ```html
    <body style="background-color:${param.bgColor}">
        ${param.username}
    </body>
    ```

---

## 📌 JSP ↔ JavaScript 연동

### 7. JSP → JS 데이터 전달

- **표현식 사용**
    ```html
    <script>
        const message = '<%= msg %>';
    </script>
    ```

- **EL 사용**
    ```html
    <script>
        const message = '${message}';
    </script>
    ```

- **템플릿 리터럴 사용**
    ```html
    <script>
        const message = `${message}`;
    </script>
    ```

---

### 8. JS → JSP 데이터 전달

- **JS에서 form 자동 전송**
    ```html
    <form action="C04JStoJSP.jsp" name="myForm">
        <input name="username" type="hidden" />
        <input name="password" type="hidden" />
        <input name="role" type="hidden" />
        <input name="flag" value="true" type="hidden" />
    </form>

    <script>
        const flag = '<%= isInit %>';
        if(flag === 'true'){
            form.username.value = "홍길동";
            form.password.value = "1234";
            form.role.value = "ROLE_USER";
            form.submit();
        }
    </script>
    ```

---

## 💡 Tip
- 선언문(`<%! %>`)은 클래스 레벨, 스크립틀릿(`<% %>`)은 메서드 레벨입니다.
- EL과 JSTL을 활용하면 가독성과 유지보수가 좋아집니다.
- POST 방식에서는 반드시 인코딩 설정을 추가하세요.

