# JSP_SERVLET
---


- ## Day_62
  - JSP 구동환경 만들기
    - TomCat 설치
    - Eclipse
    - Eclipse 프로젝트 생성
    - Emmit 설치
    - Tern 설치

- ## Day_63
  - 선언문
  - 스트립틀릿
  - 테이블 추가
  - Request_Get
  - Request_Process
  - Request_Post
  - Request_Process
  - JSP_TO_JS
  - JS_TO_JSP

- ## Day_64
  - ReqNavStyle
  - Result
  - Page
    - Import
    - Error
    - Index
  - Include
    - Main
    - Footer
    - Nav
    - TopHeader
  - Forward
    - Start
    - Page
    - Result
  - Redirect
    - Start
    - Page
    - Result
  - dbUtils
  - errors
  - join_form
  - join
  - login_form
  - validationCheck
  - myinfo_form
  - myinfo
  - UserDto

- ## Day_65
  - PageContext
  - Request
  - Response
  - Download_SingleFile
  - Download_zip
  - DownloadLink
  - Out
  - Jsession_test
  - 01
    - getSession
    - setSession
  - 02
    - login_form
    - login
    - main
    - logout
  - 03
    - getCookie
    - setCookie
    - deleteCookie

- ## Day_66
  - login_form
  - login
  - logout
  - main
  - 01EL
    - form
    - result
  - 02JSTL
    - getCookie
  - USER
    - join_form
    - join
    - index
    - selectAll
    - update_form 
    - update
  -  DBUtils

- ## Day_67
  - DTO
    - OrderDto
    - OrderDto2
    - OrderDto3
  - Order
    - selectAll_1
    - selectAll_2
  - 지역구의원투표
    - Utils
      - DBUtils
      - MemberDto
    - Layouts
      - Footer
      - Header
      - Nav
    - 01
      - Index
      - Index 

- ## Day_68
  - 지역구의원투표
    - Utils
      - DBUtils
      - MemberDto
      - VoteDto
    - 02
      - create
      - index
      - read
    - 03
      - index
  - 03HRDKOREA
    - Utils
      - DBUtils
      - TeacherDto
      - index

- ## Day_69
  - 골프연습장 회원관리
    - Utils
      - DBUtils
      - ClassDto
      - Join1Dto
      - Join2Dto
      - MemberDto
      - TeacherDto
      - VoteDto
    - 01
      - index
      - create
      - delete
      - read
      - update
    - 02
      - index
      - create
      - delete
      - read
      - update
    - 03
      - index
      - create
      - delete
      - read
      - update
    - 04
      - index
      - create
      - delete
      - read
      - update
  - 공통
    - index
    - template
    - layouts
      - Header
      - Nav
      - Footer

- ## Day_70
  - Servlet
    - C01Servlet_Test.java
    - C02Servlet_Test.java
    - C03Servlet_Test.java
    - C04Servlet_Test.java
    - C05Servlet_Test.java
  - webapp
    - index.jsp
  - WEB-INF
    - join.jsp
    - login.jsp
    - main.jsp
  - Servlets
    - Home.java
    - Join.java
    - Login.java
  - Utils
    - MysqlDbUtils.java
    - OracleDBUtils.java
    - UserDto.java
  - user
    - join.jsp
    - login.jsp
  - Filter
    - C01Filter_Test.java
    - C02Filter_Test.java
    - UTF8_EncodingFilter.java

- ## Day_70
  - 06FILTER 프로젝트
    - Filter
      - C01Filter_Test.java
      - C02Filter_Test.java
      - UTF8_EncodingFilter.java
      - LoginRedirectFilter.java
      - PermissionFilter.java
    - Servlet
      - Home.java
      - Join.java
      - Login.java
      - AdminMain.java
      - ManagerMain.java
      - UserMain.java
    - Utils
      - MysqlDbUtils.java
      - OracleDBUtils.java
      - UserDto.java
    - Type
      - Role.java
    - webapp
      - WEB-INF
        - index.jsp
        - main.jsp
        - user
          - join.jsp
          - login.jsp
          - admin.jsp
          - manager.jsp
          - user.jsp
  - 07LISTENER 프로젝트
    - Listener
      - C01ServletContextListener.java
      - C02ServletContextAttributeListener.java
      - C03HttpSessionListener.java
      - C04HttpSessionAttributeListener.java
      - C05ServletRequestListener.java
      - C06ServletRequestAttributeListener.java
    - Servlet
      - C02ListenerTest.java
      - C03ListenerTest.java
      - C05ListenerTest.java
    - webapp
      - index.jsp
      - WEB-INF
        - web.xml
  - 08RESOURCE 프로젝트
    - Servlets
      - Home.java
      - Join.java
      - Login.java
    - Utils
      - MysqlDbUtils.java
      - OracleDBUtils.java
      - UserDto.java
    - webapp
      - index.jsp
      - WEB-INF
        - index.jsp
        - main.jsp
        - user
          - join.jsp
          - login.jsp
        - lib
          - mysql-connector-j-9.2.0.jar
          - ojdbc6.jar
        - web.xml
      - META-INF
        - context.xml

- ## Day_71
  - 08RESOURCE
    - settings
      - org.eclipse.wst.common.project.facet.core.xml
    - Filter
      - UTF8_EncodingFilter.java
    - Servlets
      - Home.java
      - Join.java
      - Login.java
    - Utils
      - MysqlDbUtils.java
      - OracleDBUtils.java
      - UserDto.java
    - webapp
      - index.jsp
    - META-INF
      - MANIFEST.MF
      - context.xml
    - WEB-INF
      - index.jsp
      - main.jsp
      - web.xml
    - user
      - join.jsp
      - login.jsp
  - 09MVC_INIT
    - Controller
      - FrontController.java
      - HomeController.java
      - SubController.java
      - UserCreateController.java
    - Dao
      - BookDao.java
      - BookDaoImpl.java
      - Dao.java
      - UserDao.java
      - UserDaoImpl.java
    - ConnectionPool
      - ConnectionItem.java
      - ConnectionPool.java
      - MysqlXADataSourceFactory.java
    - Filter
      - UTF8_EncodingFilter.java
    - WEB-INF
      - web.xml
    - view
      - error.jsp
      - index.jsp
      - template.jsp
      - create.jsp
      - error.jsp
    - css
      - common.css
    - js
      - common.js
    - layouts
      - footer.jsp
      - link.jsp
      - nav.jsp
      - topHeader.jsp
  - 10MVC_USER
    - Controller
      - FrontController.java
      - HomeController.java
      - SubController.java
      - UserCreateController.java
    - Dao
      - BookDao.java
      - BookDaoImpl.java
      - Dao.java
      - UserDao.java
      - UserDaoImpl.java
    - ConnectionPool
      - ConnectionItem.java
      - ConnectionPool.java
      - MysqlXADataSourceFactory.java
    - Dto
      - UserDto.java
    - Service
      - UserServiceImpl.java
    - Filter
      - UTF8_EncodingFilter.java
    - Tests
      - DaoTests.java
    - META-INF
      - context.xml
    - WEB-INF
      - web.xml
    - view
      - error.jsp
      - index.jsp
      - template.jsp
      - create.jsp
      - error.jsp
    - css
      - common.css
    - js
      - common.js
    - layouts
      - footer.jsp
      - link.jsp
      - nav.jsp
      - topHeader.jsp

- ## Day_72
  - Controller
    - FrontController.java
    - HomeController.java
    - SubController.java
  - Controller/user
    - UserCreateController.java
    - UserLoginController.java
    - UserLogoutController.java
  - Domain/Dao/ConnectionPool
    - ConnectionItem.java
    - ConnectionPool.java
  - Domain/Dao
    - Dao.java
    - UserDao.java
    - UserDaoImpl.java
  - Domain/Dto
    - UserDto.java
  - Domain/Service
    - UserServiceImpl.java
  - Filter
    - UTF8_EncodingFilter.java
  - Tests
    - DaoTests.java

- ## Day_73
  - Controller
    - FrontController.java
    - SubController.java
    - HomeController.java
  - Controller/book
    - BookCreateController.java
    - BookReadController.java
  - Controller/user
    - UserCreateController.java
  - WEB-INF/view/book
    - create.jsp
    - read.jsp
  - WEB-INF/view/user
    - create.jsp

- ## Day_74
  - Controller
    - FrontController.java
    - SubController.java
    - HomeController.java
  - Controller/book
    - BookDeleteController.java
    - BookUpdateController.java
  - WEB-INF/view/book
    - delete.jsp
    - update.jsp
  - Domain/Dto
    - BookDto.java
  - Domain/Service
    - BookServiceImpl.java

- ## Day_75
  - Controller
    - FrontController.java
    - SubController.java
    - HomeController.java
    - 테스트 컨트롤러
      - SimpleController.java
  - Controller/book
    - BookDeleteController.java
    - BookUpdateController.java
  - View (JSP)
    - WEB-INF/view/book
      - delete.jsp
      - update.jsp
    - 기타 View
      - home.jsp
      - abcd.jsp
      - test1.jsp
  - Domain
    - Dto
      - BookDto.java
      - PersonDto.java
    - Service
      - BookServiceImpl.java
  - Config
    - PersonComponent.java
    - PersonDtoBeanConfig.java
  - XML 설정파일
    - Spring 설정
      - WEB-INF/spring/appServlet/servlet-context.xml
      - WEB-INF/spring/root-context.xml
    - Web 설정
      - WEB-INF/web.xml
  - Resources
    - log4j.xml
  - Tests
    - Ditests.java
