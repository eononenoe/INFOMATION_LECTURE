## JAVA
### demo
> DemoApplication
```java
package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

}
```
---
### C01OpenData
> OpenData01Controller
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
> OpenData02Controller
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
## VIEW
### openData
> forcast.html
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
> unexpected.html
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