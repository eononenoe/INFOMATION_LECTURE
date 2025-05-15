## JAVA

### C06Google

> C02GoogleCalendarController
> 

```java
package com.example.demo.C06Google;

import com.google.api.client.util.DateTime;
import com.google.api.services.calendar.model.Event;
import com.google.api.services.calendar.model.EventDateTime;
import com.google.api.services.calendar.model.EventReminder;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.view.RedirectView;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

@Controller
@Slf4j
@RequestMapping("/google/cal")
public class C02GoogleCalendarController {
    @GetMapping
    public String main(){
        log.info("GET /google/cal...");
        return "google/cal";
    }

    @GetMapping("/post")
    public RedirectView post(
            @RequestParam("title") String title,
            @RequestParam("desc") String desc,
            @RequestParam("date") String dateStr
    ){
        log.info("GET /google/cal/post...title : " + title + ", desc : " + desc + ", date : " + dateStr);

        try {
            // Parse the date string to Date object
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date selectedDate = dateFormat.parse(dateStr);

            // Create a new event
            Event event = new Event()
                    .setSummary(title)
                    .setDescription(desc);

            // Set the start time to the selected date at 9:00 AM
            DateTime startDateTime = new DateTime(selectedDate);
            EventDateTime start = new EventDateTime()
                    .setDateTime(startDateTime)
                    .setTimeZone("Asia/Seoul");
            event.setStart(start);

            // Set the end time to the selected date at 10:00 AM
            DateTime endDateTime = new DateTime(new Date(selectedDate.getTime() + 3600000));
            EventDateTime end = new EventDateTime()
                    .setDateTime(endDateTime)
                    .setTimeZone("Asia/Seoul");
            event.setEnd(end);

            // Add reminder
            EventReminder[] reminderOverrides = new EventReminder[] {
                    new EventReminder().setMethod("email").setMinutes(24 * 60),
                    new EventReminder().setMethod("popup").setMinutes(10),
            };
            Event.Reminders reminders = new Event.Reminders()
                    .setUseDefault(false)
                    .setOverrides(Arrays.asList(reminderOverrides));
            event.setReminders(reminders);

            // Add the event to the calendar
            GoogleCalendar.addEvent(event);

        } catch (Exception e) {
            log.error("Error adding event to Google Calendar", e);
        }

        // Redirect to calendar view
        RedirectView redirectView = new RedirectView();
        redirectView.setUrl("/google/cal");
        return redirectView;
    }

}

```

---

> GoogleCalendar
> 

```java
package com.example.demo.C06Google;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.googleapis.json.GoogleJsonResponseException;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.util.store.FileDataStoreFactory;
import com.google.api.services.calendar.Calendar;
import com.google.api.services.calendar.CalendarScopes;
import com.google.api.services.calendar.model.Event;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.security.GeneralSecurityException;
import java.util.Collections;
import java.util.List;

public class GoogleCalendar {

    private static final String APPLICATION_NAME = "Google Calendar API Java Quickstart";
    private static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
    private static final String CREDENTIALS_FOLDER = "credentials"; // Directory to store user credentials.
    private static final String CALENDAR_ID = "";
    private static final List<String> SCOPES = Collections.singletonList(CalendarScopes.CALENDAR);
    private static final String CLIENT_SECRET_DIR = "/client_secret.json";

    //이벤트추가
    public static Event addEvent(Event event) throws IOException, GeneralSecurityException, GoogleJsonResponseException {
        final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        Calendar service = new Calendar.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
                .setApplicationName(APPLICATION_NAME)
                .build();
        return service.events().insert(CALENDAR_ID, event).execute();
    }
    //이벤트삭제
    public static void delEvent(String eventKey) throws IOException, GeneralSecurityException, GoogleJsonResponseException {
        final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        Calendar service = new Calendar.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
                .setApplicationName(APPLICATION_NAME)
                .build();
        service.events().delete(CALENDAR_ID, eventKey).execute();
    }
    //인증
    private static Credential getCredentials(final NetHttpTransport HTTP_TRANSPORT) throws IOException {
        // Load client secrets.
        InputStream in = GoogleCalendar.class.getResourceAsStream(CLIENT_SECRET_DIR);
        GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(in));

        // Build flow and trigger user authorization request.
        GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(
                HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, SCOPES)
                .setDataStoreFactory(new FileDataStoreFactory(new java.io.File(CREDENTIALS_FOLDER)))
                .setAccessType("offline")
                .build();

        // Create a LocalServerReceiver with the specified redirect URI
        LocalServerReceiver receiver = new LocalServerReceiver.Builder()
                .setHost("localhost")
                .setPort(8888)
                .setCallbackPath("/google/cal/callback")
                .build();

        return new AuthorizationCodeInstalledApp(flow, receiver).authorize("user");
    }
}

```

---

### C07PortOne

> PortOneController
> 

```java
package com.example.demo.C07PortOne;

import com.example.demo.C04Kakao.C02KakaoLoginController;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
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

import java.util.HashMap;
import java.util.Map;

@Controller
@Slf4j
@RequestMapping("/portOne")
public class PortOneController {

    String RESTAPI_KEY = "";
    String RESTAPI_SECRET  = "";
    private PortOneTokenResponse portOneTokenResponse;

    @GetMapping("/index")
    public void index(){
        log.info("GET /portOne/index...");
    }
    @GetMapping("/getToken")
    @ResponseBody
    public void getToken(){
        log.info("GET /portOne/getToken....");
        //요청 정보 확인
        String url = "<https://api.iamport.kr/users/getToken>";
        //요청 헤더 설정
        HttpHeaders header = new HttpHeaders();
//        header.add("Content-Type","application/json"); //form x
        //요청 바디 설정
        MultiValueMap<String,String> params = new LinkedMultiValueMap<>();
        params.add("imp_key",RESTAPI_KEY);
        params.add("imp_secret",RESTAPI_SECRET);

        HttpEntity< MultiValueMap<String,String> > entity = new HttpEntity<>(params,header);

        //요청 후 응답확인
        RestTemplate rt = new RestTemplate();
        ResponseEntity<PortOneTokenResponse> response =
                rt.exchange(url, HttpMethod.POST,entity, PortOneTokenResponse.class);
        System.out.println(response.getBody());
        this.portOneTokenResponse =response.getBody();

    }
    //결제조회(다건조회)
    @GetMapping("/getPayments")
    @ResponseBody
    public void payments(){
        log.info("GET /portOne/getPayments...");
        String url = "<https://api.iamport.kr/payments?imp_uid[]=imp_979464507864&merchant_uid[]=>";
        //요청 헤더 설정
        HttpHeaders header = new HttpHeaders();
        header.add("Authorization","Bearer "+this.portOneTokenResponse.getResponse().getAccess_token());
        header.add("Content-Type","application/json");
        //요청 바디 설정
//        MultiValueMap<String,String> params = new LinkedMultiValueMap<>();
//        params.add("imp_uid[]","imp_051607289979");
//        params.add("merchant_uid[]","test_1234");

        HttpEntity entity = new HttpEntity<>(header);

        //요청 후 응답확인
        RestTemplate rt = new RestTemplate();
        ResponseEntity<String> response =
                rt.exchange(url, HttpMethod.GET,entity, String.class);

        System.out.println(response);

    }

    //결제취소
    @GetMapping("/payment/cancel")
    @ResponseBody
    public void payment_calcel(){
        log.info("GET /portOne/payment/cancel...");

        //요청 정보 확인
        String url = "<https://api.iamport.kr/payments/cancel>";
        //요청 헤더 설정
        HttpHeaders header = new HttpHeaders();
        header.add("Content-Type","application/json"); //form x
        header.add("Authorization","Bearer "+portOneTokenResponse.getResponse().getAccess_token());
        //요청 바디 설정
//        Map<String,Object> params = new HashMap<>();
//        params.put("\\"imp_uid\\"", "\\"imp_979464507864\\"");
//        params.put("\\"merchant_uid\\"","\\"merchant_a0fc8691-2e9a-4dc4-b47e-f42909e\\"");
        JSONObject params = new JSONObject();
        params.put("imp_uid","imp_979464507864");
        params.put("merchant_uid","merchant_a0fc8691-2e9a-4dc4-b47e-f42909e");
        System.out.println("--------------");
        System.out.println(params);
        System.out.println("--------------");
//        JSONObject params = new JSONObject();
//        params.put("imp_uid", "imp_807755828471");
//        params.put("merchant_uid","merchant_6d22d835-fe9c-4045-b8e6-d8914fa");

        HttpEntity< String > entity = new HttpEntity<>(params.toString(),header);

        //요청 후 응답확인
        RestTemplate rt = new RestTemplate();
        ResponseEntity<String> response =
                rt.exchange(url, HttpMethod.POST,entity, String.class);
        System.out.println(response.getBody());

    }

    @GetMapping("/certifications/{imp_uid}")
    @ResponseBody
    public void certifications(@PathVariable("imp_uid")String imp_uid){
        log.info("GET /portOne/getPayments...");
        String url = "<https://api.iamport.kr/certifications/>"+imp_uid;
        //요청 헤더 설정
        HttpHeaders header = new HttpHeaders();
        header.add("Authorization","Bearer "+this.portOneTokenResponse.getResponse().getAccess_token());
        header.add("Content-Type","application/json");

        HttpEntity entity = new HttpEntity<>(header);

        //요청 후 응답확인
        RestTemplate rt = new RestTemplate();
        ResponseEntity<String> response =
                rt.exchange(url, HttpMethod.GET,entity, String.class);

        System.out.println(response);

    }

    //인증조회
    @Data
    private static class Response{
        public String access_token;
        public int now;
        public int expired_at;
    }
    @Data
    private static class PortOneTokenResponse{
        public int code;
        public Object message;
        public Response response;
    }
}

```
---

### demo

> DemoApplication
> 

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

## VIEW

---

### portOne

> index.html
> 

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
  <button onClick="pay()"> 결제하기</button>
  |
  <button onClick="auth()">본인인증</button>

  <script src="<https://cdn.iamport.kr/v1/iamport.js>"></script>
  <script>
    IMP.init("imp87380722");

    function pay(){
        const date = new Date();
        IMP.request_pay({
          channelKey: "channel-key-eeabb608-3714-40be-b53c-9a40ac08cb93",
          pay_method: "phone",
          merchant_uid: "merchant_"+crypto.randomUUID(),
          name: "테스트 결제",
          amount: 100,
          buyer_tel: "010-0000-0000",
        });
    }
    function auth(){
        const date = new Date();
        IMP.certification({
            channelKey: "channel-key-39cab9fe-b827-4565-89c0-1900b38adc6d",
            merchant_uid: "test_"+date.toString(),
        },function(resp){console.log(resp);});
    }
  </script>

</body>
</html>

```

---