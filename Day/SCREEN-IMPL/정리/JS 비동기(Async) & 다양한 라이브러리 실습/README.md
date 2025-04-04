# 📚 비동기(Async) & 다양한 라이브러리 실습

## 📌 개요 (Overview)

이번 섹션에서는  
**동기/비동기의 차이**, **타이머(setTimeout, setInterval)**, **비동기처리(async/await)** 개념을 잡고,  
추가로 **Swiper(슬라이더)**, **Lodash(throttle)**, **ScrollMagic(스크롤이벤트)** 같은  
자주 사용하는 JavaScript 라이브러리들도 함께 실습합니다! 🎯

---

## 💡 핵심 개념 요약 (Key Concepts)

### ⏳ 동기(Synchronous) vs 비동기(Asynchronous)

| 구분              | 설명 |
|:------------------|:----|
| **동기(Sync)**     | 코드가 위에서 아래로 순차 실행<br>이전 작업이 끝나야 다음 작업 가능 |
| **비동기(Async)**  | 작업 완료를 기다리지 않고 바로 다음 코드 실행<br>ex) setTimeout, fetch, Promise |

- **비동기 처리 방법**  
  - 콜백 함수 (Callback)
  - 프로미스 (Promise)
  - async/await

> 💬 비동기란? "주문하고 기다리지 않고 딴 일하는 것!" ☕

---

### ⏲️ setTimeout / setInterval

- `setTimeout(callback, delay)`
  - 특정 시간 후에 딱 한 번 실행
- `setInterval(callback, delay)`
  - 특정 시간마다 반복해서 실행
- `clearTimeout(id)` / `clearInterval(id)`
  - 예약된 타이머 취소

---

### ⚡ async & await

- `async` : 함수가 항상 프로미스를 반환하도록 만들어줌
- `await` : 비동기 호출이 끝날 때까지 기다려줌 (async 함수 안에서만 사용 가능)

> **예시**: 데이터 요청 완료될 때까지 기다렸다가 다음 코드 실행하기! 📡

---

### 🛹 Swiper.js

- 고급 슬라이더 라이브러리
- 페이징, 내비게이션 버튼, 자동재생 등 기능 다양
- `.swiper`, `.swiper-wrapper`, `.swiper-slide` 구조 사용
- 옵션 설정:
  - `autoplay`, `loop`, `pagination`, `navigation`, `mousewheel` 등

---

### 🌀 Lodash.js (throttle)

- **스크롤 이벤트 최적화**할 때 자주 사용!
- `_.throttle(callback, delay)`
  - 지정한 시간마다 콜백 함수를 한 번만 실행
- 서버 과부하나 렉을 방지할 수 있음!

---

### 🎯 ScrollMagic

- 스크롤에 따라 애니메이션을 트리거하는 라이브러리
- `.setClassToggle(요소, 클래스)` 사용하여  
  특정 위치에 오면 클래스를 추가하거나 제거할 수 있음

> **Hook 위치 지정 가능** (top, center, bottom)

---

# 🛠 주요 파일 정리

## 기본 이론 및 비동기 실습

- **00_INFO.txt / 00_INFO.html**  
  → 동기/비동기 기본 개념 및 흐름 확인

- **01_set&clearTimeout.html**  
  → 3초 후 한 번 실행(setTimeout) / 예약취소(clearTimeout)

- **02_set&clearInterval.html**  
  → 1초마다 반복 실행(setInterval) / 반복취소(clearInterval)

- **03_Async&Await.html**  
  → async/await로 비동기 순서 보장하기

---

## Swiper 슬라이더 적용

- **01SWIPER.html**  
  → 메인 배너 슬라이드 구현 (단일 슬라이드)

- **02SWIPER.html**  
  → 메인 배너 + 공지사항 슬라이드 + 다중 슬라이드 구현 (slidesPerView 사용)

---

## Lodash & ScrollMagic 실습

- **LODASH 01.html**  
  → `_.throttle()`로 스크롤 이벤트 최적화

- **SCROLLMAGIC 01.html**  
  → 스크롤 위치에 따라 요소에 class 추가 (애니메이션)

---

## ⚠ 주의사항 (Cautions)

- `setTimeout`, `setInterval`의 ID를 기억해서 `clear`할 수 있어야 함
- async/await는 항상 **try/catch**로 예외처리하는 습관 들이기
- Swiper, Lodash, ScrollMagic은 **CDN 연결 필수!**
- 스크롤 이벤트는 반드시 최적화 (Lodash 사용 권장)

---

## 🧪 예제 및 비유 (Examples or Analogies)

### ✨ 비동기 쉽게 이해하기
> - **동기**: 친구랑 같이 줄 서서 주문하기 🍔
> - **비동기**: 친구한테 주문 맡기고 나는 자리 잡으러 가기 🏃‍♂️

---

## ✅ 한 줄 요약 (1-Line Summary)

> **"비동기를 자유자재로 다루고, 스크롤/슬라이더까지 추가하면 웹페이지가 살아 움직인다!" 🚀**

