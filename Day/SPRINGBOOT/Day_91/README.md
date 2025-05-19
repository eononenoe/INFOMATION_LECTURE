## 01_INIT
### auth
> PrincipalDetails.java
```java
package com.example.demo.config.auth;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.example.demo.domain.dto.UserDto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PrincipalDetails implements UserDetails{
	private UserDto userDto;

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection <GrantedAuthority> authorities = new ArrayList();
		authorities.add(new SimpleGrantedAuthority(userDto.getRole()));
		return authorities;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return userDto.getPassword();
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return userDto.getUsername();
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}
	
}
```
---
> PrincipalDetailsService.java
```java
package com.example.demo.config.auth;

import com.example.demo.domain.dto.UserDto;
import com.example.demo.domain.entity.User;
import com.example.demo.domain.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import lombok.extern.slf4j.Slf4j;

import java.util.Optional;

@Service
@Slf4j
public class PrincipalDetailsService implements UserDetailsService{

	@Autowired
	private UserRepository userRepository;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		System.out.println("loadUserByUsername .. " + username);
		Optional<User> userOption  = userRepository.findById(username);
		if(userOption.isEmpty())
			throw new UsernameNotFoundException(username + " 존재하지 않는 계정입니다.");

		//entity-> dto
		UserDto userDto = UserDto.toDto( userOption.get()    );
		return new PrincipalDetails(userDto);
	}

}
```
---
### config
> DataSourceConfig.java
```java
package com.example.demo.config;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
public class DataSourceConfig {

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
> JpaConfig.java
```java
package com.example.demo.config;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.init.DataSourceInitializer;
import org.springframework.jdbc.datasource.init.DatabasePopulator;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;

import javax.sql.DataSource;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

@Configuration
@EntityScan(basePackages = {"com.example.demo.domain.entity"})
@EnableJpaRepositories
(
                basePackages ="com.example.demo.domain.repository",
                transactionManagerRef = "jpaTransactionManager"
)
public class JpaConfig {
    @Autowired
    private DataSource dataSource;

    @Bean
    LocalContainerEntityManagerFactoryBean entityManagerFactory() {
        LocalContainerEntityManagerFactoryBean entityManagerFactoryBean = new LocalContainerEntityManagerFactoryBean();
        entityManagerFactoryBean.setDataSource(dataSource);
        entityManagerFactoryBean.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
        entityManagerFactoryBean.setPackagesToScan("com.example.demo.domain.entity");

        Properties jpaProperties = new Properties();


        Map<String, Object> properties = new HashMap<>();
        properties.put("hibernate.hbm2ddl.auto", "update");                         // 필요에 따라 'create', 'validate' 등으로 변경
        properties.put("hibernate.dialect", "org.hibernate.dialect.MySQLDialect"); // 사용 중인 DB에 맞게 변경
        properties.put("hibernate.show_sql", true);
        properties.put("hibernate.format_sql", true);

        properties.put("hibernate.hibernate.jdbc.batch_size", 1000);
        properties.put("hibernate.hibernate.order_inserts", true);
        properties.put("hibernate.order_updates", true);
        properties.put("hibernate.jdbc.batch_versioned_data", true);
        entityManagerFactoryBean.setJpaPropertyMap(properties);

        return entityManagerFactoryBean;
    }


    //애플리케이션 시작 시 데이터베이스 초기화
//    @Bean
//    public DataSourceInitializer dataSourceInitializer() {
//        DataSourceInitializer initializer = new DataSourceInitializer();
//        initializer.setDataSource(dataSource);
//        initializer.setDatabasePopulator(databasePopulator());
//        return initializer;
//    }

    //schema.sql과 data.sql 스크립트를 실행
//    private DatabasePopulator databasePopulator() {
//        //Spring Framework에서 제공하는 클래스로, 외부 리소스에 정의된 SQL 스크립트를 사용하여 데이터베이스를 초기화하거나 정리하는 데 사용
//        ResourceDatabasePopulator populator = new ResourceDatabasePopulator();
//        //src/main/resources 디렉토리에 위치한 SQL 스크립트를 로드
//        Resource schemaScript = new ClassPathResource("schema.sql");
//        Resource dataScript = new ClassPathResource("data.sql");
//        populator.addScript(schemaScript);
//        populator.addScript(dataScript);
//        return populator;
//    }

}
```
---
> SecurityConfig.java
```java
package com.example.demo.config;


import com.example.demo.config.auth.exceptionHandler.CustomAccessDeniedHandler;
import com.example.demo.config.auth.exceptionHandler.CustomAuthenticationEntryPoint;
import com.example.demo.config.auth.loginHandler.CustomLoginFailureHandler;
import com.example.demo.config.auth.loginHandler.CustomLoginSuccessHandler;
import com.example.demo.config.auth.logoutHandler.CustomLogoutHandler;
import com.example.demo.config.auth.logoutHandler.CustomLogoutSuccessHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Autowired
	private CustomLoginSuccessHandler customLoginSuccessHandler;
	@Autowired
	private CustomLogoutHandler customLogoutHandler;
	@Autowired
	private CustomLogoutSuccessHandler customLogoutSuccessHandler;


	@Bean
	protected SecurityFilterChain configure(HttpSecurity http) throws Exception {
		//CSRF비활성화
		http.csrf((config)->{config.disable();});
		//CSRF토큰 쿠키형태로 전달
//		http.csrf().csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse());
		//권한체크
		http.authorizeHttpRequests((auth)->{
			auth.requestMatchers("/","/join","/login").permitAll();
			auth.requestMatchers("/user").hasRole("USER");
			auth.requestMatchers("/manager").hasRole("MANAGER");
			auth.requestMatchers("/admin").hasRole("ADMIN");
			auth.anyRequest().authenticated();
		});

		//로그인
		http.formLogin((login)->{
			login.permitAll();
			login.loginPage("/login");
			login.successHandler(customLoginSuccessHandler);
			login.failureHandler(new CustomLoginFailureHandler());
		});
		//로그아웃
		http.logout((logout)->{
			logout.permitAll();
			logout.addLogoutHandler(customLogoutHandler);
			logout.logoutSuccessHandler(customLogoutSuccessHandler);
		});
		//예외처리

		http.exceptionHandling((ex)->{
			ex.authenticationEntryPoint(new CustomAuthenticationEntryPoint());
			ex.accessDeniedHandler(new CustomAccessDeniedHandler());
		});

		return http.build();
		
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

}
```
---
> TxConfig.java
```java
package com.example.demo.config;

import jakarta.persistence.EntityManagerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

@Configuration
@EnableTransactionManagement
public class TxConfig {
    @Autowired
    private DataSource dataSource;

//    // 기본 TransactionManager
//    @Bean(name = "dataSourceTransactionManager")
//    public DataSourceTransactionManager transactionManager2() {
//        //System.out.println("TX dataSrouce2 : " + dataSource2.toString());
//        return new DataSourceTransactionManager(dataSource);
//    }


    //    JPA TransactionManager Settings
    @Bean(name="jpaTransactionManager")
    public JpaTransactionManager jpaTransactionManager(EntityManagerFactory entityManagerFactory) {
        JpaTransactionManager transactionManager = new JpaTransactionManager();
        transactionManager.setEntityManagerFactory(entityManagerFactory);
        transactionManager.setDataSource(dataSource);

        return transactionManager;
    }

}
```
---
### controller
> HomeController.java
```java
package com.example.demo.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@Slf4j
public class HomeController {

    @GetMapping("/")
    public String home(){
        log.info("GET /...");
        return "home";
    }
}
```
---
> UserController.java
```java
package com.example.demo.controller;

import java.beans.PropertyEditorSupport;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import com.example.demo.domain.dto.UserDto;
import com.example.demo.domain.entity.User;
import com.example.demo.domain.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UserController {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@GetMapping("/login")
	public void login() {
		log.info("GET /login...");
	}
	
//	@GetMapping("/user")
//	public void user(Authentication authentication) {
//		log.info("GET /user..." + authentication);
//		log.info("name..." + authentication.getName());
//		log.info("principal..." + authentication.getPrincipal());
//		log.info("authorities..." + authentication.getAuthorities());
//		log.info("details..." + authentication.getDetails());
//		log.info("credential..." + authentication.getCredentials());
//	}
	
//	@GetMapping("/user")
//	public void user(@AuthenticationPrincipal Principal principal) {
//		log.info("GET /user..." + principal);
//	}
	
	@GetMapping("/user")
	public void user(Model model) {
		log.info("GET /user...");
		Authentication authenticaton = 
		SecurityContextHolder.getContext().getAuthentication();
		log.info("authentication : " + authenticaton);
		
		model.addAttribute("auth",authenticaton);
		
	}
	
	@GetMapping("/manager")
	public void manager() {
		log.info("GET /manager...");	
	}
	@GetMapping("/admin")
	public void admin() {
		log.info("GET /admin...");	
	}
	
	
	
	@GetMapping("/join")
	public void join() {
		log.info("GET /join..");
	}

	@PostMapping("/join")
	public String join_post(UserDto dto, RedirectAttributes redirectAttributes ) {
		log.info("POST /join.." + dto);

		//DTO->ENTITY(DB저장) , ENTITY->DTO(뷰로전달)
		dto.setPassword(  passwordEncoder.encode( dto.getPassword() ) );
		userRepository.save(dto.toEntity());

		boolean isJoin  = true;
		if(isJoin) {
			redirectAttributes.addFlashAttribute("message","회원가입 완료!");
			return "redirect:/login";
		}
		else
			return "join";
	}

}
```
---
### demo
> DemoApplication.java
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
> DemoApplicationTests.java
```java
package com.example.demo;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class DemoApplicationTests {

	@Test
	void contextLoads() {
	}

}
```
---
### dto
> UserDto.java
```java
package com.example.demo.domain.dto;

import java.time.LocalDate;

import com.example.demo.domain.entity.User;
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
	private String username;
	private String password;
	private String role;
	//DTO->ENTITY
	public User toEntity(){
		return User.builder()
				.username(this.username)
				.password(this.password)
				.role("ROLE_USER")
				.build();
	}
	//ENTITY->DTO
	public static UserDto toDto(User user){
		return UserDto.builder()
					.username(user.getUsername())
					.password(user.getPassword())
					.role(user.getRole())
					.build();
	}
}
```
---
### entity
> User.java
```java
package com.example.demo.domain.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class User {
	@Id
	private String username;
	private String password;
	private String role;
}
```
---
### exceptionHandler
> CustomAccessDeniedHandler.java
```java
package com.example.demo.config.auth.exceptionHandler;


import java.io.IOException;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
                       AccessDeniedException accessDeniedException) throws IOException, ServletException {
		log.error("CustomAccessDeniedHandler's handle invoke..");
		response.sendRedirect(request.getContextPath()+"/login?error="+accessDeniedException.getMessage());

	}

}
```
---
> CustomAuthenticationEntryPoint.java
```java
package com.example.demo.config.auth.exceptionHandler;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import lombok.extern.slf4j.Slf4j;

import lombok.extern.slf4j.Slf4j;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
                         AuthenticationException authException) throws IOException, ServletException {

		log.error("CustomAuthenticationEntryPoint's commence invoke....");
		response.sendRedirect("/login?error="+authException.getMessage());
	}

}
```
---
### loginHandler
> CustomLoginFailureHandler.java
```java
package com.example.demo.config.auth.loginHandler;

import java.io.IOException;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {

		log.error("CustomLoginFailureHandler's onAuthenticationFailure invoke..") ;
		response.sendRedirect(request.getContextPath()+"/login?error="+exception.getMessage());
	}



}
```
---
> CustomLoginSuccessHandler.java
```java
package com.example.demo.config.auth.loginHandler;

import java.io.IOException;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {

		log.info("CustomLoginSuccessHandler's onAuthenticationSuccess invoke..");

		response.sendRedirect(request.getContextPath()+"/");

	}

}
```
---
### logoutHandler
> CustomLogoutHandler.java
```java
package com.example.demo.config.auth.logoutHandler;



import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutHandler;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class CustomLogoutHandler implements LogoutHandler {

	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {

		log.info("CustomLogoutHandler's logout invoke");

		HttpSession session =  request.getSession();
		if(session!=null)
			session.invalidate();

	}

}
```
---
> CustomLogoutSuccessHandler.java
```java
package com.example.demo.config.auth.logoutHandler;

import java.io.IOException;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {

	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		log.info("CustomLogoutSuccessHandler onLogoutSuccess invoke..");
		response.sendRedirect(request.getContextPath()+"/");
	}

}
```
---
### repository
> UserRepository.java
```java
package com.example.demo.domain.repository;

import com.example.demo.domain.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User,String> {
}
```
---
### templates
> admin.html
```html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>ADMIN</h1>
	
	<a href="/logout">로그아웃</a>
</body>
</html>
```
---
> home.html
```html
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>HOME</h1>

</body>
</html>
```
---
> join.html
```html
<!DOCTYPE html>
<html xmlns:th="http://www.w3.org/1999/xhtml">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="/join" method="post">
		<div>
			<h1>회원가입</h1>
		</div>
		<div>
			<label>username : </label><span style="color:red;font-size:.7rem;" th:text="${username}"></span><br>
			<input name="username" />
		</div>
		<div>
			<label>password : </label><span style="color:red;font-size:.7rem;" th:text="${password}"></span><br>
			<input name="password" />
		</div>
		<div>
			<input type="submit" value="회원가입" />
		</div>

	
	</form>
</body>
</html>
```
---
> login.html
```html
<!DOCTYPE html>
<html xmlns:th="http://www.w3.org/1999/xhtml">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>LOGIN</h1>
	<form action="/login" method="post">
		<div>
			<label>USERNAME : </label>
			<input name="username" />
		</div>
		<div>
			<label>PASSWORD :</label>
			<input name="password" type="password"/>
		</div>
		<button>로그인</button>
<!--		 <input type="hidden" name="_csrf" value="${_csrf.token}" /> -->
	</form>
	<span th:text="${message}"></span>
	<span th:text="${param.error}"></span>


	
</body>
</html>
```
---
> manager.html
```html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>MANAGER</h1>
	
	<a href="/logout">로그아웃</a>
</body>
</html>
```
---
> user.html
```html
<!DOCTYPE html>
<html xmlns:th="http://www.w3.org/1999/xhtml">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>USER</h1>
	
	
	<div>
		auth :  <span th:text="${auth}"></span>
	</div>
	<a href="/logout">로그아웃</a>
</body>
</html>
```
---

## 02_OAUTH2
### auth
> PrincipalDetails.java
```java
package com.example.demo.config.auth;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.example.demo.domain.dto.UserDto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.oauth2.core.user.OAuth2User;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PrincipalDetails implements UserDetails,OAuth2User {
	private UserDto userDto;
	public PrincipalDetails(UserDto userDto){
		this.userDto = userDto;
	}
	//----------------------------
	// OAuth2User
	//----------------------------
	Map<String, Object> attributes;
	String access_token;
	@Override
	public Map<String, Object> getAttributes() {
		return attributes;
	}
	@Override
	public String getName() {
		return userDto.getUsername();
	}
	//----------------------------


	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection <GrantedAuthority> authorities = new ArrayList();
		authorities.add(new SimpleGrantedAuthority(userDto.getRole()));
		return authorities;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return userDto.getPassword();
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return userDto.getUsername();
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}


}
```
---
> PrincipalDetailsOAuth2Service.java
```java
package com.example.demo.config.auth;

import com.example.demo.config.auth.provider.GoogleUserInfo;
import com.example.demo.config.auth.provider.KakaoUserInfo;
import com.example.demo.config.auth.provider.NaverUserInfo;
import com.example.demo.config.auth.provider.OAuth2UserInfo;
import com.example.demo.domain.dto.UserDto;
import com.example.demo.domain.entity.User;
import com.example.demo.domain.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.util.Map;
import java.util.Optional;

@Service
public class PrincipalDetailsOAuth2Service extends DefaultOAuth2UserService {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
//        System.out.println("PrincipalDetailsOAuth2Service's loadUser invoke..");
//        System.out.println("userRequest : " + userRequest);
//        System.out.println("userRequest.getClientRegistration() :"+ userRequest.getClientRegistration());
//        System.out.println("userRequest.getAccessToken() : "+ userRequest.getAccessToken());
//        System.out.println("userRequest.getAdditionalParameters() : "+ userRequest.getAdditionalParameters());
//        System.out.println("userRequest.getAccessToken().getTokenValue() : "+ userRequest.getAccessToken().getTokenValue());
//        System.out.println("userRequest.getAccessToken().getTokenType().getValue() : "+ userRequest.getAccessToken().getTokenType().getValue());
//        System.out.println("userRequest.getAccessToken().getScopes() : "+ userRequest.getAccessToken().getScopes());

        //OAuth2UserInfo
        OAuth2User oAuth2User = super.loadUser(userRequest);
        System.out.println("oAuth2User : " + oAuth2User);
        System.out.println("getAttributes : " + oAuth2User.getAttributes());

        OAuth2UserInfo oAuth2UserInfo = null;
        //'kakao','naver','google','in-'
        String provider = userRequest.getClientRegistration().getRegistrationId();

        Map<String,Object> attributes = oAuth2User.getAttributes();
        if(provider.startsWith("kakao")) {
            //카카오 로그인시
            Long id = (Long)attributes.get("id");
            LocalDateTime connected_at = OffsetDateTime.parse( attributes.get("connected_at").toString() ).toLocalDateTime();
            Map<String,Object> properties = (Map<String,Object>)attributes.get("properties");
            Map<String,Object> kakao_account = (Map<String,Object>) attributes.get("kakao_account");
            System.out.println("id :" + id);
            System.out.println("connected_at :" + connected_at);
            System.out.println("properties :" + properties);
            System.out.println("kakao_account :" + kakao_account);
            oAuth2UserInfo = new KakaoUserInfo(id,connected_at,properties,kakao_account);

        }else if(provider.startsWith("naver")){
            //네이버 로그인시
            Map<String,Object> response = (Map<String,Object>)attributes.get("response");
            String id = (String)response.get("id");
            oAuth2UserInfo = new NaverUserInfo(id,response);

        }else if(provider.startsWith("google")){
            String id = (String)attributes.get("sub");
            oAuth2UserInfo = new GoogleUserInfo(id,attributes);
        }

        //구글 로그인시
        System.out.println("oAuth2UserInfo : " + oAuth2UserInfo);



        //최초 로그인시 로컬계정 DB 저장 처리
        String username = oAuth2UserInfo.getProvider()+"_"+oAuth2UserInfo.getProviderId();
        String password = passwordEncoder.encode("1234");
        Optional<User> userOptional =  userRepository.findById(username);
        //UserDto 생성 (이유 : PrincipalDetails에 포함)
        //UserEntity 생성(이유 : 최초 로그인시 DB 저장용도)
        UserDto userDto =null;
        if(userOptional.isEmpty()){
            //최초 로그인(Dto , Entity)
            userDto = UserDto   .builder()
                                .username(username)
                                .password(password)
                                .role("ROLE_USER")
                                .build();
            User user = userDto.toEntity();
            userRepository.save(user);  //계정 등록

        }else{
            //기존 유저 존재(Dto)
            User user = userOptional.get();
            userDto = UserDto.toDto(user);
        }


        // PrincipalDetails 전달
        PrincipalDetails principalDetails = new PrincipalDetails();
        userDto.setProvider(provider);
        userDto.setProviderId(oAuth2UserInfo.getProviderId());
        principalDetails.setUserDto(userDto);
        principalDetails.setAttributes(oAuth2User.getAttributes());
        principalDetails.setAccess_token(userRequest.getAccessToken().getTokenValue());
        return principalDetails;

    }
}
```
---
> PrincipalDetailsService.java
```java
package com.example.demo.config.auth;

import com.example.demo.domain.dto.UserDto;
import com.example.demo.domain.entity.User;
import com.example.demo.domain.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import lombok.extern.slf4j.Slf4j;

import java.util.Optional;

@Service
@Slf4j
public class PrincipalDetailsService implements UserDetailsService{

	@Autowired
	private UserRepository userRepository;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		System.out.println("loadUserByUsername .. " + username);
		Optional<User> userOption  = userRepository.findById(username);
		if(userOption.isEmpty())
			throw new UsernameNotFoundException(username + " 존재하지 않는 계정입니다.");

		//entity-> dto
		UserDto userDto = UserDto.toDto( userOption.get()    );
		return new PrincipalDetails(userDto);
	}

}
```
---
### config
> DataSourceConfig.java
```java
package com.example.demo.config;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
public class DataSourceConfig {

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
> JpaConfig.java
```java
package com.example.demo.config;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.init.DataSourceInitializer;
import org.springframework.jdbc.datasource.init.DatabasePopulator;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;

import javax.sql.DataSource;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

@Configuration
@EntityScan(basePackages = {"com.example.demo.domain.entity"})
@EnableJpaRepositories
(
                basePackages ="com.example.demo.domain.repository",
                transactionManagerRef = "jpaTransactionManager"
)
public class JpaConfig {
    @Autowired
    private DataSource dataSource;

    @Bean
    LocalContainerEntityManagerFactoryBean entityManagerFactory() {
        LocalContainerEntityManagerFactoryBean entityManagerFactoryBean = new LocalContainerEntityManagerFactoryBean();
        entityManagerFactoryBean.setDataSource(dataSource);
        entityManagerFactoryBean.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
        entityManagerFactoryBean.setPackagesToScan("com.example.demo.domain.entity");

        Properties jpaProperties = new Properties();


        Map<String, Object> properties = new HashMap<>();
        properties.put("hibernate.hbm2ddl.auto", "update");                         // 필요에 따라 'create', 'validate' 등으로 변경
        properties.put("hibernate.dialect", "org.hibernate.dialect.MySQLDialect"); // 사용 중인 DB에 맞게 변경
        properties.put("hibernate.show_sql", true);
        properties.put("hibernate.format_sql", true);

        properties.put("hibernate.hibernate.jdbc.batch_size", 1000);
        properties.put("hibernate.hibernate.order_inserts", true);
        properties.put("hibernate.order_updates", true);
        properties.put("hibernate.jdbc.batch_versioned_data", true);
        entityManagerFactoryBean.setJpaPropertyMap(properties);

        return entityManagerFactoryBean;
    }


    //애플리케이션 시작 시 데이터베이스 초기화
//    @Bean
//    public DataSourceInitializer dataSourceInitializer() {
//        DataSourceInitializer initializer = new DataSourceInitializer();
//        initializer.setDataSource(dataSource);
//        initializer.setDatabasePopulator(databasePopulator());
//        return initializer;
//    }

    //schema.sql과 data.sql 스크립트를 실행
//    private DatabasePopulator databasePopulator() {
//        //Spring Framework에서 제공하는 클래스로, 외부 리소스에 정의된 SQL 스크립트를 사용하여 데이터베이스를 초기화하거나 정리하는 데 사용
//        ResourceDatabasePopulator populator = new ResourceDatabasePopulator();
//        //src/main/resources 디렉토리에 위치한 SQL 스크립트를 로드
//        Resource schemaScript = new ClassPathResource("schema.sql");
//        Resource dataScript = new ClassPathResource("data.sql");
//        populator.addScript(schemaScript);
//        populator.addScript(dataScript);
//        return populator;
//    }

}
```
---
> SecurityConfig.java
```java
package com.example.demo.config;


import com.example.demo.config.auth.exceptionHandler.CustomAccessDeniedHandler;
import com.example.demo.config.auth.exceptionHandler.CustomAuthenticationEntryPoint;
import com.example.demo.config.auth.loginHandler.CustomLoginFailureHandler;
import com.example.demo.config.auth.loginHandler.CustomLoginSuccessHandler;
import com.example.demo.config.auth.logoutHandler.CustomLogoutHandler;
import com.example.demo.config.auth.logoutHandler.CustomLogoutSuccessHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Autowired
	private CustomLoginSuccessHandler customLoginSuccessHandler;
	@Autowired
	private CustomLogoutHandler customLogoutHandler;
	@Autowired
	private CustomLogoutSuccessHandler customLogoutSuccessHandler;


	@Bean
	protected SecurityFilterChain configure(HttpSecurity http) throws Exception {
		//CSRF비활성화
		http.csrf((config)->{config.disable();});
		//CSRF토큰 쿠키형태로 전달
//		http.csrf().csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse());
		//권한체크
		http.authorizeHttpRequests((auth)->{
			auth.requestMatchers("/","/join","/login").permitAll();
			auth.requestMatchers("/user").hasRole("USER");
			auth.requestMatchers("/manager").hasRole("MANAGER");
			auth.requestMatchers("/admin").hasRole("ADMIN");
			auth.anyRequest().authenticated();
		});

		//로그인
		http.formLogin((login)->{
			login.permitAll();
			login.loginPage("/login");
			login.successHandler(customLoginSuccessHandler);
			login.failureHandler(new CustomLoginFailureHandler());
		});
		//로그아웃
		http.logout((logout)->{
			logout.permitAll();
			logout.addLogoutHandler(customLogoutHandler);
			logout.logoutSuccessHandler(customLogoutSuccessHandler);
		});
		//예외처리

		http.exceptionHandling((ex)->{
			ex.authenticationEntryPoint(new CustomAuthenticationEntryPoint());
			ex.accessDeniedHandler(new CustomAccessDeniedHandler());
		});

		//OAUTH2-CLIENT
		http.oauth2Login((oauth2)->{
			oauth2.loginPage("/login");
		});

		return http.build();
		
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

}
```
---
> TxConfig.java
```java
package com.example.demo.config;

import jakarta.persistence.EntityManagerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

@Configuration
@EnableTransactionManagement
public class TxConfig {
    @Autowired
    private DataSource dataSource;

//    // 기본 TransactionManager
//    @Bean(name = "dataSourceTransactionManager")
//    public DataSourceTransactionManager transactionManager2() {
//        //System.out.println("TX dataSrouce2 : " + dataSource2.toString());
//        return new DataSourceTransactionManager(dataSource);
//    }


    //    JPA TransactionManager Settings
    @Bean(name="jpaTransactionManager")
    public JpaTransactionManager jpaTransactionManager(EntityManagerFactory entityManagerFactory) {
        JpaTransactionManager transactionManager = new JpaTransactionManager();
        transactionManager.setEntityManagerFactory(entityManagerFactory);
        transactionManager.setDataSource(dataSource);

        return transactionManager;
    }

}
```
---
### controller
> HomeController.java
```java
package com.example.demo.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@Slf4j
public class HomeController {

    @GetMapping("/")
    public String home(){
        log.info("GET /...");
        return "home";
    }
}
```
---
> UserController.java
```java
package com.example.demo.controller;

import java.beans.PropertyEditorSupport;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import com.example.demo.domain.dto.UserDto;
import com.example.demo.domain.entity.User;
import com.example.demo.domain.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UserController {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@GetMapping("/login")
	public void login() {
		log.info("GET /login...");
	}
	
//	@GetMapping("/user")
//	public void user(Authentication authentication) {
//		log.info("GET /user..." + authentication);
//		log.info("name..." + authentication.getName());
//		log.info("principal..." + authentication.getPrincipal());
//		log.info("authorities..." + authentication.getAuthorities());
//		log.info("details..." + authentication.getDetails());
//		log.info("credential..." + authentication.getCredentials());
//	}
	
//	@GetMapping("/user")
//	public void user(@AuthenticationPrincipal Principal principal) {
//		log.info("GET /user..." + principal);
//	}
	
	@GetMapping("/user")
	public void user(Model model) {
		log.info("GET /user...");
		Authentication authenticaton = 
		SecurityContextHolder.getContext().getAuthentication();
		log.info("authentication : " + authenticaton);
		
		model.addAttribute("auth",authenticaton);
		
	}
	
	@GetMapping("/manager")
	public void manager() {
		log.info("GET /manager...");	
	}
	@GetMapping("/admin")
	public void admin() {
		log.info("GET /admin...");	
	}
	
	
	
	@GetMapping("/join")
	public void join() {
		log.info("GET /join..");
	}

	@PostMapping("/join")
	public String join_post(UserDto dto, RedirectAttributes redirectAttributes ) {
		log.info("POST /join.." + dto);

		//DTO->ENTITY(DB저장) , ENTITY->DTO(뷰로전달)
		dto.setPassword(  passwordEncoder.encode( dto.getPassword() ) );
		userRepository.save(dto.toEntity());

		boolean isJoin  = true;
		if(isJoin) {
			redirectAttributes.addFlashAttribute("message","회원가입 완료!");
			return "redirect:/login";
		}
		else
			return "join";
	}

}
```
---
### demo
> DemoApplication.java
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
> DemoApplicationTests.java
```java
package com.example.demo;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class DemoApplicationTests {

	@Test
	void contextLoads() {
	}

}
```
---
### dto
> UserDto.java
```java
package com.example.demo.domain.dto;

import java.time.LocalDate;

import com.example.demo.domain.entity.User;
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
	private String username;
	private String password;
	private String role;

	//OAUTH2 CLIENT INFO
	private String provider;
	private String providerId;
	//DTO->ENTITY
	public User toEntity(){
		return User.builder()
				.username(this.username)
				.password(this.password)
				.role("ROLE_USER")
				.build();
	}
	//ENTITY->DTO
	public static UserDto toDto(User user){
		return UserDto.builder()
					.username(user.getUsername())
					.password(user.getPassword())
					.role(user.getRole())
					.build();
	}
}
```
---
### entity
> User.java
```java
package com.example.demo.domain.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class User {
	@Id
	private String username;
	private String password;
	private String role;
}
```
---
### exceptionHandler
> CustomAccessDeniedHandler.java
```java
package com.example.demo.config.auth.exceptionHandler;


import java.io.IOException;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
                       AccessDeniedException accessDeniedException) throws IOException, ServletException {
		log.error("CustomAccessDeniedHandler's handle invoke..");
		response.sendRedirect(request.getContextPath()+"/login?error="+accessDeniedException.getMessage());

	}

}
```
---
> CustomAuthenticationEntryPoint.java
```java
package com.example.demo.config.auth.exceptionHandler;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import lombok.extern.slf4j.Slf4j;

import lombok.extern.slf4j.Slf4j;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
                         AuthenticationException authException) throws IOException, ServletException {

		log.error("CustomAuthenticationEntryPoint's commence invoke....");
		response.sendRedirect("/login?error="+authException.getMessage());
	}

}
```
---
### loginHandler
> CustomLoginFailureHandler.java
```java
package com.example.demo.config.auth.loginHandler;

import java.io.IOException;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {

		log.error("CustomLoginFailureHandler's onAuthenticationFailure invoke..") ;
		response.sendRedirect(request.getContextPath()+"/login?error="+exception.getMessage());
	}



}
```
---
> CustomLoginSuccessHandler.java
```java
package com.example.demo.config.auth.loginHandler;

import java.io.IOException;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {

		log.info("CustomLoginSuccessHandler's onAuthenticationSuccess invoke..");

		response.sendRedirect(request.getContextPath()+"/");

	}

}
```
---
### logoutHandler
> CustomLogoutHandler.java
```java
package com.example.demo.config.auth.logoutHandler;



import com.example.demo.config.auth.PrincipalDetails;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutHandler;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class CustomLogoutHandler implements LogoutHandler {


	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {

		log.info("CustomLogoutHandler's logout invoke");

		PrincipalDetails principalDetails = (PrincipalDetails)authentication.getPrincipal();
		String provider = principalDetails.getUserDto().getProvider();
		if(provider!=null && provider.startsWith("kakao")){

		}else if(provider!=null && provider.startsWith("naver")){

		}else if(provider!=null && provider.startsWith("google")){

		}

		HttpSession session =  request.getSession();
		if(session!=null)
			session.invalidate();

	}

}
```
---
> CustomLogoutSuccessHandler.java
```java
package com.example.demo.config.auth.logoutHandler;

import java.io.IOException;


import com.example.demo.config.auth.PrincipalDetails;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {

	@Value("${spring.security.oauth2.client.registration.kakao.client-id}")
	String KAKAO_CLIENT_ID;
	@Value("${spring.security.oauth2.client.kakao.logout.redirect.uri}")
	String KAKAO_LOGOUT_REDIRECT_URI;



	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		log.info("CustomLogoutSuccessHandler onLogoutSuccess invoke..");



		PrincipalDetails principalDetails = (PrincipalDetails)authentication.getPrincipal();
		String provider = principalDetails.getUserDto().getProvider();
		if(provider!=null && provider.startsWith("kakao")){
			response.sendRedirect("https://kauth.kakao.com/oauth/logout?client_id="+KAKAO_CLIENT_ID+"&logout_redirect_uri="+KAKAO_LOGOUT_REDIRECT_URI);
			return ;
		}else if(provider!=null && provider.startsWith("naver")){
			//https://nid.naver.com/nidlogin.logout?returl=https://www.naver.com/
			response.sendRedirect("https://nid.naver.com/nidlogin.logout?returl=https://www.naver.com/");
			return ;
		}else if(provider!=null && provider.startsWith("google")){
			response.sendRedirect("https://accounts.google.com/Logout");
			return ;
		}

		response.sendRedirect(request.getContextPath()+"/");
	}

}
```
---
### provider
> GoogleUserInfo.java
```java
package com.example.demo.config.auth.provider;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GoogleUserInfo implements OAuth2UserInfo{
    private String id;
    private Map<String,Object> attributes;

    @Override
    public String getName() {
        return (String)attributes.get("name");
    }

    @Override
    public String getEmail() {
        return (String)attributes.get("email");
    }

    @Override
    public String getProvider() {
        return "google";
    }

    @Override
    public String getProviderId() {
        return this.id;
    }
}
```
---
> KakaoUserInfo.java
```java
package com.example.demo.config.auth.provider;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class KakaoUserInfo implements OAuth2UserInfo{
    private Long id;
    private LocalDateTime created_at;
    private Map<String,Object> properties;
    private Map<String,Object> kakao_account;

    @Override
    public String getName() {
        return (String)properties.get("nickname");
    }

    @Override
    public String getEmail() {
        return (String)kakao_account.get("email");
    }

    @Override
    public String getProvider() {
        return "Kakao";
    }

    @Override
    public String getProviderId() {
        return id+"";
    }

    @Override
    public Map<String, Object> getAttributes() {
        return null;
    }
//    private Map<String,Object> attributes;
}
```
---
> NaverUserInfo.java
```java
package com.example.demo.config.auth.provider;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NaverUserInfo implements OAuth2UserInfo{
    private String id;
    private Map<String,Object> attributes;


    @Override
    public String getName() {
        return (String)attributes.get("name");
    }

    @Override
    public String getEmail() {
        return (String)attributes.get("email");
    }

    @Override
    public String getProvider() {
        return "Naver";
    }

    @Override
    public String getProviderId() {
        return id;
    }
}
```
---
> OAuth2UserInfo.java
```java
package com.example.demo.config.auth.provider;

import java.util.Map;

public interface OAuth2UserInfo {
    String getName();
    String getEmail();
    String getProvider();
    String getProviderId();
    Map<String, Object> getAttributes();
}
```
---
### repository
> UserRepository.java
```java
package com.example.demo.domain.repository;

import com.example.demo.domain.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User,String> {
}
```
---
### templates
> admin.html
```html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>ADMIN</h1>
	
	<a href="/logout">로그아웃</a>
</body>
</html>
```
---
> home.html
```html
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>HOME</h1>

</body>
</html>
```
---
> join.html
```html
<!DOCTYPE html>
<html xmlns:th="http://www.w3.org/1999/xhtml">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="/join" method="post">
		<div>
			<h1>회원가입</h1>
		</div>
		<div>
			<label>username : </label><span style="color:red;font-size:.7rem;" th:text="${username}"></span><br>
			<input name="username" />
		</div>
		<div>
			<label>password : </label><span style="color:red;font-size:.7rem;" th:text="${password}"></span><br>
			<input name="password" />
		</div>
		<div>
			<input type="submit" value="회원가입" />
		</div>

	
	</form>
</body>
</html>
```
---
> login.html
```html
<!DOCTYPE html>
<html xmlns:th="http://www.w3.org/1999/xhtml">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>LOGIN</h1>
	<form action="/login" method="post">
		<div>
			<label>USERNAME : </label>
			<input name="username" />
		</div>
		<div>
			<label>PASSWORD :</label>
			<input name="password" type="password"/>
		</div>
		<button>로그인</button>
<!--		 <input type="hidden" name="_csrf" value="${_csrf.token}" /> -->
	</form>
	<span th:text="${message}"></span>
	<span th:text="${param.error}"></span>
	<hr/>
	<a href="/oauth2/authorization/kakao">카카오 로그인</a><br>
	<a href="/oauth2/authorization/naver">네이버 로그인</a><br>
	<a href="/oauth2/authorization/google">구글 로그인</a><br>
	
</body>
</html>
```
---
> manager.html
```html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>MANAGER</h1>
	
	<a href="/logout">로그아웃</a>
</body>
</html>
```
---
> user.html
```html
<!DOCTYPE html>
<html xmlns:th="http://www.w3.org/1999/xhtml">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>USER</h1>
	
	
	<div>
		auth :  <span th:text="${auth}"></span>
	</div>
	<!--
		카카오 로그아웃인지?
	-->
	<a href="/logout">로그아웃</a>
	<!--
		네이버/구글
		1) 팝업창띄우고(숨겨놓는상태) 로그아웃처리
		2) iframe 만들고 로그아웃처리
	-->

</body>
</html>
```
---

## 03_JWT
### auth
> PrincipalDetails.java
```java
package com.example.demo.config.auth;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.example.demo.domain.dto.UserDto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.oauth2.core.user.OAuth2User;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PrincipalDetails implements UserDetails,OAuth2User {
	private UserDto userDto;
	public PrincipalDetails(UserDto userDto){
		this.userDto = userDto;
	}
	//----------------------------
	// OAuth2User
	//----------------------------
	Map<String, Object> attributes;
	String access_token;
	@Override
	public Map<String, Object> getAttributes() {
		return attributes;
	}
	@Override
	public String getName() {
		return userDto.getUsername();
	}
	//----------------------------


	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection <GrantedAuthority> authorities = new ArrayList();
		authorities.add(new SimpleGrantedAuthority(userDto.getRole()));
		return authorities;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return userDto.getPassword();
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return userDto.getUsername();
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}


}
```
---
> PrincipalDetailsOAuth2Service.java
```java
package com.example.demo.config.auth;

import com.example.demo.config.auth.provider.GoogleUserInfo;
import com.example.demo.config.auth.provider.KakaoUserInfo;
import com.example.demo.config.auth.provider.NaverUserInfo;
import com.example.demo.config.auth.provider.OAuth2UserInfo;
import com.example.demo.domain.dto.UserDto;
import com.example.demo.domain.entity.User;
import com.example.demo.domain.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.util.Map;
import java.util.Optional;

@Service
public class PrincipalDetailsOAuth2Service extends DefaultOAuth2UserService {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
//        System.out.println("PrincipalDetailsOAuth2Service's loadUser invoke..");
//        System.out.println("userRequest : " + userRequest);
//        System.out.println("userRequest.getClientRegistration() :"+ userRequest.getClientRegistration());
//        System.out.println("userRequest.getAccessToken() : "+ userRequest.getAccessToken());
//        System.out.println("userRequest.getAdditionalParameters() : "+ userRequest.getAdditionalParameters());
//        System.out.println("userRequest.getAccessToken().getTokenValue() : "+ userRequest.getAccessToken().getTokenValue());
//        System.out.println("userRequest.getAccessToken().getTokenType().getValue() : "+ userRequest.getAccessToken().getTokenType().getValue());
//        System.out.println("userRequest.getAccessToken().getScopes() : "+ userRequest.getAccessToken().getScopes());

        //OAuth2UserInfo
        OAuth2User oAuth2User = super.loadUser(userRequest);
        System.out.println("oAuth2User : " + oAuth2User);
        System.out.println("getAttributes : " + oAuth2User.getAttributes());

        OAuth2UserInfo oAuth2UserInfo = null;
        //'kakao','naver','google','in-'
        String provider = userRequest.getClientRegistration().getRegistrationId();

        Map<String,Object> attributes = oAuth2User.getAttributes();
        if(provider.startsWith("kakao")) {
            //카카오 로그인시
            Long id = (Long)attributes.get("id");
            LocalDateTime connected_at = OffsetDateTime.parse( attributes.get("connected_at").toString() ).toLocalDateTime();
            Map<String,Object> properties = (Map<String,Object>)attributes.get("properties");
            Map<String,Object> kakao_account = (Map<String,Object>) attributes.get("kakao_account");
            System.out.println("id :" + id);
            System.out.println("connected_at :" + connected_at);
            System.out.println("properties :" + properties);
            System.out.println("kakao_account :" + kakao_account);
            oAuth2UserInfo = new KakaoUserInfo(id,connected_at,properties,kakao_account);

        }else if(provider.startsWith("naver")){
            //네이버 로그인시
            Map<String,Object> response = (Map<String,Object>)attributes.get("response");
            String id = (String)response.get("id");
            oAuth2UserInfo = new NaverUserInfo(id,response);

        }else if(provider.startsWith("google")){
            String id = (String)attributes.get("sub");
            oAuth2UserInfo = new GoogleUserInfo(id,attributes);
        }

        //구글 로그인시
        System.out.println("oAuth2UserInfo : " + oAuth2UserInfo);



        //최초 로그인시 로컬계정 DB 저장 처리
        String username = oAuth2UserInfo.getProvider()+"_"+oAuth2UserInfo.getProviderId();
        String password = passwordEncoder.encode("1234");
        Optional<User> userOptional =  userRepository.findById(username);
        //UserDto 생성 (이유 : PrincipalDetails에 포함)
        //UserEntity 생성(이유 : 최초 로그인시 DB 저장용도)
        UserDto userDto =null;
        if(userOptional.isEmpty()){
            //최초 로그인(Dto , Entity)
            userDto = UserDto   .builder()
                                .username(username)
                                .password(password)
                                .role("ROLE_USER")
                                .build();
            User user = userDto.toEntity();
            userRepository.save(user);  //계정 등록

        }else{
            //기존 유저 존재(Dto)
            User user = userOptional.get();
            userDto = UserDto.toDto(user);
        }


        // PrincipalDetails 전달
        PrincipalDetails principalDetails = new PrincipalDetails();
        userDto.setProvider(provider);
        userDto.setProviderId(oAuth2UserInfo.getProviderId());
        principalDetails.setUserDto(userDto);
        principalDetails.setAttributes(oAuth2User.getAttributes());
        principalDetails.setAccess_token(userRequest.getAccessToken().getTokenValue());
        return principalDetails;

    }
}
```
---
> PrincipalDetailsService.java
```java
package com.example.demo.config.auth;

import com.example.demo.domain.dto.UserDto;
import com.example.demo.domain.entity.User;
import com.example.demo.domain.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import lombok.extern.slf4j.Slf4j;

import java.util.Optional;

@Service
@Slf4j
public class PrincipalDetailsService implements UserDetailsService{

	@Autowired
	private UserRepository userRepository;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		System.out.println("loadUserByUsername .. " + username);
		Optional<User> userOption  = userRepository.findById(username);
		if(userOption.isEmpty())
			throw new UsernameNotFoundException(username + " 존재하지 않는 계정입니다.");

		//entity-> dto
		UserDto userDto = UserDto.toDto( userOption.get()    );
		return new PrincipalDetails(userDto);
	}

}
```
---
### config
> DataSourceConfig.java
```java
package com.example.demo.config;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
public class DataSourceConfig {

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
> JpaConfig.java
```java
package com.example.demo.config;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.init.DataSourceInitializer;
import org.springframework.jdbc.datasource.init.DatabasePopulator;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;

import javax.sql.DataSource;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

@Configuration
@EntityScan(basePackages = {"com.example.demo.domain.entity"})
@EnableJpaRepositories
(
                basePackages ="com.example.demo.domain.repository",
                transactionManagerRef = "jpaTransactionManager"
)
public class JpaConfig {
    @Autowired
    private DataSource dataSource;

    @Bean
    LocalContainerEntityManagerFactoryBean entityManagerFactory() {
        LocalContainerEntityManagerFactoryBean entityManagerFactoryBean = new LocalContainerEntityManagerFactoryBean();
        entityManagerFactoryBean.setDataSource(dataSource);
        entityManagerFactoryBean.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
        entityManagerFactoryBean.setPackagesToScan("com.example.demo.domain.entity");

        Properties jpaProperties = new Properties();


        Map<String, Object> properties = new HashMap<>();
        properties.put("hibernate.hbm2ddl.auto", "update");                         // 필요에 따라 'create', 'validate' 등으로 변경
        properties.put("hibernate.dialect", "org.hibernate.dialect.MySQLDialect"); // 사용 중인 DB에 맞게 변경
        properties.put("hibernate.show_sql", true);
        properties.put("hibernate.format_sql", true);

        properties.put("hibernate.hibernate.jdbc.batch_size", 1000);
        properties.put("hibernate.hibernate.order_inserts", true);
        properties.put("hibernate.order_updates", true);
        properties.put("hibernate.jdbc.batch_versioned_data", true);
        entityManagerFactoryBean.setJpaPropertyMap(properties);

        return entityManagerFactoryBean;
    }


    //애플리케이션 시작 시 데이터베이스 초기화
//    @Bean
//    public DataSourceInitializer dataSourceInitializer() {
//        DataSourceInitializer initializer = new DataSourceInitializer();
//        initializer.setDataSource(dataSource);
//        initializer.setDatabasePopulator(databasePopulator());
//        return initializer;
//    }

    //schema.sql과 data.sql 스크립트를 실행
//    private DatabasePopulator databasePopulator() {
//        //Spring Framework에서 제공하는 클래스로, 외부 리소스에 정의된 SQL 스크립트를 사용하여 데이터베이스를 초기화하거나 정리하는 데 사용
//        ResourceDatabasePopulator populator = new ResourceDatabasePopulator();
//        //src/main/resources 디렉토리에 위치한 SQL 스크립트를 로드
//        Resource schemaScript = new ClassPathResource("schema.sql");
//        Resource dataScript = new ClassPathResource("data.sql");
//        populator.addScript(schemaScript);
//        populator.addScript(dataScript);
//        return populator;
//    }

}
```
---
> SecurityConfig.java
```java
package com.example.demo.config;


import com.example.demo.config.auth.exceptionHandler.CustomAccessDeniedHandler;
import com.example.demo.config.auth.exceptionHandler.CustomAuthenticationEntryPoint;
import com.example.demo.config.auth.loginHandler.CustomLoginFailureHandler;
import com.example.demo.config.auth.loginHandler.CustomLoginSuccessHandler;
import com.example.demo.config.auth.logoutHandler.CustomLogoutHandler;
import com.example.demo.config.auth.logoutHandler.CustomLogoutSuccessHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Autowired
	private CustomLoginSuccessHandler customLoginSuccessHandler;
	@Autowired
	private CustomLogoutHandler customLogoutHandler;
	@Autowired
	private CustomLogoutSuccessHandler customLogoutSuccessHandler;


	@Bean
	protected SecurityFilterChain configure(HttpSecurity http) throws Exception {
		//CSRF비활성화
		http.csrf((config)->{config.disable();});
		//CSRF토큰 쿠키형태로 전달
//		http.csrf().csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse());
		//권한체크
		http.authorizeHttpRequests((auth)->{
			auth.requestMatchers("/","/join","/login").permitAll();
			auth.requestMatchers("/user").hasRole("USER");
			auth.requestMatchers("/manager").hasRole("MANAGER");
			auth.requestMatchers("/admin").hasRole("ADMIN");
			auth.anyRequest().authenticated();
		});

		//로그인
		http.formLogin((login)->{
			login.permitAll();
			login.loginPage("/login");
			login.successHandler(customLoginSuccessHandler);
			login.failureHandler(new CustomLoginFailureHandler());
		});
		//로그아웃
		http.logout((logout)->{
			logout.permitAll();
			logout.addLogoutHandler(customLogoutHandler);
			logout.logoutSuccessHandler(customLogoutSuccessHandler);
		});
		//예외처리

		http.exceptionHandling((ex)->{
			ex.authenticationEntryPoint(new CustomAuthenticationEntryPoint());
			ex.accessDeniedHandler(new CustomAccessDeniedHandler());
		});

		//OAUTH2-CLIENT
		http.oauth2Login((oauth2)->{
			oauth2.loginPage("/login");

		});
		//SESSION INVALIDATED
		http.sessionManagement((sessionManagerConfigure)->{
			sessionManagerConfigure.sessionCreationPolicy(SessionCreationPolicy.STATELESS);
		});

		return http.build();
		
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

}
```
---
> TxConfig.java
```java
package com.example.demo.config;

import jakarta.persistence.EntityManagerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

@Configuration
@EnableTransactionManagement
public class TxConfig {
    @Autowired
    private DataSource dataSource;

//    // 기본 TransactionManager
//    @Bean(name = "dataSourceTransactionManager")
//    public DataSourceTransactionManager transactionManager2() {
//        //System.out.println("TX dataSrouce2 : " + dataSource2.toString());
//        return new DataSourceTransactionManager(dataSource);
//    }


    //    JPA TransactionManager Settings
    @Bean(name="jpaTransactionManager")
    public JpaTransactionManager jpaTransactionManager(EntityManagerFactory entityManagerFactory) {
        JpaTransactionManager transactionManager = new JpaTransactionManager();
        transactionManager.setEntityManagerFactory(entityManagerFactory);
        transactionManager.setDataSource(dataSource);

        return transactionManager;
    }

}
```
---
### controller
> HomeController.java
```java
package com.example.demo.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@Slf4j
public class HomeController {

    @GetMapping("/")
    public String home(){
        log.info("GET /...");
        return "home";
    }
}
```
---
> UserController.java
```java
package com.example.demo.controller;

import java.beans.PropertyEditorSupport;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import com.example.demo.domain.dto.UserDto;
import com.example.demo.domain.entity.User;
import com.example.demo.domain.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UserController {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@GetMapping("/login")
	public void login() {
		log.info("GET /login...");
	}
	
//	@GetMapping("/user")
//	public void user(Authentication authentication) {
//		log.info("GET /user..." + authentication);
//		log.info("name..." + authentication.getName());
//		log.info("principal..." + authentication.getPrincipal());
//		log.info("authorities..." + authentication.getAuthorities());
//		log.info("details..." + authentication.getDetails());
//		log.info("credential..." + authentication.getCredentials());
//	}
	
//	@GetMapping("/user")
//	public void user(@AuthenticationPrincipal Principal principal) {
//		log.info("GET /user..." + principal);
//	}
	
	@GetMapping("/user")
	public void user(Model model) {
		log.info("GET /user...");
		Authentication authenticaton = 
		SecurityContextHolder.getContext().getAuthentication();
		log.info("authentication : " + authenticaton);
		
		model.addAttribute("auth",authenticaton);
		
	}
	
	@GetMapping("/manager")
	public void manager() {
		log.info("GET /manager...");	
	}
	@GetMapping("/admin")
	public void admin() {
		log.info("GET /admin...");	
	}
	
	
	
	@GetMapping("/join")
	public void join() {
		log.info("GET /join..");
	}

	@PostMapping("/join")
	public String join_post(UserDto dto, RedirectAttributes redirectAttributes ) {
		log.info("POST /join.." + dto);

		//DTO->ENTITY(DB저장) , ENTITY->DTO(뷰로전달)
		dto.setPassword(  passwordEncoder.encode( dto.getPassword() ) );
		userRepository.save(dto.toEntity());

		boolean isJoin  = true;
		if(isJoin) {
			redirectAttributes.addFlashAttribute("message","회원가입 완료!");
			return "redirect:/login";
		}
		else
			return "join";
	}

}
```
---
### demo
> DemoApplication.java
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
> DemoApplicationTests.java
```java
package com.example.demo;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class DemoApplicationTests {

	@Test
	void contextLoads() {
	}

}
```
---
### dto
> UserDto.java
```java
package com.example.demo.domain.dto;

import java.time.LocalDate;

import com.example.demo.domain.entity.User;
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
	private String username;
	private String password;
	private String role;

	//OAUTH2 CLIENT INFO
	private String provider;
	private String providerId;
	//DTO->ENTITY
	public User toEntity(){
		return User.builder()
				.username(this.username)
				.password(this.password)
				.role("ROLE_USER")
				.build();
	}
	//ENTITY->DTO
	public static UserDto toDto(User user){
		return UserDto.builder()
					.username(user.getUsername())
					.password(user.getPassword())
					.role(user.getRole())
					.build();
	}
}
```
---
### entity
> User.java
```java
package com.example.demo.domain.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class User {
	@Id
	private String username;
	private String password;
	private String role;
}
```
---
### exceptionHandler
> CustomAccessDeniedHandler.java
```java
package com.example.demo.config.auth.exceptionHandler;


import java.io.IOException;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
                       AccessDeniedException accessDeniedException) throws IOException, ServletException {
		log.error("CustomAccessDeniedHandler's handle invoke..");
		response.sendRedirect(request.getContextPath()+"/login?error="+accessDeniedException.getMessage());

	}

}
```
---
> CustomAuthenticationEntryPoint.java
```java
package com.example.demo.config.auth.exceptionHandler;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import lombok.extern.slf4j.Slf4j;

import lombok.extern.slf4j.Slf4j;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
                         AuthenticationException authException) throws IOException, ServletException {

		log.error("CustomAuthenticationEntryPoint's commence invoke....");
		response.sendRedirect("/login?error="+authException.getMessage());
	}

}
```
---
### jwt
> JwtAuthorizationFilter.java
```java
package com.example.demo.config.auth.jwt;


import com.example.demo.domain.entity.User;
import com.example.demo.domain.repository.UserRepository;
import io.jsonwebtoken.ExpiredJwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;


import java.io.IOException;
import java.util.Arrays;
import java.util.Optional;

/**
 * JWT를 이용한 인증
 */
public class JwtAuthorizationFilter extends OncePerRequestFilter {

    private final UserRepository userRepository;
    private final JwtTokenProvider jwtTokenProvider;

    public JwtAuthorizationFilter(
            UserRepository userRepository,
            JwtTokenProvider jwtTokenProvider
    ) {
        this.userRepository = userRepository;
        this.jwtTokenProvider = jwtTokenProvider;
    }

    @Override
    protected void doFilterInternal(
            HttpServletRequest request,
            HttpServletResponse response,
            FilterChain chain
    ) throws IOException, ServletException, IOException {
        System.out.println("[JWTAUTHORIZATIONFILTER] doFilterInternal...");

        String token = null;
        try {
            // cookie 에서 JWT token을 가져옵니다.
            token = Arrays.stream(request.getCookies())
                    .filter(cookie -> cookie.getName().equals(JwtProperties.ACCESS_TOKEN_COOKIE_NAME)).findFirst()
                    .map(cookie -> cookie.getValue())
                    .orElse(null);

        } catch (Exception ignored) {


        }
        if (token != null) {
            try {
                if(jwtTokenProvider.validateToken(token)) {
                    Authentication authentication = getUsernamePasswordAuthenticationToken(token);
                    SecurityContextHolder.getContext().setAuthentication(authentication);
                    System.out.println("[JWTAUTHORIZATIONFILTER] : " + authentication);
                }

            } catch (ExpiredJwtException e)     //토큰만료시 예외처리(쿠키 제거)
            {

                System.out.println("[JWTAUTHORIZATIONFILTER] : ...ExpiredJwtException ...."+e.getMessage());

                //토큰 만료시 처리(Refresh-token으로 갱신처리는 안함-쿠키에서 제거)
//                Cookie cookie = new Cookie(JwtProperties.COOKIE_NAME, null);
//                cookie.setMaxAge(0);
//                response.addCookie(cookie);

            }catch(Exception e2){

            }
        }
        chain.doFilter(request, response);
    }

    /**
     * JWT 토큰으로 User를 찾아서 UsernamePasswordAuthenticationToken를 만들어서 반환한다.
     * User가 없다면 null
     */
    private Authentication getUsernamePasswordAuthenticationToken(String token) {
        Authentication authentication = jwtTokenProvider.getAuthentication(token);
        Optional<User> user = userRepository.findById(authentication.getName()); // 유저를 유저명으로 찾습니다.
        System.out.println("JwtAuthorizationFilter.getUsernamePasswordAuthenticationToken...authenticationToken : " +authentication );
        if(user.isPresent())
            return authentication;
        return null; // 유저가 없으면 NULL
    }

}
```
---
> JwtProperties.java
```java
package com.example.demo.config.auth.jwt;

/**
 * JWT 기본 설정값
 */
public class JwtProperties {
    public static final int ACCESS_TOKEN_EXPIRATION_TIME = 1000*60;          // 60초
    public static final int REFRESH_TOKEN_EXPIRATION_TIME = 1000*60*5;       // 5분
    public static final String ACCESS_TOKEN_COOKIE_NAME = "access-token";
    public static final String REFRESH_TOKEN_COOKIE_NAME = "refresh-token";

}
```
---
> JwtTokenProvider.java
```java
package com.example.demo.config.auth.jwt;


import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.stream.Collectors;

@Slf4j
@Component
public class JwtTokenProvider {

    //Key 저장
    private final Key key;

        public JwtTokenProvider() {
            byte[] keyBytes = KeyGenerator.getKeygen();
            this.key = Keys.hmacShaKeyFor(keyBytes);
            System.out.println("JwtTokenProvider Constructor  Key init: " + key);

        }

    // 유저 정보를 가지고 AccessToken, RefreshToken 을 생성하는 메서드
    public TokenInfo generateToken(Authentication authentication) {
        // 권한 가져오기
        String authorities = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.joining(","));
        long now = (new Date()).getTime();

        // Access Token 생성
        Date accessTokenExpiresIn = new Date(now + JwtProperties.ACCESS_TOKEN_EXPIRATION_TIME); // 60초후 만료
        String accessToken = Jwts.builder()
                .setSubject(authentication.getName())
                .claim("username",authentication.getName()) //정보저장
                .claim("auth", authorities)//정보저장
                .setExpiration(accessTokenExpiresIn)
                .signWith(key, SignatureAlgorithm.HS256)
                .compact();

        // Refresh Token 생성
        String refreshToken = Jwts.builder()
                .setExpiration(new Date(now + JwtProperties.REFRESH_TOKEN_EXPIRATION_TIME))    //1일: 24 * 60 * 60 * 1000 = 86400000
                .signWith(key, SignatureAlgorithm.HS256)
                .compact();

        System.out.println("JwtTokenProvider.generateToken.accessToken : " + accessToken);
        System.out.println("JwtTokenProvider.generateToken.refreshToken : " + refreshToken);

        return TokenInfo.builder()
                .grantType("Bearer")
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .build();
    }


    // JWT 토큰을 복호화하여 토큰에 들어있는 정보를 꺼내는 메서드
    public Authentication getAuthentication(String accessToken) {
        // 토큰 복호화
        Claims claims = parseClaims(accessToken);

        if (claims.get("auth") == null) {
            throw new RuntimeException("권한 정보가 없는 토큰입니다.");
        }
        // 클레임에서 권한 정보 가져오기
        Collection<? extends GrantedAuthority> authorities =
                Arrays.stream(claims.get("auth").toString().split(","))
                        .map(auth -> new SimpleGrantedAuthority(auth))
                        .collect(Collectors.toList());

        String username = claims.getSubject(); //username
        // UserDetails 객체를 만들어서 Authentication 리턴
        UserDetails principal = new User(username, "", authorities);
        System.out.println("JwtTokenProvider.getAuthentication UsernamePasswordAuthenticationToken : " + accessToken);
        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken =
                new UsernamePasswordAuthenticationToken(principal, "", authorities);
        return usernamePasswordAuthenticationToken;
    }

    private Claims parseClaims(String accessToken) {
        try {
            return Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(accessToken).getBody();
        } catch (ExpiredJwtException e) {
            return e.getClaims();
        }
    }

    // 토큰 정보를 검증하는 메서드
    public boolean validateToken(String token) {
        try {
            Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token);
            return true;
        } catch (io.jsonwebtoken.security.SecurityException | MalformedJwtException e) {
            log.info("Invalid JWT Token", e);
//        }
//        catch (ExpiredJwtException e) {
//            log.info("Expired JWT Token", e);

        } catch (UnsupportedJwtException e) {
            log.info("Unsupported JWT Token", e);
        } catch (IllegalArgumentException e) {
            log.info("JWT claims string is empty.", e);
        }
        return false;
    }
}
```
---
> KeyGenerator.java
```java
package com.example.demo.config.auth.jwt;

import java.security.SecureRandom;

public class KeyGenerator {

    public static  byte[]  getKeygen(){
        SecureRandom secureRandom = new SecureRandom();
        byte[] keyBytes = new byte[256 / 8]; // 256비트 키 생성
        secureRandom.nextBytes(keyBytes); // 난수로 바이트 배열 생성
        System.out.println("KeyGenerator getKeygen Key: " + keyBytes);
        return keyBytes;
    }
}
```
---
> TokenInfo.java
```java
package com.example.demo.config.auth.jwt;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
@AllArgsConstructor
public class TokenInfo {
    private String grantType;
    private String accessToken;
    private String refreshToken;
}
```
---
### loginHandler
> CustomLoginFailureHandler.java
```java
package com.example.demo.config.auth.loginHandler;

import java.io.IOException;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {

		log.error("CustomLoginFailureHandler's onAuthenticationFailure invoke..") ;
		response.sendRedirect(request.getContextPath()+"/login?error="+exception.getMessage());
	}



}
```
---
> CustomLoginSuccessHandler.java
```java
package com.example.demo.config.auth.loginHandler;

import java.io.IOException;


import com.example.demo.config.auth.jwt.JwtProperties;
import com.example.demo.config.auth.jwt.JwtTokenProvider;
import com.example.demo.config.auth.jwt.TokenInfo;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	@Autowired
	private JwtTokenProvider jwtTokenProvider;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {

		log.info("CustomLoginSuccessHandler's onAuthenticationSuccess invoke..");

		//TOKEN 쿠키로 전달
		TokenInfo tokenInfo = jwtTokenProvider.generateToken(authentication);
		Cookie cookie = new Cookie(JwtProperties.ACCESS_TOKEN_COOKIE_NAME,tokenInfo.getAccessToken());
		cookie.setMaxAge(JwtProperties.ACCESS_TOKEN_EXPIRATION_TIME);
		cookie.setPath("/");
		response.addCookie(cookie);

		response.sendRedirect(request.getContextPath()+"/");

	}

}
```
---
### logoutHandler
> CustomLogoutHandler.java
```java
package com.example.demo.config.auth.logoutHandler;



import com.example.demo.config.auth.PrincipalDetails;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutHandler;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class CustomLogoutHandler implements LogoutHandler {


	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {

		log.info("CustomLogoutHandler's logout invoke");

		PrincipalDetails principalDetails = (PrincipalDetails)authentication.getPrincipal();
		String provider = principalDetails.getUserDto().getProvider();
		if(provider!=null && provider.startsWith("kakao")){

		}else if(provider!=null && provider.startsWith("naver")){

		}else if(provider!=null && provider.startsWith("google")){

		}

		HttpSession session =  request.getSession();
		if(session!=null)
			session.invalidate();

	}

}
```
---
> CustomLogoutSuccessHandler.java
```java
package com.example.demo.config.auth.logoutHandler;

import java.io.IOException;


import com.example.demo.config.auth.PrincipalDetails;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {

	@Value("${spring.security.oauth2.client.registration.kakao.client-id}")
	String KAKAO_CLIENT_ID;
	@Value("${spring.security.oauth2.client.kakao.logout.redirect.uri}")
	String KAKAO_LOGOUT_REDIRECT_URI;



	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		log.info("CustomLogoutSuccessHandler onLogoutSuccess invoke..");



		PrincipalDetails principalDetails = (PrincipalDetails)authentication.getPrincipal();
		String provider = principalDetails.getUserDto().getProvider();
		if(provider!=null && provider.startsWith("kakao")){
			response.sendRedirect("https://kauth.kakao.com/oauth/logout?client_id="+KAKAO_CLIENT_ID+"&logout_redirect_uri="+KAKAO_LOGOUT_REDIRECT_URI);
			return ;
		}else if(provider!=null && provider.startsWith("naver")){
			//https://nid.naver.com/nidlogin.logout?returl=https://www.naver.com/
			response.sendRedirect("https://nid.naver.com/nidlogin.logout?returl=https://www.naver.com/");
			return ;
		}else if(provider!=null && provider.startsWith("google")){
			response.sendRedirect("https://accounts.google.com/Logout");
			return ;
		}

		response.sendRedirect(request.getContextPath()+"/");
	}

}
```
---
### provider
> GoogleUserInfo.java
```java
package com.example.demo.config.auth.provider;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GoogleUserInfo implements OAuth2UserInfo{
    private String id;
    private Map<String,Object> attributes;

    @Override
    public String getName() {
        return (String)attributes.get("name");
    }

    @Override
    public String getEmail() {
        return (String)attributes.get("email");
    }

    @Override
    public String getProvider() {
        return "google";
    }

    @Override
    public String getProviderId() {
        return this.id;
    }
}
```
---
> KakaoUserInfo.java
```java
package com.example.demo.config.auth.provider;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class KakaoUserInfo implements OAuth2UserInfo{
    private Long id;
    private LocalDateTime created_at;
    private Map<String,Object> properties;
    private Map<String,Object> kakao_account;

    @Override
    public String getName() {
        return (String)properties.get("nickname");
    }

    @Override
    public String getEmail() {
        return (String)kakao_account.get("email");
    }

    @Override
    public String getProvider() {
        return "Kakao";
    }

    @Override
    public String getProviderId() {
        return id+"";
    }

    @Override
    public Map<String, Object> getAttributes() {
        return null;
    }
//    private Map<String,Object> attributes;
}
```
---
> NaverUserInfo.java
```java
package com.example.demo.config.auth.provider;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NaverUserInfo implements OAuth2UserInfo{
    private String id;
    private Map<String,Object> attributes;


    @Override
    public String getName() {
        return (String)attributes.get("name");
    }

    @Override
    public String getEmail() {
        return (String)attributes.get("email");
    }

    @Override
    public String getProvider() {
        return "Naver";
    }

    @Override
    public String getProviderId() {
        return id;
    }
}
```
---
> OAuth2UserInfo.java
```java
package com.example.demo.config.auth.provider;

import java.util.Map;

public interface OAuth2UserInfo {
    String getName();
    String getEmail();
    String getProvider();
    String getProviderId();
    Map<String, Object> getAttributes();
}
```
---
### repository
> UserRepository.java
```java
package com.example.demo.domain.repository;

import com.example.demo.domain.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User,String> {
}
```
---
### templates
> admin.html
```html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>ADMIN</h1>
	
	<a href="/logout">로그아웃</a>
</body>
</html>
```
---
> home.html
```html
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>HOME</h1>

</body>
</html>
```
---
> join.html
```html
<!DOCTYPE html>
<html xmlns:th="http://www.w3.org/1999/xhtml">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="/join" method="post">
		<div>
			<h1>회원가입</h1>
		</div>
		<div>
			<label>username : </label><span style="color:red;font-size:.7rem;" th:text="${username}"></span><br>
			<input name="username" />
		</div>
		<div>
			<label>password : </label><span style="color:red;font-size:.7rem;" th:text="${password}"></span><br>
			<input name="password" />
		</div>
		<div>
			<input type="submit" value="회원가입" />
		</div>

	
	</form>
</body>
</html>
```
---
> login.html
```html
<!DOCTYPE html>
<html xmlns:th="http://www.w3.org/1999/xhtml">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>LOGIN</h1>
	<form action="/login" method="post">
		<div>
			<label>USERNAME : </label>
			<input name="username" />
		</div>
		<div>
			<label>PASSWORD :</label>
			<input name="password" type="password"/>
		</div>
		<button>로그인</button>
<!--		 <input type="hidden" name="_csrf" value="${_csrf.token}" /> -->
	</form>
	<span th:text="${message}"></span>
	<span th:text="${param.error}"></span>
	<hr/>
	<a href="/oauth2/authorization/kakao">카카오 로그인</a><br>
	<a href="/oauth2/authorization/naver">네이버 로그인</a><br>
	<a href="/oauth2/authorization/google">구글 로그인</a><br>
	
</body>
</html>
```
---
> manager.html
```html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>MANAGER</h1>
	
	<a href="/logout">로그아웃</a>
</body>
</html>
```
---
> user.html
```html
<!DOCTYPE html>
<html xmlns:th="http://www.w3.org/1999/xhtml">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>USER</h1>
	
	
	<div>
		auth :  <span th:text="${auth}"></span>
	</div>
	<!--
		카카오 로그아웃인지?
	-->
	<a href="/logout">로그아웃</a>
	<!--
		네이버/구글
		1) 팝업창띄우고(숨겨놓는상태) 로그아웃처리
		2) iframe 만들고 로그아웃처리
	-->

</body>
</html>
```
---