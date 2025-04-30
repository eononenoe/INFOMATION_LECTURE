
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

---

## 🔁 SecurityFilterChain 구조

![필터 체인 구조](/img%20(1).png)

- Spring Security는 **FilterChain** 구조로 요청을 감싸서 인증/권한 체크를 진행합니다.
- 요청이 들어오면 다양한 Security Filter들을 순서대로 거쳐 최종적으로 인증 여부를 판단합니다.

### 🔐 대표적인 필터들

| 필터명 | 설명 |
|------|------|
| `SecurityContextPersistenceFilter` | 인증정보를 `SecurityContext`에 저장/복원 |
| `UsernamePasswordAuthenticationFilter` | 로그인 폼 기반 아이디/비밀번호 인증 |
| `BasicAuthenticationFilter` | HTTP Basic 인증 처리 |
| `ExceptionTranslationFilter` | 인증/인가 예외 처리 |
| `LogoutFilter` | 로그아웃 처리 |
| `FilterSecurityInterceptor` | 인가 처리 및 접근 결정 |

---

## 🔐 인증 처리 흐름

![인증 처리 흐름](/img.png)

1. 사용자가 로그인 폼에 ID/PW 입력
2. `UsernamePasswordAuthenticationToken` 객체에 담김
3. `AuthenticationManager`를 통해 `AuthenticationProvider`로 전달
4. `UserDetailsService`가 DB에서 사용자 정보 조회
5. 일치 시 인증 성공 → `SecurityContextHolder`에 저장

---

## 🔐 Remember-Me 기능 (자동 로그인)

- 사용자가 로그인할 때 "로그인 상태 유지"를 체크하면 세션이 만료되어도 로그인 상태 유지
- 쿠키를 통해 토큰을 저장하고, 이후 자동 인증 시도

###  핵심 동작

```java
http.rememberMe()
    .key("remember-me-key")
    .tokenValiditySeconds(86400); // 하루 유지
```

###  토큰 저장 방식

- `TokenBasedRememberMeServices`: 단순 해시 토큰 쿠키 저장
- `PersistentTokenBasedRememberMeServices`: DB에 저장된 토큰 사용
- 둘 모두 `UserDetailsService`가 필요함

---

## 🏗 Layered Architecture vs MVC

### MVC 구조

![3계층 아키텍처 (단순)](/img%20(2).png)

- Model: 데이터/비즈니스 로직
- View: 사용자에게 보이는 화면
- Controller: 입력 수신, 흐름 제어

### 3계층 아키텍처 (Layered Architecture)

![3계층 아키텍처 상세](/img%20(3).png)

- Presentation Layer
- Service Layer
- Data Access Layer

MVC는 Layered Architecture 내부에 포함될 수 있는 구현 패턴입니다.

---

## 🧪 예제 코드 (Examples)

### 📋 Maven 의존성 추가

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

### 📋 Security 설정 (Java Config)

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
                .tokenValiditySeconds(86400)
            .and()
            .logout()
                .permitAll();
        return http.build();
    }
}
```

---

## 🛠 사용자 인증 흐름 예시

### 📦 User Entity

```java
@Entity
public class User implements UserDetails {
    @Id
    @GeneratedValue
    private Long id;
    private String email;
    private String password;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority("user"));
    }

    @Override public String getUsername() { return email; }
    @Override public String getPassword() { return password; }
    @Override public boolean isAccountNonExpired() { return true; }
    @Override public boolean isAccountNonLocked() { return true; }
    @Override public boolean isCredentialsNonExpired() { return true; }
    @Override public boolean isEnabled() { return true; }
}
```

### 📦 UserRepository

```java
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
}
```

### 📦 UserDetailsService 구현

```java
@RequiredArgsConstructor
@Service
public class UserDetailService implements UserDetailsService {
    private final UserRepository userRepository;

    @Override
    public User loadUserByUsername(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException(email));
    }
}
```

---

## 한 줄 요약 (1-Line Summary)

> **Spring Security**는 필터 체인 기반으로 인증과 권한을 처리하며, Remember-Me 기능과 구조화된 설계를 통해 보안성과 확장성을 동시에 제공한다! 🔐🚀
