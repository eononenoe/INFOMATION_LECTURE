# 📚 Spring Security 정리

## 📌 개요 (Overview)

- **Spring Security**는 스프링 기반 애플리케이션의 **인증(Authentication)** 과 **권한(Authorization)** 을 처리하는 보안 프레임워크입니다.
- 웹 애플리케이션, API 서버 모두에 적용 가능하며, 세션 관리, CSRF 보호, 패스워드 암호화, 필터 체인 기반 인증 처리 등을 제공합니다.

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🌟 Spring Security 주요 특징

| 항목         | 설명 |
| :----------- | :--- |
| 인증(Authentication) | 사용자가 누구인지 확인 (로그인 과정) |
| 권한(Authorization) | 인증된 사용자가 요청한 작업을 할 수 있는지 확인 |
| 필터 기반 구조       | 여러 보안 관련 필터가 체인처럼 연결되어 요청을 처리함 |
| 다양한 인증 방식 지원 | Form Login, OAuth2, JWT, HTTP Basic 등 |
| 세션/토큰 기반 인증   | 세션 또는 JWT를 통한 Stateless 인증 가능 |
| 메서드 수준 보안 지원 | `@Secured`, `@PreAuthorize` 등으로 메서드 접근 제어 |

### 🌟 SecurityFilterChain
- Spring Security는 **FilterChain** 구조로 요청을 감싸서 인증/권한 체크를 진행합니다.
- 요청이 들어오면 다양한 Security Filter들을 순서대로 거쳐 최종적으로 인증 여부를 판단합니다.

**대표적인 필터 예시:**
- `UsernamePasswordAuthenticationFilter`: 사용자 로그인 처리
- `BasicAuthenticationFilter`: HTTP Basic 인증 처리
- `SecurityContextPersistenceFilter`: SecurityContext 관리
- `ExceptionTranslationFilter`: 인증/권한 오류 처리

### 🌟 Remember-Me 기능
- 사용자가 로그인할 때 "로그인 상태 유지" 체크박스를 선택하면 세션이 만료되어도 로그인 상태를 유지시켜주는 기능
- 서버는 브라우저에 토큰을 발급해 저장하고, 클라이언트는 이 토큰을 통해 자동 로그인 처리 가능

**Remember-Me 핵심 흐름:**
1. 최초 로그인 시 서버가 Remember-Me 토큰 생성
2. 브라우저 쿠키에 토큰 저장
3. 세션이 사라져도 쿠키를 통해 자동 인증 시도

---

## ⚠ 주의사항 (Cautions)

- Spring Security 설정은 **Filter 기반**이기 때문에 필터 순서에 민감함.
- Remember-Me 토큰 유출에 주의해야 하며, 토큰에는 민감 정보를 직접 담지 말아야 함.
- 기본 설정만 사용하면 편리하지만, 실서비스에서는 반드시 **커스터마이징** 필요 (ex. 커스텀 로그인 실패 핸들러 등)

---

## 🧪 예제 코드 (Examples)

### 📋 Maven 의존성 추가 (pom.xml)
```xml
<!-- Spring Security -->
<dependency>
    <groupId>org.springframework.security</groupId>
    <artifactId>spring-security-web</artifactId>
    <version>5.0.7.RELEASE</version>
</dependency>
<dependency>
    <groupId>org.springframework.security</groupId>
    <artifactId>spring-security-config</artifactId>
    <version>5.0.7.RELEASE</version>
</dependency>
```

### 📋 Security 기본 설정 (Java Config)
```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .authorizeRequests()
                .antMatchers("/admin/**").hasRole("ADMIN")
                .antMatchers("/user/**").hasAnyRole("USER", "ADMIN")
                .anyRequest().authenticated()
            .and()
            .formLogin()
                .loginPage("/login")
                .permitAll()
            .and()
            .rememberMe()
                .key("remember-me-key")
                .tokenValiditySeconds(86400) // 1일 유지
            .and()
            .logout()
                .permitAll();

        return http.build();
    }
}
```

### 📋 Remember-Me 사용 방법
- `rememberMe()` 설정 추가
- `key()`를 지정해 고유 토큰 생성 보장
- `tokenValiditySeconds()`로 유효기간 설정 (초 단위)

```java
http.rememberMe()
    .key("uniqueAndSecret")
    .tokenValiditySeconds(86400); // 하루 유지
```

---

## ✅ 한 줄 요약 (1-Line Summary)

> **Spring Security**는 필터 체인 기반으로 인증과 권한을 처리하며, Remember-Me로 **로그인 상태 유지**도 간편하게 구현할 수 있다! 🔐🚀

