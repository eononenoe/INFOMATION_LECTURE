# Node 기초 정리

## 📌 개요 (Overview)

**Node.js**는 Chrome V8 JavaScript 엔진으로 빌드된 **서버 사이드 JavaScript 런타임**입니다.  
즉, 브라우저 외부에서도 JavaScript를 실행할 수 있게 해주며, **비동기 이벤트 기반 구조로 고성능 I/O 처리**에 특화되어 있습니다.

---

## 💡 핵심 개념

### 1. Node.js란?
- Node.js는 Chrome V8 JavaScript 엔진으로 빌드된 서버 사이드 JavaScript 런타임이다.
- 브라우저 외부에서도 JavaScript를 실행할 수 있게 해줌
- 비동기 이벤트 기반으로 고성능 I/O 처리에 특화

### 2. 특징

| 항목 | 설명 |
|------|------|
| 비동기 및 이벤트 기반 | 논블로킹 I/O를 통해 빠른 응답 처리 |
| 단일 스레드 | 싱글 스레드 기반으로 작동하지만 내부적으로 libuv를 통해 멀티 I/O 처리 |
| 빠른 처리 속도 | Chrome V8 엔진 덕분에 빠른 코드 실행 |
| npm 생태계 | 세계 최대 규모의 오픈소스 패키지 저장소 (npm) |
| 크로스 플랫폼 | Windows, macOS, Linux 모두 지원 |

### 3. Node.js 주요 구성요소
- **V8 Engine**: 자바스크립트 실행 엔진 (Google Chrome에서 사용)
- **libuv**: 이벤트 루프, 비동기 I/O를 위한 라이브러리
- **npm (Node Package Manager)**: 패키지 관리 도구
- **내장 모듈**: fs, http, path, os 등 기본 제공 모듈

---

## 🧪 코드 예시와 구조

### 4. 기본 구조 예시

```js
const http = require('http');

const server = http.createServer((req, res) => {
  res.write('Hello, Node.js!');
  res.end();
});

server.listen(3000, () => {
  console.log('Server running on http://localhost:3000');
});
```

---

## 🧠 주요 내장 모듈

### 5. 주요 내장 모듈

| 모듈 | 설명 |
|------|------|
| fs | 파일 시스템 조작 |
| http | 웹 서버 기능 구현 |
| path | 경로 처리 |
| url | URL 파싱 |
| os | 운영체제 정보 |
| crypto | 암호화 기능 제공 |

---

## 📦 npm 사용법

### 6. npm 사용법

| 명령어 | 설명 |
|--------|------|
| npm init | 프로젝트 초기화 |
| npm install <패키지> | 패키지 설치 |
| npm install -g <패키지> | 전역 설치 |
| npm start | 시작 스크립트 실행 |
| npm uninstall <패키지> | 패키지 제거 |

---

## 🧩 주요 프레임워크

### 7. 주요 프레임워크

| 프레임워크 | 설명 |
|------------|------|
| Express.js | 가장 인기 있는 경량 웹 프레임워크 |
| NestJS | Angular 스타일의 구조화된 Node.js 백엔드 프레임워크 |
| Koa.js | 미들웨어 기반 프레임워크, Express 팀 개발 |
| Fastify | 고성능 HTTP 서버 프레임워크 |

---

## 🚀 활용 분야

### 8. Node.js의 활용 분야
- REST API 서버 구축
- 실시간 웹 어플리케이션 (예: 채팅, 게임)
- 마이크로서비스 백엔드
- IoT 디바이스와 통신
- CLI(Command Line Interface) 툴 개발
- 정적 사이트 생성기 (예: Gatsby)

---

## 🔍 Node.js vs 기존 백엔드 언어

### 9. Node.js vs 기존 백엔드 언어

| 비교 항목 | Node.js | Java/Python 등 |
|------------|---------|----------------|
| 실행 방식 | 비동기, 논블로킹 | 동기, 블로킹 |
| 성능 | 고속 I/O 처리 우수 | 연산, 병렬 처리에 강함 |
| 개발 속도 | 빠름 (npm, 자바스크립트 활용) | 상대적으로 느림 |
| 멀티스레딩 | 단일 스레드 (이벤트 기반) | 멀티 스레드 사용 가능 |

---

## 🧠 기타 핵심 개념

### 10. 기타 개념
- **Callback / Promise / Async-Await**: 비동기 처리를 위한 주요 패턴
- **Event Loop**: Node.js 비동기 처리를 가능하게 해주는 핵심 구조
- **Middleware**: 요청과 응답 사이에 동작하는 중간 처리 로직 (Express에서 주로 사용)

---

## 📁 프로젝트 구조 예시

### 11. 프로젝트 구조 예시 (Express 기준)

```
my-app/
├── app.js
├── routes/
│   └── index.js
├── controllers/
├── models/
├── views/
├── public/
└── package.json
```

---

## ⚙ 시작 명령 요약

### 12. 시작 명령
```bash
npm init -y
npm install express
node app.js
```

---

## 💻 Node.js 설치 방법 (Windows / macOS / Linux)

### 1. Node.js란?
Node.js는 Chrome V8 JavaScript 엔진 기반의 런타임으로, 브라우저 외부에서도 JavaScript를 실행할 수 있도록 해주는 환경입니다.  
주로 백엔드 서버, CLI 툴, REST API 서버, 실시간 앱 등에 활용됩니다.

---

### 2. 설치 방법

#### A. 공식 웹사이트에서 설치 (권장)
1. Node.js 공식 사이트 접속  
2. LTS(Long Term Support) 버전 다운로드 (안정된 버전)  
3. 운영체제에 맞는 설치 파일 실행  
4. 설치 완료 후 다음 명령어로 확인:
```bash
node -v
npm -v
```

#### B. Windows 설치
- .msi 파일 실행 → 다음 → 다음 → 설치  
- 설치 중 npm 포함 여부 확인 체크  
- 환경변수 자동 설정됨

#### C. macOS 설치
**방법 1**: 공식 설치 파일 (.pkg) → 다운로드 후 설치  
**방법 2**: Homebrew 사용
```bash
brew install node
```

#### D. Linux (Ubuntu 기준)
```bash
# 1. curl로 Node.js 설치 스크립트 가져오기 (LTS)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

# 2. Node.js 설치
sudo apt-get install -y nodejs

# 3. 설치 확인
node -v
npm -v
```

---

### 3. 설치 후 필수 확인

| 명령어 | 설명 |
|--------|------|
| node -v | Node.js 버전 확인 |
| npm -v | Node 패키지 매니저(npm) 버전 확인 |
| npx -v | npm 패키지 실행 도구 버전 확인 |

---

### 4. 설치 오류 시 해결 방법
- 기존에 설치된 Node.js가 있다면 제거 후 재설치
- 권한 문제 발생 시 관리자 권한 또는 `sudo` 사용
- `PATH` 환경변수에 node 경로가 포함되어 있는지 확인

---

### 5. 버전 관리 도구 사용 (선택사항)
**nvm (Node Version Manager)**  
- 여러 Node.js 버전 설치 및 전환 가능

```bash
nvm install --lts
nvm use --lts
nvm ls
```

---

### 6. 설치 후 기본 테스트

```bash
// hello.js 파일 생성
console.log("Hello from Node.js!");

// 실행
node hello.js
```

설치가 완료되면 **Express.js** 또는 **React.js** 같은 프레임워크 기반 프로젝트 개발을 바로 시작할 수 있습니다.

---

## 📃 한 줄 요약 (1-Line Summary)

Node.js는 빠르고 효율적인 비동기 처리와 방대한 npm 생태계를 기반으로 하는 서버 사이드 JavaScript 런타임입니다.

