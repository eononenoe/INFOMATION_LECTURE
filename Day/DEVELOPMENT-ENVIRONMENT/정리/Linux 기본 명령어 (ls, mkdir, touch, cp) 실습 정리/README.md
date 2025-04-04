# 📚 Linux 기본 명령어 (ls, mkdir, touch, cp) 실습 정리

---

# 📌 개요 (Overview)

이 문서는 리눅스 파일 및 디렉토리 관리의 기본이 되는 **ls**, **mkdir**, **touch**, **cp** 명령어를 실습 중심으로 정리한 자료입니다.

---

# 💡 핵심 개념 요약 (Key Concepts)

## 📂 ls (List)

> 파일과 디렉토리 목록을 출력하는 명령어

### 주요 옵션
- `-a` : 숨김파일까지 모두 보기
- `-l` : 자세히 보기 (파일 권한, 소유자 등)
- `-R` : 하위 디렉토리까지 모두 보기
- `-d` : 디렉토리 자체 정보만 보기

### 실습 예시
```bash
ls /etc/
ls -l /etc/         # [명령어][옵션][타겟]
ls -al /etc/        # 옵션은 조합이 가능하다
ls -Ral /etc/
cd /etc
ls -l               # 상대경로에서는 경로 생략 가능
ls -ld /etc
```

---

## 📁 mkdir (Make Directory)

> 디렉토리를 생성하는 명령어

### 주요 옵션
- `-p` : 상위 디렉토리도 함께 생성

### 실습 예시
```bash
mkdir /home/test
ls -l /home

mkdir /home/health/a/b     # (X) 상위 폴더가 없으면 실패
mkdir -p /home/health/a/b  # (O) 상위 폴더까지 생성

mkdir /home/test/c/d       # (X)
mkdir -p /home/test/c/d/    # (O)
```

---

## 📖 man (manual)

> 명령어 사용법을 보는 매뉴얼 명령어

```bash
man 명령어이름
```

---

## 📝 touch

> 파일 생성 및 시간 정보 수정

### 주요 옵션
- `-d` : 특정 시간으로 수정
- `-t` : 날짜/시간 지정 (YYYYMMDDHHMMSS)

### 실습 예시
```bash
mkdir /touch
cd /touch

touch /touch/1
touch 2

# 여러 파일 생성
touch /touch/3 4 ./5

# 시간 변경
touch -d 12:12 1

touch -t 201601010101 6

# 파일 정보 확인
stat 6
```

---

## 📋 cp (Copy)

> 파일이나 디렉토리를 복사하는 명령어

### 주요 옵션
- `-i` : 덮어쓰기 전 물어보기
- `-r` : 디렉토리 복사
- `-p` : 원본 파일 정보(시간, 권한) 보존

### 실습 예시
```bash
mkdir /cptest
cd /cptest

# 파일 복사
cp /touch/1 /cptest/1
cp /touch/2 /cptest/
cp /touch/2 ~user1

# 파일 복사하면서 이름 변경
cp /touch/3 /cptest/sam
cp /touch/4 /cptest/sa

# 보존 복사
cp -p /touch/3 /cptest/3
cp -p /touch/4 /cptest/4
cp -p /touch/2 /cptest/test

# 디렉토리 복사
cp -r /touch /cptest

# 질의, 강제 옵션
cp -i /touch/1 /cptest
cp -f /touch/2 /cptest

# 복수 파일 복사
cp -f /touch/1 2 ./3 /cptest/
```

✅ **Tip:** 복수 경로 지정시 마지막 경로가 "복사될 디렉토리"입니다.

---

# 🧪 예제 또는 비유 (Examples or Analogies)

## 📝 문제 01

```bash
# 1. /final 디렉토리 생성
mkdir /final

# 2. 12, 34, 56 파일 생성
cd /final
touch 12 34 56

# 3. 34 파일 시간 수정 (1999년 01월 01일 12:00)
touch -t 199901011200 34

# 4. /back 디렉토리 생성
mkdir /back

# 5. 12, 56 파일 복사
cp /final/12 /back/
cp /final/56 /back/

# 6. 34 파일 보존 복사
cp -p /final/34 /back/
```

---

## 📝 문제 02

```bash
# 1. /backup 디렉토리 생성 및 파일 복사
mkdir /backup
cp /etc/login.defs /etc/passwd /boot/grub2/grub.cfg /backup/

# 2. /backup/test 디렉토리에 이름 변경하여 복사
mkdir /backup/test
cp /backup/login.defs /backup/test/login
cp /backup/passwd /backup/test/pass
cp /backup/grub.cfg /backup/test/grub

# 3. test1, test2 파일 생성
cd /backup
touch test1
cd /backup/test
touch test2

# 4. /backup/test 디렉토리를 이름 변경 보존 복사
cp -rp /backup/test /home/test/c/d/linux

# 5. /home에서 backup 파일 4개를 보존 복사
cd /home
cp -p /backup/login.defs /backup/passwd /backup/grub.cfg /backup/test1 /home/test/c/d/linux/
```

---

# ⚠ 주의사항 (Cautions)

- `cp` 사용 시 경로를 정확히 지정하세요.
- 복사 중 이름 변경 시 실수하지 않도록 주의하세요.
- `-p` 옵션을 써야 시간/권한이 보존됩니다.

---

# ✅ 한 줄 요약 (1-Line Summary)

> 파일과 디렉토리를 자유롭게 생성하고 복사하는 것은 리눅스 기본기의 시작이다! 🏁
~~~

