# 📄 CSS Motion Effects 정리 (Transition / Transform3D / Animation)

---

📌 **개요 (Overview)**

이 문서는 CSS를 이용한 **부드러운 모션 효과**와 **애니메이션 기법**을 정리한 자료입니다.  
`Transition`, `Transform`, `Transform3D`, `Animation`을 활용하여 다양한 시각적 효과를 구현합니다.

---

💡 **핵심 개념 요약 (Key Concepts)**

### 📍 Transition
- `transition: property duration` 으로 요소의 스타일 변화에 부드러운 움직임을 추가
- hover, focus 이벤트 시 자연스러운 변화 적용

### 📍 Transform
- 요소를 `translate`, `scale`, `rotate`, `skew`로 이동, 크기 조절, 회전, 기울이기

### 📍 Transform3D
- 3D 공간 속 이동 및 회전을 위해 `perspective`와 `transform-style: preserve-3d` 사용
- `rotateY(180deg)`를 활용해 카드 뒤집기(Flip) 같은 3D 효과 구현

### 📍 Animation
- `@keyframes`를 사용하여 중간 단계를 포함한 복잡한 애니메이션 구현
- 반복(`iteration`), 방향(`direction`), 지연(`delay`) 등을 세밀하게 조정 가능

---

⚠ **주의사항 (Cautions)**

- `transition`은 **시작**과 **끝** 사이를 부드럽게 연결, 중간 단계 설정 불가
- `animation`은 **0%, 50%, 100%** 등 **구간별로** 상태를 지정 가능
- 3D 변환 사용 시, 부모 요소에 `perspective` 설정을 잊지 말기
- `transform`과 `transition`은 종종 같이 쓰지만, 목적이 다름!

---

🧪 **예제 또는 비유 (Examples or Analogies)**

| ✨ | 설명 |
|:---|:---|
| 버튼이 스르륵 커진다 | transition |
| 카드가 돌면서 뒤집힌다 | transform3D |
| 텍스트가 화면 밖에서 들어온다 | animation |
| 이미지가 확대되었다가 축소된다 | transform + transition |

---

✅ **한 줄 요약 (1-Line Summary)**

> Transition은 **부드러운 변화**, Animation은 **연속적 움직임**, Transform3D는 **입체적 회전**을 만든다!

---

# 📚 목차

## 1. Transition 실습
- **01Transition.html** : div 크기 변화 및 input 포커스 효과
- **02Transition.html** : 이미지 위로 튀어나오기 효과
- **03Transition.html** : transform으로 이동/확대/회전/기울이기

## 2. Transform3D 실습
- **05Transform3D.html** : 원근(perspective) 설정 후 3D 회전
- **06Transform3D.html** : 앞/뒤 면을 가진 카드 뒤집기 효과

## 3. Animation 실습
- **07Animation.html** : 텍스트의 좌우, 상하 이동 애니메이션
- **08Animation.html** : 다양한 방향, 변형을 조합한 애니메이션
- **09Animation.html** : 색상 변화 + 회전 동작을 가진 박스

---

# 🚀 복습 키워드

- `transition`
- `transform`
- `transform3d`
- `perspective`
- `@keyframes`
- `animation-iteration-count`
- `animation-direction`

