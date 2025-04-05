# 🌟 JSP 구동환경 셋팅 가이드 (Tomcat + Eclipse)

---

## 📌 개요 (Overview)

JSP(Java Server Pages) 개발을 위해 **Tomcat 서버**와 **Eclipse IDE** 환경을  
올바르게 설정하는 전체 과정을 순서대로 정리했습니다!  

누구나 따라할 수 있도록, 초보자도 쉽게 이해할 수 있게 작성했어요 🚀

---

## 💡 핵심 설치 및 설정 항목 (Key Setup Items)

| 항목             | 내용                              |
|------------------|-----------------------------------|
| **Tomcat 설치**  | 서버 포트 8090 설정 필수          |
| **Eclipse 설정** | UTF-8 인코딩 통일                |
| **프로젝트 생성** | Dynamic Web Project 생성          |
| **Emmet 설치**   | HTML/CSS 자동완성 플러그인 설치    |
| **Tern 설치**    | JavaScript 자동완성 플러그인 설치 |

---

## 🛠️ 설치 및 설정 과정 (Step-by-Step)

### 1️⃣ Tomcat 설치

- Tomcat 설치 시 **Connector Port**를 반드시 `8090`으로 설정하세요.
- 이유 : 기본 포트 `8080`과 충돌을 피하기 위해 별도로 설정합니다.

### 2️⃣ Eclipse 환경 설정

- Eclipse 모든 인코딩을 **UTF-8**로 설정합니다.
  - Window → Preferences → General → Workspace → Text file encoding: UTF-8
  - Window → Preferences → Web → HTML Files → Encoding: UTF-8
  - Window → Preferences → Web → JSP Files → Encoding: UTF-8
  - Window → Preferences → Java → Compiler → Encoding: UTF-8

### 3️⃣ Dynamic Web Project 생성

1. File → New → Dynamic Web Project 선택
2. 프로젝트 이름 입력
3. Target Runtime: Apache Tomcat 9.0 선택
4. Configuration: Dynamic Web Module 4.0 선택
5. **web.xml 생성 체크박스 활성화**
6. 프로젝트 생성 완료

### 4️⃣ Emmet 설치

- HTML/CSS 코딩 자동화를 지원하는 플러그인입니다.

설치 경로:
```bash
http://download.emmet.io/eclipse/updates/
```

- Eclipse → Help → Install New Software → 위 URL 추가 후 설치 진행

### 5️⃣ Tern 설치

- JavaScript 코딩 자동완성을 지원하는 플러그인입니다.

설치 경로:
```bash
https://github.com/angelozerr/tern.java/
```

- Eclipse → Help → Install New Software → GitHub 페이지 참고하여 설치 진행

---

## ⚠ 주의사항 (Cautions)

- **Tomcat 버전**과 **Eclipse 버전** 호환성을 꼭 맞추세요.
- Dynamic Web Project 생성 시, 꼭 **Deployment Descriptor(web.xml)** 추가할 것.
- Emmet, Tern 설치 시에는 **인터넷 연결**이 필요합니다.
- 설치 중 문제 발생 시 Eclipse를 재시작하세요.

---

## 🧠 쉽게 기억하는 비유 (Examples or Analogies)

| 개념          | 비유 설명 |
|---------------|-----------|
| Tomcat 서버   | 요리를 직접 제공하는 주방장 (서버) |
| Eclipse IDE   | 레시피를 작성하는 주방 노트 (IDE) |
| Port 8090     | 레스토랑 입구 번호 (충돌 피하기!) |
| Emmet         | 빠른 재료 세팅 툴 (HTML 자동 생성) |
| Tern          | 빠른 조리법 추천사 (JS 자동완성) |

---

## ✅ 한 줄 요약 (1-Line Summary)

> **Tomcat + Eclipse 세팅 완료 = JSP 개발 시작 준비 끝! 🚀**

---

# 📝 참고 자료 (References)

- [Tomcat 공식 홈페이지](https://tomcat.apache.org/)
- [Emmet 공식 홈페이지](https://emmet.io/)
- [Tern Java GitHub](https://github.com/angelozerr/tern.java)
- [Oracle JDK 다운로드](https://www.oracle.com/java/technologies/javase-downloads.html)

---
