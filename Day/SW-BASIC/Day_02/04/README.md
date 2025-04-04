# 04

> OSI 계층
> 

| OS | 응용, 표현, 세션 계층 |
| --- | --- |
| - | 전송 계층 |
| Network Device | 네트워크, 데이터, 물리 계층 |

![image.png](image%205.png)

> 응용(application) 계층
> 

```jsx
사용자가 직접 이용하는 프로그램과 서비스를 제공
```

> 표현(presentation) 계층
> 

```jsx
데이터를 송수신하는 양식이나 형식을 변환 (예: 암호화, 압축, 이미지)
```

> 세션(session) 계층
> 

```jsx
통신 세션을 설정하고 유지하며 종료
```

![image.png](image%206.png)

> 3계층 정리
> 

```jsx
1.물리 계층
	역할 : 장치간 물리적 연결
	약속 : 전기적 신호 전달
	장치 : 케이블, 리피터, 허브
	
2.데이터 링크 계층
	역할 : 장치간(Point-to-Point) 데이터 운송방식
	약속 : Ethernet, HDLC
	장치 : L2 Switch
	
3.네트워크 계층
	역할 : 경로탐색
	약속 : IP, ICMP, ARP, ROUTING, PROTOCOL
	장치 : Router
	
4.전송 계층
	역할 : 종단간(송수신지 사이, End-to-End) 데이터의 신뢰성 보장
	약속 : TCP/UDP
	장치 : L4 Switch(로드밸런서)
```
