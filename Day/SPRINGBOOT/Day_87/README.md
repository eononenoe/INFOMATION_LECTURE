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
    //관련 참조 사이트(국가교통정보센터) : https://www.its.go.kr/opendata/opendataList
    //공공데이터 포털 : 대구광역시_돌발 교통정보 조회 서비스(신)
    String url = "https://apis.data.go.kr/6270000/service/rest/dgincident";
    String serviceKey = "";
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;

@RestController
@Slf4j
@RequestMapping("/openData")
public class OpenData02Controller {

    String url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst";
    String serviceKey = "";
    String pageNo = "1";
    String numOfRows = "10";
    String base_date = "20250509";
    String base_time = "1600";
    String dataType = "JSON";
    String nx = "89";
    String ny = "90";
    @GetMapping("/forcast")
    public void forcast(){
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
        ResponseEntity<Root> response = rt.exchange(url, HttpMethod.GET,null,Root.class);
        System.out.println(response);
        // 데이터 가공처리
        Root root = response.getBody();
        Response rs =  root.getResponse();
        Body body = rs.getBody();
        Items items =  body.getItems();
        List<Item> list =  items.getItem();
        list.stream().forEach(System.out::println);





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
> OpenData03Controller
```java
package com.example.demo.C01OpenData;



import com.example.demo.C01OpenData.bus.BUSResult;
import jakarta.xml.bind.annotation.*;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URLEncoder;
import java.util.List;

@RestController
@Slf4j
@RequestMapping("/openData")
public class OpenData03Controller {

    @GetMapping("/bus/realtime")
    public void bus_realtime() throws UnsupportedEncodingException {
        String url = "https://apis.data.go.kr/6270000/dbmsapi01/getRealtime";
        String serviceKey =  "xYZ80mMcU8S57mCCY/q8sRsk7o7G8NtnfnK7mVEuVxdtozrl0skuhvNf34epviHrru/jiRQ41FokE9H4lK0Hhg==";
        String bsId = "7001001600";
        String routeNo = "649";

        URI uri = UriComponentsBuilder
                .fromHttpUrl(url)
                .queryParam("serviceKey", URLEncoder.encode(serviceKey, "UTF-8")) // 인코딩 꼭 필요
                .queryParam("bsId", bsId)
                .queryParam("routeNo", routeNo)
                .build(true) // 자동 인코딩 방지 → true 설정 중요
                .toUri();

        RestTemplate rt = new RestTemplate();
        ResponseEntity<BUSResult> response = rt.exchange(uri, HttpMethod.GET,null,BUSResult.class);
        System.out.println(response.getBody());
        // 가공처리

        //

        //
    }

}
```
---
### bus
> BUSResult
```java
package com.example.demo.C01OpenData.bus;

import jakarta.xml.bind.annotation.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;


import java.util.List;

@Data
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name = "BUSResult")
public class BUSResult {

    @XmlElement(name = "header")
    private Header header;

    @XmlElement(name = "body")
    private Body body;

    @Data
    @XmlAccessorType(XmlAccessType.FIELD)
    public static class Header {

        @XmlElement(name = "success")
        private boolean success;

        @XmlElement(name = "resultCode")
        private String resultCode;

        @XmlElement(name = "resultMsg")
        private String resultMsg;
    }

    @Data
    @XmlAccessorType(XmlAccessType.FIELD)
    public static class Body {

        @XmlElement(name = "items")
        private Items items;

        @XmlElement(name = "totalCount")
        private int totalCount;
    }

    @Data
    @XmlAccessorType(XmlAccessType.FIELD)
    public static class Items {

        @XmlElement(name = "routeNo")
        private String routeNo;

        @XmlElementWrapper(name = "arrList")
        @XmlElement(name = "arrList")
        private List<ArrList> arrList;
    }

    @Data
    @XmlAccessorType(XmlAccessType.FIELD)
    public static class ArrList {

        @XmlElement(name = "routeId")
        private String routeId;

        @XmlElement(name = "routeNo")
        private String routeNo;

        @XmlElement(name = "moveDir")
        private int moveDir;

        @XmlElement(name = "bsGap")
        private int bsGap;

        @XmlElement(name = "bsNm")
        private String bsNm;

        @XmlElement(name = "vhcNo2")
        private String vhcNo2;

        @XmlElement(name = "busTCd2")
        private String busTCd2;

        @XmlElement(name = "busTCd3")
        private String busTCd3;

        @XmlElement(name = "busAreaCd")
        private String busAreaCd;

        @XmlElement(name = "arrState")
        private String arrState;

        @XmlElement(name = "prevBsGap")
        private int prevBsGap;
    }
}
```
---
### C02OpenWeatherMap
> OpenWeatherController
```java
package com.example.demo.C02OpenWeatherMap;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URLEncoder;
import java.util.ArrayList;

@RestController
@Slf4j
@RequestMapping("/open/weather")
public class OpenWeatherController {
    //https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    @GetMapping("/get/{lat}/{lon}")
    public ResponseEntity<Root> get(@PathVariable String lat , @PathVariable String lon) throws UnsupportedEncodingException {
        log.info("GET /open/weather/get....");
        String url="https://api.openweathermap.org/data/2.5/weather";
//        String lat="";
//        String lon="";
        String serviceKey="2d8187fb662c9a0871d7a65d5941a3e8";
        URI uri = UriComponentsBuilder
                .fromHttpUrl(url)
                .queryParam("appid", URLEncoder.encode(serviceKey, "UTF-8")) // 인코딩 꼭 필요
                .queryParam("lat", lat)
                .queryParam("lon", lon)
                .build(true) // 자동 인코딩 방지 → true 설정 중요
                .toUri();

        //요청 헤더 x
        //요청 바디 x

        //요청 -> 응답
        RestTemplate rt = new RestTemplate();
        ResponseEntity<Root> response = rt.exchange(uri, HttpMethod.GET,null,Root.class);
        System.out.println(response.getBody());

        return new ResponseEntity<>(response.getBody(), HttpStatus.OK);






    }

    // import com.fasterxml.jackson.databind.ObjectMapper; // version 2.11.1
// import com.fasterxml.jackson.annotation.JsonProperty; // version 2.11.1
/* ObjectMapper om = new ObjectMapper();
Root root = om.readValue(myJsonString, Root.class); */
    @Data
    private static class Clouds{
        public int all;
    }
    @Data
    private static class Coord{
        public double lon;
        public double lat;
    }
    @Data
    private static class Main{
        public double temp;
        public double feels_like;
        public double temp_min;
        public double temp_max;
        public int pressure;
        public int humidity;
        public int sea_level;
        public int grnd_level;
    }
    @Data
    private static class Root{
        public Coord coord;
        public ArrayList<Weather> weather;
        public String base;
        public Main main;
        public int visibility;
        public Wind wind;
        public Clouds clouds;
        public int dt;
        public Sys sys;
        public int timezone;
        public int id;
        public String name;
        public int cod;
    }
    @Data
    private static class Sys{
        public int type;
        public int id;
        public String country;
        public int sunrise;
        public int sunset;
    }
    @Data
    private static class Weather{
        public int id;
        public String main;
        public String description;
        public String icon;
    }
    @Data
    private static class Wind{
        public double speed;
        public int deg;
    }


}
```
---
### C03Leatlet
> LeafletController
```java
package com.example.demo.C03Leatlet;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequestMapping("/leaflet")
public class LeafletController {
    @GetMapping("index")
    public void index(){
        log.info("GET /leaflet/index...");
    }
}
```
---
### C04Kakao
> C01KakaoMapController
```java
package com.example.demo.C04Kakao;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequestMapping("/kakao/map")
public class C01KakaoMapController {
    @GetMapping("/01")
    public void map_01(){
        log.info("GET /kakao/map/01...");
    }

    @GetMapping("/02")
    public void map_02(){
        log.info("GET /kakao/map/02...");
    }
}
```
---
## VIEW
### map
> 01.html
```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>지도 생성하기</title>

</head>
<body>
<!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width:100%;height:800px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24e6b922efee68203bbb325a7f168bc3&libraries=LIBRARY"></script>

<script >

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 마커가 표시될 위치입니다
    var markerPosition  = new kakao.maps.LatLng(33.450701, 126.570667);

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    // 마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);

    // 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
    var iwContent = '<div style="padding:5px;">Hello World!</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
        iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

    // 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow({
        content : iwContent,
        removable : iwRemoveable
    });

    // 마커에 클릭이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'click', function() {
          // 마커 위에 인포윈도우를 표시합니다
          infowindow.open(map, marker);
    });
</script>
</body>
</html>
```
---
> 02.html
```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>키워드로 장소검색하고 목록으로 표출하기</title>

    <!--    BS-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

    <style>

        /*ADD */
        .map_wrap{
            display:flex;
            justify-content:left;
        }
        .map_wrap>#map{
            width : 100%;
        }
        .map_wrap>#menu_wrap{
            width : 300px;
        }

        .map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
        .map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
        .map_wrap {position:relative;width:100%;height:500px;}


        #menu_wrap {height:90vh; position:absolute;top:0;left:0;bottom:0;width:300px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
        .bg_white {background:#fff;}


        /* ADDED */
        #menu_wrap::-webkit-scrollbar {
          display: none;
        }


        #menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
        #menu_wrap .option{text-align: center;}
        #menu_wrap .option p {margin:10px 0;}
        #menu_wrap .option button {margin-left:5px;}
        #placesList li {list-style: none;}
        #placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
        #placesList .item span {display: block;margin-top:4px;}
        #placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
        #placesList .item .info{padding:10px 0 10px 55px;}
        #placesList .info .gray {color:#8a8a8a;}
        #placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
        #placesList .info .tel {color:#009900;}
        #placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px; left:10px;top:20px;}

        /* UPDATE */
        #placesList .item .marker_1 {background-image: url('https://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png');  background-size: 30px 35px; background-repeat: no-repeat; background-position:};

        #placesList .item ::after{

        }

        #placesList .item .marker_2 {background-image: url('https://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png');  background-size: 30px 35px; background-repeat: no-repeat; background-position:}
        #placesList .item .marker_3 {background-image: url('https://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png');  background-size: 30px 35px; background-repeat: no-repeat; background-position:}
        #placesList .item .marker_4 {background-image: url('https://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png');  background-size: 30px 35px; background-repeat: no-repeat; background-position:}
        #placesList .item .marker_5 {background-image: url('https://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png');  background-size: 30px 35px; background-repeat: no-repeat; background-position:}
        #placesList .item .marker_6 {background-image: url('https://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png');  background-size: 30px 35px; background-repeat: no-repeat; background-position:}
        #placesList .item .marker_7 {background-image: url('https://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png');  background-size: 30px 35px; background-repeat: no-repeat; background-position:}
        #placesList .item .marker_8 {background-image: url('https://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png');  background-size: 30px 35px; background-repeat: no-repeat; background-position:}
        #placesList .item .marker_9 {background-image: url('https://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png');  background-size: 30px 35px; background-repeat: no-repeat; background-position:}
        #placesList .item .marker_10 {background-image: url('https://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png');  background-size: 30px 35px; background-repeat: no-repeat; background-position:}
        #placesList .item .marker_11 {background-image: url('https://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png');  background-size: 30px 35px; background-repeat: no-repeat; background-position:}
        #placesList .item .marker_12 {background-image: url('https://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png');  background-size: 30px 35px; background-repeat: no-repeat; background-position:}
        #placesList .item .marker_13 {background-image: url('https://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png');  background-size: 30px 35px; background-repeat: no-repeat; background-position:}
        #placesList .item .marker_14 {background-image: url('https://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png');  background-size: 30px 35px; background-repeat: no-repeat; background-position:}
        #placesList .item .marker_15 {background-image: url('https://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png');  background-size: 30px 35px; background-repeat: no-repeat; background-position:}

        #pagination {margin:10px auto;text-align: center;}
        #pagination a {display:inline-block;margin-right:10px;}
        #pagination .on {font-weight: bold; cursor: default;color:#777;}

        .infowindow{
            width : 300px;
            height : 150px;
            z-index : 1;
            font-size : 1.2rem;
            padding : 5px;
            text-align:center;
            display:flex;
            flex-direction:column;
            align-items:center;
            justify-content:center;
        }
        .infowindow>*{
            margin : 2px;
        }
    </style>

    <link rel="stylesheet" href="../../css/map.css">
</head>
<body>

<div class="map_wrap">
    <div id="map" style="width:100%;height:100vh;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
                <form onsubmit="searchPlaces(); return false;">
                    <div class="row">
                        <div class="col-9" >
                            <input class="form-control w-100" type="text" value="대구 맛집" id="keyword" size="15" style="height:30px;">
                        </div>
                        <div class="col">
                            <button type="submit" class="btn btn-warning w-100" style="height:30px;">검색하기</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
</div>



<!--axios-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.5.0/axios.min.js" integrity="sha512-aoTNnqZcT8B4AmeCFmiSnDlc4Nj/KPaZyB5G7JnOnUEkdNpCZs1LCankiYi01sLTyWy+m2P+W4XM+BuQ3Q4/Dg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4e1450712d271f29b12b9e5ee26425d7&libraries=services"></script>
<script>
    // 마커를 담을 배열입니다
    var markers = [];

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    // 지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 장소 검색 객체를 생성합니다
    var ps = new kakao.maps.services.Places();

    // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow({zIndex:1});

    // 키워드로 장소를 검색합니다
    searchPlaces();

    // 키워드 검색을 요청하는 함수입니다
    function searchPlaces() {

        var keyword = document.getElementById('keyword').value;

        if (!keyword.replace(/^\s+|\s+$/g, '')) {
            alert('키워드를 입력해주세요!');
            return false;
        }

        // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
        ps.keywordSearch( keyword, placesSearchCB);
    }

    // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
    function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {

            // 정상적으로 검색이 완료됐으면
            // 검색 목록과 마커를 표출합니다
            displayPlaces(data);

            // 페이지 번호를 표출합니다
            displayPagination(pagination);

        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

            alert('검색 결과가 존재하지 않습니다.');
            return;

        } else if (status === kakao.maps.services.Status.ERROR) {

            alert('검색 결과 중 오류가 발생했습니다.');
            return;

        }
    }

    // 검색 결과 목록과 마커를 표출하는 함수입니다
    function displayPlaces(places) {

        var listEl = document.getElementById('placesList'),
        menuEl = document.getElementById('menu_wrap'),
        fragment = document.createDocumentFragment(),
        bounds = new kakao.maps.LatLngBounds(),
        listStr = '';

        // 검색 결과 목록에 추가된 항목들을 제거합니다
        removeAllChildNods(listEl);

        // 지도에 표시되고 있는 마커를 제거합니다
        removeMarker();

        for ( var i=0; i<places.length; i++ ) {

            // 마커를 생성하고 지도에 표시합니다
            var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                marker = addMarker(placePosition, i),
                itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
            // LatLngBounds 객체에 좌표를 추가합니다
            bounds.extend(placePosition);

            // 마커와 검색결과 항목에 mouseover 했을때
            // 해당 장소에 인포윈도우에 장소명을 표시합니다
            // mouseout 했을 때는 인포윈도우를 닫습니다
            (function(marker, place) {

                //마우스가 마커에 오버되었을때
                kakao.maps.event.addListener(marker, 'mouseover', function() {
                    displayInfowindow(marker, place);
                });

                kakao.maps.event.addListener(marker, 'mouseout', function() {
                    //infowindow.close();
                });
                //추가
                kakao.maps.event.addListener(marker, 'mouseclick', function() {
                     displayInfowindow(marker, place);
                });

                //아이템에 마우스 오버되었을때
                itemEl.onmouseover =  function () {
                    displayInfowindow(marker, place);
                };

                itemEl.onmouseout =  function () {
                    infowindow.close();
                };
            })(marker, places[i]);  //수정!!!!!!!!!!!!!!!!!!!!!!!! places[i]

            fragment.appendChild(itemEl);
        }

        // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
        listEl.appendChild(fragment);
        menuEl.scrollTop = 0;

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    }

    // 검색결과 항목을 Element로 반환하는 함수입니다
    function getListItem(index, places) {
        var el = document.createElement('li'),
        itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                    '<div class="info">' +
                    '   <h5>' + places.place_name + '</h5>';

        if (places.road_address_name) {
            itemStr += '    <span>' + places.road_address_name + '</span>' +
                        '   <span class="jibun gray">' +  places.address_name  + '</span>';
        } else {
            itemStr += '    <span>' +  places.address_name  + '</span>';
        }

          itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                    '</div>';

        el.innerHTML = itemStr;
        el.className = 'item';

        //-----------------------------------------------------------------
        //추가
        //-----------------------------------------------------------------
        el.addEventListener('click',function(){
            console.log("clicked...!");
            console.log(places);
            panTo(places);
        })
        return el;
    }
    //--------------------------------------------------------
    //지도이동
    //--------------------------------------------------------
    function panTo(places) {
        // 이동할 위도 경도 위치를 생성합니다
        var moveLatLon = new kakao.maps.LatLng(places.y, places.x);

        // 지도 중심을 부드럽게 이동시킵니다
        // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
        map.panTo(moveLatLon);
    }



    //UPDATE--------------------- 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
    function addMarker(position, idx, title) {
        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
            imageSize = new kakao.maps.Size(26, 37),  // 마커 이미지의 크기
            imgOptions =  {
                offset: new kakao.maps.Point(23, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
            },
            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                marker = new kakao.maps.Marker({
                position: position, // 마커의 위치
                image: markerImage
            });

        marker.setMap(map); // 지도 위에 마커를 표출합니다
        markers.push(marker);  // 배열에 생성된 마커를 추가합니다

        return marker;
    }

    // 지도 위에 표시되고 있는 마커를 모두 제거합니다
    function removeMarker() {
        for ( var i = 0; i < markers.length; i++ ) {
            markers[i].setMap(null);
        }
        markers = [];
    }

    // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
    function displayPagination(pagination) {
        console.log("pagination",pagination);

        var paginationEl = document.getElementById('pagination'),
            fragment = document.createDocumentFragment(),
            i;

        // 기존에 추가된 페이지번호를 삭제합니다
        while (paginationEl.hasChildNodes()) {
            paginationEl.removeChild (paginationEl.lastChild);
        }

        for (i=1; i<=pagination.last; i++) {
            var el = document.createElement('a');
            el.href = "#";
            el.innerHTML = i;

            if (i===pagination.current) {
                el.className = 'on';
            } else {
                el.onclick = (function(i) {
                    return function() {
                        pagination.gotoPage(i);
                    }
                })(i);
            }

            fragment.appendChild(el);
        }
        paginationEl.appendChild(fragment);
    }

    // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
    // 인포윈도우에 장소명을 표시합니다
    function displayInfowindow(marker, places) {
        console.log('displayInfowindow ',places);
        var content = '<div  class="infowindow" >'
        content += '<div>TITLE : ' + places.place_name + '</div>';
        content += '<div>URL : <a href='+places.place_url+' target=_blank>' + places.place_url+ ' </a></div>'
        content += '<div>CATEGORY : '+ places.category_name+' </div>'
        content += '<div>Address : '+ places.address_name +'</div>'
        content += '<div>TEL : '+ places.phone+'</div>'
        content += '</div>'
        infowindow.setContent(content);
        infowindow.open(map, marker);
    }

    // 검색결과 목록의 자식 Element를 제거하는 함수입니다
    function removeAllChildNods(el) {
        while (el.hasChildNodes()) {
            el.removeChild (el.lastChild);
        }
    }
</script>
</body>
</html>
```
---
### leaflet
> index.html
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>

    <!--  leaflet CDN   -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin="" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>

    <!-- Leaflet Plugins: Leaflet.KoreanTmsProviders 추가  -->
    <script src="/js/KoreanTmsProviders/lib/proj4.js"></script>
    <script src="/js/KoreanTmsProviders/lib/proj4leaflet.js"></script>
    <script src="/js/KoreanTmsProviders/src/Leaflet.KoreanTmsProviders.js"></script>

    <!--  axios cdn  -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.9.0/axios.min.js" integrity="sha512-FPlUpimug7gt7Hn7swE8N2pHw/+oQMq/+R/hH/2hZ43VOQ+Kjh25rQzuLyPz7aUWKlRpI7wXbY6+U3oFPGjPOA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <style>
        * {box-sizing:border-box;}
        body{padding : 0; margin : 0;}

    </style>
</head>
<body>
<!--  <h1>LEAFLET PAGE</h1>-->

    <div id="map" style="height:100vh;width:100%;"></div>

    <script>
        // initialize the map on the "map" div with a given center and zoom
        var map = L.map('map', {
            center: [51.505, -0.09],
            zoom: 13
        });
        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(map);

        <!--        -->
        // 지도 기본타일 적용
 		var map = new L.Map('map', {
			  center: new L.LatLng(35.829890, 128.532719), //중심점 : 대구
			  zoom: 8,	//Leaflet.KoreanTmsProviders.js : resolutions기준 줌 레벨(Level 12)
			  crs: L.Proj.CRS.Daum, //Leaflet.KoreanTmsProviders.js : 새로 정의된 Daum Map CRS
			  worldCopyJump: false,  //https://leafletjs.com/reference-1.3.2.html#map-worldcopyjump 참조
		});
		var baseLayers = L.tileLayer.koreaProvider('DaumMap.Street').addTo(map);

        //마커 추가
        const centerMaker =  L.marker([35.829890, 128.532719]).addTo(map);
        //툴팁 추가
        centerMaker.bindTooltip("my tooltip text",{direction:'top',offset:[-15,-15]}).openTooltip();
        //POPUP 추가
        const popupContent=`<div>TEST</div>`;
        centerMaker.bindPopup(popupContent);        //.openPopup();
        //마커 클릭이벤트
        centerMaker.on('click',function(e){
            console.log('click',e);
        })
        centerMaker.on('mouseover',function(e){
            console.log('mouseover',e);
        })
        centerMaker.on('mouseout',function(e){
            console.log('mouseout',e);
        })

        //지도 클릭이벤트
        map.on('click',function(e){
            console.log('map',e.latlng.lat , e.latlng.lng);
            //마커 추가
            const newMarker = L.marker([e.latlng.lat, e.latlng.lng]).addTo(map);
            axios.get(`/open/weather/get/${e.latlng.lat}/${e.latlng.lng}`)
                .then(resp=>{
                    console.log(resp)

                    //POP추가
                    const newContent=`
                        <div>
                            <div>${resp.data.base}</div>
                            <div>${resp.data.clouds.all}</div>
                        </div>`;
                    newMarker.bindPopup(newContent);        //.openPopup();
                })
            .catch(error=>{console.log(error)})
        });

        //
        const geojsonData = {
            "type": "FeatureCollection",
            "features": [
                {
                    "type": "Feature",
                    "geometry": {
                        "type": "Point",
                        "coordinates": [128.532719,35.829890]
                    },
                    "properties": {
                        "name": "부산",
                        "description": "부산광역시 중심"
                    }
                },
                {
                    "type": "Feature",
                    "geometry": {
                        "type": "Polygon",
                        "coordinates": [
                            [
                                [128.53126325650484,35.831312978913026],
                                [128.53140278914103,35.82993280343082 ],
                                [128.5327550720095,35.828870502365156],
                                [128.5353581523016,35.83125171674299],
                            ]
                        ]
                    },
                    "properties": {
                        "name": "Polygon Example",
                        "description": "샘플 폴리곤 영역"
                    }
                }
            ]
        };
        //GEOJSON
        L.geoJSON(geojsonData, {
            style: function (feature) {
                   return {
                    color: 'blue',
                    fillColor: 'yellow',
                    fillOpacity: 0.5,
                    weight: 2
                };
            }
        }).bindPopup(function (layer) {
            return layer.feature.properties.description;
        }).addTo(map);

        //법정동 지도 추가
        // 대한민국 법정동 지도 : https://github.com/raqoon886/Local_HangJeongDong
        // 대한민국 행정동 경계파일 : https://github.com/vuski/admdongkor

        const borderColors = {
            "중구":"red",
            "동구":"orange",
            "서구":"yellow",
            "남구":"green",
            "북구":"blue",
            "수성구":"navy",
            "달서구":"black",
            "달성군":"royalblue",
        }
        axios.get("/geoJson/daegu.json")
                .then(resp=>{
                    console.log("GEOJSON",resp)
                    const HangjungdongAllData = resp.data.features;
                    const groupMap = {};
                    HangjungdongAllData.forEach(item=>{
                        //console.log(item);

                        if(!groupMap[item.properties.sggnm])
                            groupMap[item.properties.sggnm]=[]
                        groupMap[item.properties.sggnm].push(item);
                    })
                    //console.log('groupMap',groupMap);

                    Object.entries(groupMap).forEach((group)=>{
                      //GEOJSON
                      console.log(group[0],group[1]);
                      L.geoJSON(group[1], {
                            style: function (feature) {
                                   return {
                                    color: borderColors[group[0]],
                                    fillColor: borderColors[group[0]],
                                    fillOpacity: 0.7,
                                    weight: 3
                                };
                            }
                        }).bindPopup(function (layer) {
                            return layer.feature.properties.description;
                        }).addTo(map);
                    })


                })
                .catch(error=>{console.log(error)})
    </script>
</body>
</html>
```
---
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