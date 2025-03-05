# 02

> 계정
> 

```jsx
계정 : 인증과              권한부여(소유권, 허가권 부여)의 도구
      (Authentication)    (permission)
      :시스탬 네에서 등록된 사용자임을 확인
			:ID/PW, 지문인증, 홍채인증 ...
			:ID를 확인(식별)
			:PW의 일치여부 확인(인증)
			
인증 + 허가 = 인가(Authorization)
```

---

> **리눅스 계정관련 파일**
> 

```jsx
계정 생성시 필요한 정보 저장 파일
/etc/login.defs    ->   /etc/default/useradd
계정의 보안관련설정      계정 경로 관련 설정
(패스워드관련설정 다수) (계정 개별 Home디렉토리경로)
                       (계정 Skel 경로 설정)
                       
개정생성 요청이후 해당 계정의 개별 정보
/etc/passwd 사용자의 기본정보저장
계정명, UID, GID,  개별홈 D경로, 쉘종류
/etc/shadow : 암호화된 패스워드 저장

/etc/group : 그룹계정 정보저장
/home/개별홈디렉토리 : 개별 계정마다 부여되는 작업공간
/var/spool/mail/개별메일파일 : 개별 임시 메일함
```

---

> **계정**
> 

```jsx
-------------------------------------------------------------
/etc/login.defs : 보안관련 설정(모든계정적용)
-------------------------------------------------------------
MAIL_DIR        /var/spool/mail

PASS_MAX_DAYS   99999		패스워드 최대 사용일
PASS_MIN_DAYS   0		패스워드 최소 사용일		
PASS_MIN_LEN    5			패스워드 최소 길이
PASS_WARN_AGE   7		패스워드 만료 경고일

UID_MIN                   500		UID의 최소 최대 범위
UID_MAX                 60000
`
GID_MIN                   500		GID의 최소 최대 범위
GID_MAX                 60000

CREATE_HOME     yes		홈디렉토리 생성여부

UMASK           077			홈디렉토리의 Umask 값
USERGROUPS_ENAB yes		사용자 계정 삭제시 그룹 삭제 여부 

ENCRYPT_METHOD SHA512		암호화 기법

CentOS 5.2 = MD5
CentOS 6.2 = SHA512

---------------------------------------------------------
/etc/default/useradd : 계정 기본 경로 설정 (모든계정적용)
---------------------------------------------------------

GROUP=100	그룹지정(100 :UID 와 동일한 GID명)
HOME=/home	홈디렉토리 위치
INACTIVE=-1	패스워드 만료후 계정 사용 불가능 되는 날 지정(-1 :사용안함, 0:기간없음[계정정지],1 : 하루,,,,)
EXPIRE=		계정의 패스워드 만료일(비어있으면 무제한)
SHELL=/bin/bash	로그인시 사용되는 쉘 경로
SKEL=/etc/skel	스컬디렉토리 경로
CREATE_MAIL_SPOOL=yes	메일함 생성여부

★★★★ 주의 ★★★★

메일함 생성여부는 /etc/default/useradd 
메일함 디렉토리설정은 /etc/login.defs
계정 생성여부는 /etc/login.defs
계정 홈위치 	/etc/default/useradd

---------------------------------------------------------
생성한 계정 정보 저장
---------------------------------------------------------

1./etc/passwd (계정 기본정보저장) 	

1)      2)3)   4)  5)  6)               7)
heath:x:503:503:  :/home/heath:/bin/bash

1) 계정명
2) 패스워드(x-> /etc/shadow에 저장)
3) UID
4) GID
5) Comment
6) 홈디렉토리 경로
7) 사용하는 쉘 경로

2./etc/shadow (계정 패스워드 정보저장)

1)      2)  3)  4)5)    6)   7) 8)
heath:!!/:17216:0:99999:7  :  :  :

1)계정명
2)암호화된 패스워드 저장공간
3)패스워드 생성날짜(1970.01.01이후)
4)패스워드 최소사용날짜
5)패스워드 최대사용날짜
6)패스워드 만료 경고일 
7)만료시 비활성화 옵션(-1:미설정, 0:바로만료,1:하루연장)
8)만료지정일 

패스워드 설정시 !! 부분의 암호화된 패스워드 저장

heath:$6$gAQ20msY$lRejdUefR4ytjO2CjhzcJCX5EQYPk3c.3HpOtyqpCye4C6fo5MbaLZPOwajWhielmTlxUf8dls11.KiGHp5e1/:17216:0:99999:7:::
$6 = 해시 알고리즘 종류
$gAQ20msY = Salt 값
$lRejdUefR4ytjO2CjhzcJCX5EQYPk3c.3HpOtyqpCye4C6fo5MbaLZPOwajWhielmTlxUf8dls11.KiGHp5e1/:17216:0:99999:7:::
= Salt값 + 평문Password -> 해시알고리즘 -> 해시값
3./etc/group (그룹계정 정보 저장)
heath:x:503:

4. /home/계정명(사용자의 홈디렉토리 생성 & 기본프로필 환경저장)

.bash_profile	: 로그인쉘 프로필파일	
.bashrc		: 서브쉘 프로필파일
.bash_logout	: 로그아웃시 적용할 설정
.bash_history	: 명령 기록 보존 파일

5./var/spool/mail/계정명(사용자 계정의 임시 메일함 생성)

```

---

---

> **무결성 알고리즘의 특징**
> 

```jsx
단방향성(복호화 할수없다)
Salt값을 써서 다른값을 주게 한다

ID : User100 -> SHA512 -> user100:$$$
PW : 1
ID : User200 -> SHA512 -> user200:$$$
PW : 1
```

---

> **계정 생성**
> 

```jsx
id = UID, GID, 속한 그룹 목록 확인 가능

useradd - u <UID> <username>
<UID> 원하는 사용자ID 숫자

[그룹]
useradd -g <groupname> <username>

[보조그룹]
useradd -G <groupname> <username>

[쉘 지정]
useradd -s <경로> <username>

[쉘 경로 확인]
grep <username> /etc/passwd
<사용자명>:x:UID:GID:<설명>:<홈디렉토리>:<쉘경로>

[홈 디렉토리]
-m : 홈 디렉토리를 생성하도록 지시
-k : 스켈 경로 변경
-d : 홈 디렉토리를 지정
useradd -m -k <스켈 경로> -d <홈 디렉토리 경로> <username>

[계정 삭제]
userdel <username>
-계정과 홈 디렉토리 및 메일 스풀 삭제
userdel -r <username>
```

---

> **문제**
> 

```jsx
-------------------------------
[미니 문제]
-------------------------------
1.test10 계정 생성시 UID 를 1800으로 지정하세요 
useradd -u <1800> <test10>

2.test20 계정 생성시 주그룹을 test10으로 지정하세요
useradd -g test10 test20

3.test30 계정 생성시 보조그룹을 test10 추가
useradd -G test10 test30

4.test40 계정 생성시 기본쉘 경로를 /export/test40 로 지정하세요
useradd -s /export/test40 test40

5.test50 계정 생성시 스컬의 기본경로를 /skel2로하고 test50홈디렉토리에 test50가 생성되도록 하세요
cp -r /etc/skel /etc/skel2
touch /ske12/test50
useradd -m -d /home/test50 -k /etc/ske12 test50

6.test60 계정 생성시 쉘을 /bin/ksh 로 설정
useradd -s /bin/ksh test60
```