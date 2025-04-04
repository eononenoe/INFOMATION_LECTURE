~~~markdown
# 📚 JDK 구버전 설치, Tomcat, Eclipse 개발 환경 세팅 정리

---

# 📌 개요 (Overview)

이번 문서는 **JDK 구버전 설치**, **Tomcat 서버 설치**, **Eclipse IDE 설치 및 연동**, **Git 설정 및 Github 연동 방법**까지 Java 개발을 위한 환경 세팅 과정을 정리했습니다.

---

# 💡 핵심 개념 요약 (Key Concepts)

## ☕ JDK 구버전 설치

- JDK 다운로드 및 설치 진행
- 환경 변수 설정
    - `JAVA_HOME` 추가
    - `Path`에 `%JAVA_HOME%\bin` 추가
- 설치 완료 후 버전 확인
```bash
java -version
javac -version
```

---

## 🛠️ Tomcat 설치

- Tomcat 다운로드 및 압축 해제
- 환경 변수 설정 (필요 시)
- Tomcat 서버 시작 및 접속 테스트
    - 기본 포트 8080 접속 확인 (`http://localhost:8080`)

---

## 🖥️ Eclipse 설치 및 설정

- Eclipse IDE 다운로드 및 설치
- Workspace 설정
- 필요한 플러그인 설치 가능

---

## 🔁 Java 버전 변경 설정

- Eclipse 내 JDK 변경 방법
    - Preferences > Java > Installed JREs
    - Add > Standard VM > 설치된 JDK 경로 선택
- Project 별 Java 버전 설정
    - Project > Properties > Java Build Path > Libraries 수정

---

## ⚙️ Eclipse + Tomcat 연동

- Servers 탭 열기
- New > Server > Apache > Tomcat 선택
- Tomcat 설치 경로 지정
- 프로젝트를 서버에 Add 후 Run (서버 실행)

---

# 🌐 Git 설정 및 Github 연동

## Git 기본 설정

- Git 설치 후 환경 설정
```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```
- 로컬 저장소 생성 및 초기화
```bash
git init
```
- GitHub 저장소 연결
```bash
git remote add origin <repository URL>
```

## Eclipse 내 Git 연동

- Git Perspective 활성화
- Clone Repository or Import 프로젝트
- Commit, Push 기능 사용하여 GitHub와 연동 관리

---

# 📦 import (프로젝트 가져오기)

- Eclipse에서 Import > Git > Projects from Git
- Local Repository 선택 후 프로젝트 Import
- 프로젝트를 Eclipse 워크스페이스로 가져오기

---

# ⚠ 주의사항 (Cautions)

- JDK, Tomcat, Eclipse 모두 버전 호환성 확인 필요
- Eclipse 내 Java 버전과 실제 시스템 Java 버전 다를 수 있음 (별도 설정 필요)
- Git remote origin 설정할 때 오타 주의
- Github 연동 시 SSH Key 등록하거나 HTTPS 인증 필요

---

# ✅ 한 줄 요약 (1-Line Summary)

> JDK, Tomcat, Eclipse 설치부터 GitHub 연동까지 개발 환경 세팅 완료! 🚀🖥️
~~~

