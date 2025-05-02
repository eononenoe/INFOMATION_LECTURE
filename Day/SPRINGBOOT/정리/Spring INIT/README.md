# 🔧 INIT 정리

📌 개요 (Overview)

INIT은 Spring Boot 애플리케이션이 실행될 때 가장 먼저 동작하는 초기화 파일들을 말합니다. 이 파일들은 프로젝트의 시작점을 구성하며, 애플리케이션을 독립 실행하거나 외부 WAS에 배포할 수 있도록 도와줍니다.

💡 핵심 개념 요약 (Key Concepts)

- `@SpringBootApplication`: 컴포넌트 스캔 + 자동 설정 + 설정 클래스 기능을 하나로 합친 어노테이션입니다.
- `SpringApplication.run()`: 애플리케이션을 실행하는 메인 진입점입니다.
- `SpringBootServletInitializer`: WAR로 배포할 때 사용하는 추상 클래스입니다.
- `configure()`: 외부 서버에서 Spring Boot 앱을 실행할 수 있도록 진입점을 지정합니다.

⚠ 주의사항 (Cautions)

- 내장 톰캣을 사용할 경우 `ServletInitializer`는 필요하지 않습니다.
- WAR 배포를 할 계획이 없다면 `configure()`는 생략 가능합니다.

🧪 예제 또는 비유 (Examples or Analogies)

- `DemoApplication`은 **게임을 실행하는 런처** 역할
- `ServletInitializer`는 **외부 설치를 위한 마법사**


---

## 📄 DemoApplication.java

📂 위치: `src/main/java/com/example/demo/DemoApplication.java`

📌 개요 (Overview)

Spring Boot 애플리케이션의 시작점 클래스입니다.

💡 핵심 개념 요약 (Key Concepts)

Spring Boot의 메인 클래스이며, 프로젝트 실행 시 가장 먼저 동작합니다. 내부적으로 자동 설정 및 컴포넌트 스캔을 포함합니다.

⚠ 주의사항 (Cautions)

- `main()` 메서드는 프로젝트에 하나만 존재해야 하며, Spring Boot는 이를 기준으로 애플리케이션을 실행합니다.


🧩 코드 일부 발췌:
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

🧠 등장하는 주요 키워드 설명:

- 🌐 `SpringApplication.run()`: Spring Boot 애플리케이션을 실행하는 정적 메서드입니다.


🧪 예제 또는 비유 (Examples or Analogies)

- `DemoApplication.java`는 게임을 시작하는 **게임 런처**입니다.


---

## 📄 ServletInitializer.java

📂 위치: `src/main/java/com/example/demo/ServletInitializer.java`

📌 개요 (Overview)

외부 WAS 배포를 위한 SpringBootServletInitializer 확장 클래스입니다.

💡 핵심 개념 요약 (Key Concepts)

Spring Boot 프로젝트를 WAR로 패키징해 외부 WAS에 배포할 수 있도록 설정하는 클래스입니다. configure() 메서드를 통해 진입점을 등록합니다.

⚠ 주의사항 (Cautions)

- `main()` 메서드는 프로젝트에 하나만 존재해야 하며, Spring Boot는 이를 기준으로 애플리케이션을 실행합니다.
- 외부 WAS 배포를 하지 않을 경우 ServletInitializer는 필요 없습니다.

🧩 코드 일부 발췌:
```java
package com.example.demo;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
public class ServletInitializer extends SpringBootServletInitializer {
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(DemoApplication.class);
	}
}
```

🧠 등장하는 주요 키워드 설명:

- 🧱 `SpringBootServletInitializer`: WAR 배포를 위한 추상 클래스입니다.
- 🧰 `SpringApplicationBuilder`: 애플리케이션 설정 정보를 구성합니다.
- ⚙ `configure()`: 외부 WAS 배포 시 진입점을 등록하는 메서드입니다.


🧪 예제 또는 비유 (Examples or Analogies)

- `ServletInitializer.java`는 게임을 외부 PC방에서 설치할 수 있도록 하는 **설치 마법사** 역할입니다.


✅ 한 줄 요약 (1-Line Summary)

Spring Boot 초기화를 담당하는 핵심 파일로, 독립 실행과 외부 서버 배포를 모두 가능하게 합니다.
