# 📦 npm(Node Package Manager) 정리

## 📌 1. npm이란?

**npm(Node Package Manager)**은 Node.js의 기본 패키지 매니저로,  
JavaScript 라이브러리나 모듈을 설치, 관리, 배포할 수 있는 도구입니다.  
Node.js 설치 시 자동 포함되며, 프론트엔드/백엔드 개발에서 모두 사용됩니다.

---

## 💡 2. 주요 기능

| 기능 | 설명 |
|------|------|
| 패키지 설치 | 외부 라이브러리 설치 (로컬/글로벌) |
| 패키지 관리 | 버전, 의존성, 스크립트 관리 |
| 패키지 실행 | 프로젝트 내 명령어 실행 (npm run) |
| 패키지 생성 | 새로운 프로젝트 초기화 |

---

## 🧠 3. 주요 명령어 정리

| 명령어 | 설명 |
|--------|------|
| `npm init` | 프로젝트 초기화 (package.json 생성) |
| `npm install [패키지명]` | 로컬 패키지 설치 |
| `npm install -g [패키지명]` | 글로벌 패키지 설치 |
| `npm install` | package.json 기반 전체 의존성 설치 |
| `npm uninstall [패키지명]` | 패키지 제거 |
| `npm update` | 설치된 모든 패키지 업데이트 |
| `npm list` | 설치된 패키지 확인 |
| `npm run [스크립트명]` | 지정된 스크립트 실행 |

---

## 🧪 4. 실습 예제

### 1단계: 프로젝트 초기화
```bash
mkdir my-npm-app
cd my-npm-app
npm init -y
```
> `-y` 옵션은 기본값으로 `package.json` 생성

---

### 2단계: 외부 패키지 설치
```bash
npm install lodash
```
- `lodash`: 유틸리티 함수들을 제공하는 대표적인 JS 라이브러리  
- `node_modules/` 폴더와 `package-lock.json` 자동 생성됨

---

### 3단계: 사용 예제 (index.js)
```js
// index.js
const _ = require("lodash");

const arr = [1, 2, 3, 4, 5];
const shuffled = _.shuffle(arr);
console.log("Shuffled:", shuffled);
```

```bash
node index.js
```

---

### 4단계: scripts 등록 후 실행
`package.json` 일부:
```json
"scripts": {
  "start": "node index.js",
  "test": "echo \"Test script here\""
}
```

```bash
npm run start
npm run test
```

---

## 🗂 5. package.json 설명

| 필드 | 설명 |
|------|------|
| `name` | 패키지 이름 |
| `version` | 현재 버전 |
| `dependencies` | 설치한 라이브러리 목록 |
| `scripts` | 실행 가능한 사용자 정의 명령어 목록 |

---

## 🌐 6. 글로벌 설치 예

```bash
npm install -g nodemon
```

- `nodemon`: 소스 파일이 변경될 때 자동으로 Node 앱을 재시작해주는 도구

```bash
nodemon index.js
```

---

## 🧩 7. 기타 팁

- `.gitignore`에 반드시 `node_modules` 포함시키기
- `npm ci`: CI/CD 환경에서 빠르고 깨끗한 의존성 설치용
- `npx [패키지명]`: 전역 설치 없이 일회성 실행 가능

---

# 🌐 Parcel Bundler 설정 및 사용법 정리

## 📌 1. Parcel이란?

**Parcel**은 빠르고 사용하기 쉬운 웹 애플리케이션 번들러입니다.  
Webpack에 비해 **설정이 거의 필요 없는 제로 설정(Zero Configuration)** 도구이며,  
HTML, CSS, JS, 이미지 등 다양한 자산을 자동으로 번들링합니다.

---

## 🔧 2. Parcel 설치

### 프로젝트 초기화
```bash
mkdir parcel-app
cd parcel-app
npm init -y
```

### Parcel 설치
```bash
npm install --save-dev parcel
# 또는 최신 Parcel v2
npm install --save-dev parcel@latest
```

---

## 🗂 3. 기본 프로젝트 구조 예시

```
parcel-app/
├── src/
│   ├── index.html
│   └── index.js
├── package.json
```

---

## 📝 4. index.html 예시

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Parcel App</title>
</head>
<body>
  <h1>Hello Parcel</h1>
  <script src="./index.js"></script>
</body>
</html>
```

---

## ✍ 5. index.js 예시

```js
const message = "Hello from Parcel!";
console.log(message);
```

---

## ⚙ 6. package.json 스크립트 설정

```json
"scripts": {
  "dev": "parcel src/index.html",
  "build": "parcel build src/index.html"
}
```

---

## 🚀 7. 개발 서버 실행

```bash
npm run dev
```

- 기본적으로 `http://localhost:1234` 에서 실행됨  
- 소스 코드 변경 시 자동 리로딩 지원

---

## 📦 8. 번들링 (프로덕션 빌드)

```bash
npm run build
```

- `dist/` 디렉토리에 최적화된 결과물 생성됨

---

## 💎 9. 주요 Parcel 특징

| 특징 | 설명 |
|------|------|
| Zero Config | 별도의 설정 파일 없이 사용 가능 |
| 빠른 번들링 | 멀티코어 처리 및 캐시 기반 빠른 재빌드 |
| HMR 지원 | 코드 변경 시 자동 갱신 (Hot Module Replacement) |
| 다양한 파일 지원 | JS, JSX, TS, CSS, SCSS, 이미지, HTML 등 자동 인식 |
| 플러그인 기반 확장 | 커스텀 transformer/optimizer 등 추가 가능 |

---

## ⚙ 10. .parcelrc (옵션 설정 시 사용)

Parcel은 기본적으로 설정이 필요 없지만, 커스텀 설정이 필요한 경우 `.parcelrc` 파일 사용:

```json
{
  "extends": "@parcel/config-default"
}
```

---

## 🔗 참고

- 공식 사이트: [https://parceljs.org/](https://parceljs.org/)
- Parcel 2는 CommonJS와 ESM 모두 지원
- Tree-shaking, Code Splitting 기능 내장

---

## 📃 한 줄 요약 (1-Line Summary)

**npm은 Node.js의 필수 도구로, 패키지 설치 및 실행을 관리하며, Parcel은 빠르고 쉽게 웹 프로젝트를 번들링할 수 있게 도와주는 도구입니다.**

