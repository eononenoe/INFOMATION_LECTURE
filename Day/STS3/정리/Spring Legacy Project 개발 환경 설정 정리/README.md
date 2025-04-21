# 🌱 Spring Legacy Project 개발 환경 설정 정리

Spring MVC 기반의 Legacy 프로젝트를 시작하기 위한 전체 환경 설정 과정을 정리한 문서입니다.  
STS 설치부터 프로젝트 생성, pom.xml, web.xml 설정, Lombok까지 모두 포함되어 있습니다.

---

## 📌 개요 (Overview)

이 문서는 Spring MVC 기반의 웹 애플리케이션을 STS(Spring Tool Suite)를 이용하여 구성하는 방법을 단계별로 설명합니다.

구성 항목:
- STS 설치
- JDK 설정
- Spring MVC 프로젝트 생성
- pom.xml / web.xml 설정
- Lombok 설정

---

## 💡 핵심 개념 요약 (Key Concepts)

- **STS**: 이클립스 기반의 Spring 전용 통합 개발 환경
- **JDK**: Java 개발 키트, 프로젝트 빌드와 실행에 필수
- **pom.xml**: 프로젝트 의존성과 빌드 정보를 설정하는 Maven 파일
- **web.xml**: 웹 애플리케이션 초기화 설정 파일
- **Lombok**: 자바 코드를 간결하게 만들어주는 애너테이션 기반 라이브러리

---

## ⚙ STS 설치 및 기본 설정

### 1. STS 설치

- STS 3 다운로드: [https://spring.io/tools3/sts/all](https://spring.io/tools3/sts/all)
- 설치 후 실행

---

### 2. JDK 11 설정

- Window > Preferences > Java > Installed JREs
- JDK 11 선택 or 추가
- Compiler 설정: 11

---

### 3. STS 환경 기본 설정

```xml
Window > Preferences > Web > Java EE > Web Project
- Context Root: /프로젝트명
- Content Directory: src/main/webapp
```

```xml
Server 설정: Tomcat 9.0
```

---

## 🚀 Spring MVC Legacy Project 생성

### 1. File > New > Dynamic Web Project

- 이름: 예) legacy-project
- Target runtime: Apache Tomcat v9.0
- Dynamic web module version: 3.1
- 체크 해제: Generate web.xml
- Finish

---

## 📦 pom.xml 설정

```xml
<properties>
  <java-version>11</java-version>
</properties>

<dependencies>
  <!-- Spring Core -->
  <dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-core</artifactId>
    <version>5.3.23</version>
  </dependency>
  
  <!-- Spring Web MVC -->
  <dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-webmvc</artifactId>
    <version>5.3.23</version>
  </dependency>
  
  <!-- JSTL -->
  <dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>jstl</artifactId>
    <version>1.2</version>
  </dependency>

  <!-- Lombok -->
  <dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.24</version>
    <scope>provided</scope>
  </dependency>
</dependencies>

<build>
  <plugins>
    <plugin>
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-compiler-plugin</artifactId>
      <version>3.8.1</version>
      <configuration>
        <source>11</source>
        <target>11</target>
      </configuration>
    </plugin>
  </plugins>
</build>
```

---

## 🌐 web.xml 설정

```xml
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee" 
         version="3.1">

  <display-name>legacy-project</display-name>

  <servlet>
    <servlet-name>appServlet</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
    <load-on-startup>1</load-on-startup>
  </servlet>

  <servlet-mapping>
    <servlet-name>appServlet</servlet-name>
    <url-pattern>/</url-pattern>
  </servlet-mapping>

  <welcome-file-list>
    <welcome-file>index.jsp</welcome-file>
  </welcome-file-list>
</web-app>
```

---

## 🧩 Lombok 설정 (pom.xml)

```xml
<dependency>
  <groupId>org.projectlombok</groupId>
  <artifactId>lombok</artifactId>
  <version>1.18.24</version>
  <scope>provided</scope>
</dependency>
```

### 🛠 추가 설정

- Lombok 설치 파일 실행 후 STS 플러그인 설치 필요

---

## 🧪 예제 또는 비유 (Examples or Analogies)

- **Spring MVC Legacy Project**는 마치 건축물의 뼈대를 짜는 작업과 비슷합니다.
  - `pom.xml`: 건축 자재 목록
  - `web.xml`: 건축 설계도
  - DispatcherServlet: 출입문 관리 시스템
  - Controller: 안내 데스크

---

## ⚠ 주의사항 (Cautions)

- JDK와 Maven 설정이 일치하지 않으면 컴파일 오류 발생 가능
- Lombok은 별도 설치 및 IDE 연동 필요 (안 하면 애너테이션이 작동 안 함)
- STS에서 자동 생성되는 설정 파일들은 프로젝트 구조에 따라 다를 수 있음

---

## ✅ 한 줄 요약 (1-Line Summary)

Spring Legacy Project는 STS + Spring MVC + Maven + Lombok 설정을 통해 구성되는 Java 웹 앱의 뼈대입니다. 💻🧱

