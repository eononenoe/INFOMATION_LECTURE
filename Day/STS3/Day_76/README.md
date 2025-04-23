# 01

### ex01_LOMBOK_ID

---

> .classpath
> 

```
<?xml version="1.0" encoding="UTF-8"?>
<classpath>
	<classpathentry kind="src" output="target/classes" path="src/main/java">
		<attributes>
			<attribute name="optional" value="true"/>
			<attribute name="maven.pomderived" value="true"/>
		</attributes>
	</classpathentry>
	<classpathentry excluding="**" kind="src" output="target/classes" path="src/main/resources">
		<attributes>
			<attribute name="maven.pomderived" value="true"/>
		</attributes>
	</classpathentry>
	<classpathentry kind="src" output="target/test-classes" path="src/test/java">
		<attributes>
			<attribute name="test" value="true"/>
			<attribute name="optional" value="true"/>
			<attribute name="maven.pomderived" value="true"/>
		</attributes>
	</classpathentry>
	<classpathentry excluding="**" kind="src" output="target/test-classes" path="src/test/resources">
		<attributes>
			<attribute name="test" value="true"/>
			<attribute name="maven.pomderived" value="true"/>
		</attributes>
	</classpathentry>
	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/JavaSE-11">
		<attributes>
			<attribute name="maven.pomderived" value="true"/>
		</attributes>
	</classpathentry>
	<classpathentry kind="con" path="org.eclipse.m2e.MAVEN2_CLASSPATH_CONTAINER">
		<attributes>
			<attribute name="maven.pomderived" value="true"/>
			<attribute name="org.eclipse.jst.component.dependency" value="/WEB-INF/lib"/>
		</attributes>
	</classpathentry>
	<classpathentry kind="con" path="org.eclipse.jdt.junit.JUNIT_CONTAINER/5"/>
	<classpathentry kind="output" path="target/classes"/>
</classpath>

```

---

> .project
> 

```
<?xml version="1.0" encoding="UTF-8"?>
<projectDescription>
	<name>ex01_lombok_id</name>
	<comment></comment>
	<projects>
	</projects>
	<buildSpec>
		<buildCommand>
			<name>org.eclipse.jdt.core.javabuilder</name>
			<arguments>
			</arguments>
		</buildCommand>
		<buildCommand>
			<name>org.eclipse.wst.common.project.facet.core.builder</name>
			<arguments>
			</arguments>
		</buildCommand>
		<buildCommand>
			<name>org.springframework.ide.eclipse.core.springbuilder</name>
			<arguments>
			</arguments>
		</buildCommand>
		<buildCommand>
			<name>org.eclipse.wst.jsdt.core.javascriptValidator</name>
			<arguments>
			</arguments>
		</buildCommand>
		<buildCommand>
			<name>org.eclipse.wst.validation.validationbuilder</name>
			<arguments>
			</arguments>
		</buildCommand>
		<buildCommand>
			<name>org.eclipse.m2e.core.maven2Builder</name>
			<arguments>
			</arguments>
		</buildCommand>
	</buildSpec>
	<natures>
		<nature>org.springframework.ide.eclipse.core.springnature</nature>
		<nature>org.eclipse.jdt.core.javanature</nature>
		<nature>org.eclipse.m2e.core.maven2Nature</nature>
		<nature>org.eclipse.wst.common.project.facet.core.nature</nature>
		<nature>org.eclipse.wst.common.modulecore.ModuleCoreNature</nature>
		<nature>org.eclipse.wst.jsdt.core.jsNature</nature>
	</natures>
</projectDescription>

```

---

> .springBeans
> 

```
<?xml version="1.0" encoding="UTF-8"?>
<beansProjectDescription>
	<version>1</version>
	<pluginVersion><![CDATA[3.9.18.202109140629-RELEASE]]></pluginVersion>
	<configSuffixes>
		<configSuffix><![CDATA[xml]]></configSuffix>
	</configSuffixes>
	<enableImports><![CDATA[true]]></enableImports>
	<configs>
		<config>src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml</config>
		<config>src/main/webapp/WEB-INF/spring/root-context.xml</config>
	</configs>
	<autoconfigs>
	</autoconfigs>
	<configSets>
	</configSets>
</beansProjectDescription>

```

---

> pom.xml
> 

```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="<http://maven.apache.org/POM/4.0.0>" xmlns:xsi="<http://www.w3.org/2001/XMLSchema-instance>"
	xsi:schemaLocation="<http://maven.apache.org/POM/4.0.0> <https://maven.apache.org/maven-v4_0_0.xsd>">
	<modelVersion>4.0.0</modelVersion>
	<groupId>com.example</groupId>
	<artifactId>ex01_lombok_DI</artifactId>
	<name>ex01_lombok_DI</name>
	<packaging>war</packaging>
	<version>1.0.0-BUILD-SNAPSHOT</version>
	<properties>
		<java-version>11</java-version>
		<org.springframework-version>5.0.7.RELEASE</org.springframework-version>
		<org.aspectj-version>1.6.10</org.aspectj-version>
		<org.slf4j-version>1.6.6</org.slf4j-version>
	</properties>
	<dependencies>
		<!-- Spring -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-context</artifactId>
			<version>${org.springframework-version}</version>
			<exclusions>
				<!-- Exclude Commons Logging in favor of SLF4j -->
				<exclusion>
					<groupId>commons-logging</groupId>
					<artifactId>commons-logging</artifactId>
				 </exclusion>
			</exclusions>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-webmvc</artifactId>
			<version>${org.springframework-version}</version>
		</dependency>

		<!-- AspectJ -->
		<dependency>
			<groupId>org.aspectj</groupId>
			<artifactId>aspectjrt</artifactId>
			<version>${org.aspectj-version}</version>
		</dependency>

		<!-- Logging -->
		<dependency>
			<groupId>org.slf4j</groupId>
			<artifactId>slf4j-api</artifactId>
			<version>${org.slf4j-version}</version>
		</dependency>
		<dependency>
			<groupId>org.slf4j</groupId>
			<artifactId>jcl-over-slf4j</artifactId>
			<version>${org.slf4j-version}</version>
			<scope>runtime</scope>
		</dependency>
		<dependency>
			<groupId>org.slf4j</groupId>
			<artifactId>slf4j-log4j12</artifactId>
			<version>${org.slf4j-version}</version>
			<scope>runtime</scope>
		</dependency>
		<dependency>
			<groupId>log4j</groupId>
			<artifactId>log4j</artifactId>
			<version>1.2.15</version>
			<exclusions>
				<exclusion>
					<groupId>javax.mail</groupId>
					<artifactId>mail</artifactId>
				</exclusion>
				<exclusion>
					<groupId>javax.jms</groupId>
					<artifactId>jms</artifactId>
				</exclusion>
				<exclusion>
					<groupId>com.sun.jdmk</groupId>
					<artifactId>jmxtools</artifactId>
				</exclusion>
				<exclusion>
					<groupId>com.sun.jmx</groupId>
					<artifactId>jmxri</artifactId>
				</exclusion>
			</exclusions>
			<!-- <scope>runtime</scope> -->
		</dependency>

		<!-- @Inject -->
		<dependency>
			<groupId>javax.inject</groupId>
			<artifactId>javax.inject</artifactId>
			<version>1</version>
		</dependency>

		<!-- Servlet -->
		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>servlet-api</artifactId>
			<version>2.5</version>
			<scope>provided</scope>
		</dependency>
		<dependency>
			<groupId>javax.servlet.jsp</groupId>
			<artifactId>jsp-api</artifactId>
			<version>2.1</version>
			<scope>provided</scope>
		</dependency>
		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>jstl</artifactId>
			<version>1.2</version>
		</dependency>

		<!-- Test -->
		<dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<version>4.12</version>
			<scope>test</scope>
		</dependency>

		<!-- 한글경로 문제 해결 -->
		<dependency>
		    <groupId>xerces</groupId>
		    <artifactId>xercesImpl</artifactId>
		    <version>2.12.2</version>
		</dependency>

		<!-- LOMBOK -->
		<dependency>
		    <groupId>org.projectlombok</groupId>
		    <artifactId>lombok</artifactId>
		    <version>1.18.34</version>
		    <scope>provided</scope>
		</dependency>

		<!-- SPRING-TEST -->
		<dependency>
		    <groupId>org.springframework</groupId>
		    <artifactId>spring-test</artifactId>
		    <version>${org.springframework-version}</version>
		    <scope>test</scope>
		</dependency>

	</dependencies>
    <build>
        <plugins>
            <plugin>
                <artifactId>maven-eclipse-plugin</artifactId>
                <version>2.9</version>
                <configuration>
                    <additionalProjectnatures>
                        <projectnature>org.springframework.ide.eclipse.core.springnature</projectnature>
                    </additionalProjectnatures>
                    <additionalBuildcommands>
                        <buildcommand>org.springframework.ide.eclipse.core.springbuilder</buildcommand>
                    </additionalBuildcommands>
                    <downloadSources>true</downloadSources>
                    <downloadJavadocs>true</downloadJavadocs>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.5.1</version>
                <configuration>
                    <source>${java-version}</source>
                    <target>${java-version}</target>
                    <compilerArgument>-Xlint:all</compilerArgument>
                    <showWarnings>true</showWarnings>
                    <showDeprecation>true</showDeprecation>
                    <encoding>UTF-8</encoding>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.codehaus.mojo</groupId>
                <artifactId>exec-maven-plugin</artifactId>
                <version>1.2.1</version>
                <configuration>
                    <mainClass>org.test.int1.Main</mainClass>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>

```

---

### config

---

> PersonComponent.java
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

> PersonDtoBeanConfig.java
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

### controller

---

> HomeController.java
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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

}

```

---

> SimpleController.java
> 

```
package com.example.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/test")
public class SimpleController {

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

### dto

---

> PersonDto.java
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

### resources

---

> log4j.xml
> 

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE log4j:configuration PUBLIC "-//APACHE//DTD LOG4J 1.2//EN" "log4j.dtd">
<log4j:configuration xmlns:log4j="<http://jakarta.apache.org/log4j/>">

	<!-- Appenders -->
	<appender name="console" class="org.apache.log4j.ConsoleAppender">
		<param name="Target" value="System.out" />
		<layout class="org.apache.log4j.PatternLayout">
			<param name="ConversionPattern" value="%-5p: %c - %m%n" />
		</layout>
	</appender>

	<!-- Application Loggers -->
	<logger name="com.example.app">
		<level value="info" />
	</logger>

	<!-- 3rdparty Loggers -->
	<logger name="org.springframework.core">
		<level value="info" />
	</logger>

	<logger name="org.springframework.beans">
		<level value="info" />
	</logger>

	<logger name="org.springframework.context">
		<level value="info" />
	</logger>

	<logger name="org.springframework.web">
		<level value="info" />
	</logger>

	<!-- Root Logger -->
	<root>
		<priority value="warn" />
		<appender-ref ref="console" />
	</root>

</log4j:configuration>

```

---

### WEB-INF

---

> web.xml
> 

```
<?xml version="1.0" encoding="UTF-8"?>
<web-app version="2.5" xmlns="<http://java.sun.com/xml/ns/javaee>"
	xmlns:xsi="<http://www.w3.org/2001/XMLSchema-instance>"
	xsi:schemaLocation="<http://java.sun.com/xml/ns/javaee> <https://java.sun.com/xml/ns/javaee/web-app_2_5.xsd>">

	<!-- The definition of the Root Spring Container shared by all Servlets
		and Filters -->
	<context-param>
		<param-name>contextConfigLocation</param-name>
		<param-value>/WEB-INF/spring/root-context.xml</param-value>
	</context-param>

	<!-- Creates the Spring Container shared by all Servlets and Filters -->
	<listener>
		<listener-class>org.springframework.web.context.ContextLoaderListener
		</listener-class>
	</listener>

	<!-- Processes application requests -->
	<servlet>
		<servlet-name>appServlet</servlet-name>
		<servlet-class>org.springframework.web.servlet.DispatcherServlet
		</servlet-class>
		<init-param>
			<param-name>contextConfigLocation</param-name>
			<param-value>/WEB-INF/spring/appServlet/servlet-context.xml
			</param-value>
		</init-param>
		<load-on-startup>1</load-on-startup>
	</servlet>

	<servlet-mapping>
		<servlet-name>appServlet</servlet-name>
		<url-pattern>/</url-pattern>
	</servlet-mapping>

	<!-- FILTER -->
	<filter>
		<filter-name>encodingFilter</filter-name>
		<filter-class>org.springframework.web.filter.CharacterEncodingFilter
		</filter-class>
		<init-param>
			<param-name>encoding</param-name>
			<param-value>UTF-8</param-value>
		</init-param>
		<init-param>
			<param-name>forceEncoding</param-name>
			<param-value>true</param-value>
		</init-param>
	</filter>

	<filter-mapping>
		<filter-name>encodingFilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>

</web-app>

```

---

### spring

---

> root-context.xml
> 

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="<http://www.springframework.org/schema/beans>"
	xmlns:xsi="<http://www.w3.org/2001/XMLSchema-instance>"
	xmlns:context="<http://www.springframework.org/schema/context>"
	xsi:schemaLocation="<http://www.springframework.org/schema/beans> <https://www.springframework.org/schema/beans/spring-beans.xsd>
		<http://www.springframework.org/schema/context> <http://www.springframework.org/schema/context/spring-context-4.3.xsd>">

	<!-- Root Context: defines shared resources visible to all other web components -->
	<!-- 직접 Bean 등록 -->
 	<bean id="personDto1" class="com.example.app.domain.dto.PersonDto" >
		<constructor-arg name="username" value="홍길동" />
		<constructor-arg name="age" value="11" />
		<constructor-arg name="addr" value="창원" />
	</bean>

 	<bean id="personDto2" class="com.example.app.domain.dto.PersonDto" >
		<constructor-arg name="username" value="홍길동2" />
		<constructor-arg name="age" value="55" />
		<constructor-arg name="addr" value="울산" />
	</bean>

	<context:component-scan base-package="com.example.app.config" />

	<!--
		애플리케이션 전체에서 공유되는 설정 파일
		전역 설정 or Bean의 정의
		주로 비즈니스 로직과 관련된 서비스 ,Dao등을 설정
		데이터베이스 연결, 트랜잭션 관리 , 보안설정(Spring Security등..)과 같은 애플리케이션 전체에서 공유되는 설정을 포함
		딱 한번 생성되는 Bean들이 정의되며, 모든 웹 요청에 공유
	-->

</beans>

```

---

### appServlet

---

> servlet-context.xml
> 

```
<?xml version="1.0" encoding="UTF-8"?>
<beans:beans xmlns="<http://www.springframework.org/schema/mvc>"
	xmlns:xsi="<http://www.w3.org/2001/XMLSchema-instance>"
	xmlns:beans="<http://www.springframework.org/schema/beans>"
	xmlns:context="<http://www.springframework.org/schema/context>"
	xsi:schemaLocation="<http://www.springframework.org/schema/mvc> <https://www.springframework.org/schema/mvc/spring-mvc.xsd>
		<http://www.springframework.org/schema/beans> <https://www.springframework.org/schema/beans/spring-beans.xsd>
		<http://www.springframework.org/schema/context> <https://www.springframework.org/schema/context/spring-context.xsd>">

	<!-- DispatcherServlet Context: defines this servlet's request-processing infrastructure -->

	<!-- Enables the Spring MVC @Controller programming model -->
	<annotation-driven />

	<!-- Handles HTTP GET requests for /resources/** by efficiently serving up static resources in the ${webappRoot}/resources directory -->
	<resources mapping="/resources/**" location="/resources/" />

	<!-- Resolves views selected for rendering by @Controllers to .jsp resources in the /WEB-INF/views directory -->
	<beans:bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
		<beans:property name="prefix" value="/WEB-INF/views/" />
		<beans:property name="suffix" value=".jsp" />
	</beans:bean>

	<context:component-scan base-package="com.example.app.controller" />

	<!--
		FrontController 역할을 하는 DispatherServlet설정 파일
		정적 자원의 경로(css,js..) 지정
		MVC Component(@Controller, @Service, @Repository ....)애노테이션 활성화
		View Resolver(Page와 연결을 담당하는 Bean)등 설정
	 -->

</beans:beans>

```

---

### views

---

> home.jsp
> 

```
<%@ taglib uri="<http://java.sun.com/jsp/jstl/core>" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!
</h1>

<P>  The time on the server is ${serverTime}. </P>
</body>
</html>

```

---

### test

---

> abcd.jsp
> 

```
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>ABCD PAGE</h1>
</body>
</html>

```

---

> test1.jsp
> 

```
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>TEST1 PAGE</h1>
</body>
</html>

```

---

### DiTests

---

> Ditests.java
> 

```
package DiTests;

import static org.junit.Assert.assertNotNull;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.example.app.config.PersonComponent;
import com.example.app.domain.dto.PersonDto;
@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
class Ditests {

	@Autowired
	private PersonDto personDto1;

	@Autowired
	private PersonDto personDto2;

	@Autowired
	private PersonDto person03;

	@Autowired
	private PersonDto personBean;

	@Autowired
	private PersonComponent personComponent;
	@Test
	public void test() {
//		System.out.println(personDto1);
//		System.out.println(personDto2);
//		System.out.println(person03);
//		System.out.println(personBean);
//		System.out.println(personComponent);
	}

	@Autowired
	private ApplicationContext applicationContext;
	@Test
	public void test2() {

		assertNotNull(applicationContext);
		System.out.println(applicationContext.getBean("personDto1"));
		System.out.println(applicationContext.getBean("personDto2"));

	}

}

```

---

### resources

---

> log4j.xml
> 

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE log4j:configuration PUBLIC "-//APACHE//DTD LOG4J 1.2//EN" "log4j.dtd">
<log4j:configuration xmlns:log4j="<http://jakarta.apache.org/log4j/>">

	<!-- Appenders -->
	<appender name="console" class="org.apache.log4j.ConsoleAppender">
		<param name="Target" value="System.out" />
		<layout class="org.apache.log4j.PatternLayout">
			<param name="ConversionPattern" value="%-5p: %c - %m%n" />
		</layout>
	</appender>

	<!-- Application Loggers -->
	<logger name="com.example.app">
		<level value="info" />
	</logger>

	<!-- 3rdparty Loggers -->
	<logger name="org.springframework.core">
		<level value="info" />
	</logger>

	<logger name="org.springframework.beans">
		<level value="info" />
	</logger>

	<logger name="org.springframework.context">
		<level value="info" />
	</logger>

	<logger name="org.springframework.web">
		<level value="info" />
	</logger>

	<!-- Root Logger -->
	<root>
		<priority value="info" />
		<appender-ref ref="console" />
	</root>

</log4j:configuration>

```