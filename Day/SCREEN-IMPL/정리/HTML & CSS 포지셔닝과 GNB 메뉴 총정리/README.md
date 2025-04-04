# 📚 HTML & CSS 포지셔닝과 GNB 메뉴 총정리

---

## 📌 개요 (Overview)

이 문서는 **HTML 구조와 CSS 포지셔닝(Positioning)**, 그리고 **GNB(Global Navigation Bar)** 메뉴 만드는 다양한 방법에 대해 정리한 자료입니다! 🚀 기본부터 심화까지 깔끔히 정리했어요.

---

## 💡 핵심 개념 요약 (Key Concepts)

### 1. 포지셔닝(Position)
- **Relative** : 자기 원래 자리 기준으로 이동
- **Absolute** : 가장 가까운 `position` 설정된 조상 기준 이동 (없으면 `viewport` 기준)

### 2. Nth-Child 선택자
- `:first-child` : 첫 번째 요소
- `:last-child` : 마지막 요소
- `:nth-child(n)` : n번째 요소 선택

### 3. GNB(Global Navigation Bar)
- 메인 메뉴와 서브 메뉴를 구조적으로 설계
- **Hover 이벤트**로 서브메뉴를 자연스럽게 표시
- 다양한 스타일 (가로형, 세로형, hover 위치 이동 등)

### 4. CSS Display, Layout
- `flex`, `absolute`, `relative`를 조합해서 메뉴 레이아웃 구성
- `box-sizing: border-box`로 크기 제어하기

---

## ⚠ 주의사항 (Cautions)

- `absolute` 사용할 때 반드시 부모 요소에 `relative`를 주어야 기준이 잡힘 ❗
- GNB 메뉴 hover 이벤트는 구조에 따라 **메인 메뉴에 hover**, 또는 **메뉴 항목에 hover**를 잘 구분해서 작성해야 함
- `nth-child`는 부모 기준으로 순서가 매겨짐. 예상과 다른 요소가 선택될 수 있음 주의 ⚡

---

## 🧪 예제 또는 비유 (Examples or Analogies)

- **Relative vs Absolute 비유**
  - 🏠 집(부모) 안에서 자기 방(Relative) 위치 옮기는 것 vs 집 전체를 벗어나서 마을 기준으로 자리 잡는 것(Absolute)

- **GNB 메뉴 비유**
  - 🍔 햄버거 메뉴처럼, 메인 메뉴를 클릭하거나 마우스를 올리면 속 재료(서브메뉴)가 펼쳐지는 느낌!

---

## ✅ 한 줄 요약 (1-Line Summary)

> 포지셔닝(Relative/Absolute)과 Nth-Child 선택자를 활용해 깔끔한 GNB 메뉴를 만드는 방법을 완벽히 마스터했습니다! 🎯

~~~

