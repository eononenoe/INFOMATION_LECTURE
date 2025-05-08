## INIT
### config
> DataSourceConfig
```java
package com.example.demo.config;

import com.zaxxer.hikari.HikariDataSource;
import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

@Configuration
public class DataSourceConfig {
	// Spring-jdbc DataSource	
//	@Bean
//	public DataSource dataSource2()
//	{
////		DriverManagerDataSource dataSource = new DriverManagerDataSource();
//		BasicDataSource dataSource = new BasicDataSource();
//		dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
//		dataSource.setUrl("jdbc:mysql://localhost:3306/testdb");
//		dataSource.setUsername("root");
//		dataSource.setPassword("1234");
//
//		dataSource.setInitialSize(5);//초기 연결개수
//		dataSource.setMaxTotal(10);//최대 연결 개수
//		dataSource.setMaxIdle(8);//최대 유휴 연결 수
//		dataSource.setMinIdle(3);//최소 유휴 연결 수
//
//		return dataSource;
//	}
//	HikariCP DataSource
	@Bean
	public HikariDataSource dataSource()
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
```java
package com.example.demo.config;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import javax.sql.DataSource;

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
## PARAM
### controller
> ExceptionTestController
```java
package com.example.demo.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.FileNotFoundException;

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
> HomeController
```java
package com.example.demo.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@Slf4j
public class HomeController {

    @GetMapping(value = "/")
    public String home(){

        log.info("GET /");
        return "index";
    }
}
```
---
> MemoController
```java
package com.example.demo.controller;


import com.example.demo.domain.dto.MemoDto;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.beans.PropertyEditorSupport;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Controller
@Slf4j
@RequestMapping("/memo")
public class MemoController {
	
	@InitBinder
	public void dataBinder(WebDataBinder webDataBinder) {
		log.info("MemoController's dataBinder ..." + webDataBinder);
		webDataBinder.registerCustomEditor(LocalDate.class, "dateTest", new DateTestEditor());
	}
	
	
	@GetMapping("/add")
	public void add_get() {
		log.info("GET /memo/add...");
	}

	@PostMapping("/add")
	public void add_post(@Valid MemoDto dto, BindingResult bindingResult, Model model) {
		log.info("POST /memo/add..."+dto);
		
		if(bindingResult.hasErrors()) {
//			log.info("유효성 에러발생 : " + bindingResult.getFieldError("id").getDefaultMessage());
			
			for(FieldError error : bindingResult.getFieldErrors()) {
				log.info("Error Field : "+error.getField()+" Error Msg : "+error.getDefaultMessage());
				model.addAttribute(error.getField(),error.getDefaultMessage());
			}
			
		}
		
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

}
```
---
> ParameterTestController
```java
package com.example.demo.controller;


import com.example.demo.domain.dto.PersonDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public void page01(PersonDto dto, Model model) {
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
	public String page05(HttpServletRequest req, HttpServletResponse resp) {
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
## VALIDATION
### exception
> GlobalExceptionHandler
```java
package com.example.demo.controller.exception;


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
### dto
> MemoDto
```java
package com.example.demo.domain.dto;


import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.time.LocalDateTime;

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
	
	private LocalDate dateTest;
}
```
---
> PersonDto
```java
package com.example.demo.domain.dto;

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
## EXCEPTION
### exception
> GlobalExceptionHandler
```java
package com.example.demo.controller.exception;


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
## DATASOURCE
### mapper
> MemoMapper
```java
package com.example.demo.domain.mapper;

import com.example.demo.domain.dto.MemoDto;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;


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
	
////	XML방식
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
### repository
> BookRepository
```java
package com.example.demo.domain.repository;

import com.example.demo.domain.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookRepository extends JpaRepository<Book,Long>{
    List<Book> findByBookName(String bookName);
    List<Book> findByPublisher(String publisher);
    List<Book> findByIsbn(String isbn);
    Book findByBookNameAndIsbn(String bookName, String isbn);
    List<Book> findByBookNameContains(String keyword);

    int countByBookName(String bookName);
    int countByBookNameContains(String bookName);
    //삭제
    void deleteByBookName(String bookname);

    //명명규칙 참고
// 07 JPA 명명규칙 확인 ------------------------------
//    // 책 이름으로 책 검색
//    List<Book> findByBookname(String bookname);
//    // 출판사로 책 검색
//    List<Book> findByPublisher(String publisher);
//    // ISBN으로 책 검색
//    Book findByIsbn(String isbn);
//    // 책 코드 범위로 책 검색
//    List<Book> findByBookcodeBetween(long start, long end);
//
//    // 책 이름이나 출판사로 책 검색
//    List<Book> findByBooknameOrPublisher(String bookname, String publisher);
//
//    // 책 이름이나 출판사로 책 검색, 정렬하여 가져오기
//    List<Book> findByBooknameOrPublisherOrderByBooknameAsc(String bookname, String publisher);
//
//    // 책 이름에 특정 문자열이 포함된 책 검색
//    List<Book> findByBooknameContaining(String keyword);
//
//    // 출판사가 특정 문자열로 시작하는 책 검색
//    List<Book> findByPublisherStartingWith(String prefix);
//
//    // 책 이름으로 책 개수 가져오기
//    int countByBookname(String bookname);
//
//    // 출판사로 책 개수 가져오기
//    int countByPublisher(String publisher);
//
//    // 책 이름으로 책 삭제
//    void deleteByBookname(String bookname);
// 07 JPA 명명규칙 확인  끝-----------------------------

}
```
---
> LendRepository
```java
package com.example.demo.domain.repository;

import com.example.demo.domain.entity.Lend;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LendRepository extends JpaRepository<Lend,Long> {
}
```
---
> UserRepository
```java
package com.example.demo.domain.repository;

import com.example.demo.domain.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User,String> {
    @Query("SELECT u FROM User AS u WHERE u.role=?1")
    List<User> selectByRole(String role);

    @Query("SELECT u FROM User AS u WHERE u.role=?1 and u.password=?2")
    List<User> selectByRoleAndPassword(String role, String password);

    @Query("SELECT u FROM User AS u WHERE u.password=:password")
    List<User> selectByPassword(@Param("password") String pw);

    @Query("SELECT u FROM User u WHERE u.username LIKE CONCAT('%',:username,'%')")
    List<User> selectAllLikeUsername(@Param("username") String username);

}
```
---
## JPA_ENTITY
### entity
> Book
```java
package com.example.demo.domain.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="book")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Book {
    @Id
//  @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="bookcode")
    private Long bookCode;
    @Column(name="bookname")
    private String bookName;
    private String publisher;
    private String isbn;
}
```
---
> Lend
```java
package com.example.demo.domain.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="lend")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Lend {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "bookcode", foreignKey = @ForeignKey(name="FK_LEND_BOOK",
            foreignKeyDefinition = "FOREIGN KEY(bookcode) REFERENCES book(bookcode) ON DELETE CASCADE ON UPDATE CASCADE" ))
    private Book book;

    @ManyToOne
    @JoinColumn(name = "username", foreignKey = @ForeignKey(name="FK_LEND_USER",
            foreignKeyDefinition = "FOREIGN KEY(username) REFERENCES user(username) ON DELETE CASCADE ON UPDATE CASCADE" ))
    private User user;


}
```
---
> User
```java
package com.example.demo.domain.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="user")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {
    @Id
    @Column(length=100)
    private String username;
    @Column(length=255,nullable = false)
    private String password;
    @Column(length=255)
    private String role;
}
```
---