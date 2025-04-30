# 01

## ex10_interceptor

### config

> DataSourceConfig
> 

```
package com.example.app.config;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.zaxxer.hikari.HikariDataSource;

@Configuration
public class DataSourceConfig {
	// Spring-jdbc DataSource
	@Bean
	public DataSource dataSource2()
	{
//		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		BasicDataSource dataSource = new BasicDataSource();
		dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
		dataSource.setUrl("jdbc:mysql://localhost:3306/testdb");
		dataSource.setUsername("root");
		dataSource.setPassword("1234");

		dataSource.setInitialSize(5);//초기 연결개수
		dataSource.setMaxTotal(10);//최대 연결 개수
		dataSource.setMaxIdle(8);//최대 유휴 연결 수
		dataSource.setMinIdle(3);//최소 유휴 연결 수

		return dataSource;
	}
//	HikariCP DataSource
	@Bean
	public HikariDataSource dataSource3()
	{
		HikariDataSource dataSource = new HikariDataSource();
		dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
		dataSource.setJdbcUrl("jdbc:mysql://localhost:3306/testdb");
		dataSource.setUsername("root");
		dataSource.setPassword("1234");

		return dataSource;
	}

}

```

---

> MybatisConfig
> 

```
package com.example.app.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

@Configuration
public class MybatisConfig {

	@Autowired
	private DataSource dataSource3;

	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
		sessionFactory.setDataSource(dataSource3);

	    // Mapper XML 파일의 위치 설정
	    PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
	    Resource[] resources = resolver.getResources("classpath*:mapper/*.xml");
	    sessionFactory.setMapperLocations(resources);

		return sessionFactory.getObject();
	}

//    @Autowired
//    private SqlSessionFactory sqlSessionFactory;

    @Bean
    public SqlSessionTemplate sqlSessionTemplate() throws Exception {
        return new SqlSessionTemplate(sqlSessionFactory());
    }

}

```

---

> PersonComponent
> 

```
package com.example.app.config;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class PersonComponent {
	private String username;
	private int age;
	private String addr;

	PersonComponent(){
		this.username = "티모";
		this.age = 33;
		this.addr = "인천";
	}
}

```

---

> PersonDtoBeanConfig
> 

```
package com.example.app.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.example.app.domain.dto.PersonDto;

@Configuration
public class PersonDtoBeanConfig {

	@Bean
	public PersonDto person03() {

		return PersonDto.builder()
				.age(55)
				.username("철수")
				.addr("울산")
				.build();

//		return new PersonDto("김범수",44,"서울");
	}

	@Bean(name = "personBean")
	public PersonDto person04() {
		return new PersonDto("박효신",40,"대구");
	}

}

```

---

> TxConfig
> 

```
package com.example.app.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
public class TxConfig {
	@Autowired
	private DataSource dataSource3;

    @Bean
    public DataSourceTransactionManager transactionManager() {
        return new DataSourceTransactionManager(dataSource3);
    }
}

```

---

> WebMvcConfig
> 

```
package com.example.app.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScans;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.example.app.interceptor.MemoInterceptor;

@Configuration
@EnableWebMvc
@ComponentScans({
	@ComponentScan("com.example.app.controller"),
	@ComponentScan("com.example.app.restController")
})
public class WebMvcConfig implements WebMvcConfigurer{

	@Bean
	public MultipartResolver multipartResolver() {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
        multipartResolver.setMaxUploadSize(1024*1024*20); 			// 20MB	//전체 업로드 허용 사이즈
        multipartResolver.setMaxUploadSizePerFile(1024*1024*20); 	// 20MB	//파일 1개당 허용가능한 업로드 사이즈
        multipartResolver.setMaxInMemorySize(1024*1024*20); 		// 20MB //캐시 공간
        return multipartResolver;
	}
	//ViewResolver
	@Bean
	public ViewResolver viewResolver() {
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setPrefix("/WEB-INF/views/");
		viewResolver.setSuffix(".jsp");
		return viewResolver;
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
	}

	//INTERCEPTOR ADD
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new MemoInterceptor()).addPathPatterns("/memo/*");
	}

}

```

---

### controller

> ExceptionTestController
> 

```
package com.example.app.controller;

import java.io.FileNotFoundException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/except")
public class ExceptionTestController {

//	@ExceptionHandler(FileNotFoundException.class)
//	public String fileNotFoundExceptionHandler(Exception e, Model model) {
//		log.error("error : " + e);
//		return "except/error";
//	}
//	@ExceptionHandler(ArithmeticException.class)
//	public String arithmeticExceptionHandler(Exception e, Model model) {
//		log.error("error : " + e);
//		return "except/error";
//	}

//	@ExceptionHandler(Exception.class)
//	public String arithmeticExceptionHandler(Exception e, Model model) {
//		log.error("error : " + e);
//		return "except/error";
//	}

	@GetMapping("/ex")
	public void ex1_1() throws FileNotFoundException{
		log.info("GET -");
		throw new FileNotFoundException("파일을 찾을수가 없습니다.");
	}

	@GetMapping("/page01")
	public void ex1() throws FileNotFoundException{
		log.info("GET /except/page01");
		throw new FileNotFoundException("파일을 찾을수가 없습니다.");
	}

	@GetMapping("/page02/{num}/{div}")
	public String ex2 (
			@PathVariable("num") int num,
			@PathVariable("div") int div,
			Model model
			) throws ArithmeticException {
		log.info("GET /except/page02..." + (num/div));
		model.addAttribute("result",(num/div));

		return "except/page02";
	}
}

```

---

> FileUpDownloadController
> 

```
package com.example.app.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.app.domain.dto.FileDto;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/file")
public class FileUpDownloadController {

	private String ROOT_PATH = "c:";
	private String UPLOAD_PATH = "upload";

	@GetMapping("/upload")
	public void upload_form() {
		log.info("GET /file/upload..");
	}

	@PostMapping("/upload")
	public void upload(@RequestParam("files") MultipartFile[] files) throws IllegalStateException, IOException {

		log.info("POST /file/upload.."+files.length);

		LocalDateTime now = LocalDateTime.now();
		//yyyyMMdd_HHmmss 폴더명
		String folderName =now.format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
		//업로드 경로 설정
		String UploadPath = ROOT_PATH
							+File.separator // '/'
							+UPLOAD_PATH
							+File.separator
							+folderName
							+File.separator;
		//디렉토리 생성( c:\\\\upload\\\\20250421_102933\\\\ )
		File dir = new File(UploadPath);
		if(!dir.exists())
			dir.mkdirs();

		for(MultipartFile file : files) {
			System.out.println("--------------------");
			System.out.println("FILE NAME : " + file.getOriginalFilename());
			System.out.println("FILE SIZE : " + file.getSize() + " Byte");
			System.out.println("--------------------");
			String filename= file.getOriginalFilename();
			File fileObject = new File(dir,filename);
			file.transferTo(fileObject);	//UPLOAD  처리
		}

	}

	@PostMapping("/upload_dto")
	public void upload_dto(FileDto dto) throws IllegalStateException, IOException {

		MultipartFile files [] = dto.getFiles();
		log.info("POST /file/upload.."+files.length);

		LocalDateTime now = LocalDateTime.now();
		//yyyyMMdd_HHmmss 폴더명
		String folderName =now.format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
		//업로드 경로 설정
		String UploadPath = ROOT_PATH
							+File.separator // '/'
							+UPLOAD_PATH
							+File.separator
							+folderName
							+File.separator;
		//디렉토리 생성( c:\\\\upload\\\\20250421_102933\\\\ )
		File dir = new File(UploadPath);
		if(!dir.exists())
			dir.mkdirs();

		for(MultipartFile file : files) {
			System.out.println("--------------------");
			System.out.println("FILE NAME : " + file.getOriginalFilename());
			System.out.println("FILE SIZE : " + file.getSize() + " Byte");
			System.out.println("--------------------");
			String filename= file.getOriginalFilename();
			File fileObject = new File(dir,filename);
			file.transferTo(fileObject);	//UPLOAD  처리
		}
	}

	@GetMapping("/list")
	public void list(Model model) {
		log.info("GET /file/list...");
		String UploadPath = ROOT_PATH
				+File.separator // '/'
				+UPLOAD_PATH
				+File.separator;

		File uploadDir = new File(UploadPath);
		File [] dirs =  uploadDir.listFiles();
		for(File dir : dirs) {
			System.out.println("DIR : " + dir);

			File subDir = new File(dir.getPath());
			for(File file : subDir.listFiles()) {
				System.out.println("FILE : " + file);
			}

		}

		model.addAttribute("uploadPath",new File(UploadPath));

	}
	@GetMapping(value="/download" ,produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> download(@RequestParam("path") String path) throws UnsupportedEncodingException {
		log.info("GET /file/download..." + path);
		//FileSystemResource : 파일시스템의 특정 파일로부터 정보를 가져오는데 사용
		Resource resource = new FileSystemResource(path);
		//파일명 추출
		String filename = resource.getFilename();
		//헤더 정보 추가
		HttpHeaders headers = new HttpHeaders();
		//ISO-8859-1 : 라틴어(특수문자등 깨짐 방지)
		headers.add("Content-Disposition","attachment; filename="+new String(filename.getBytes("UTF-8"),"ISO-8859-1"));
		//리소스,파일정보가 포함된 헤더,상태정보를 전달
		return new ResponseEntity<Resource>(resource,headers,HttpStatus.OK);
	}

}

```

---

> HomeController
> 

```
package com.example.app.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
//		logger.info("Welcome home! The client locale is {}.", locale);

		log.trace("TRACE LOG TEST");
		log.debug("DEBUG LOG TEST");
		log.info("INFO LOG TEST");
		log.warn("WARN LOG TEST");
		log.error("ERROR LOG TEST");

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate );

		return "home";
	}

	@GetMapping("/home/test")
	@ResponseBody
	public String test() {

		return "{\\"message\\":\\"REST DATA TEST\\"}";
	}

}

```

---

> MemoController
> 

```
package com.example.app.controller;

import java.beans.PropertyEditorSupport;
import java.io.FileNotFoundException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.app.domain.dto.MemoDto;
import com.example.app.domain.service.MemoServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/memo")
public class MemoController {

	@Autowired
	private MemoServiceImpl memoServiceImpl;

//	@InitBinder
//	public void dataBinder(WebDataBinder webDataBinder) {
//		log.info("MemoController's dataBinder ..." + webDataBinder);
//		webDataBinder.registerCustomEditor(LocalDate.class, "dateTest", new DateTestEditor());
//	}

	@GetMapping("/ex")
	public void ex1_1() throws FileNotFoundException{
		log.info("GET -");
		throw new FileNotFoundException("파일을 찾을수가 없습니다.");
	}

	@GetMapping("/add")
	public void add_get(MemoDto dto) throws SQLException {
		log.info("GET /memo/add...");
		memoServiceImpl.registrationMemo(dto);
	}

	@PostMapping("/add")
	public void add_post(@Valid MemoDto dto,BindingResult bindingResult,Model model) throws Exception {
		log.info("POST /memo/add..."+dto);

		if(bindingResult.hasErrors()) {
//			log.info("유효성 에러발생 : " + bindingResult.getFieldError("id").getDefaultMessage());

			for(FieldError error : bindingResult.getFieldErrors()) {
				log.info("Error Field : "+error.getField()+" Error Msg : "+error.getDefaultMessage());
				model.addAttribute(error.getField(),error.getDefaultMessage());
			}

			return ;
		}
		//서비스
		boolean isAdded =  memoServiceImpl.registrationMemo(dto);
		//memoServiceImpl.addMemoTx(dto);

	}

	// static private
	private static class DateTestEditor extends PropertyEditorSupport {

		@Override
		public void setAsText(String dateTest) throws IllegalArgumentException {
			log.info("DateTestEditor's setAsText invoke.." + dateTest);
			LocalDate date = null;
			if(dateTest.isEmpty()) {
				date = LocalDate.now();
			}else {
				//yyyy#MM#dd -> yyyy-MM-dd(LocalDate format)
				dateTest = dateTest.replaceAll("#", "-");
				date = LocalDate.parse(dateTest,DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			}

			setValue(date);

		}
	}
	//
	@GetMapping("/rest")
	public void rest() {
		log.info("GET /rest...");
	}

}

```

---

> ParameterTestController
> 

```
package com.example.app.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.app.domain.dto.PersonDto;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/param")
public class ParameterTestController {

	@RequestMapping(value="/p01",method=RequestMethod.GET)
	public void p01(@RequestParam(value="name", required=false) String name) {
		log.info("GET /param/p01..." + name);
	}

	@GetMapping("/p02")
	public void p02(@RequestParam(value="name", required=true) String name) {
		log.info("GET /param/p02..." + name);
	}

	@PostMapping(value="/p03")
	public void p03(@RequestParam(value="name", required=true) String name) {
		log.info("POST /param/p03..." + name);
	}
	// @RequestParam	: 동기요청 파라미터 처리 	/ form 기반 전달되는 파라미터 받기
	// @RequestBody		: 비동기요청 파라미터 처리 / form / json 등 파라미터 받기
	@PostMapping(value="/p04")
	public void p04(@RequestBody String name) {
		log.info("POST /param/p04..." + name);
	}
	@RequestMapping(value="/p05",method=RequestMethod.GET)
	public void p05(@RequestParam(value="name",defaultValue="홍길동") String name) {
		log.info("GET /param/p05..." + name);
	}

	@RequestMapping(value="/p06",method=RequestMethod.GET)
	public void p06(
					@RequestParam(value="name") 	String name,
					@RequestParam(value="age") 		int age ,
					@RequestParam(value="addr")  	String addr
					)
	{
		log.info("GET /param/p06..." + name + " " + age + " " + addr);
	}

	@RequestMapping(value="/p07",method=RequestMethod.GET)
	public void p07( @ModelAttribute PersonDto dto)
	{
		log.info("GET /param/p07..." + dto);
	}

	@RequestMapping(value="/p08/{username}/{age}/{addr}",method=RequestMethod.GET)
	public void p08(
				@PathVariable("username") String name,
				@PathVariable int age,
				@PathVariable String addr
			)
	{
		log.info("GET /param/p08..." + name+" " + age + " " + addr);
	}

	@RequestMapping(value="/p09/{username}/{age}/{addr}",method=RequestMethod.GET)
	public void p09(PersonDto dto)
	{
		log.info("GET /param/p09..." + dto);
	}

	@GetMapping("/page01")
	public void page01(PersonDto dto,Model model) {
		log.info("GET /param/page01..."+ dto);
		//반환자료형이 void 일때 /WEB-INF/views/param/page01.jsp와 매핑

		//파라미터
		//유효성
		//서비스
		//뷰이동 + 데이터 전달(Model객체 - DispatherServlet(FC))
		model.addAttribute("dto",dto);
		model.addAttribute("test","test1Value");

	}
	@GetMapping("/page02")
	public String page02(PersonDto dto,Model model) {
		log.info("GET /param/page02..."+ dto);
		model.addAttribute("dto",dto);
		model.addAttribute("test","test2Value");

		//반환자료형 void : /WEB-INF/views/param/page02.jsp와 매핑
		//위치변경시 String  + return "path"

		return "param/page01";
	}
	@GetMapping("/page03/{username}/{age}/{addr}")
	public String page03(PersonDto dto,Model model) {
		log.info("GET /param/page03..." + dto);
		model.addAttribute("dto",dto);
		model.addAttribute("test","test_value_3");
		return "param/page01";
	}
	@GetMapping("/page04/{username}/{age}/{addr}")
	public ModelAndView page04(PersonDto dto) {
		log.info("GET /param/page04..." + dto);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("dto",dto);
		modelAndView.setViewName("param/page01");

		return modelAndView;
	}

	//SERVLET 방식
	@GetMapping("/page05")
	public String page05(HttpServletRequest req,HttpServletResponse resp) {
		log.info("GET /param/page05...");
		//파라미터 받기
		String name = req.getParameter("username");
		int age =  Integer.parseInt(req.getParameter("age"));
		String addr = req.getParameter("addr");
		log.info(name+" "  + age);
		PersonDto dto = new PersonDto(name,age,addr);

		//내용담기
		req.setAttribute("dto", dto);

		HttpSession session = req.getSession();
		log.info("session : "  + session);
		return "param/page01";
	}

	//Forward
	@GetMapping("/forward1")
	public String f1(Model model) {
		log.info("param/forward1..");
		model.addAttribute("f1","f1Value");
		return "forward:/param/forward2";
	}
	//Forward
	@GetMapping("/forward2")
	public String f2(Model model) {
		log.info("/param/forward2..");
		model.addAttribute("f2","f2Value");
		return "forward:/param/forward3";
	}
	//Forward
	@GetMapping("/forward3")
	public String f3(Model model) {
		log.info("/param/forward3..");
		model.addAttribute("f3","f3Value");
		return "param/forward_result";
	}

	//Redirect
	@GetMapping("/redirect1")
	public String r1(Model model,RedirectAttributes redirectAttributes) {
		log.info("/param/redirect1..");
//		model.addAttribute("r1","r1Value");
		redirectAttributes.addAttribute("r1", "r1Value");//쿼리스트링
		return "redirect:/param/redirect2";
	}
	@GetMapping("/redirect2")
	public String r2(
			Model model,
			@RequestParam("r1") String r1,
			RedirectAttributes redirectAttributes
			) {
		log.info("/param/redirect2..r1 : " + r1);
//		model.addAttribute("r2","r2Value");

		redirectAttributes.addAttribute("r1", r1);//쿼리스트링
		redirectAttributes.addAttribute("r2", "r2Value");//쿼리스트링
		return "redirect:/param/redirect_result";
	}
	@GetMapping("/redirect_result")
	public void r_result(
			Model model,
			@RequestParam("r1") String r1,
			@RequestParam("r2") String r2
			) {
		model.addAttribute("r1",r1);
		model.addAttribute("r2",r2);
		model.addAttribute("r3","r3Value");
		log.info("/param/redirect_result..:");
	}

}

```

---

> SimpleController
> 

```
package com.example.app.controller;

import java.io.FileNotFoundException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/test")
public class SimpleController {

	@GetMapping("/ex")
	public void ex1_1() throws FileNotFoundException{
		log.info("GET -");
		throw new FileNotFoundException("파일을 찾을수가 없습니다.");
	}

	@RequestMapping( value = "/test1" ,method=RequestMethod.GET)
	public void test1() {
		log.info("GET /test/test1...");
		// 파라미터
		// 유효성
		// 서비스
		// 뷰이동(x)
	}
	@RequestMapping( value = "/test2" ,method=RequestMethod.GET)
	public String test2() {
		log.info("GET /test/test2...");
		return "test/abcd";
	}

	@RequestMapping( value = "/test3" ,method= {RequestMethod.GET,RequestMethod.POST})
	public void test3() {
		log.info("GET /test/test3...");
	}

}

```

---

> UserController
> 

```
package com.example.app.controller;

import java.beans.PropertyEditorSupport;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.app.domain.dto.UserDto;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UserController {

	@InitBinder
	public void dataBinder(WebDataBinder webDataBinder) {
		log.info("UserController dataBinder ..." + webDataBinder);
		webDataBinder.registerCustomEditor(String.class, "phone", new PhoneEditor());
		webDataBinder.registerCustomEditor(LocalDate.class, "birthday", new BirthdayEditor());
	}

	@GetMapping("/join")
	public void join() {
		log.info("GET /join..");
	}
	@PostMapping("/join")
	public void join_post(@Valid UserDto dto,BindingResult bindingResult,Model model) {
		log.info("POST /join.." + dto);

		for(FieldError error : bindingResult.getFieldErrors()) {
			log.info("Error Field : "+error.getField()+" Error Msg : "+error.getDefaultMessage());
			model.addAttribute(error.getField(),error.getDefaultMessage());
		}
	}

	private static class PhoneEditor extends PropertyEditorSupport {

		@Override
		public void setAsText(String text) throws IllegalArgumentException {
			text=text.replaceAll("-", "");
			setValue(text);
		}

	}

	private static class BirthdayEditor extends PropertyEditorSupport{

		@Override
		public void setAsText(String text) throws IllegalArgumentException {
			LocalDate date = null;
			if(text.isEmpty()) {
				date = LocalDate.now();
			}else {
				//yyyy#MM#dd -> yyyy-MM-dd(LocalDate format)
				text = text.replaceAll("~", "-");
				date = LocalDate.parse(text,DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			}

			setValue(date);
		}
	}
}

```

---

### exception

> GlobalExceptionHandler
> 

```
package com.example.app.controller.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import lombok.extern.slf4j.Slf4j;

@ControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

	@ExceptionHandler(Exception.class)
	public String AllExceptionExceptionHandler(Exception e, Model model) {
		log.info("GlobalExceptionHandler's error : " + e);
		model.addAttribute("ex",e);
		return "global_error";
	}
}

```

---

### dao

> MemoDaoImpl
> 

```
package com.example.app.domain.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.app.domain.dto.MemoDto;

@Repository
public class MemoDaoImpl {
//	@Autowired
//	private DataSource dataSource1;
//
//
//	public int insert(MemoDto memoDto) throws SQLException {
//		Connection con =  dataSource1.getConnection();
//		PreparedStatement pstmt = con.prepareStatement("insert into tbl_memo values(?,?,?,?)");
//		pstmt.setInt(1, memoDto.getId());
//		pstmt.setString(2, memoDto.getText());
//		pstmt.setString(3, memoDto.getWriter());
//		pstmt.setTimestamp(4, Timestamp.valueOf(memoDto.getCreateAt()));
//		int result = pstmt.executeUpdate();
//		return result;
//	}

	@Autowired
	private SqlSession sqlSession;

	private static String namespace="com.example.app.domain.mapper.MemoMapper.";

	public int insert(MemoDto memoDto) throws SQLException{
		sqlSession.insert(namespace+"insert",memoDto);
		System.out.println("MemoDaoImpl's insert invoke... " + memoDto);
		return memoDto.getId();	//자동증가한 다음 숫자의 Id값 리턴(Select Key )
	}

}

```

---

### dto

> FileDto
> 

```
package com.example.app.domain.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FileDto {
	private long id;
	private String category;
	private int price;
	private MultipartFile [] files;

}

```

---

> MemoDto
> 

```
package com.example.app.domain.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.validation.constraints.Email;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemoDto {
	@Min(value=10,message = "ID는 10이상 이어야 합니다.")
	@Max(value=65535,message="ID의 최대 숫자는 65535 이하이어야 합니다")
	@NotNull(message="ID는 필수항목입니다")
	private Integer id;
	@NotBlank(message="메모를 입력하세요")
	private String text;
	@NotBlank(message="메모를 입력하세요")
	@Email(message="example@example.com에 맞게 입력해주세요")
	private String writer;
	@DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm")
	@NotNull(message="날짜정보를 선택해주세요")
	private LocalDateTime createAt;

//	private LocalDate dateTest;
}

```

---

> PersonDto
> 

```
package com.example.app.domain.dto;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

//@Getter
//@Setter
//@ToString
@Data
@AllArgsConstructor
@NoArgsConstructor
@Component
@Builder
public class PersonDto {
	private String username;
	private int age;
	private String addr;

}

```

---

> UserDto
> 

```
package com.example.app.domain.dto;

import java.time.LocalDate;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserDto {
	private String userid;		//유저ID
	@NotBlank(message="password 를 입력하세요")
	private String password;	//패스워드
	@NotBlank(message="rePassword 를 입력하세요")
	private String rePassword;	//패스워드확인
	@NotBlank(message="username 를 입력하세요")
	private String username;	//유저이름
	@NotBlank(message="phone 를 입력하세요")
	private String phone;		//전화번호
	@NotBlank(message="zipcode 를 입력하세요")
	private String zipcode;		//우편번호
	@NotBlank(message="addr1 를 입력하세요")
	private String addr1;		//기본주소
	@NotBlank(message="addr2 를 입력하세요")
	private String addr2;		//상세주소

	@NotNull(message="birthday 를 입력하세요")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private LocalDate birthday;	//생년월일(yyyy-MM-dd)
}

```

---

### mapper

> MemoMapper
> 

```
package com.example.app.domain.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.example.app.domain.dto.MemoDto;

@Mapper
public interface MemoMapper {

	@SelectKey(statement="select max(id)+1 from tbl_memo",keyProperty = "id",before = false, resultType = int.class)
	@Insert(value = "insert into tbl_memo values(#{id},#{text},#{writer},#{createAt})")
	public int insert(MemoDto memoDto);

	@Update("update tbl_memo set text=#{text} where id=#{id}")
	public int update(MemoDto dto);

	@Delete("delete from tbl_memo where id=#{id}")
	public int delete(int id);

	@Select("select * from tbl_memo where id=#{id}")
	public MemoDto selectAt(int id);

	@Select("select * from tbl_memo")
	public List<MemoDto> selectAll();

	@Results(id="MemoResultMap", value= {
			@Result(property = "id",column="id"),
			@Result(property = "text", column="text")
	})
	@Select("select * from tbl_memo")
	public List< Map<String,Object> > selectAllResultMap();

//	XML방식
	public int insertXml(MemoDto memoDto);
	public int updateXml(MemoDto memoDto);
	public int deleteXml(@Param("id") int id);
	public MemoDto selectAtXml(int id);
	public List<MemoDto> selectAllXml();
	public List< Map<String,Object> > selectAllResultMapXml();

	public List<Map<String,Object>>  Select_if_xml(Map<String,Object> param);
	public List<Map<String,Object>>  Select_when_xml(Map<String,Object> param);

}

```

---

### service

> MemoServiceImpl
> 

```
package com.example.app.domain.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.app.domain.dto.MemoDto;
import com.example.app.domain.mapper.MemoMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemoServiceImpl {

//	@Autowired
//	private MemoDaoImpl memoDaoIistrationMemo(MemoDto memoDto) throws SQLException {
//
//		int result =  memoDaoImpl.insert(memoDto);
//
//		return result>0;
//	}

	@Autowired
	private MemoMapper memoMapper;

	public boolean registrationMemo(MemoDto memoDto) throws SQLException{
		int result = memoMapper.insert(memoDto);

		return result>0;
	}

	//전체메모가져오기
	public List<MemoDto> getAllMemo(){
		log.info("MemoService's getAllMemo Call! ");
		return  memoMapper.selectAll();
	}

	//메모작성
	@Transactional(rollbackFor = Exception.class)
	public void addMemoTx(MemoDto dto)	 {
		log.info("MemoService's addMemoTx Call! ");
		int id=dto.getId();
		memoMapper.insert(dto);		//01 정상INSERT
		dto.setId(id);				//PK오류 발생예정인 dto
		memoMapper.insert(dto);		//02	PK오류 발생!!
	}

	@Transactional(rollbackFor = Exception.class)
	public MemoDto getMemo(int id) {

		return memoMapper.selectAt(id);

	}
	@Transactional(rollbackFor = Exception.class)
	public void modifyMemo(MemoDto dto) {
		memoMapper.update(dto);
	}

	@Transactional(rollbackFor = Exception.class)
	public void removeMemo(int id) {
		memoMapper.delete(id);
	}

}

```

---

### interceptor

> MemoInterceptor
> 

```
package com.example.app.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class MemoInterceptor implements HandlerInterceptor{

	//MemoController로 이동하기 전 처리
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("MemoInterceptor's preHandle...");
		return true;
	}
	//MemoController의 작업이 끝난 이후
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		System.out.println("MemoInterceptor's postHandle...");
	}
	//View Page 렌더링 된 이후 처리
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		System.out.println("MemoInterceptor's afterCompletion...");
	}

}

```

---

### restController

> MemoRestController
> 

```
package com.example.app.restController;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.app.domain.dto.MemoDto;
import com.example.app.domain.service.MemoServiceImpl;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@RequestMapping("/rest/memo")
public class MemoRestController {
	@Autowired
	private MemoServiceImpl memoService;

	//메모확인전체
	@GetMapping(value="/getAll",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<MemoDto> getAll() {
		log.info("GET /rest/memo/getAll");
		return memoService.getAllMemo();
	}

	//메모확인(단건)
	@GetMapping(value="/get/{id}",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<MemoDto> get(@PathVariable int id) {
		log.info("GET /memo/get... "+id);

		MemoDto dto =  memoService.getMemo(id);

		return new ResponseEntity(dto, HttpStatus.OK);

	}
	//메모쓰기
	@GetMapping("/add")
	public void add_get(MemoDto dto) throws SQLException {
		log.info("POST /rest/memo/add.."+dto);
		memoService.registrationMemo(dto);
	}
	//메모쓰기
	@PostMapping("/post")	//http://localhost:8090/ex08_restController/rest/memo/post
	public void add(@RequestBody MemoDto dto) throws SQLException {
		log.info("POST /rest/memo/post.."+dto);
		memoService.registrationMemo(dto);
	}

	//메모수정
	@PutMapping("/put/{id}/{text}")
	public void put(MemoDto dto) {
		log.info("PUT /memo/put.."+dto);
		memoService.modifyMemo(dto);
	}

	@PutMapping("/put2")	//http://localhost:8080/app/memo/put2
	public void put2(@RequestBody MemoDto dto) {
		log.info("PUT /memo/put2.."+dto);
		memoService.modifyMemo(dto);
	}

	@PatchMapping("/patch/{id}/{text}")
	public void patch(MemoDto dto) {
		log.info("PATCH /memo/patch.."+dto);
		memoService.modifyMemo(dto);
	}
	//메모삭제
	@DeleteMapping("/remove/{id}")	//http://localhost:8080/app/memo/remove/{id}
	public void remove(@PathVariable int id) {
		log.info("DELETE /memo/remove.."+id);
		memoService.removeMemo(id);
	}

}

```

---

> RestController_01
> 

```
package com.example.app.restController;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.app.domain.dto.MemoDto;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@RequestMapping("/rest")
public class RestController_01 {

	@GetMapping(value="/getText" , produces=MediaType.TEXT_PLAIN_VALUE)
	public String f1() {
		log.info("GET /rest/getText...");
		return "HELLO WORLD";
	}
	@GetMapping(value="/getJson" , produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public MemoDto f2() {
		log.info("GET /rest/getJson...");
		return new MemoDto(11,"ABCD","FFFF",LocalDateTime.now());
	}

	@GetMapping(value="/getXml" , produces=MediaType.APPLICATION_XML_VALUE)
	public MemoDto f3() {
		log.info("GET /rest/getXml...");
		return new MemoDto(11,"ABCD","FFFF",LocalDateTime.now());
	}

	@GetMapping(value="/getXmlList" , produces=MediaType.APPLICATION_XML_VALUE)
	public List<MemoDto> f4() {
		log.info("GET /rest/getXmlList...");
		List<MemoDto> list = new ArrayList();

		for(int i=5000;i<5010;i++) {
			list.add(new MemoDto(i,"A"+i,"aa",LocalDateTime.now()));
		}
		return list;
	}

	@GetMapping(value="/getXmlList2/{show}" , produces=MediaType.APPLICATION_XML_VALUE)
	public  ResponseEntity< List<MemoDto> > f5(@PathVariable("show") boolean show) {
		log.info("GET /rest/getXmlList2...");
		if(show) {
			List<MemoDto> list = new ArrayList();
			for(int i=6000;i<6010;i++) {
				list.add(new MemoDto(i, "A"+i , "",LocalDateTime.now()));
			}

			return ResponseEntity.status(HttpStatus.OK).body(list);
		}
		return ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(null);
	}

}

```

---

## ex11_HandlerMapping

### config

> WebMvcConfig
> 

```
package com.example.app.config;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScans;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.handler.BeanNameUrlHandlerMapping;
import org.springframework.web.servlet.handler.SimpleUrlHandlerMapping;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.example.app.handler.CustomHandler;
import com.example.app.interceptor.MemoInterceptor;

@Configuration
@EnableWebMvc
@ComponentScans({
	@ComponentScan("com.example.app.controller"),
	@ComponentScan("com.example.app.restController")
})
public class WebMvcConfig implements WebMvcConfigurer{

	@Bean
	public MultipartResolver multipartResolver() {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
        multipartResolver.setMaxUploadSize(1024*1024*20); 			// 20MB	//전체 업로드 허용 사이즈
        multipartResolver.setMaxUploadSizePerFile(1024*1024*20); 	// 20MB	//파일 1개당 허용가능한 업로드 사이즈
        multipartResolver.setMaxInMemorySize(1024*1024*20); 		// 20MB //캐시 공간
        return multipartResolver;
	}
	//ViewResolver
	@Bean
	public ViewResolver viewResolver() {
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setPrefix("/WEB-INF/views/");
		viewResolver.setSuffix(".jsp");
		return viewResolver;
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
	}

	//INTERCEPTOR ADD
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new MemoInterceptor()).addPathPatterns("/memo/*");
	}

	//HANDLER MAPPING

	//1) BEAN MAPPING(BeanNameUrlHandlerMapping : 요청 URL을 동일한 이름을 가진 Bean에 매핑)
	@Bean
	BeanNameUrlHandlerMapping beanNameUrlHandlerMapping() {
		return new BeanNameUrlHandlerMapping();
	}

	@Bean("/custom_01")
	public CustomHandler customHandler() {
		return new CustomHandler();
	}

	//2) SimpleUrlHandlerMapping : 개발자가 직접 매핑정보를 설정 방식중 하나 , 기본값 : 정적자원 매핑
	@Bean
	SimpleUrlHandlerMapping simpleUrlHandlerMapping() {

		SimpleUrlHandlerMapping handlerMapping = new SimpleUrlHandlerMapping();

		Map<String,Object> urlMap = new HashMap();

		urlMap.put("/custom_02", new CustomHandler());

		handlerMapping.setUrlMap(urlMap);
		return handlerMapping;
	}

	//3) RequesetMappingHandlerMapping : Controller와 매핑되는 URL을 찾아내고 해당 URL에 대한 요청 처리
	//적절한 컨트롤러 및 메서드를 찾아 매핑(@RequestMapping,@GetMapping,@PostMapping...)
	@Bean
	RequestMappingHandlerMapping requestMappingHandlerMapping() throws NoSuchMethodException, SecurityException {
		RequestMappingHandlerMapping handlerMapping = new RequestMappingHandlerMapping();

		//URL 요청 매핑정보 구성
		RequestMappingInfo mappingInfo = RequestMappingInfo
				 							.paths("/custom_03")
				 							.methods(RequestMethod.GET)
				 							.build();
		//URL 매핑될 매서드를 찾기
		Method method = CustomHandler.class.getMethod("hello", null);

		//요청 매핑정보, 핸들러,매서드 등록
		handlerMapping.registerMapping(mappingInfo, new CustomHandler(), method);

		return handlerMapping;
	}

}

```

---

### handler

> CustomHandler
> 

```
package com.example.app.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class CustomHandler implements Controller{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("CustomHandler's handleRequest...");
		return null;
	}

	public void hello() {
		System.out.println("CustomHandler's hello!!..");
	}

}

```

---

## ex12_scheduled

### scheduled

> Scheduling
> 

```
package com.example.app.scheduled;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
@EnableScheduling
public class Scheduling {

//	@Scheduled(fixedRate = 1000)
//	public void t1() {
//		System.out.println("Scheduling's t1() invoke...");
//	}

//	@Scheduled(cron = "*/3 * * * * *")
//	public void t2() {
//		System.out.println("Scheduling's t2() invoke...");
//	}

}

//초(0-59)  분(0-59)  시(0-23)  일(1-31)  월(1-12)  요일(0-6)
//매 초마다 실행: "* * * * * *"
//매 시간의 30분마다 실행: "0 30 * * * *"
//매일 오전 8시 30분마다 실행: "0 30 8 * * *"
//매주 월요일 아침 9시 30분마다 실행: "0 30 9 * * 1"
//매월 1일 아침 4시 30분마다 실행: "0 30 4 1 * *"
//매주 월요일부터 금요일까지 아침 10시마다 실행: "0 0 10 * * 1-5"

```

---

## ex13_aop

### aop

> LoggingAdvice
> 

```
package com.example.app.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Aspect
@Component
@Slf4j
public class LoggingAdvice {

	//"execution(* com.example.ex01.domain.service.simpleServiceImpl.get1())"
	// execution : 메서드 실행
	// * 		 : 모든 리턴 타입
	// com.example.ex01.domain.service.simpleServiceImpl.get1() : 함수명

	@Before("execution(boolean com.example.app.domain.service.MemoServiceImpl.registrationMemo(..) )")
	public void logginBefore(JoinPoint joinPoint) {
		log.info("[AOP] BEFORE..." + joinPoint);
	}
	@Before("execution(* com.example.app.domain.service.UserServiceImpl.*(..) )")
	public void logginBeforee(JoinPoint joinPoint) {
		log.info("[AOP] BEFORE..." + joinPoint);
	}

	@After("execution(* com.example.app.domain.service.MemoServiceImpl.getAllMemo() )")
	public void loggingAfter(JoinPoint joinPoint) {
		log.info("[AOP] AFTER..." + joinPoint);
		log.info("[AOP] AFTER..." + joinPoint.getTarget());
		log.info("[AOP] AFTER..." + joinPoint.getSignature());
		log.info("[AOP] AFTER..." + joinPoint.getSignature().getName());
	}

	@Around("execution(* com.example.app.domain.service.*.*(..))")
	public Object loggingAround(ProceedingJoinPoint pjp) throws Throwable {
		//이전시점
		log.info("[AOP] AROUND BEFORE");
		long startTime = System.currentTimeMillis();
		//MVC흐름대로 진행
		Object isUpdated = (Object)pjp.proceed();
		//이후시점
		log.info("[AOP] AROUND AFTER");
		long endTime = System.currentTimeMillis();
		log.info("[AOP] TIME : "+(endTime-startTime) + " ms");

		return isUpdated;
	}

}

```

---

### controller

> MemoController
> 

```
package com.example.app.controller;

import java.beans.PropertyEditorSupport;
import java.io.FileNotFoundException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.app.domain.dto.MemoDto;
import com.example.app.domain.service.MemoServiceImpl;
import com.example.app.domain.service.UserServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/memo")
public class MemoController {

	@Autowired
	private MemoServiceImpl memoServiceImpl;

//	@Autowired
//	private UserServiceImpl userService;
//

//	@InitBinder
//	public void dataBinder(WebDataBinder webDataBinder) {
//		log.info("MemoController's dataBinder ..." + webDataBinder);
//		webDataBinder.registerCustomEditor(LocalDate.class, "dateTest", new DateTestEditor());
//	}

	@GetMapping("/ex")
	public void ex1_1() throws FileNotFoundException{
		log.info("GET -");
		throw new FileNotFoundException("파일을 찾을수가 없습니다.");
	}

	@GetMapping("/add")
	public void add_get(MemoDto dto) throws SQLException {
		log.info("GET /memo/add...");
		memoServiceImpl.registrationMemo(dto);
	}

	@PostMapping("/add")
	public void add_post(@Valid MemoDto dto,BindingResult bindingResult,Model model) throws Exception {
		log.info("POST /memo/add..."+dto);

		if(bindingResult.hasErrors()) {
//			log.info("유효성 에러발생 : " + bindingResult.getFieldError("id").getDefaultMessage());

			for(FieldError error : bindingResult.getFieldErrors()) {
				log.info("Error Field : "+error.getField()+" Error Msg : "+error.getDefaultMessage());
				model.addAttribute(error.getField(),error.getDefaultMessage());
			}

			return ;
		}
		//서비스
		boolean isAdded =  memoServiceImpl.registrationMemo(dto);
		//memoServiceImpl.addMemoTx(dto);

	}

	// static private
	private static class DateTestEditor extends PropertyEditorSupport {

		@Override
		public void setAsText(String dateTest) throws IllegalArgumentException {
			log.info("DateTestEditor's setAsText invoke.." + dateTest);
			LocalDate date = null;
			if(dateTest.isEmpty()) {
				date = LocalDate.now();
			}else {
				//yyyy#MM#dd -> yyyy-MM-dd(LocalDate format)
				dateTest = dateTest.replaceAll("#", "-");
				date = LocalDate.parse(dateTest,DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			}

			setValue(date);

		}
	}
	//
	@GetMapping("/rest")
	public void rest() {
		log.info("GET /rest...");
	}

}

```

---

> UserController
> 

```
package com.example.app.controller;

import java.beans.PropertyEditorSupport;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.app.domain.dto.UserDto;
import com.example.app.domain.service.UserServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UserController {

	@Autowired
	private UserServiceImpl userService;

	@InitBinder
	public void dataBinder(WebDataBinder webDataBinder) {
		log.info("UserController dataBinder ..." + webDataBinder);
		webDataBinder.registerCustomEditor(String.class, "phone", new PhoneEditor());
		webDataBinder.registerCustomEditor(LocalDate.class, "birthday", new BirthdayEditor());
	}

	@GetMapping("/join")
	public void join() {
		log.info("GET /join..");
	}
	@PostMapping("/join")
	public void join_post(@Valid UserDto dto,BindingResult bindingResult,Model model) {
		log.info("POST /join.." + dto);

		for(FieldError error : bindingResult.getFieldErrors()) {
			log.info("Error Field : "+error.getField()+" Error Msg : "+error.getDefaultMessage());
			model.addAttribute(error.getField(),error.getDefaultMessage());
		}
	}

	private static class PhoneEditor extends PropertyEditorSupport {

		@Override
		public void setAsText(String text) throws IllegalArgumentException {
			text=text.replaceAll("-", "");
			setValue(text);
		}

	}

	private static class BirthdayEditor extends PropertyEditorSupport{

		@Override
		public void setAsText(String text) throws IllegalArgumentException {
			LocalDate date = null;
			if(text.isEmpty()) {
				date = LocalDate.now();
			}else {
				//yyyy#MM#dd -> yyyy-MM-dd(LocalDate format)
				text = text.replaceAll("~", "-");
				date = LocalDate.parse(text,DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			}

			setValue(date);
		}
	}
}

```

---

### service

> MemoServiceImpl
> 

```
package com.example.app.domain.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.app.domain.dto.MemoDto;
import com.example.app.domain.mapper.MemoMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemoServiceImpl {

//	@Autowired
//	private MemoDaoImpl memoDaoIistrationMemo(MemoDto memoDto) throws SQLException {
//
//		int result =  memoDaoImpl.insert(memoDto);
//
//		return result>0;
//	}

	@Autowired
	private MemoMapper memoMapper;

	public boolean registrationMemo(MemoDto memoDto) throws SQLException{

		System.out.println("MemoServiceImpl's registrationMemo() invoke..");
		int result = memoMapper.insert(memoDto);

		return result>0;
	}

	//전체메모가져오기
	public List<MemoDto> getAllMemo(){
		log.info("MemoService's getAllMemo Call! ");
		return  memoMapper.selectAll();
	}

	//메모작성
	@Transactional(rollbackFor = Exception.class)
	public void addMemoTx(MemoDto dto)	 {
		log.info("MemoService's addMemoTx Call! ");
		int id=dto.getId();
		memoMapper.insert(dto);		//01 정상INSERT
		dto.setId(id);				//PK오류 발생예정인 dto
		memoMapper.insert(dto);		//02	PK오류 발생!!
	}

	@Transactional(rollbackFor = Exception.class)
	public MemoDto getMemo(int id) {

		return memoMapper.selectAt(id);

	}
	@Transactional(rollbackFor = Exception.class)
	public void modifyMemo(MemoDto dto) {
		memoMapper.update(dto);
	}

	@Transactional(rollbackFor = Exception.class)
	public void removeMemo(int id) {
		memoMapper.delete(id);
	}

}

```

---

> UserServiceImpl
> 

```
package com.example.app.domain.service;

import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class UserServiceImpl {

	public void test1() {
		System.out.println("TEST");
	}
}

```

---