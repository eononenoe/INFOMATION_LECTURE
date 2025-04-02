# 🧱 미들웨어(Middleware) & Java 개발 환경 구축 가이드

---

## 📌 개요 (Overview)

웹 애플리케이션을 개발하려면 **하드웨어 ↔ 사용자 프로그램** 사이를 연결해주는  
**미들웨어(Middleware)**가 필요해요.  
이 문서에서는 미들웨어 개념부터 Java, Tomcat, Eclipse 설치와 연동까지 과정을 정리합니다.

---

## 💡 핵심 개념 요약 (Key Concepts)

---

### 🧠 소프트웨어/하드웨어/미들웨어

```jsx
ware       : 제품, 구성요소
hardware   : CPU, RAM, DISK 같은 부품
software   : 하드웨어를 활용하기 위한 컴퓨터 프로그램
```

#### 소프트웨어 종류

- **System Software** : OS, 파일/자원 관리
- **Application Software** : 사용자 목적 수행 (게임, 웹브라우저 등)
- **Middleware** : OS와 Application 사이에서 통신 중개

---

### 🔥 JAVA 삭제

```jsx
JAVA_HOME 삭제
Path - JAVA 관련 항목 삭제
```

- 환경 변수에서 JAVA 관련 설정 제거

---

### 🧱 JDK 설치

- Java Development Kit (개발자용 자바 도구 모음)
- 설치 후 환경 변수 설정 필요:  
  `JAVA_HOME`, `Path` 등에 추가

---

### 🐱 Tomcat 설치

- Apache Tomcat: **Java 기반 웹 서버 (Servlet Container)**  
- 웹 애플리케이션을 실행할 수 있는 서버 플랫폼

---

### 🌘 Eclipse 설치

- Eclipse IDE: Java 개발용 통합 개발 환경
- 다양한 플러그인을 통해 웹, 서버 개발에도 활용 가능

---

### 🔁 Eclipse + Tomcat 연동

- Eclipse에서 Tomcat 서버 등록
- 실행할 프로젝트에 Tomcat 연동 설정
- `Run on Server` 기능으로 웹 애플리케이션 실행 가능

---

### ⚙️ 프로젝트 설정

- Dynamic Web Project 생성
- WEB-INF, web.xml 구성
- servlet 클래스 작성 및 맵핑 설정

---

## ⚠ 주의사항 (Cautions)

- JDK와 Tomcat은 버전 호환성 주의!
- 환경 변수 설정을 꼼꼼히 해야 에러 발생 없음
- Eclipse에 Tomcat 서버가 정상 연동됐는지 항상 확인

---

## 🧪 예제 또는 비유 (Examples or Analogies)

| 개념         | 비유 설명                          |
|--------------|-------------------------------------|
| Java         | 웹 애플리케이션을 만드는 언어       |
| JDK          | 자바 개발용 도구 상자               |
| Tomcat       | 웹사이트를 보여주는 무대 (서버)     |
| Eclipse      | 무대 장치를 조종하는 컨트롤러 (IDE) |
| Middleware   | 번역가 (OS ↔ 사용자 프로그램)       |

---

## ✅ 한 줄 요약 (1-Line Summary)

> 미들웨어는 소프트웨어 간 통역사이고, Java + Tomcat + Eclipse는 웹 개발을 위한 완벽한 팀이에요! ☕🧱🌐

---
