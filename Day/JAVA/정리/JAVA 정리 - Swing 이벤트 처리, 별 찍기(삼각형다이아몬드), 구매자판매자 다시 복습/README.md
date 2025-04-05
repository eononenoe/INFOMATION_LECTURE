# 📚 JAVA 정리 - Swing 이벤트 처리, 별 찍기(삼각형/다이아몬드), 구매자/판매자 다시 복습

---

## 📌 개요 (Overview)

이번 파트에서는

- **Swing 컴포넌트 이벤트 처리** (버튼, 키보드, 마우스)
- **별 찍기 프로그램 (삼각형, 다이아몬드)**
- **객체 설계 복습 (구매자-판매자 관계)**

를 다루었습니다! ✨

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🎨 Swing 이벤트 처리

- `ActionListener` : 버튼 클릭 감지
- `KeyListener` : 키보드 입력 감지
- `MouseListener` : 마우스 클릭, 이동 감지

```java
btn1.addActionListener(this); // 버튼 클릭 이벤트 등록
txt1.addKeyListener(this);    // 텍스트 필드 키보드 이벤트 등록
area1.addMouseListener(this); // 텍스트 에어리어 마우스 이벤트 등록
```

---

### ⭐ 별 찍기 (삼각형/다이아몬드)

- **높이 입력 삼각형**
  - 줄마다 공백 개수 + 별 개수 조절
- **홀수 높이 다이아몬드**
  - 윗부분(점점 늘어남) + 아랫부분(점점 줄어듦) 나누어 반복

```java
for (i=0; i<height; i++) {
    if (i <= height/2) { // 위쪽
        // 공백 + 별
    } else { // 아래쪽
        // 공백 + 별
    }
}
```

---

### 🛒 구매자/판매자 관계 (복습)

- **Buyer**
  - `myMoney` (보유 금액)
  - `appleCnt` (사과 개수)
  - `payment(Seller, money)` : 돈 주고 사과 받음

- **Seller**
  - `myMoney` (보유 금액)
  - `appleCnt` (사과 개수)
  - `price` (사과 개당 가격)
  - `receive(money)` : 돈 받고 사과 개수 계산해서 전달

---

## ⚠ 주의사항 (Cautions)

- **Swing 이벤트 등록**시 올바른 컴포넌트에만 리스너를 등록해야 함.
- **KeyListener**는 `keyPressed`, `keyTyped`, `keyReleased` 세 가지를 모두 구현해야 함.
- **다이아몬드 별찍기**는 홀수 높이만 허용! (짝수 입력 방지 필요)
- **Buyer-Seller 로직**에서 돈/사과 수를 정확히 차감 및 누적해야 함.

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 🎨 버튼 클릭 이벤트 처리

```java
@Override
public void actionPerformed(ActionEvent e) {
    if (e.getSource() == btn1) {
        System.out.println("파일로 저장 클릭");
    }
}
```
> 특정 버튼을 눌렀을 때 다른 동작을 구분해서 실행!

---

### 🎯 엔터 키 입력 처리 (KeyListener)

```java
@Override
public void keyPressed(KeyEvent e) {
    if (e.getKeyCode() == KeyEvent.VK_ENTER) {
        String message = txt1.getText();
        area1.append(message + "\n");
        txt1.setText("");
    }
}
```
> 텍스트 필드에서 Enter 키 입력 시 바로 대화창에 추가!

---

### 🛒 구매자-판매자 거래 흐름 예시

```java
Buyer hong = new Buyer(10000, 0);
Seller appleSeller = new Seller(100000, 100, 1000);

hong.payment(appleSeller, 5000);
```
> 홍길동은 5000원을 지불하고 사과를 5개 구매한다! 🍎

---

### ⭐ 삼각형 출력 결과 예시 (높이 5)

```
    *
   ***
  *****
 *******
*********
```

---

### 💎 다이아몬드 출력 결과 예시 (높이 7)

```
   *
  ***
 *****
*******
 *****
  ***
   *
```

---

## ✅ 한 줄 요약 (1-Line Summary)

> **Swing은 이벤트로 소통하고, 별찍기는 반복으로 그리고, 객체는 관계로 살아있다!** 🎨⭐🔗

