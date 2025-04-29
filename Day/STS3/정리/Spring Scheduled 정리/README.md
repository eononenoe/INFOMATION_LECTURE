# 📚 Spring Scheduled 정리

## 📌 개요 (Overview)

- **Spring Scheduling**은 정해진 시간마다 또는 일정한 주기로 자동으로 특정 작업을 실행할 수 있도록 도와주는 기능입니다.
- 스프링에서는 `@Scheduled` 어노테이션을 통해 손쉽게 **크론(Cron) 기반 작업**, **지연 시간 기반 반복 작업** 등을 구현할 수 있습니다.
- 배치 작업, 정기적인 알림, 로그 정리, 데이터 동기화 등에 활용됩니다.

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🌟 주요 어노테이션

| 어노테이션       | 설명 |
|------------------|------|
| `@Scheduled`     | 메서드에 붙여 정기 실행을 지정 |
| `@EnableScheduling` | 스케줄링 기능을 프로젝트에서 활성화함 |
| `@Component`     | 스케줄링 클래스를 빈으로 등록하기 위해 사용 |

### 🌟 스케줄 방식 종류

| 방식 | 속성 | 예시 | 설명 |
|------|------|------|------|
| Fixed Rate | `fixedRate` | `@Scheduled(fixedRate = 5000)` | 이전 실행과 관계없이 매 5초마다 실행 |
| Fixed Delay | `fixedDelay` | `@Scheduled(fixedDelay = 5000)` | 이전 작업이 끝난 후 5초 후 실행 |
| Initial Delay | `initialDelay` | `@Scheduled(initialDelay = 2000, fixedRate = 5000)` | 앱 시작 후 2초 후 첫 실행 |
| Cron | `cron` | `@Scheduled(cron = "0 0/1 * * * ?")` | 매 분마다 실행 (크론 표현식 기반) |

---

## 🧪 예제 코드 (Examples)

### 📋 스케줄링 클래스 예시 (Scheduling.java)
```java
@Component
@EnableScheduling
public class Scheduling {

    @Scheduled(fixedRate = 10000) // 10초마다 실행
    public void printTimeEvery10Seconds() {
        System.out.println("💡 현재 시각: " + LocalDateTime.now());
    }

    @Scheduled(cron = "0 0/1 * * * ?") // 매 분 0초마다 실행
    public void runEveryMinute() {
        System.out.println("✅ 1분마다 실행되는 작업: " + LocalDateTime.now());
    }
}
```

### 📋 설정 클래스 예시
```java
@Configuration
@EnableScheduling
@ComponentScan(basePackages = "com.example.app")
public class AppConfig {
    // 스케줄러가 동작하도록 설정
}
```

---

## ⚠ 주의사항 (Cautions)

- `@EnableScheduling`이 설정 클래스에 반드시 있어야 스케줄이 활성화됩니다.
- `@Scheduled`가 붙은 메서드는 **반환값이 없어야 하며**, **파라미터도 없어야** 합니다.
- 스케줄 메서드는 **빈(bean)으로 등록된 클래스** 내부에 있어야 작동합니다.
- 크론 표현식 작성 시 오타 또는 의미 해석 오류에 주의해야 합니다.

---

## 🧠 크론 표현식 구조

| 필드 | 설명 | 예시 |
|------|------|------|
| 초   | 0~59 | 0 |
| 분   | 0~59 | 0/1 → 매 1분마다 |
| 시   | 0~23 | 12 |
| 일   | 1~31 | * |
| 월   | 1~12 | * |
| 요일 | 0(Sun)~6(Sat) | ? 또는 * |

예:  
- `"0 0/5 * * * ?"` → 매 5분마다 실행  
- `"0 0 9 * * MON-FRI"` → 평일 오전 9시에 실행

---

## ✅ 한 줄 요약 (1-Line Summary)

> **Spring Scheduled**는 정해진 간격 또는 크론 표현식을 기반으로 자동으로 작업을 실행할 수 있는 매우 강력한 반복 작업 기능이다! ⏰🚀
