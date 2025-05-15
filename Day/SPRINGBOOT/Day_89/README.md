## JAVA
### C05Naver
> C01NaverLoginController
```java
package com.example.demo.C05Naver;


import com.example.demo.C04Kakao.C02KakaoLoginController;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

@Controller
@Slf4j
@RequestMapping("/naver")
public class C01NaverLoginController {

    private String NAVER_CLIENT_ID="";
    private String NAVER_CLIENT_SECRET="";
    private String REDIRECT_URL = "http://localhost:8090/naver/callback";
    private NaverTokenResponse naverTokenResponse;

    @GetMapping("/login")
    public String login(){
        log.info("GET /naver/login...");
        return "redirect:https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id="+NAVER_CLIENT_ID+"&state=STATE_STRING&redirect_uri="+REDIRECT_URL;
    }
    @GetMapping("/callback")
    public String callback(
            @RequestParam("code") String code,
            @RequestParam("state") String state
            ){
        log.info("GET /naver/callback..."+code+" " + state);

        //요청 정보 확인
        String url = "https://nid.naver.com/oauth2.0/token";
        //요청 헤더 설정
        HttpHeaders header = new HttpHeaders();

        //요청 바디 설정
        MultiValueMap<String,String> params = new LinkedMultiValueMap<>();
        params.add("grant_type","authorization_code");
        params.add("client_id",NAVER_CLIENT_ID);
        params.add("client_secret",NAVER_CLIENT_SECRET);
        params.add("code",code);
        params.add("state",state);

        HttpEntity< MultiValueMap<String,String> > entity = new HttpEntity<>(params,header);

        //요청 후 응답확인
        RestTemplate rt = new RestTemplate();
        ResponseEntity<NaverTokenResponse> response =
                rt.exchange(url, HttpMethod.POST,entity, NaverTokenResponse.class);

        System.out.println(response.getBody());
        this.naverTokenResponse = response.getBody();

        return "redirect:/naver/main";
    }

    @GetMapping("/main")
    public void main(Model model){
        log.info("GET /naver/main...");

        //정보확인
        String url="https://openapi.naver.com/v1/nid/me";
        //요청헤더
        //요청 헤더 설정
        HttpHeaders header = new HttpHeaders();
        header.add("Authorization","Bearer "+this.naverTokenResponse.getAccess_token());
        //요청바디

        //ENTITY
        HttpEntity entity = new HttpEntity<>(header);

        //요청->응답
        RestTemplate rt = new RestTemplate();
        ResponseEntity<NaverProfileResponse> response =rt.exchange(url,HttpMethod.POST,entity, NaverProfileResponse.class);
        System.out.println(response.getBody());

        model.addAttribute("profile",response.getBody());

    }

    @GetMapping("/unlink")
    public void logout(){
        log.info("GET /naver/logout....");

        //요청 정보 확인
        String url = "https://nid.naver.com/oauth2.0/token";
        //요청 헤더 설정
        HttpHeaders header = new HttpHeaders();

        //요청 바디 설정
        MultiValueMap<String,String> params = new LinkedMultiValueMap<>();
        params.add("grant_type","delete");
        params.add("client_id",NAVER_CLIENT_ID);
        params.add("client_secret",NAVER_CLIENT_SECRET);
        params.add("access_token",this.naverTokenResponse.getAccess_token());


        HttpEntity< MultiValueMap<String,String> > entity = new HttpEntity<>(params,header);

        //요청 후 응답확인
        RestTemplate rt = new RestTemplate();
        ResponseEntity<String> response =
                rt.exchange(url, HttpMethod.POST,entity, String.class);

        System.out.println(response.getBody());


    }
    @GetMapping("/logout")
    public String disConnect(){
        return "redirect:https://nid.naver.com/nidlogin.logout?returl=https://www.naver.com/";
    }

    @Data
    private static class NaverTokenResponse{
        public String access_token;
        public String refresh_token;
        public String token_type;
        public String expires_in;
    }
    @Data
    private static class Response{
        public String id;
        public String profile_image;
        public String email;
        public String name;
    }
    @Data
    private static class NaverProfileResponse{
        public String resultcode;
        public String message;
        public Response response;
    }


}
```
---
> C02NaverSearchController
```java
package com.example.demo.C05Naver;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

@Controller
@Slf4j
@RequestMapping("/naver/search")
public class C02NaverSearchController {

    private String NAVER_CLIENT_ID="";
    private String NAVER_CLIENT_SECRET="";

    @GetMapping("/book/{keyword}")
    @ResponseBody
    public void book(@PathVariable("keyword") String keyword)
    {
        log.info("GET /naver/search/book....");
        //요청 정보 확인
        String url = "https://openapi.naver.com/v1/search/book.json?query="+keyword;
        //요청 헤더 설정
        HttpHeaders header = new HttpHeaders();
        header.add("X-Naver-Client-Id",NAVER_CLIENT_ID);
        header.add("X-Naver-Client-Secret",NAVER_CLIENT_SECRET);

        //요청 바디 설정
//        MultiValueMap<String,String> params = new LinkedMultiValueMap<>();
//        params.add("grant_type","authorization_code");
//        params.add("client_id",NAVER_CLIENT_ID);
//        params.add("client_secret",NAVER_CLIENT_SECRET);
//        params.add("code",code);
//        params.add("state",state);

        HttpEntity entity = new HttpEntity<>(header);

        //요청 후 응답확인
        RestTemplate rt = new RestTemplate();
        ResponseEntity<String> response =
                rt.exchange(url, HttpMethod.GET,entity, String.class);

        System.out.println(response.getBody());


    }

}
```
---
### C06Google
> C01GoogleMailAPIController
```java
package com.example.demo.C06Google;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Slf4j
@RequestMapping("/google/mail")
public class C01GoogleMailAPIController {

    @Autowired
    JavaMailSender javaMailSender;

    @GetMapping("/req")
    @ResponseBody
    public void req(
            @RequestParam("email") String email,
            @RequestParam("text") String text
    )
    {
        log.info("GET /google/mail/req.."+javaMailSender);

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject("[WEB발신] 메일 테스트입니다-!");
        message.setText(text);

        javaMailSender.send(message);
    }


}
```
---
> C02GoogleCalendarAPIController
```java
package com.example.demo.C06Google;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequestMapping("/google/cal")
public class C02GoogleCalendarAPIController {
    @GetMapping
    public void get(){
        log.info("GET /google/cal...");
    }
}
```
---
## VIEW
### google
> cal.html
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
        <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js'></script>
    <script src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.17/index.global.min.js"></script>    <script>

        document.addEventListener('DOMContentLoaded', function() {

          var calendarEl = document.getElementById('calendar');

          var calendar = new FullCalendar.Calendar(calendarEl, {
              initialView: 'dayGridMonth',
              googleCalendarApiKey: '-FrkWsa_L3r1F2ZeKpw',
              events: {
                googleCalendarId: '@group.calendar.google.com'
              },

              eventClick: function(info) {
                info.jsEvent.preventDefault();  //기본기능 해제
                console.log(info);
                console.log(info.event._def.title);
                //alert('Event: ' + info.event.title);
                //alert('Coordinates: ' + info.jsEvent.pageX + ',' + info.jsEvent.pageY);
                //alert('View: ' + info.view.type);

                // change the border color just for fun
                //info.el.style.borderColor = 'red';
              }

          });



          calendar.render();



        });

    </script>



</head>
<body>
  <h1>FULLCALENDAR + GOOGLE CALENDAR 연동</h1>

  <div id='calendar'></div>
</body>
</html>
```
---
### kakao
> channel.html
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
  <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.5/kakao.min.js" integrity="sha384-dok87au0gKqJdxs7msEdBPNnKSRT+/mhTVzq+qOhcL464zXwvcrpjeWvyj1kCdq6" crossorigin="anonymous"></script>
</head>
<body>
  <h1>KAKAO CHANNEL</h1>
  <a href="javascript:void(0)" id="kakao-add-channel-button"></a>

  <script>
    console.log("Kakao",Kakao);
    Kakao.init('');  // 사용하려는 앱의 JavaScript 키 입력

    Kakao.Channel.createAddChannelButton({
      container: '#kakao-add-channel-button',
      channelPublicId: '_DXyBn' // 카카오톡 채널 홈 URL에 명시된 id로 설정합니다.
    });

  </script>
</body>
</html>
```
---
> main.html
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
  <h1>메인페이지</h1>
  <hr/>
  <div th:text="${profile}">

  </div>
</body>
</html>
```
---
### naver
> main.html
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
  <h1>NAVER MAIN</h1>
    <hr>
    <div th:text="${profile}">

    </div>
</body>
</html>
```
---
