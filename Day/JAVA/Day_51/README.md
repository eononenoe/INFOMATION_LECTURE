# 01

> **C09URLStreamMain**
> 

```java
package Ch19;

import java.io.BufferedInputStream;
import java.io.FileWriter;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.Writer;
import java.net.URI;
import java.net.URL;

public class C09URLStreamMain {
	public static void main(String[] args) throws Exception {
		//URL url = new URL("https://blog.naver.com/PostView.naver?blogId=techcaptain&logNo=223792895655&proxyReferer=&noTrackingCode=true")
		URL url = (new URI("https://blog.naver.com/PostView.naver?blogId=techcaptain&logNo=223792895655&proxyReferer=&noTrackingCode=true")).toURL();
		InputStream in = url.openStream();
		
		//보조 스트림 추가(Ch20에서 진행)
		BufferedInputStream buffIn = new BufferedInputStream(in);	//버퍼 공간 추가
		Reader rin = new InputStreamReader(buffIn);					//byte -> char 변환

		Writer out = new FileWriter("C:\\IOTEST\\index.html");
//		OutputStream out = new FileOutputStream("C:\\IOTEST\\index.html");
		
		while(true) {
			int data = in.read();
			if(data==-1)
				break;
			System.out.print((char)data);
			out.write((char)data);
			out.flush();
		}
		rin.close();
		buffIn.close();
		in.close();
		out.close();
	}
}

```

---

> **C10JsoupMain**
> 

```java
package Ch19;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.UUID;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class C10JsoupMain {

	public static void main(String[] args) throws IOException, URISyntaxException {

		// URL 연결
		Connection conn = Jsoup.connect("")
							.userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36")
							.timeout(5000)
							.ignoreHttpErrors(true)
							.followRedirects(true);
		// DOM객체 받기
		Document document = conn.get();
//		System.out.println(document);

		Elements elements = document.getElementsByTag("img");
		System.out.println(elements.size());

		
		
		for (Element el : elements) {
//			
			try {
				System.out.println(el);
				String img_url = el.getElementsByAttribute("src").attr("src");
//				System.out.println(img_url);

				URL url = (new URI(img_url)).toURL();
				InputStream in = url.openStream();
				BufferedInputStream buffIn = new BufferedInputStream(in); // 버퍼 공간 추가

				OutputStream out = null;

				if (img_url.contains(".png"))
					out = new FileOutputStream("C:\\IOTEST\\" + UUID.randomUUID() + ".png");
				else if (img_url.contains(".svg"))
					out = new FileOutputStream("C:\\IOTEST\\" + UUID.randomUUID() + ".svg");
				else if (img_url.contains(".webp"))
					out = new FileOutputStream("C:\\IOTEST\\" + UUID.randomUUID() + ".webp");
				else
					out = new FileOutputStream("C:\\IOTEST\\" + UUID.randomUUID() + ".jpg");

				while (true) {
					int data = buffIn.read();
					if (data == -1)
						break;
					out.write((byte) data);
					out.flush();
				}

				out.close();
				buffIn.close();
				in.close();
			} catch (Exception e) {

			} finally {
			
			}

		}

	}

}

```

---

> **C11SelenumAPIMain**
> 

```java
package Ch19;

import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

//크롬서버.jar 다운로드 경로(셀레니움 공식 홈페이지)
//https://www.selenium.dev/downloads/

//크롬드라이브 다운로드 경로
//https://googlechromelabs.github.io/chrome-for-testing/#stable

public class C11SelenumAPIMain {

	private static final String WEB_DRIVER_ID = "webdriver.chrome.driver";
	private static final String WEB_DRIVER_PATH = "src/Drivers/chromedriver.exe";

	
	public static void main(String[] args) throws IOException {
		
		//브라우저 옵션
		ChromeOptions options = new ChromeOptions();
//		options.addArguments("--headless");			//백그라운드 실행
//		options.addArguments("--no-sandbox");		//리눅스환경 sendbox 사용 여부

		//브라우저 동작
		WebDriver driver = new ChromeDriver(options);
		driver.get("https://www.naver.com");
		
		//특정 위치 요소 선택(키워드 입력하기)
		WebElement searchEl = driver.findElement(By.id("query"));
		
		//키워드 입력
		searchEl.sendKeys("노트북");
		
		//엔터키 전달
		searchEl.sendKeys(Keys.RETURN);
		
		//노트북 검색 이후에 쇼핑 버튼 클릭
		WebElement shoppingBtnEl =  driver.findElement(By.cssSelector(".api_pcpg_wrap .tab:nth-child(1)"));
		//target_blank(새창열기) 제거 
		JavascriptExecutor js = (JavascriptExecutor)driver;
		js.executeScript("arguments[0].removeAttribute('target')",shoppingBtnEl);
		
		shoppingBtnEl.click();
		//네이버포털 -> '노트북'검색 -> 쇼핑 클릭-> 삼성 노트북(엔터)
//		WebElement itemsHeaderEl =  driver.findElement(By.cssSelector("._searchInput_search_text_3CUDs"));
//		itemsHeaderEl.sendKeys("삼성 노트북");
//		itemsHeaderEl.sendKeys(Keys.RETURN);
		
		
		//네이버포털 -> '노트북'검색 -> 쇼핑 클릭-> 삼성 노트북(엔터) -> 리뷰 많은순 클릭
		List<WebElement> Els =  driver.findElements(By.cssSelector(".subFilter_sort__lhuHl"));
		Els.forEach(el->{
			if(el.getText().contains("리뷰 많은순"))
				el.click();
		});
		
		//영역내 모든 정보 긁어오기 basicList_list_basis__uNBZx
		List<WebElement> El2s =  driver.findElements(By.cssSelector(".basicList_list_basis__uNBZx"));
		
		
		//파일로 저장
		Writer out = new FileWriter("C:\\TMP_IO\\index.html");
	
		//css link 빼내오기
		List<WebElement> cssLinks = driver.findElements(By.tagName("link"));
		for(WebElement link : cssLinks) {
			String rel = link.getAttribute("rel");
			if(rel.equals("stylesheet")){
				String href = link.getAttribute("href");
				System.out.println("CSS 링크 : " + href);
			}
		}
		
		//본문내용
		for(WebElement el :El2s) {
			String elHTML = el.getAttribute("outerHTML");
			out.write(elHTML+"\n");
		}
		out.flush();
		out.close();
		
	}
	

}

```

---

> **C12RestRequestResponseMain**
> 

```java
package Ch19;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.ArrayList;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.ObjectMapper;

public class C12RestRequestResponseMain {

	public static void main(String[] args) throws Exception {
		// URL,PARAM 지정
		String url = "https://www.daegufood.go.kr/kor/api/tasty.html";
		String mode = "json";
		String addr = "중구";
		url = url + "?mode=" + mode + "&addr=" + addr;

		// Http Request 객체 생성
		HttpRequest httpRequest = HttpRequest.newBuilder().uri(URI.create(url)).GET().build();

		// Http Request 요청 / 응답 확인
		HttpClient httpClient = HttpClient.newHttpClient();

		HttpResponse<String> response = httpClient.send(httpRequest, HttpResponse.BodyHandlers.ofString());
//		System.out.println(response.body());

		// 가공 처리 (Class Type vs JSON Type)
		ObjectMapper objectMapper = new ObjectMapper();

		// JSON TYPE
//		JsonNode jsonNode = objectMapper.readTree(response.body());
//		System.out.println("Status : " + jsonNode.get("status"));
//		System.out.println("total : " + jsonNode.get("total"));
//		JsonNode data_arr = jsonNode.get("data");
//		for(int i=0;i<data_arr.size();i++) {
//			JsonNode el = data_arr.get(i);
//			System.out.println(el.get("BZ_NM"));
//		}

		// CLASS TYPE
		
		ResponseObject responseObject =  objectMapper.readValue(response.body(), ResponseObject.class);
		System.out.println("Status : " + responseObject.getStatus());
		System.out.println("total : " + responseObject.getTotal());
		System.out.println("total : " + responseObject.getTotal());
		System.out.println(responseObject.getData().get(0));
		
		
	}

	private static class Data {
		
		public String cnt;
		@JsonProperty("OPENDATA_ID")
		public String oPENDATA_ID;
		@JsonProperty("GNG_CS")
		public String gNG_CS;
		@JsonProperty("FD_CS")
		public String fD_CS;
		@JsonProperty("BZ_NM")
		public String bZ_NM;
		@JsonProperty("TLNO")
		public String tLNO;
		@JsonProperty("MBZ_HR")
		public String mBZ_HR;
		@JsonProperty("SEAT_CNT")
		public String sEAT_CNT;
		@JsonProperty("PKPL")
		public String pKPL;
		@JsonProperty("HP")
		public String hP;
		@JsonProperty("PSB_FRN")
		public String pSB_FRN;
		@JsonProperty("BKN_YN")
		public String bKN_YN;
		@JsonProperty("INFN_FCL")
		public String iNFN_FCL;
		@JsonProperty("BRFT_YN")
		public String bRFT_YN;
		@JsonProperty("DSSRT_YN")
		public String dSSRT_YN;
		@JsonProperty("MNU")
		public String mNU;
		@JsonProperty("SMPL_DESC")
		public String sMPL_DESC;
		@JsonProperty("SBW")
		public String sBW;
		@JsonProperty("BUS")
		public String bUS;

		Data() {
		}
		// 모든인자생성자

		public Data(String cnt, String oPENDATA_ID, String gNG_CS, String fD_CS, String bZ_NM, String tLNO,
				String mBZ_HR, String sEAT_CNT, String pKPL, String hP, String pSB_FRN, String bKN_YN, String iNFN_FCL,
				String bRFT_YN, String dSSRT_YN, String mNU, String sMPL_DESC, String sBW, String bUS) {
			super();
			this.cnt = cnt;
			this.oPENDATA_ID = oPENDATA_ID;
			this.gNG_CS = gNG_CS;
			this.fD_CS = fD_CS;
			this.bZ_NM = bZ_NM;
			this.tLNO = tLNO;
			this.mBZ_HR = mBZ_HR;
			this.sEAT_CNT = sEAT_CNT;
			this.pKPL = pKPL;
			this.hP = hP;
			this.pSB_FRN = pSB_FRN;
			this.bKN_YN = bKN_YN;
			this.iNFN_FCL = iNFN_FCL;
			this.bRFT_YN = bRFT_YN;
			this.dSSRT_YN = dSSRT_YN;
			this.mNU = mNU;
			this.sMPL_DESC = sMPL_DESC;
			this.sBW = sBW;
			this.bUS = bUS;
		}

		// Getter And Setter
		public String getCnt() {
			return cnt;
		}

		public void setCnt(String cnt) {
			this.cnt = cnt;
		}

		public String getoPENDATA_ID() {
			return oPENDATA_ID;
		}

		public void setoPENDATA_ID(String oPENDATA_ID) {
			this.oPENDATA_ID = oPENDATA_ID;
		}

		public String getgNG_CS() {
			return gNG_CS;
		}

		public void setgNG_CS(String gNG_CS) {
			this.gNG_CS = gNG_CS;
		}

		public String getfD_CS() {
			return fD_CS;
		}

		public void setfD_CS(String fD_CS) {
			this.fD_CS = fD_CS;
		}

		public String getbZ_NM() {
			return bZ_NM;
		}

		public void setbZ_NM(String bZ_NM) {
			this.bZ_NM = bZ_NM;
		}

		public String gettLNO() {
			return tLNO;
		}

		public void settLNO(String tLNO) {
			this.tLNO = tLNO;
		}

		public String getmBZ_HR() {
			return mBZ_HR;
		}

		public void setmBZ_HR(String mBZ_HR) {
			this.mBZ_HR = mBZ_HR;
		}

		public String getsEAT_CNT() {
			return sEAT_CNT;
		}

		public void setsEAT_CNT(String sEAT_CNT) {
			this.sEAT_CNT = sEAT_CNT;
		}

		public String getpKPL() {
			return pKPL;
		}

		public void setpKPL(String pKPL) {
			this.pKPL = pKPL;
		}

		public String gethP() {
			return hP;
		}

		public void sethP(String hP) {
			this.hP = hP;
		}

		public String getpSB_FRN() {
			return pSB_FRN;
		}

		public void setpSB_FRN(String pSB_FRN) {
			this.pSB_FRN = pSB_FRN;
		}

		public String getbKN_YN() {
			return bKN_YN;
		}

		public void setbKN_YN(String bKN_YN) {
			this.bKN_YN = bKN_YN;
		}

		public String getiNFN_FCL() {
			return iNFN_FCL;
		}

		public void setiNFN_FCL(String iNFN_FCL) {
			this.iNFN_FCL = iNFN_FCL;
		}

		public String getbRFT_YN() {
			return bRFT_YN;
		}

		public void setbRFT_YN(String bRFT_YN) {
			this.bRFT_YN = bRFT_YN;
		}

		public String getdSSRT_YN() {
			return dSSRT_YN;
		}

		public void setdSSRT_YN(String dSSRT_YN) {
			this.dSSRT_YN = dSSRT_YN;
		}

		public String getmNU() {
			return mNU;
		}

		public void setmNU(String mNU) {
			this.mNU = mNU;
		}

		public String getsMPL_DESC() {
			return sMPL_DESC;
		}

		public void setsMPL_DESC(String sMPL_DESC) {
			this.sMPL_DESC = sMPL_DESC;
		}

		public String getsBW() {
			return sBW;
		}

		public void setsBW(String sBW) {
			this.sBW = sBW;
		}

		public String getbUS() {
			return bUS;
		}

		public void setbUS(String bUS) {
			this.bUS = bUS;
		}

		@Override
		public String toString() {
			return "Data [cnt=" + cnt + ", oPENDATA_ID=" + oPENDATA_ID + ", gNG_CS=" + gNG_CS + ", fD_CS=" + fD_CS
					+ ", bZ_NM=" + bZ_NM + ", tLNO=" + tLNO + ", mBZ_HR=" + mBZ_HR + ", sEAT_CNT=" + sEAT_CNT
					+ ", pKPL=" + pKPL + ", hP=" + hP + ", pSB_FRN=" + pSB_FRN + ", bKN_YN=" + bKN_YN + ", iNFN_FCL="
					+ iNFN_FCL + ", bRFT_YN=" + bRFT_YN + ", dSSRT_YN=" + dSSRT_YN + ", mNU=" + mNU + ", sMPL_DESC="
					+ sMPL_DESC + ", sBW=" + sBW + ", bUS=" + bUS + "]";
		}
		
		

	}

	private static class ResponseObject {
		public String status;
		public String total;
		public ArrayList<Data> data;

		// 모든인자생성자
		ResponseObject() {
		}

		// getter And setter
		public ResponseObject(String status, String total, ArrayList<Data> data) {
			super();
			this.status = status;
			this.total = total;
			this.data = data;
		}

		public String getStatus() {
			return status;
		}

		public void setStatus(String status) {
			this.status = status;
		}

		public String getTotal() {
			return total;
		}

		public void setTotal(String total) {
			this.total = total;
		}

		public ArrayList<Data> getData() {
			return data;
		}

		public void setData(ArrayList<Data> data) {
			this.data = data;
		}

	}

}

```

---

> **C13Ex**
> 

```java
package Ch19;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.ArrayList;

import com.fasterxml.jackson.databind.ObjectMapper;

public class C13Ex {

	public static void main(String[] args) throws IOException, InterruptedException {
		// OPENWEATHER MAP API 를 이용해서 날씨 정보 받아옵니다
		// (https://openweathermap.org/api/one-call-3)

		String url = "https://api.openweathermap.org/data/2.5/weather";
		String lat = "37";
		String lon = "127";
		String lang = "kr";
		String appid = "75dba4fffc6d852857ede205cfa1bb39";
		url = url + "?lat=" + lat + "&lon=" + lon + "&lang=" + lang + "&appid=" + appid;
		System.out.println(url);

		// Http Request 객체 생성
		HttpRequest httpRequest = HttpRequest.newBuilder().uri(URI.create(url)).GET().build();

		// Http Request 요청 / 응답 확인
		HttpClient httpClient = HttpClient.newHttpClient();
		HttpResponse<String> response = httpClient.send(httpRequest, HttpResponse.BodyHandlers.ofString());

		// 가공 처리 (Class Type vs JSON Type)
		ObjectMapper objectMapper = new ObjectMapper();

		Weatherdata responseObject = objectMapper.readValue(response.body(), Weatherdata.class);
		System.out.println("Status : "+responseObject);
		
	}

	private static class Clouds {
		public int all;

		@Override
		public String toString() {
			return "Clouds [all=" + all + "]";
		}

		public Clouds(int all) {
			super();
			this.all = all;
		}

		public int getAll() {
			return all;
		}

		public void setAll(int all) {
			this.all = all;
		}
		public Clouds () {}
	}

	private static class Coord {
		public int lon;
		public int lat;
		public int getLon() {
			return lon;
		}
		public void setLon(int lon) {
			this.lon = lon;
		}
		public int getLat() {
			return lat;
		}
		public void setLat(int lat) {
			this.lat = lat;
		}
		public Coord(int lon, int lat) {
			super();
			this.lon = lon;
			this.lat = lat;
		}
		public Coord () {}
	}

	private static class Main {
		@Override
		public String toString() {
			return "Main [temp=" + temp + ", feels_like=" + feels_like + ", temp_min=" + temp_min + ", temp_max="
					+ temp_max + ", pressure=" + pressure + ", humidity=" + humidity + ", sea_level=" + sea_level
					+ ", grnd_level=" + grnd_level + "]";
		}
		public Main () {}
		public double temp;
		public double feels_like;
		public double temp_min;
		public double temp_max;
		public int pressure;
		public int humidity;
		public int sea_level;
		public int grnd_level;
		public double getTemp() {
			return temp;
		}
		public void setTemp(double temp) {
			this.temp = temp;
		}
		public double getFeels_like() {
			return feels_like;
		}
		public void setFeels_like(double feels_like) {
			this.feels_like = feels_like;
		}
		public double getTemp_min() {
			return temp_min;
		}
		public void setTemp_min(double temp_min) {
			this.temp_min = temp_min;
		}
		public double getTemp_max() {
			return temp_max;
		}
		public void setTemp_max(double temp_max) {
			this.temp_max = temp_max;
		}
		public int getPressure() {
			return pressure;
		}
		public void setPressure(int pressure) {
			this.pressure = pressure;
		}
		public int getHumidity() {
			return humidity;
		}
		public void setHumidity(int humidity) {
			this.humidity = humidity;
		}
		public int getSea_level() {
			return sea_level;
		}
		public void setSea_level(int sea_level) {
			this.sea_level = sea_level;
		}
		public int getGrnd_level() {
			return grnd_level;
		}
		public void setGrnd_level(int grnd_level) {
			this.grnd_level = grnd_level;
		}
		public Main(double temp, double feels_like, double temp_min, double temp_max, int pressure, int humidity,
				int sea_level, int grnd_level) {
			super();
			this.temp = temp;
			this.feels_like = feels_like;
			this.temp_min = temp_min;
			this.temp_max = temp_max;
			this.pressure = pressure;
			this.humidity = humidity;
			this.sea_level = sea_level;
			this.grnd_level = grnd_level;
		}
	}

	private static class Weatherdata {
		@Override
		public String toString() {
			return "Weatherdata [coord=" + coord + ", weather=" + weather + ", base=" + base + ", main=" + main
					+ ", visibility=" + visibility + ", wind=" + wind + ", clouds=" + clouds + ", dt=" + dt + ", sys="
					+ sys + ", timezone=" + timezone + ", id=" + id + ", name=" + name + ", cod=" + cod + "]";
		}
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
		public Coord getCoord() {
			return coord;
		}
		public void setCoord(Coord coord) {
			this.coord = coord;
		}
		public ArrayList<Weather> getWeather() {
			return weather;
		}
		public void setWeather(ArrayList<Weather> weather) {
			this.weather = weather;
		}
		public String getBase() {
			return base;
		}
		public void setBase(String base) {
			this.base = base;
		}
		public Main getMain() {
			return main;
		}
		public void setMain(Main main) {
			this.main = main;
		}
		public int getVisibility() {
			return visibility;
		}
		public void setVisibility(int visibility) {
			this.visibility = visibility;
		}
		public Wind getWind() {
			return wind;
		}
		public void setWind(Wind wind) {
			this.wind = wind;
		}
		public Clouds getClouds() {
			return clouds;
		}
		public void setClouds(Clouds clouds) {
			this.clouds = clouds;
		}
		public int getDt() {
			return dt;
		}
		public void setDt(int dt) {
			this.dt = dt;
		}
		public Sys getSys() {
			return sys;
		}
		public void setSys(Sys sys) {
			this.sys = sys;
		}
		public int getTimezone() {
			return timezone;
		}
		public void setTimezone(int timezone) {
			this.timezone = timezone;
		}
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public int getCod() {
			return cod;
		}
		public void setCod(int cod) {
			this.cod = cod;
		}
		public Weatherdata(Coord coord, ArrayList<Weather> weather, String base, Main main, int visibility, Wind wind,
				Clouds clouds, int dt, Sys sys, int timezone, int id, String name, int cod) {
			super();
			this.coord = coord;
			this.weather = weather;
			this.base = base;
			this.main = main;
			this.visibility = visibility;
			this.wind = wind;
			this.clouds = clouds;
			this.dt = dt;
			this.sys = sys;
			this.timezone = timezone;
			this.id = id;
			this.name = name;
			this.cod = cod;
		}
		public Weatherdata () {}
		
	}

	private static class Sys {
		@Override
		public String toString() {
			return "Sys [country=" + country + ", sunrise=" + sunrise + ", sunset=" + sunset + "]";
		}
		public Sys () {}
		public String country;
		public int sunrise;
		public int sunset;
		public String getCountry() {
			return country;
		}
		public void setCountry(String country) {
			this.country = country;
		}
		public int getSunrise() {
			return sunrise;
		}
		public void setSunrise(int sunrise) {
			this.sunrise = sunrise;
		}
		public int getSunset() {
			return sunset;
		}
		public void setSunset(int sunset) {
			this.sunset = sunset;
		}
		public Sys(String country, int sunrise, int sunset) {
			super();
			this.country = country;
			this.sunrise = sunrise;
			this.sunset = sunset;
		}
	}

	private static class Weather {
		@Override
		public String toString() {
			return "Weather [id=" + id + ", main=" + main + ", description=" + description + ", icon=" + icon + "]";
		}
		public Weather() {}
		public int id;
		public String main;
		public String description;
		public String icon;
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getMain() {
			return main;
		}
		public void setMain(String main) {
			this.main = main;
		}
		public String getDescription() {
			return description;
		}
		public void setDescription(String description) {
			this.description = description;
		}
		public String getIcon() {
			return icon;
		}
		public void setIcon(String icon) {
			this.icon = icon;
		}
		public Weather(int id, String main, String description, String icon) {
			super();
			this.id = id;
			this.main = main;
			this.description = description;
			this.icon = icon;
		}
	}

	private static class Wind {
		@Override
		public String toString() {
			return "Wind [speed=" + speed + ", deg=" + deg + ", gust=" + gust + "]";
		}
		public Wind () {}
		public double speed;
		public int deg;
		public double gust;
		public double getSpeed() {
			return speed;
		}
		public void setSpeed(double speed) {
			this.speed = speed;
		}
		public int getDeg() {
			return deg;
		}
		public void setDeg(int deg) {
			this.deg = deg;
		}
		public double getGust() {
			return gust;
		}
		public void setGust(double gust) {
			this.gust = gust;
		}
		public Wind(double speed, int deg, double gust) {
			super();
			this.speed = speed;
			this.deg = deg;
			this.gust = gust;
		}
	}
}

```

---