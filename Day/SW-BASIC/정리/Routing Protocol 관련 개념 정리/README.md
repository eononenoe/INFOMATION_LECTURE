# 📡 라우팅 프로토콜(Routing Protocol) & AS 개념 총정리

---

## 📌 개요 (Overview)

라우팅 프로토콜은 네트워크에서 **데이터가 어떤 경로(Route)를 통해 목적지까지 갈지 자동으로 결정**해주는 기술이에요.  
이 문서에서는 **Routing**, **AS(자치 시스템)**, **IGP/EGP**, **RIP**, **OSPF** 등의 핵심 개념을 쉽게 정리합니다.

---

## 💡 핵심 개념 요약 (Key Concepts)

---

### 🔤 용어 정리

```jsx
Route    : 경로
Router   : 경로 안내 장치
Routing  : 경로 안내 작업
Protocol : 통신을 위한 프로그램
```

---

### 🔄 동적 라우팅 프로토콜 (Dynamic Routing Protocol)

- 네트워크 환경 변화에 따라 **자동으로 라우팅 정보를 교환**하고 경로를 갱신해요.
  
```jsx
IGP - Distance Vector : RIPv2
    - Link-State      : OSPF

EGP : BGP
```

---

### 🗺️ AS (Autonomous System)

```jsx
AS = Autonomous System
자치 시스템 : 동일한 관리자가 운영하는 라우터의 집합
```

- AS는 하나의 조직이나 기관이 **자체적으로 관리하는 네트워크 단위**예요.

---

### 🚪 ASBR (AS Boundary Router)

```jsx
ASBR = AS Boundary Router
AS 가장자리에 위치해 다른 AS와 연결해주는 라우터
```

---

### 🧮 Distance Vector

```jsx
Distance Vector : RIPv2
전체 네트워크를 학습한 후, 가장 적은 거리(홉 수)의 경로를 선택
```

- **라우터끼리 서로 거리 정보를 주고받으며 최적 경로를 계산**

---

### 🧩 IGP vs EGP

```jsx
IGP = Interior Gateway Protocol
→ 하나의 AS 내부에서 사용하는 라우팅 프로토콜
예: RIP, OSPF

EGP = Exterior Gateway Protocol
→ 서로 다른 AS 간에 사용하는 프로토콜 (Inter-Domain Routing)
예: BGP
```

---

### 🕸️ 링크 상태 라우팅 알고리즘

```jsx
Link State Routing Algorithm (링크 상태 라우팅)
OSPF : 네트워크 내 모든 라우터가 링크 상태 정보를 교환하여
       최단 경로를 갱신하는 방식
```

- 링크 상태 정보를 가지고 **전체 맵을 그리듯 최단 경로를 계산**

---

## ⚠ 주의사항 (Cautions)

- RIP은 설정은 쉽지만 네트워크가 커질수록 느려질 수 있음
- OSPF는 복잡하지만 대규모 네트워크에 적합
- EGP(BGP)는 인터넷처럼 여러 AS 간 경로 설정에 사용됨

---

## 🧪 예제 또는 비유 (Examples or Analogies)

| 개념       | 비유 설명                                  |
|------------|---------------------------------------------|
| Router     | 내비게이션 기기                            |
| RIP        | 오래된 내비 (매번 전체 길 다시 계산)       |
| OSPF       | 실시간 내비 (지도 전체 파악 후 최단 경로) |
| AS         | 각각 독립된 마을, 조직 네트워크           |
| BGP        | 마을 사이를 연결해주는 도로 안내          |

---

## ✅ 한 줄 요약 (1-Line Summary)

> 라우팅 프로토콜은 네트워크 길찾기 시스템이고, RIP과 OSPF는 내부, BGP는 외부를 잇는 통신 전문가예요! 🛰️🧭

---
