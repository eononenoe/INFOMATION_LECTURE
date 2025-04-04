# 📚 VI 편집기, 권한 관리, 계정 생성 정리

---

# 📌 개요 (Overview)

이번 문서에서는 **VI 문서 편집기**, **파일/디렉토리 권한과 소유권**, **리눅스 계정 시스템**에 대해 초보자도 이해할 수 있도록 정리했습니다.

---

# 💡 핵심 개념 요약 (Key Concepts)

## 📝 VI 문서 편집기

- **이동 모드** : h(왼), j(아래), k(위), l(오른)
- **편집 모드** : a(다음 문자부터), i(현재 위치), o(아래 줄), s(삭제 후 입력)
- **실행 모드** : `:wq` (저장후 나가기), `:q!` (강제종료)
- **기타 명령어** : `:set number` (행 번호 출력), `:set nonu` (행 번호 숨김)

---

## 🔐 권한과 소유권

### 허가권 (Permission)
- r (read): 읽기
- w (write): 쓰기
- x (execute): 실행

| 구분 | 파일 | 디렉토리 |
|:---|:---|:---|
| r | 파일 내용 보기 | 폴더 내 목록 보기 |
| w | 파일 내용 수정 | 폴더 내 파일 생성/수정/삭제 |
| x | 실행파일 실행 | 폴더 진입 허용 |

**권한 표현 방법**
- Symbolic 방식: rwxr-xr-x
- Numeric 방식: 755

### 소유권 (Ownership)
- 사용자(User), 그룹(Group), 기타(Other)에 대해 권한 설정 가능

### chmod (권한 변경)
```bash
chmod 755 파일명
chmod u+x,g+x 파일명
chmod o-r 파일명
```

### chown (소유권 변경)
```bash
chown user:group 파일명
```

---

## 🧠 계정 시스템

- **계정 인증(Authentication)** + **권한 부여(Authorization)** = 인가

### 계정 관련 주요 파일
- `/etc/login.defs` : 보안 설정
- `/etc/default/useradd` : 홈디렉토리/쉘 경로 기본 설정
- `/etc/passwd` : 사용자 기본정보 저장
- `/etc/shadow` : 암호화된 비밀번호 저장
- `/etc/group` : 그룹 정보 저장
- `/home/계정명/` : 사용자 홈디렉토리
- `/var/spool/mail/계정명` : 메일 저장소

### useradd 옵션
```bash
useradd -u 1800 test10         # UID 지정
useradd -g test10 test20        # 주 그룹 지정
useradd -G test10 test30        # 보조 그룹 추가
useradd -s /export/test40 test40 # 기본 쉘 지정
useradd -m -d /home/test50 -k /etc/skel2 test50 # 스켈 경로 변경 및 홈 생성
useradd -s /bin/ksh test60      # 쉘 변경
```

### userdel 옵션
```bash
userdel username               # 계정 삭제
userdel -r username             # 계정 + 홈디렉토리 삭제
```

---

# 🧪 예제 또는 비유 (Examples or Analogies)

### 미니 문제 (권한 관련)

| 기호표현 | 숫자표현 |
|:---|:---|
| rw-r-xr-- | 654 |
| rwxr--r-x | 745 |
| r--rwxr-- | 474 |
| r-xr--r-x | 545 |
| r--r-x--- | 450 |

| 숫자표현 | 기호표현 |
|:---|:---|
| 755 | rwxr-xr-x |
| 644 | rw-r--r-- |
| 701 | rwx-----x |
| 542 | r-xr---w- |
| 643 | rw-r---wx |
| 375 | -wxrwxr-x |

### 미니 문제 (계정 생성)
```bash
# 1. UID 1800으로 test10 생성
useradd -u 1800 test10

# 2. 주 그룹을 test10으로 지정하여 test20 생성
useradd -g test10 test20

# 3. 보조 그룹에 test10 추가하여 test30 생성
useradd -G test10 test30

# 4. 기본 쉘을 /export/test40으로 지정하여 test40 생성
useradd -s /export/test40 test40

# 5. 스켈을 /etc/skel2로, 홈디렉토리를 /home/test50으로 하여 test50 생성
cp -r /etc/skel /etc/skel2
useradd -m -d /home/test50 -k /etc/skel2 test50

# 6. 쉘을 /bin/ksh로 지정하여 test60 생성
useradd -s /bin/ksh test60
```

---

# ⚠ 주의사항 (Cautions)

- VI 편집 시 모드 전환을 정확히 인지하고 사용하세요.
- chmod, chown 사용 시 권한 실수로 시스템 장애를 초래할 수 있습니다.
- 계정 생성 후 홈디렉토리, 쉘 설정을 반드시 확인하세요.

---

# ✅ 한 줄 요약 (1-Line Summary)

> VI 편집부터 권한 설정, 계정 생성까지 마스터하면 리눅스 관리의 반은 끝났다! 🚀
~~~

