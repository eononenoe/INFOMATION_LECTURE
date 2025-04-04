# 📚 콜백함수, 마우스 이벤트, 프로젝트 메인화면

## 📌 개요 (Overview)

이번 섹션에서는  
**콜백함수(CallBack Function)**,  
**마우스 이벤트(Mouse Events)**,  
그리고 **프로젝트 메인화면 구축**까지 진행합니다! 🚀

콜백함수를 이해하면, **비동기 처리**와 **배열 함수(map, filter, sort)**도 쉽게 다룰 수 있습니다.

---

## 💡 핵심 개념 요약 (Key Concepts)

- **콜백함수**란?  
  👉 함수의 "실행 타이밍"을 외부에서 넘긴 함수가 결정하는 구조
- **클로저(Closure)**를 이용해 상태 관리하기
- **마우스 이벤트 종류**  
  - `click`, `dblclick`, `contextmenu`
  - `mouseenter`, `mouseover`, `mouseleave`
- **커스텀 map/sort/filter 함수 만들기**
- **화면 레이아웃 제작** (HTML + CSS)

---

# 🛠 주요 코드 모음

## 🖱️ 05_CALLBACK.html

- **콜백함수**를 이용한 `customMap`, `customSort` 함수 만들기
- **클로저**와 **콜백함수**를 조합해서 데이터 관리하기

```html
(05_CALLBACK.html 코드 전체)
```

---

## 🖱️ 01_마우스.html

- `click` 이벤트로 클릭 수 카운트
- 클로저를 이용한 **클릭 수 누적 관리**
- 다양한 마우스 이벤트(`mouseover`, `mouseleave`, `dblclick`, `contextmenu`)를 실습

```html
(01_마우스.html 코드 전체)
```

---

## 🖱️ 프로젝트 화면구현 - 메인

- 메인 페이지 UI 레이아웃 설계
- (추후 메뉴, 주문, 관리 기능이 추가될 예정!)

```html
(프로젝트 메인 화면 이미지)
```

---

## ⚠ 주의사항 (Cautions)

- **콜백함수**는 "내가 호출하는 것"이 아니라 "누군가가 나중에 호출해주는 것"이라는 점 주의!  
- `mouseenter` vs `mouseover` 차이:  
  - `mouseenter`: 진입 시 1회만 발생
  - `mouseover`: 내부 자식 요소를 진입해도 계속 발생
- 이벤트 등록 시 **addEventListener**를 사용해야 깔끔한 관리 가능!

---

## 🧪 예제 및 비유 (Examples or Analogies)

### ✨ 콜백함수 비유
> "배달앱 주문하고 기다리는 것"과 같다.  
>  
> (주문하고, 음식이 준비되면 가게에서 콜백을 호출한다. 🍔📞)

### ✨ 마우스 이벤트 비유
> "네가 내 집 문 앞에 서면 알림벨이 울리는 것"이다.  
> (mouseover = 문앞, mouseleave = 문 떠남)

---

## ✅ 한 줄 요약 (1-Line Summary)

> **"콜백함수 + 클로저 + 마우스 이벤트 이해하면 자바스크립트 마스터에 한 걸음 더 다가간다!" 🏆**

