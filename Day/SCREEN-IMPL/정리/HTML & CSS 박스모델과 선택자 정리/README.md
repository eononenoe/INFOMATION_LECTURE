~~~markdown
# ✨ HTML & CSS 박스모델과 선택자 정리


## 📌 개요 (Overview)

HTML과 CSS의 핵심 기초인 **박스모델**과 **선택자**에 대해 다양한 예제를 통해 연습하고 정리했습니다.
각 파일은 특정 개념을 실습한 내용입니다.


## 💡 핵심 개념 요약 (Key Concepts)

### 🎁 박스모델(Box Model)
- **Border**: 테두리 스타일 조정 (solid, dashed, dotted 등)
- **Border-Radius**: 테두리 깎기(둥글게)
- **삼각형 만들기**: border를 활용한 도형 생성
- **Overflow**: 부모 박스 크기 초과 시 자식 요소 처리 방법(hidden, scroll, auto)
- **Box-Sizing**: 패딩, 보더 포함여부 설정 (`border-box` vs `content-box`)

### 🎯 CSS 선택자 (Selector)
- **전체 선택자(*)**: 문서 내 모든 요소 선택
- **요소 선택자(div, p 등)**
- **클래스 선택자(.class)**
- **아이디 선택자(#id)**
- **그룹 선택자 (선택자, 선택자)**
- **자식 선택자(>) / 자손 선택자(공백)**
- **형제 선택자(~, +)**
- **가상 클래스(:hover, :active, :visited)**
- **가상 요소(::before, ::after)**

### 🛠 커스텀 체크박스
- 체크박스를 숨기고(label 커스터마이징) 스타일 적용하기

### 🏛️ Header/Footer 레이아웃 잡기
- Header 안에 Top-Header(로그인, 회원가입) 메뉴
- ::after를 활용한 구분선 넣기


## ⚠ 주의사항 (Cautions)

- `box-sizing: border-box;`를 설정하지 않으면 padding, border 때문에 width/height 계산이 어긋날 수 있음.
- 선택자 우선순위 주의! (id > class > element)
- 가상 클래스와 가상 요소는 순서에 따라 적용 결과가 다를 수 있음.
- overflow 속성은 **부모 크기를 초과할 때만** 동작함.


## 🧪 예제 또는 비유 (Examples or Analogies)

- **박스모델**을 집이라고 생각하면,
  - padding = 집 안쪽 여유 공간
  - border = 집 벽
  - margin = 집 바깥 여유 공간

- **선택자**는 우체부가 편지를 정확한 집(요소)에 배달하는 방법과 같음.
  - #id는 집에 적힌 명확한 주소
  - .class는 같은 아파트 동 전체
  - div는 동네 전체

- **overflow**는 가방 안에 너무 많은 책을 넣었을 때
  - hidden은 책이 밖으로 안 보이게 가림
  - scroll은 가방에 지퍼를 달아 열어볼 수 있게 함


## ✅ 한 줄 요약 (1-Line Summary)

> **HTML과 CSS 기초 중 박스모델과 다양한 선택자 활용법을 실제 예제를 통해 마스터한다! 🚀**

~~~