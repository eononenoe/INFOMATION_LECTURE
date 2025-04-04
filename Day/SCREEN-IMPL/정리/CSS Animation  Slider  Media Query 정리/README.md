# 🎬 CSS Animation / Slider / Media Query 정리

---

📌 **개요 (Overview)**

이 문서는 **CSS 애니메이션(Animation)**, **슬라이더 구현(Slider)**, 그리고 **미디어 쿼리(Media Query)**를 활용하여  
웹 페이지를 **생동감 있고 반응형**으로 만드는 방법을 정리한 자료입니다.

---

💡 **핵심 개념 요약 (Key Concepts)**

### 🎯 Animation
- `@keyframes`를 이용해 요소를 시간에 따라 움직임
- `animation-timing-function`을 이용해 속도 곡선을 조정 가능
- 다양한 속도 조절 (ease, ease-in, ease-out, linear 등)

### 🎯 Slider
- 요소를 좌우로 이동시켜 여러 콘텐츠를 보여주는 효과
- `overflow: hidden` + `position: relative/absolute` 사용
- 버튼이나 자동 애니메이션으로 슬라이딩 제어

### 🎯 Media Query
- 기기 크기에 따라 다른 스타일 적용
- `@media`를 사용하여 데스크탑, 태블릿, 모바일 반응형 구현

---

⚠ **주의사항 (Cautions)**

- `animation`은 복합적인 움직임(변형, 위치이동, 색상변화 등)을 만들어낼 수 있다
- 슬라이더 구현 시 `overflow: hidden`으로 넘치는 부분을 숨겨야 깔끔하다
- 미디어 쿼리는 **순서**에 주의 (좁은 해상도 -> 넓은 해상도 순으로 작성 추천)

---

🧪 **예제 또는 비유 (Examples or Analogies)**

| ✨ | 설명 |
|:---|:---|
| 공이 튕기는 효과 | Animation + Timing Function |
| 갤러리 사진 슬라이드 | Slider |
| 모바일 화면에서 메뉴 접힘 | Media Query |

---

✅ **한 줄 요약 (1-Line Summary)**

> **Animation은 움직임**, **Slider는 연속된 콘텐츠 이동**, **Media Query는 화면 맞춤 스타일링**!

---

# 📚 목차

## 1. Animation 실습
- **10Animation.html** : 다양한 `animation-timing-function` (ease, linear 등) 비교
- **11Ball.html** : 공이 튕기며 찌그러지는 모션
- **07Animation.html**, **08Animation.html**, **09Animation.html** : 다양한 방향/속도 애니메이션

## 2. Slider 실습
- **12Slider.html** : 가로로 흘러가는 슬라이더 (Hover 시 멈춤)
- **13Slider.html** : 라디오 버튼으로 컨트롤하는 간단 슬라이더
- **14Slider.html** : 라디오 버튼으로 이동하는 풀 페이지 슬라이더

## 3. Media Query 실습
- **1MQ.html** : 화면 크기에 따라 배경색 변화 (오렌지 → 초록 → 파랑)
- **2MQ.html** : 외부 CSS 파일을 이용한 반응형
- **3MQ.html** : 실제 레이아웃(네비게이션, 카드, 미디어 아이템) 반응형 조정

---

# 🚀 핵심 키워드 모음

- `@keyframes`
- `animation-name`, `animation-duration`, `animation-iteration-count`
- `animation-timing-function` (`ease`, `linear`, `ease-in`, `ease-out`, `ease-in-out`)
- `transition`
- `slider-wrapper`, `overflow: hidden`
- `@media (max-width: ...)`

---

# 🌟 보너스: 주요 타이밍 함수 정리

| Timing Function | 설명 |
|:----------------|:-----|
| ease            | 천천히 시작 → 빨라짐 → 천천히 끝남 (기본값) |
| ease-in         | 천천히 시작 |
| ease-out        | 천천히 끝남 |
| ease-in-out     | 천천히 시작 → 빠름 → 천천히 끝남 |
| linear          | 일정한 속도 |

---

