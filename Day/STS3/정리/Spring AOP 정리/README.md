# 📚 Spring AOP 정리

## 📌 개요 (Overview)

- **AOP**는 Aspect Oriented Programming(관점 지향 프로그래밍)의 약자입니다.
- 프로그램을 핵심 비즈니스 로직(주된 기능)과 부가 기능(로깅, 트랜잭션 등)으로 나누어 **관심사를 분리(Separation of Concerns)**하는 방식입니다.
- 중복되는 코드(흩어진 관심사, Crosscutting Concerns)를 모듈화하여 코드의 **유지보수성**과 **재사용성**을 높입니다.

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🌟 AOP 주요 용어

| 용어        | 설명 |
| :---------- | :--- |
| Aspect      | 공통 기능을 모듈화한 것 (ex. 로깅, 보안, 트랜잭션) |
| Target      | Aspect를 적용할 대상 (ex. 클래스, 메서드) |
| Advice      | 실제로 실행될 부가 기능의 코드 (ex. 메서드 호출 전 로깅) |
| JoinPoint   | Advice가 적용될 수 있는 지점 (ex. 메서드 호출, 생성자 호출 등) |
| PointCut    | JoinPoint 중 Advice가 적용될 구체적인 조건을 설정하는 것 |


### 🌟 스프링 AOP 특징
- **프록시 패턴** 기반으로 동작
- **Spring Bean**에만 AOP 적용 가능
- 핵심 기능과 부가 기능을 깔끔하게 분리
- **엔터프라이즈 환경**에서 중복 코드 제거, 관계 복잡성 감소를 목표로 함

### 🌟 AOP 애노테이션 정리

| 애노테이션         | 설명 |
| :----------------- | :--- |
| `@Before`          | 타겟 메소드 실행 **이전**에 수행 |
| `@After`           | 타겟 메소드가 **끝난 후** (성공, 실패 모두 포함) 수행 |
| `@AfterReturning`  | 타겟 메소드가 **정상적으로 반환**된 후 수행 |
| `@AfterThrowing`   | 타겟 메소드 실행 중 **예외 발생** 시 수행 |
| `@Around`          | 타겟 메소드 실행 **전후** 모두 수행 (가장 강력) |

---

## ⚠ 주의사항 (Cautions)

- 스프링 AOP는 **런타임 시 프록시 객체**를 생성해 동작합니다.
- 기본적으로 **메서드 실행 지점**(Method Execution)만 지원합니다.
- 내부 메서드 호출(self-invocation)에는 AOP가 적용되지 않으니 주의해야 합니다.

---

## 🧪 예제 코드 (Examples)

### 🧠 Pointcut 표현식 예시

| 표현식 예시 | 설명 |
|:-----------|:-----|
| `execution(* com.example..*.*(..))` | com.example 하위 모든 메서드에 적용 |
| `execution(public * *(..))` | 모든 public 메서드에 적용 |
| `execution(* *..save*(..))` | 이름이 save로 시작하는 메서드에 적용 |

---

### 📋 AOP 설정 클래스
```java
@Aspect
@Component
public class LoggingAspect {

    @Before("execution(* com.example.service.*.*(..))")
    public void beforeMethod(JoinPoint joinPoint) {
        System.out.println("[Before] " + joinPoint.getSignature().getName());
    }

    @AfterReturning("execution(* com.example.service.*.*(..))")
    public void afterReturningMethod(JoinPoint joinPoint) {
        System.out.println("[AfterReturning] " + joinPoint.getSignature().getName());
    }

    @AfterThrowing("execution(* com.example.service.*.*(..))")
    public void afterThrowingMethod(JoinPoint joinPoint) {
        System.out.println("[AfterThrowing] " + joinPoint.getSignature().getName());
    }

    @Around("execution(* com.example.service.*.*(..))")
    public Object aroundMethod(ProceedingJoinPoint joinPoint) throws Throwable {
        System.out.println("[Around-Before] " + joinPoint.getSignature().getName());
        Object result = joinPoint.proceed();
        System.out.println("[Around-After] " + joinPoint.getSignature().getName());
        return result;
    }
}
```

### 📋 PointCut 예시
```java
// com.example.service 패키지 하위의 모든 메서드에 적용
execution(* com.example.service..*(..))

// 특정 클래스의 특정 메서드에만 적용
execution(public String com.example.service.UserService.findUser(..))
```

---

## ✅ 한 줄 요약 (1-Line Summary)

> AOP는 **핵심 비즈니스 로직과 부가 기능(로깅, 트랜잭션 등)을 분리**해 코드 품질을 높이고, **Spring AOP**는 프록시 기반으로 동작한다! 🚀

