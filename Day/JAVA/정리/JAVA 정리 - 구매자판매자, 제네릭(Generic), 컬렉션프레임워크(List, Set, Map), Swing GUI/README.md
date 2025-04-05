# 📚 JAVA 정리 - 구매자/판매자, 제네릭(Generic), 컬렉션프레임워크(List, Set, Map), Swing GUI

---

## 📌 개요 (Overview)

이번 파트에서는

- 구매자-판매자 객체 설계
- 제네릭(Generic) 활용
- 컬렉션 프레임워크 (List, Set, Map)
- Swing GUI 기초

를 다룹니다! 🎯

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🛒 구매자/판매자 객체

- **Buyer** (구매자)
  - 보유 금액
  - 사과 개수
  - `payment(Seller, money)` : 돈을 주고 사과를 받음

- **Seller** (판매자)
  - 보유 금액
  - 사과 개수
  - 가격
  - `receive(money)` : 돈을 받고 사과 개수를 리턴

### 📦 제네릭(Generic)

- 타입을 일반화하여 코드의 재사용성과 타입 안전성 향상
- `class Box<T> { T item; }`
- `Couple<X extends Person, Y extends Person>`

### 🧺 List, Set, Map

- **List** : 순서 있음, 중복 허용
- **Set** : 순서 없음, 중복 불허
- **Map** : 키-값(Key-Value) 쌍으로 저장

### 🎨 Swing GUI 기초

- `JFrame`, `JPanel`, `JButton`, `JTextArea`, `JTextField`
- 레이아웃 설정 및 컴포넌트 배치
- 스크롤 추가 (`JScrollPane`)

---

## ⚠ 주의사항 (Cautions)

- Set은 중복을 허용하지 않기 때문에 `equals()` 와 `hashCode()` 반드시 재정의 필요
- Map은 key가 중복되면 **나중 값**으로 덮어쓰기 된다
- Swing에서 컴포넌트 배치는 `null` 레이아웃이면 직접 `setBounds` 설정
- 제네릭 타입은 `<T extends 클래스>` 형태로 상속제한 걸 수 있음

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 🛒 구매자-판매자 거래 흐름

```java
Buyer hong = new Buyer(10000, 0);
Seller seller = new Seller(10000, 100, 1000);

hong.payment(seller, 5000);
// 홍길동은 5개 사과를 구매하고, 보유 금액 감소
```

---

### 📦 제네릭 Couple 클래스

```java
Couple<Man, Woman> couple1 = new Couple<>(new Man("철수","30","서울"), new Woman("영희","28","부산"));
System.out.println(couple1);
```
> 사람 타입을 제네릭으로 묶어 커플 클래스를 생성

---

### 📜 List 사용 예시

```java
List<String> list = new ArrayList<>();
list.add("HTML");
list.add("CSS");
list.add("JS");
list.forEach(System.out::println);
```
> 순서대로 저장, 꺼낼 수 있음

---

### 🚫 Set 중복 금지 예시

```java
Set<String> set = new HashSet<>();
set.add("JAVA");
set.add("JAVA"); // 중복 무시
System.out.println(set.size()); // 1
```
> 중복 저장 안 됨!

---

### 🔑 Map 사용 예시

```java
Map<String, Integer> map = new HashMap<>();
map.put("aaa", 1111);
map.put("bbb", 2222);
System.out.println(map.get("aaa"));
```
> key로 빠르게 데이터 검색

---

### 🎨 Swing GUI 기본 구조

```java
JFrame frame = new JFrame("Title");
frame.setBounds(100,100,500,500);
frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
frame.setVisible(true);
```
> 기본 프레임 만들기

---

### 🎨 Swing 채팅창 GUI 예시

```java
// 입력창, 버튼, 대화창(TextArea) 구성
JTextField inputField = new JTextField();
JButton sendButton = new JButton("입력");
JTextArea chatArea = new JTextArea();
JScrollPane scroll = new JScrollPane(chatArea);
```
> JTextArea에 입력 기록 남기기

---

## ✅ 한 줄 요약 (1-Line Summary)

> **제네릭은 타입 안전, 컬렉션은 데이터 관리, GUI는 세상과 소통이다!** 🖥️✨

