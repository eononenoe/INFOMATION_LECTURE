# 📚 Linux 사용자 계정 및 프로세스 관리 정리

---

# 📌 개요 (Overview)

이번 문서는 **usermod로 계정 수정**, **userdel로 계정 삭제**, **프로세스 관리**를 다루는 리눅스 기초 관리편입니다.

---

# 💡 핵심 개념 요약 (Key Concepts)

## 👤 usermod

> 기존 계정 정보를 수정하는 명령어

### 주요 옵션
- `-u` : UID 변경
- `-g` : 주 그룹 변경
- `-G` : 보조 그룹 변경
- `-c` : 계정 설명(comment) 변경
- `-s` : 기본 쉘 변경
- `-d` : 홈디렉토리 설정
- `-m` : 홈디렉토리 이동

### 실습 예시
```bash
usermod -u 2000 mod
usermod -g heath mod
usermod -G test1 mod
usermod -c linux mod
usermod -s /bin/sh mod

mkdir -p /export/home
usermod -md /export/home/mod mod
```

---

## 🗑️ userdel

> 사용자 계정을 삭제하는 명령어

### 주요 옵션
- `-r` : 홈디렉토리와 메일함도 함께 삭제

### 실습 예시
```bash
userdel mod         # 홈디렉토리는 남음
userdel -r itbank   # 홈디렉토리와 메일까지 삭제
```

---

## ⚙️ 프로세스 관리

> 시스템에서 실행 중인 프로세스를 확인하고 관리하는 방법

### 주요 명령어
```bash
ps         # 현재 사용자 프로세스 확인
ps -elf    # 시스템 전체 프로세스 확인
```

✅ 프로세스 우선순위 조절 명령어
```bash
nice -n [우선순위값] 명령어
```

### 주요 항목
- **UID** : 프로세스를 실행한 사용자 ID
- **PID** : 프로세스 ID
- **PRI** : 프로세스 우선순위 (낮을수록 우선)
- **NI** : 프로세스 Nice값 (우선순위에 영향)

---

# ⚠ 주의사항 (Cautions)

- usermod로 홈디렉토리 변경 시 `-m` 옵션을 꼭 함께 사용해야 파일 이동까지 처리됩니다.
- userdel 사용 시 `-r`을 빼먹으면 홈디렉토리와 메일함이 남을 수 있습니다.
- nice 명령어로 잘못된 우선순위 설정은 시스템 퍼포먼스에 영향을 줄 수 있습니다.

---

# ✅ 한 줄 요약 (1-Line Summary)

> 리눅스 계정과 프로세스 관리는 서버 관리의 기본 중 기본이다! 🚀