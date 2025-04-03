# 🫘 JSP에서 JavaBean 사용하기 - 완벽 정리

**JavaBean**은 JSP에서 데이터를 저장하고 전달할 때 사용하는 **자바 객체**입니다!  
JSP에서 Java 클래스를 생성하고 `<jsp:useBean>`, `<jsp:setProperty>`, `<jsp:getProperty>` 태그로 연결하여 데이터를 주고받을 수 있어요.

---

## 📌 개요 (Overview)

| 항목 | 설명 |
|------|------|
| JavaBean이란? | 자바의 기본 클래스 구조로 데이터를 저장하고 관리하는 객체 |
| JSP에서 역할 | 폼에서 받은 데이터를 저장하고 JSP 간에 주고받기 위함 |
| 사용 위치 | `<jsp:useBean>`, `<jsp:setProperty>`, `<jsp:getProperty>` 태그 사용 |

---

## 🧱 JavaBean 클래스 만들기

```java
public class Person implements java.io.Serializable {
    private String name;
    private int age;

    public Person() {} // 기본 생성자 필수

    // Getter/Setter
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }
}
```

- 모든 필드는 `private`로 설정
- **기본 생성자** 필요
- **Getter/Setter** 필수

---

## ✨ JSP에서 JavaBean 연결

### 1. `<jsp:useBean>` — 객체 생성

```jsp
<jsp:useBean id="person" class="beans.Person" scope="request" />
```

| 속성 | 설명 |
|------|------|
| `id` | 자바빈즈 객체 이름 |
| `class` | 자바 클래스의 전체 경로 |
| `scope` | 객체 유효 범위 (`page`, `request`, `session`, `application`) |

---

### 2. `<jsp:setProperty>` — 값 설정

```jsp
<jsp:setProperty name="person" property="name" value="홍길동" />
<jsp:setProperty name="person" property="age" value="30" />
```

- `name` : 설정할 자바빈 객체의 이름
- `property` : 설정할 속성 이름
- `value` : 설정할 값

> 🔄 자동 매핑도 가능!
```jsp
<jsp:setProperty name="person" property="*" />
```
HTML 폼의 name 속성과 Bean의 필드명이 같으면 자동 매핑돼요.

---

### 3. `<jsp:getProperty>` — 값 출력

```jsp
<p>이름: <jsp:getProperty name="person" property="name" /></p>
<p>나이: <jsp:getProperty name="person" property="age" /></p>
```

- `name` : 값을 가져올 자바빈 객체 이름
- `property` : 가져올 속성 이름

---

## 🧪 예제 흐름 요약

### 📤 폼에서 데이터 전송 (form.jsp)

```html
<form action="result.jsp" method="post">
    이름: <input type="text" name="name" />
    나이: <input type="text" name="age" />
    <input type="submit" value="전송" />
</form>
```

### 📥 결과 처리 (result.jsp)

```jsp
<jsp:useBean id="person" class="beans.Person" scope="request" />
<jsp:setProperty name="person" property="*" />

<p>이름: <jsp:getProperty name="person" property="name" /></p>
<p>나이: <jsp:getProperty name="person" property="age" /></p>
```

---

## ⚠ 주의사항 (Cautions)

- Bean 클래스는 반드시 **기본 생성자**가 있어야 합니다.
- Bean의 필드는 **private**로 선언하고, **getter/setter**를 통해 접근해야 해요.
- `property="*"` 사용 시, **폼 필드 이름과 Bean 속성명이 같아야** 자동 설정됩니다.

---

## ✅ 한 줄 요약 (1-Line Summary)

> 🫘 JSP의 JavaBean은 데이터를 저장하고 JSP 페이지 간에 주고받는 **작고 똑똑한 자바 객체**입니다!

---
