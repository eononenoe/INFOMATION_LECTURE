# 🌐 JAVA 정리 - 네트워크 IO, Jsoup, Selenium, REST API

---

## 📌 개요 (Overview)

이번 파트에서는

- **URLStream**으로 웹페이지 가져오기
- **Jsoup**을 이용한 HTML 파싱 & 이미지 다운로드
- **Selenium**을 이용한 웹 자동화
- **REST API**를 호출해서 JSON 데이터 받아오기

를 실습했습니다! 🔥

---

## 💡 핵심 개념 요약 (Key Concepts)

### 📄 URL로부터 데이터 읽기

```java
URL url = new URL("https://example.com");
InputStream in = url.openStream();
BufferedInputStream buffIn = new BufferedInputStream(in);
Reader rin = new InputStreamReader(buffIn);

Writer out = new FileWriter("output.html");

int data;
while((data = rin.read()) != -1){
    out.write(data);
}
rin.close();
out.close();
```
- `InputStreamReader`로 바이트 → 문자 변환
- `BufferedInputStream`으로 속도 향상

---

### 🍀 Jsoup을 이용한 HTML 파싱 및 이미지 다운로드

```java
Document document = Jsoup.connect("https://example.com").get();
Elements elements = document.getElementsByTag("img");

for (Element el : elements) {
    String imgUrl = el.attr("src");
    InputStream in = new URL(imgUrl).openStream();
    OutputStream out = new FileOutputStream("image.jpg");
    
    byte[] buffer = new byte[4096];
    int n;
    while ((n = in.read(buffer)) != -1) {
        out.write(buffer, 0, n);
    }
    in.close();
    out.close();
}
```
- `Jsoup` 라이브러리로 HTML 문서 쉽게 파싱 가능
- 이미지 링크 추출해서 다운로드

---

### 🖱️ Selenium으로 웹 자동화

```java
WebDriver driver = new ChromeDriver();
driver.get("https://naver.com");

WebElement searchBox = driver.findElement(By.id("query"));
searchBox.sendKeys("노트북");
searchBox.sendKeys(Keys.RETURN);

// '쇼핑' 탭 클릭
WebElement shoppingTab = driver.findElement(By.cssSelector(".api_pcpg_wrap .tab:nth-child(1)"));
JavascriptExecutor js = (JavascriptExecutor) driver;
js.executeScript("arguments[0].removeAttribute('target')", shoppingTab);
shoppingTab.click();
```
- `Selenium`은 실제 브라우저를 띄워서 조작할 수 있다.
- `JavascriptExecutor`로 DOM 조작 가능

---

### 🌎 REST API 호출 및 JSON 파싱 (Jackson 사용)

```java
HttpRequest request = HttpRequest.newBuilder()
    .uri(URI.create("https://api.example.com/data"))
    .GET()
    .build();

HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());

ObjectMapper mapper = new ObjectMapper();
ResponseObject responseObject = mapper.readValue(response.body(), ResponseObject.class);

System.out.println(responseObject.getStatus());
System.out.println(responseObject.getData());
```
- `HttpClient`로 HTTP 요청
- `Jackson` ObjectMapper로 JSON → Java 객체 변환

---

## ⚠ 주의사항 (Cautions)

- URL, URI 차이점 숙지 (공백, 한글이 있으면 URL 대신 URI 사용)
- Jsoup 연결 시 **userAgent**를 명시해서 봇 차단을 피할 것
- Selenium은 **WebDriver 버전**과 **Chrome 버전**을 반드시 맞출 것!
- REST API 호출 시 오류코드(404, 500 등) 대비하기

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 📄 URLStream

> 웹사이트 HTML을 '물통으로 퍼오기' 느낌 🚰

---

### 🍀 Jsoup

> HTML 문서를 '나무'처럼 탐색하고 필요한 가지를 꺾어오기 🌳

---

### 🖱 Selenium

> 마치 사람이 직접 웹사이트를 클릭하고 입력하는 것을 **코드로 자동화**하는 것 🤖

---

### 🌎 REST API

> **자판기**처럼, 요청(Request)을 넣으면 원하는 데이터(Response)를 주는 시스템 🥤

---

## ✅ 한 줄 요약 (1-Line Summary)

> **네트워크도 자바로 자유롭게 다루자! URL, Jsoup, Selenium, REST API까지 완전정복!** 🌐✨

