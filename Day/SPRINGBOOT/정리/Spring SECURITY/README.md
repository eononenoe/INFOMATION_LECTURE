# Spring Security 6.x (Spring Boot 3.x) vs Spring 5 (STS3) 그룹 보안 정보 정리

## 통합 개요

* Spring Boot 3.x과 글러시츠 STS3(Spring 5.x)의 Spring Security 구조 차이, 설정 방식, 포스\uud2b8-문드가 변화되어 다가온다.
* 개발 환경, Java 방식, OAuth2, JWT, Redis와 연계한 구조가 많이 변경되었기 때문에 다양한 관련 서비스의 유저정리가 필요하다.

---

## 환경 차이

| 그룹                           | STS3(Spring 5.x)    | Spring Boot 3.x                  |
| ---------------------------- | ------------------- | -------------------------------- |
| 설정 스택                        | XML + JavaConfig 혼합 | JavaConfig 중심 (람다식)              |
| 버전                           | Spring Security 5.x | Spring Security 6.x 이상           |
| WebSecurityConfigurerAdapter | 사용                  | 폐지 (SecurityFilterChain Bean 등록) |
| 서비스 버전                       | Servlet 3.0\~3.1    | Servlet 5.0 이상                   |
| JDK 버전                       | 8\~11               | 17 이상                            |

---

## 의존성 설정

### Spring 5.x

```xml
<dependency>
    <groupId>org.springframework.security</groupId>
    <artifactId>spring-security-web</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.security</groupId>
    <artifactId>spring-security-config</artifactId>
</dependency>
```

### Spring Boot 3.x

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

---

## 보안 설정 방식

### Spring 5.x

```java
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .authorizeRequests()
                .antMatchers("/admin/**").hasRole("ADMIN")
                .anyRequest().permitAll()
            .and()
                .formLogin();
    }
}
```

### Spring Boot 3.x

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        return http
            .authorizeHttpRequests(authorize -> authorize
                .requestMatchers("/admin/**").hasRole("ADMIN")
                .anyRequest().permitAll()
            )
            .formLogin(Customizer.withDefaults())
            .build();
    }
}
```

* **차이점**: WebSecurityConfigurerAdapter 사용 가능 방식 가 원칙적으로 해제되었고, 이에 대해 “SecurityFilterChain” 비어 스팅브를 개발자가 만들어야 한다.

---

## 기본 로그인 동작 차이

| 항목          | STS3                              | Spring Boot 3.x                              |
| ----------- | --------------------------------- | -------------------------------------------- |
| 기본 로그인 페이지  | 수동 설정 가능                          | 기본 제공 /login 경로 생성                           |
| 기본 사용자      | InMemory 설정                       | console에 임시 사용자 표시                           |
| 커스텀 로그인 페이지 | .formLogin().loginPage("/custom") | formLogin(form -> form.loginPage("/custom")) |

---

## CSRF(Cross Site Request Forgery)

### 개념

* 인증된 사용자의 의지와 무관한 요청을 수행하도록 유도하는 공격
* 동시에 CSRF가 확인된 상황에서 특정 POST 개인 형의 요청을 한것처럼 발생

### 동작 방식

1. 서버: 세션/쿠키 기반 토큰 생성 및 저장
2. 클라이언트: form hidden 필드 또는 Ajax Header에 포함
3. 서버: 전달된 토큰과 세션 토큰을 비교

### 예제

```html
<form method="post" action="/submit">
  <input type="hidden" name="_csrf" value="..." />
  <button type="submit">제출</button>
</form>
```

### 비활성화 (개발 또는 API 전용 서버에서만)

```java
http.csrf().disable();
```

> 실 서비스에서는 반드시 활성화 권장

---

## CORS(Cross-Origin Resource Sharing)

### 개념

* SOP(Same Origin Policy)가 일정… 다른 초처 origin(프로토컴 + 도메인 + 포트)에 대한 회의를 제한

### 설정 방식

#### Controller 단위

```java
@CrossOrigin(origins = "http://localhost:3000")
```

#### 전역 설정

```java
@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
            .allowedOrigins("http://localhost:3000")
            .allowedMethods("GET", "POST")
            .allowCredentials(true);
    }
}
```

#### Security 설정

```java
http.cors();
```

### 주의사항

* allowCredentials(true) 사용 시 `allowedOrigins("*")` 금지
* 브라우저 캐시 삭제 필요 (설정 바뀌었을 경우 적용 안됨)

---

## OAUTH2 인증 흐름 요약

1. 사용자가 로그인 버튼 클릭
2. 클라이언트가 Authorization Server에 인증 요청 (구글, 카카오, 네이버 등)
3. 사용자 동의 후 Authorization Code 발급
4. Code를 이용해 Access Token 획득
5. Access Token으로 사용자 정보 요청

### 핵심 설정 정보

* `client-id`, `client-secret`, `redirect-uri`
* `scope`: 접근 범위 (예: email, profile)
* `user-name-attribute`: JSON에서 사용자명에 해당하는 key

### Spring Security 코드 예시

```java
http.oauth2Login(oauth2 ->
    oauth2.loginPage("/login")
);
```

---

## JWT + Redis 구조 요약

| 구성 요소                  | 설명                                       |
| ---------------------- | ---------------------------------------- |
| JWT Access Token       | 사용자 인증 완료 후 발급. 클라이언트 쿠키에 저장             |
| JWT Refresh Token      | Access Token 만료 시 재발급 용. Redis에 저장       |
| Redis                  | Refresh Token 저장소, TTL 적용 가능             |
| JwtTokenProvider       | JWT 발급, 검증 처리 클래스                        |
| JwtAuthorizationFilter | 요청 필터에서 인증 수행 (Access -> Refresh 순으로 확인) |

### Redis 저장 예

```java
redisTemplate.opsForValue().set("RT:user123", refreshToken, Duration.ofDays(7));
```

### Redis 조회 및 삭제

```java
String token = redisTemplate.opsForValue().get("RT:user123");
redisTemplate.delete("RT:user123");
```

---

## 실습 요약 포인트

* Spring Boot 3.x에서는 모든 보안 구성은 JavaConfig 기반 람다식으로 정리됨
* WebSecurityConfigurerAdapter 폐지됨 → SecurityFilterChain 사용
* OAUTH2 및 JWT 인증 시 Redis와 연계된 고급 인증 시스템 구현 가능
* JWT 사용 시 RefreshToken 관리가 핵심, Redis 사용으로 확장성 증가
* 각 인증 흐름은 명확한 단계로 분리되어 있어 유지보수 용이
