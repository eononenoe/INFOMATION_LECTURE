# 02

> **mv : 파일 디렉토리 이동(옵션x)**
> 

```jsx
-환경-
mkdir /mvfile /mvtest
cd /mvfile
touch 1 2 3 4 
mkdir a b c 
cd /mvtest

-실습-
1. mv /mvfile/1 	/mvtest/1		
2. mv /mvfile/2 	/mvtest			
3. mv /mvfile/a 	./			
4. mv /mvfile/3	/mvfile/b	/mvfile/c 	/mvtest	
5. mv /mvfile/4	/mvtest/sa		
```

---

> **rm(remove) : 파일&디렉토리 삭제**
> 

```jsx
[옵션] 
-f : 강제 삭제
-r : 디렉토리 삭제
-i : 질의(y/n)

[환경]
mkdir /rmtest 
cd /rmtest
touch 1 2 3 4
mkdir a b c 
```

---

> **cat : 문서 전체 출력**
> 

```jsx
[옵션]
-n  : 행번호 출력

[실습]

cat /etc/passwd
cat -n /etc/passwd
```

---

> **head&tail : 위&아래에서 시작해서(기본10줄) 출력**
> 

```jsx
[옵션]
-숫자 : 지정된 숫자 줄수만큼 출력

[실습]

head /etc/passwd
head -5 /etc/passwd 	
head -2 /etc/passwd 
tail /etc/passwd
tail -5 /etc/passwd
```

> **more : 화면크기만큼 출력**
> 

```jsx
more /etc/passwd

[실습]
more /etc/passwd
more -4 /etc/passwd
```

---

> **파이프라인 / 리다이렉션**
> 

> **논리연산자**
> 

```jsx
-------------------------------------------
논리 연산자
-------------------------------------------

---------------
&& : and연산	
---------------
왼쪽 명령어 성공시 오른쪽 명령어 실행
왼쪽 명령어 실패시 오른쪽 명령어 실행x

------
실습
------

mkdir /andtest && touch /andtest/testfile1
ls -al /andtest 

ls -al /fj0923k20  && touch /andtest/testfil2
ls -al /andtest

---------------
||  : or 연산	
---------------
왼쪽 명령어 성공시 오른쪽 명령어 실행 x		
왼쪽 명령어 실패시 오른쪽 명령어 실행

------
실습
------

mkdir /ortest || touch /ortest/testfile1
ls -al /ortest

ls -al /2m302903rk2 || touch /ortest/testfile2
ls -al /ortest

-------------------------------------------
[미니문제]
-------------------------------------------
기존 /andtest, /ortest 디렉토리를 삭제하고 진행 하세요

1. /andtest 디렉토리를 만들고 그안에  and 파일을 만드는 작업을 한줄명령어로 수행하세요

2. /ortest 디렉토리를 만들고 그안에 or파일을 만드는 작업을 한줄 명령어로 수행하세요 

```

![image.png](image.png)

![image.png](image%201.png)

---

> **리다이렉션**
> 

```jsx
-------------------------------------------------
리다이렉션 
-------------------------------------------------
: 표준입력&출력을 파일로 대체한다.

[환경]
mkdir /retest
cd /retest
-------------------------------------------------
1.표준출력(>,>>)
-------------------------------------------------
-> 모니터 출력물을 파일로 대체한다.
-------------------
기본 확인
-------------------

Cat		
hello	- 키보드 입력
hello	- 모니터 출력
컨트롤+c- 작업 취소

Cat >a
hello	- 키보드 입력
	- 모니터 출력 없음
컨트롤+c- 작업 취소		

ls -l 	- a파일 생성

cat a	- a파일 확인 hello가 저장

-------------------
[>] : 생성,덮어쓰기
-------------------

cat a	- hello 저장

cat  > a	 
Test
CTRL+C

cat a	- test 저장

cat > a  	
heath
CTRL + c

cat  a	- heath 저장
	 	
-------------------
[>>] : 생성,추가하기
-------------------

cat >> b
bbb
CTRL + c		

ls -al 	- b파일 생성
cat b	- b내용보기, bbb 저장

cat b		
cat >> b 		
Aaa	
CTRL + c

cat b	- bbb아래에 Aaa 저장

cat b		
cat a b > c 	
cat c		 
tail -2  c>d	

-------------------------------------------------
2.표준 입력(<)		- 추가!
-------------------------------------------------
->키보드에 입력할 내용을 파일로 대체한다.

sort  : 정렬 명령어

cat > a
5
3
4
2
1

ctrl +c

sort < a
1
2
3
4
5
 

-------------------------------------------------
5. 표준 에러(2>)
-------------------------------------------------
-> 에러 메시지만 파일로 대체한다.

ls -al /23f2f3 
ls -al /109k029 2> errfile1
cat errfile

-------------------------------------------------
6. 표준 출력 & 표준에러 (&>)
-------------------------------------------------
-> 출력물 + 에러메시지를 파일로 대체한다.

ls -al /etc/ /etwcmwioecw 2> errfile2
->/etc/목록은 출력, /etwcmwioecw 목록의 에러메시지는 파일로 저장

ls -al /etc/ /eetwomf2030 &> errfile3
->/etc/의 목록과 /etwcmwioecw 목록의 에러메시지는 파일로 저장

-------------------------------------------------
미니문제
-------------------------------------------------
[환경]
mkdir /retest

1. /etc안의 디렉토리의 목록을 /retest/a에 저장하세요
2. /etc/passwd의 위에서 7번째 행까지의 내용을 /retest/b에 저장하세요
3. /etc/inittab의 아래에서 4번째 행까지의 내용을 /retest/c에 저장하세요
4. /retest 안의 a,b,c,의 내용을 병합하는 d 파일을 만드세요
```

![image.png](image%202.png)

![image.png](image%203.png)

---

> **파이프라인**
> 

```jsx
--------------------------------------------------
파이프 라인(|) 
--------------------------------------------------
->한명령어의 표준출력을 다른 명령어의 표준 입력으로 보내는 기능
->왼쪽 명령의 결과를 받아서 오른쪽 명령어 적용

[실습]

ls -al /dev 

ls -al /dev | cat -n

ls -al /dev | cat -n | more

--------------------------------------------------
[참고]  ; 
--------------------------------------------------
-> 한번에 여러 명령어 실행
-> 각 명령어를 독립적으로 수행

[실습]

mkdir /test100 ;touch /test100/a; ls -al /test100  

ls -al /dev ; cat -n		--	x, 각 명령어 따로 실행
ls -al /dev ; cat -n ; more 	--	x, 각 명령어 따로 실행
```