
# 🌐 RESTful API 실습 정리 (공공데이터 기반) – 전체 코드 포함 + 실제 HTML 반영

---

## 📌 개요 (Overview)

이번 실습에서는 **Spring Boot + RestTemplate** 기반으로 공공 데이터 포털(OpenAPI)을 연동하여 RESTful API를 호출하고, JSON 데이터를 Java 객체로 역직렬화한 후, **Thymeleaf 템플릿 엔진**을 통해 뷰에 출력하는 과정을 실습했습니다.

---

## ⚙️ 사용된 의존성 (build.gradle 발췌)

```groovy
implementation 'org.springframework.boot:spring-boot-starter-web'
implementation 'org.springframework.boot:spring-boot-starter-thymeleaf'
implementation 'com.fasterxml.jackson.core:jackson-databind:2.19.0'
implementation 'com.fasterxml.jackson.dataformat:jackson-dataformat-xml:2.19.0'
implementation 'com.fasterxml.jackson.datatype:jackson-datatype-jsr310:2.19.0'
implementation 'com.fasterxml.jackson.core:jackson-annotations:2.19.0'
compileOnly 'org.projectlombok:lombok'
annotationProcessor 'org.projectlombok:lombok'
```

---

## 📂 디렉토리 구조 요약

```
src/
└── main/
    ├── java/
    │   └── com.example.demo
    │       └── C01OpenData
    │           ├── OpenData01Controller.java
    │           └── OpenData02Controller.java
    └── resources/
        └── templates/
            └── openData/
                ├── unexpected.html
                └── forcast.html
```

---

## 📄 OpenData01Controller.java 전체 코드

```java
package com.example.demo.C01OpenData;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;

@Controller
@Slf4j
@RequestMapping("/openData")
public class OpenData01Controller {
    //대구광역시_돌발 교통정보 조회 서비스(신)
    String url = "https://apis.data.go.kr/6270000/service/rest/dgincident";
    String serviceKey = "xYZ80mMcU8S57mCCY/q8sRsk7o7G8NtnfnK7mVEuVxdtozrl0skuhvNf34epviHrru/jiRQ41FokE9H4lK0Hhg==";
    String pageNo = "1";
    String numOfRows = "10";

    @GetMapping("/unexpected")
    public void unexpected(Model model){
        //01 서버요청정보 확인(URL /KEY / etc Parameter)
        url+="?serviceKey=" + serviceKey;
        url+="&pageNo=" + pageNo;
        url+="&numOfRows="+numOfRows;

        //02 요청 헤더 설정(x)
        
        //03 요청 바디 설정(x)
        
        //04 요청 작업 이후 결과 확인
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Root> response =
        restTemplate.exchange(url, HttpMethod.GET,null,Root.class);
        System.out.println(response);
        //05 기타 가공처리
//        if(response.get)

        //뷰 전달
        Root root =  response.getBody();
        Body body =  root.getBody();
        Items items = body.getItems();
        List<Item> list = items.getItem();
        list.stream().forEach(System.out::println);

        model.addAttribute("list" , list);

    }

    //-----------------------------------
    @Data
    private static class Body{
        public Items items;
        public String numOfRows;
        public String pageNo;
        public String totalCount;
    }
    @Data
    private static class Header{
        public String resultCode;
        public String resultMsg;
    }
    @Data
    private static class Item{
        @JsonProperty( value ="LOCATION" ,required = false)
        public String LOCATION;
        @JsonProperty(value ="INCIDENTTITLE")
        public String INCIDENTTITLE;
        @JsonProperty(value ="LOGDATE")
        public String LOGDATE;
        @JsonProperty(value ="TROUBLEGRADE")
        public String TROUBLEGRADE;
        @JsonProperty(value ="STARTDATE")
        public String STARTDATE;
        @JsonProperty(value ="INCIDENTSUBCODE")
        public String INCIDENTSUBCODE;
        @JsonProperty(value ="LINKID")
        public String LINKID;
        @JsonProperty(value ="REPORTDATE")
        public String REPORTDATE;
        @JsonProperty(value ="ENDDATE")
        public String ENDDATE;
        @JsonProperty(value ="COORDX")
        public double COORDX;
        @JsonProperty(value ="INCIDENTCODE")
        public String INCIDENTCODE;
        @JsonProperty(value ="INCIDENTID")
        public String INCIDENTID;
        @JsonProperty(value ="COORDY")
        public double COORDY;
        @JsonProperty("TRAFFICGRADE")
        public String TRAFFICGRADE;
    }
    @Data
    private static class Items{
        public ArrayList<Item> item;
    }
    @Data
    private static class Root{
        public Body body;
        public Header header;
    }
    //-----------------------------------

}

```

---

## 📄 OpenData02Controller.java 전체 코드

```java
package com.example.demo.C01OpenData;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;

@Controller
@Slf4j
@RequestMapping("/openData")
public class OpenData02Controller {

    String url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst";
    String serviceKey = "xYZ80mMcU8S57mCCY/q8sRsk7o7G8NtnfnK7mVEuVxdtozrl0skuhvNf34epviHrru/jiRQ41FokE9H4lK0Hhg==";
    String pageNo = "1";
    String numOfRows = "10";
    String base_date = "20250509";
    String base_time = "1600";
    String dataType = "JSON";
    String nx = "89";
    String ny = "90";
    @GetMapping("/forcast")
    public void forcast(Model model){
        log.info("GET /openData/forcast...");
        // 서버 정보
        url += "?serviceKey=" + serviceKey;
        url +="&pageNo=" + pageNo;
        url +="&numOfRows=" + numOfRows;
        url +="&base_date=" + base_date;
        url +="&base_time=" + base_time;
        url +="&dataType=" + dataType;
        url +="&nx="+nx;
        url +="&ny="+ny;
        // 요청 헤더(x)
        // 요청 바디(x)
        // 요청 -> 응답
        RestTemplate rt = new RestTemplate();
        ResponseEntity<OpenData02Controller.Root> response = rt.exchange(url, HttpMethod.GET,null,OpenData02Controller.Root.class);
        System.out.println(response.getBody());
        // 데이터 가공처리
        OpenData02Controller.Root root = response.getBody();
        OpenData02Controller.Response res = root.getResponse();
        OpenData02Controller.Body body = res.getBody();
        OpenData02Controller.Items items = body.getItems();
        List<OpenData02Controller.Item> list = items.getItem();
        list.stream().forEach(System.out::println);
        model.addAttribute("list",list);

    }

    //------------------------------------------
    @Data
    private static class Body{
        public String dataType;
        public Items items;
        public int pageNo;
        public int numOfRows;
        public int totalCount;
    }
    @Data
    private static class Header{
        public String resultCode;
        public String resultMsg;
    }
    @Data
    private static class Item{
        public String baseDate;
        public String baseTime;
        public String category;
        public int nx;
        public int ny;
        public String obsrValue;
    }
    @Data
    private static class Items{
        public ArrayList<Item> item;
    }
    @Data
    private static class Response{
        public Header header;
        public Body body;
    }
    @Data
    private static class Root{
        public Response response;
    }
    //------------------------------------------
}

```

---

## 🖥️ unexpected.html (도로 돌발 정보)

```html
<!DOCTYPE html>
<html lang="en" xmlns:th="">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    <h1>대구 돌발 사고 정보 실시간 조회</h1>
    <hr/>
    <th:block th:each="item:${list}">
        <p>
            <div th:text="${item.LOCATION}"></div>
            <div th:text="${item.INCIDENTTITLE}"></div>
            <div th:text="${item.LOGDATE}"></div>
            <div th:text="${item.TROUBLEGRADE}"></div>
            <div th:text="${item.STARTDATE}"></div>
            <div th:text="${item.INCIDENTSUBCODE}"></div>
            <div th:text="${item.LINKID}"></div>
            <div th:text="${item.REPORTDATE}"></div>
            <div th:text="${item.ENDDATE}"></div>
            <div th:text="${item.COORDX}"></div>
            <div th:text="${item.INCIDENTCODE}"></div>
            <div th:text="${item.INCIDENTID}"></div>
            <div th:text="${item.COORDY}"></div>
            <div th:text="${item.TRAFFICGRADE}"></div>
        </p>
        <hr/>
    </th:block>

</body>
</html>
```

---

## 🖥️ forcast.html (초단기 실황 조회)

```html
<!DOCTYPE html>
<html lang="en" xmlns:th="">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<h1>초단기 실황 조회</h1>
<hr/>
<th:block th:each="item:${list}">
    <p>
        <div th:text="${item.baseDate}"></div>
        <div th:text="${item.baseTime}"></div>
        <div th:text="${item.category}"></div>
        <div th:text="${item.nx}"></div>
        <div th:text="${item.ny}"></div>
        <div th:text="${item.obsrValue}"></div>
    </p>

</th:block>
</body>
</html>
```

---

## 📚 한 줄 요약 (1-Line Summary)

Spring Boot의 RestTemplate과 Thymeleaf를 활용해 공공 REST API 데이터를 받아오고 HTML로 렌더링하는 전 과정을 경험한 실습입니다.



---

## 🧠 개념 상세 설명

| 항목 | 설명 |
|------|------|
| `@Controller` | Spring MVC에서 HTML 뷰를 반환하는 클래스에 사용. 주로 템플릿 뷰(.html)와 연결됨 |
| `RestTemplate` | Java에서 외부 HTTP API를 호출하기 위한 Spring의 도구로, GET, POST 등 요청을 보낼 수 있음 |
| `exchange()` | RestTemplate의 핵심 메서드. 요청 메서드(GET, POST 등), URL, 요청 바디, 응답 타입을 지정하여 외부 API 호출 |
| `ResponseEntity<T>` | 응답 HTTP 상태 코드, 헤더, 바디를 모두 포함하는 객체 |
| `getBody()` | `ResponseEntity`에서 실제 응답 데이터(본문)를 추출하는 메서드 |
| `Model` | 컨트롤러에서 뷰(.html)로 데이터를 전달할 때 사용. `addAttribute("key", value)` 형태로 전달 |
| `@JsonProperty` | JSON 필드명과 자바 필드명이 다를 경우 매핑을 도와주는 Jackson 어노테이션 |
| `@Data` | Lombok 제공. Getter, Setter, toString, equals 등을 자동으로 만들어줌 |
| `th:each` | Thymeleaf에서 리스트나 배열을 반복 출력할 때 사용하는 문법 |
| `th:text` | Thymeleaf에서 해당 태그 내부에 텍스트로 데이터를 삽입 |
| `stream()` | Java 8 이상에서 제공하는 데이터 처리 API. 컬렉션 데이터를 선언형으로 처리 가능 |
| `forEach()` | 스트림 또는 리스트 등 반복 가능한 데이터 요소를 하나씩 처리하는 함수형 메서드 |
| `List<T>` | 자바의 기본 자료구조 중 하나. 순서가 있는 데이터 집합을 표현할 때 사용 |

---

📝 예시:

```java
list.stream().forEach(item -> System.out.println(item));
```

- `stream()` : 리스트의 요소를 스트림 형태로 변환 (반복 가능하게 만듦)
- `forEach()` : 각 요소마다 지정된 작업을 수행 (여기서는 출력)

---

🧠 추가 팁

- `getBody()`는 외부 API에서 JSON을 받아올 때 본문만 뽑아내는 용도로 사용됨
- `th:each="item : ${list}"`는 마치 Java의 `for (Item item : list)`와 동일한 개념
