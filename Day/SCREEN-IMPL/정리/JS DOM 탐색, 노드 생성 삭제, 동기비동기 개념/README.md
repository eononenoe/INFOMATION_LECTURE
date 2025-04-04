# 📚 DOM 탐색, 노드 생성/삭제, 동기/비동기 개념

## 📌 개요 (Overview)

이번 섹션에서는  
**HTML 문서의 요소를 찾고, 수정하고, 추가하거나 삭제하는 방법**을 배우고,  
또한 **동기(Synchronous)와 비동기(Asynchronous) 실행 방식**의 개념까지 함께 익힙니다! 🧠

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🔎 DOM 탐색 (요소 찾기)

- `getElementById('id')`
- `getElementsByTagName('tag')`
- `querySelector('CSS선택자')`
- `querySelectorAll('CSS선택자')`

> **Tip**: `getElementsByTagName`은 유사배열 → `Array.from()`으로 배열 변환 가능!

---

### 🛠 폼(Form) 접근

- `document.forms` → 전체 폼 목록
- `document.formName.inputName.value` → 특정 폼의 input 값에 직접 접근 가능

---

### 🎨 클래스 추가/제거

- `element.classList.add('클래스명')`
- `element.classList.remove('클래스명')`
- **이벤트**를 통해 클래스 스타일 동적으로 적용 가능!

---

### 🛠 CRUD(Create, Read, Update, Delete)

- `createElement('tag')` → 새 노드 생성
- `appendChild(node)` → 부모에 추가
- `removeChild(node)` → 부모로부터 삭제
- 이벤트를 통한 **실시간 추가/삭제/수정** 구현

---

### ⏳ 동기(Synchronous) vs 비동기(Asynchronous)

| 구분            | 설명 |
|:---------------|:----|
| 동기(Sync)     | 코드가 위에서 아래로 차례차례 실행 |
| 비동기(Async)  | 기다리지 않고 다음 작업을 바로 실행 (예: 서버요청, 파일읽기) |
| 동기 특징      | 직관적이지만 느릴 수 있음 |
| 비동기 특징    | 빠르지만 관리가 필요 (콜백, 프로미스, async/await 사용) |

> **비동기는 마치 "주문하고 다른 일 하다가 알림 받기" 같은 거야!** 🍔➡️📱

---

# 🛠 주요 파일 정리

## 🔎 DOM 탐색 & 기본 조작

- **01_NODE_검색.html**  
  → 요소를 다양한 방법으로 찾고 스타일 변경하기

- **02_FORM_검색.html**  
  → form 요소와 input 값을 다루는 방법

- **03_Class_추가.html**  
  → 마우스 이벤트로 동적으로 클래스 추가/제거 (hover효과)

---

## 🧹 CRUD 동작

- **04_EL_CRUD.html**  
  → 텍스트 입력 후 버튼 클릭으로 **목록 추가/삭제**

- **05_[문제] EL_CRUD.html**  
  → 이름, 나이, 주소 입력 → **테이블에 행 추가**, 삭제 버튼 구현

- **06_EL_CRUD_DRAG.html**  
  → (추후 추가 예정 - Drag로 요소 정렬하는 고급 CRUD)

---

## ⏳ 동기/비동기 개념

- **00_INFO.txt / 00_INFO.html**  
  → 동기, 비동기 실행방식 개념 정리 및 간단한 예제

---

## ⚠ 주의사항 (Cautions)

- `getElementsByTagName`은 유사배열이라 `forEach` 불가 → `Array.from` 필수
- form 다룰 때는 name 속성 활용해서 접근하면 편리함
- input 입력 유효성 검사 필수 (공백, 숫자 입력 여부 등)
- 비동기 로직은 항상 오류처리/순서관리에 주의해야 함

---

## 🧪 예제 및 비유 (Examples or Analogies)

### ✨ 동기 비동기 쉽게 이해하기
> - **동기**: 친구랑 줄 서서 라면 사기 🍜  
> - **비동기**: 친구한테 "라면 사와줘" 하고 다른 일 하기 📞

---

## ✅ 한 줄 요약 (1-Line Summary)

> **"HTML 요소를 자유자재로 다루고, 동기/비동기를 이해하면 진짜 프로 개발자처럼 된다!" 🚀**

