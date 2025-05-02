# Spring Boot 정리

Spring Boot는 Spring Framework 기반 웹 애플리케이션을 쉽고 빠르게 개발할 수 있도록 도와주는 프레임워크입니다.  
복잡한 설정 없이 실행 가능한 독립형 애플리케이션을 만들 수 있으며, 마이크로서비스나 REST API 개발에 최적화되어 있습니다.

---

## 📌 개요 (Overview)

Spring Boot란  
Spring Framework를 기반으로, 복잡한 XML 설정 없이 웹 애플리케이션을 **간단하고 빠르게 개발**할 수 있게 만든 프레임워크입니다.  
**설정 최소화**, **자동 구성**, **내장 서버 제공**이라는 특징을 통해 생산성과 효율성을 높여줍니다.

---

## 💡 핵심 개념 요약 (Key Concepts)

### 1. 자동 설정 (Auto Configuration)
- 대부분의 설정을 자동으로 구성
- XML 없이 `application.properties` 또는 `application.yml` 파일로 설정 가능

### 2. 내장 웹 서버 제공
- Tomcat, Jetty, Undertow 등 웹 서버 내장
- 별도의 WAS 없이 `java -jar` 명령으로 실행 가능

### 3. 독립 실행형 애플리케이션
- `main()` 메서드 하나로 서버 실행
- 실행 가능한 `.jar` 파일 하나만으로 배포 가능

### 4. 스타터(Starter) 의존성
- 필요한 라이브러리 패키지를 미리 묶은 의존성 제공
  - 예시: `spring-boot-starter-web`, `spring-boot-starter-data-jpa`

### 5. Spring 생태계와의 통합
- Spring Security, Spring Data, Spring Cloud 등과 자연스럽게 연동 가능

### 6. 운영 환경 지원
- Spring Boot Actuator로 상태 확인, 로그, 모니터링, 메트릭 수집 가능

---

## 📅 Spring Boot 버전별 요약

| 버전 | 출시일 | 주요 특징 | 비고 |
|------|--------|-----------|------|
| 1.0.x | 2014.04 | 최초 릴리즈, 스타터 도입 | 초기 버전 (EOL) |
| 1.5.x | 2017.01 | Spring 4 기반, 보안 기능 강화 | 레거시에서 많이 사용 |
| 2.0.x | 2018.03 | Spring 5 기반, WebFlux 도입 | Java 8 이상 필요 |
| 2.1.x | 2018.10 | Java 11 지원, 성능 개선 | 많이 사용된 LTS |
| 2.2.x | 2019.10 | Lazy Init, JUnit 5 도입 |  |
| 2.3.x | 2020.05 | Buildpack, 헬스체크 그룹 | 클라우드 친화적 |
| 2.4.x | 2020.11 | Config import, 설정 구조화 |  |
| 2.5.x | 2021.05 | Gradle 7 지원, 설정 최적화 |  |
| 2.6.x | 2021.11 | Spring Native Preview, PathPatternParser | Native 테스트 |
| 2.7.x | 2022.05 | Spring Boot 2의 마지막 | LTS 유지보수 대상 |
| 3.0.x | 2022.11 | Spring Framework 6, Jakarta EE 9, Java 17 이상 필요 | 대규모 변경 |
| 3.1.x | 2023.05 | 테스트 개선, @ServiceConnection, Docker 연동 강화 |  |
| 3.2.x | 2023.11 | Java 21, Virtual Thread, RestClient 도입 | 최신 Java 최적화 |
| 3.3.x | 2024.05 예정 | GraalVM Native 정식 지원 예상, Micrometer 개선 | 예정 버전 |

---

## 📦 javax vs jakarta 네임스페이스 비교

### 네임스페이스 변화 요약

| 항목 | javax | jakarta |
|------|-------|---------|
| 네임스페이스 | `javax.servlet`, `javax.persistence` 등 | `jakarta.servlet`, `jakarta.persistence` 등 |
| 소속 | Oracle | Eclipse Foundation |
| 기반 표준 | Java EE | Jakarta EE |
| 도입 시기 | Java EE 시대 | Jakarta EE 9 (2020년) |
| 호환 버전 | Spring Boot 2.x 이하 | Spring Boot 3.x 이상 |
| 주요 변화 | 기존 API 유지 | 패키지 명칭 전체 변경 |

### 변경 배경
- Oracle은 Java EE를 Eclipse에 기부하면서 `javax.*` 네임스페이스의 상표권은 유지
- Eclipse는 새로운 표준을 위해 `jakarta.*`로 변경

### Spring Boot에서의 적용

| Spring Boot 버전 | 사용 네임스페이스 | 설명 |
|------------------|------------------|------|
| 2.x 이하 | `javax.*` | 기존 Java EE 표준 사용 |
| 3.x 이상 | `jakarta.*` | Jakarta EE 기반으로 전환 |

### 코드 예시

```java
// Spring Boot 2.x
import javax.servlet.http.HttpServletRequest;
import javax.persistence.Entity;

// Spring Boot 3.x
import jakarta.servlet.http.HttpServletRequest;
import jakarta.persistence.Entity;
```

---

## 🛠 Spring Boot vs STS3 vs STS4 비교

| 항목 | Spring Boot | STS3 | STS4 |
|------|-------------|------|------|
| 종류 | 프레임워크 | 통합 개발 도구 (IDE) | 통합 개발 도구 (IDE) |
| 기반 플랫폼 | 독립 실행형 | Eclipse 기반 | Eclipse / VSCode |
| 중심 기술 | Spring Boot | Spring (XML 중심) | Spring Boot |
| 설정 방식 | 애너테이션 + YAML/Properties | XML 설정 중심 | YAML/Properties 중심 |
| XML 설정 지원 | 지원하지 않음 | 매우 강력 | 일부만 지원 |
| JSP 사용 편의성 | 별도 설정 필요 | 내장 지원 | 불편함 |
| 주요 특징 | 자동 설정, 내장 서버, 스타터 | JSP 친화, 레거시 대응 | Spring Boot 기능 시각화 |
| 추천 용도 | REST API, 마이크로서비스 | JSP 기반 레거시 | 최신 Spring Boot 앱 |
| 장점 | 빠른 실행, 설정 간소화 | 익숙한 환경, JSP 친화 | 가볍고 최신 기능 연동 용이 |
| 단점 | JSP 연동 어려움 | 무겁고 업데이트 중단 예정 | XML 부족, JSP 비호환 |

---

## ⚠ 주의사항 (Cautions)

- Spring Boot 3.x부터는 Java 17 이상 필수
- `javax.*` → `jakarta.*` 전환 필요
- JSP 기반 프로젝트는 STS3 환경에서 개발하는 것이 더 편리할 수 있음

---

## 🧪 예제 또는 비유 (Examples or Analogies)

Spring Framework는 레고 블록처럼 하나하나 조립하는 느낌이라면,  
Spring Boot는 모든 재료가 들어 있는 밀키트 같은 느낌입니다.  
설정과 환경 구성이 모두 갖춰져 있어 빠르고 쉽게 개발할 수 있습니다.

---

## 한 줄 요약 (1-Line Summary)

Spring Boot는 설정을 최소화하고 실행을 자동화하여,  
웹 애플리케이션을 빠르게 개발할 수 있는 Spring 기반 프레임워크입니다.
