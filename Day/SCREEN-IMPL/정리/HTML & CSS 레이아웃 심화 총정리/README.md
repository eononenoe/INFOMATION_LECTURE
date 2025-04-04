# HTML & CSS 레이아웃 심화 총정리 ✨

---

📌 **개요 (Overview)**

HTML과 CSS를 이용해 다양한 레이아웃을 구성하는 방법을 학습했습니다.  
이번 정리에서는 고정, 상대, 절대, 스티키 포지션, 그리고 Flex와 Grid 레이아웃 활용법까지 실습하며 완성도 높은 페이지 구조를 만드는 데 초점을 맞췄습니다.

---

💡 **핵심 개념 요약 (Key Concepts)**

### 📍 포지션 종류
- `relative` : 자신의 원래 위치를 기준으로 이동
- `absolute` : 가장 가까운 `relative` 조상 기준 이동 (없으면 viewport 기준)
- `fixed` : 화면에 고정 (스크롤해도 움직이지 않음)
- `sticky` : 스크롤 위치에 따라 고정/해제 자동 전환

### 📍 Flexbox 핵심
- `display: flex`로 수평/수직 정렬
- `justify-content`, `align-items`, `flex-direction`, `flex-wrap`
- `flex-grow`, `flex-shrink`, `flex-basis`로 공간 배분

### 📍 Grid 핵심
- `display: grid`로 2차원 레이아웃 구성
- `grid-template-columns`, `grid-template-rows`, `grid-area`
- `gap`, `repeat()`, `auto-fit`, `minmax()` 활용

---

⚠ **주의사항 (Cautions)**

- `absolute`는 기준이 되는 부모(`relative`)가 있어야 한다.
- `fixed`는 항상 화면 기준으로 위치한다.
- Flex와 Grid를 섞을 때 구조를 명확히 구분할 것.
- 반응형에서는 `flex-wrap`, `auto-fit`, `minmax()`를 적극 활용.

---

🧪 **예제 또는 비유 (Examples or Analogies)**

| 예시 | 설명 |
|:---|:---|
| 🧲 Fixed 포지션 | 자석처럼 화면에 고정된 메뉴 |
| 📦 Flexbox | 상자를 수평/수직으로 줄 세우는 느낌 |
| 🏢 Grid 레이아웃 | 건물처럼 행과 열로 구조화 |
| 🧗 Sticky 포지션 | 스크롤 중 "툭" 걸리는 메뉴 |

---

✅ **한 줄 요약 (1-Line Summary)**

> 다양한 **position**, **Flexbox**, **Grid**를 활용해 다양한 레이아웃을 설계하고 구현할 수 있다.

---

# 📚 목차

## 1. 포지션(position) 심화
- **04Fixed.html** : 고정 네비게이션 바 + 퀵메뉴
- **05Sticky.html** : Sticky/Fixed/Absolute 비교
- **06Zindex.html** : z-index로 요소 순서 조정

## 2. Flexbox 레이아웃
- **01Flex.html** : 기본 Flex 속성 (정렬, 방향, gap, align-self)
- **02Flex.html** : flex-grow, flex-shrink, flex-basis 실습
- **03Flex_Layout_Template.html** : 실무 스타일 Flex 레이아웃 템플릿

## 3. Grid 레이아웃
- **04Grid.html** : 기본 Grid, Grid Areas, 반응형 Grid, 정렬 등 다양한 활용

---

# 🎯 주요 실습 스크린샷

> 각 실습 파일 별로 주요 캡쳐 이미지를 첨부하여 실제 동작 화면을 참고할 수 있습니다.

---

# 🚀 복습 키워드

- `relative`, `absolute`, `fixed`, `sticky`
- `flexbox`: `justify-content`, `align-items`, `flex-wrap`
- `grid`: `grid-template-areas`, `grid-template-columns`, `auto-fit`, `minmax()`
- 미디어쿼리(media query) 활용

