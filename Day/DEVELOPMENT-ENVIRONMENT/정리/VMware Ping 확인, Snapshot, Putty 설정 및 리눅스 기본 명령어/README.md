# 📚 VMware Ping 확인, Snapshot, Putty 설정 및 리눅스 기본 명령어 정리

---

# 📌 개요 (Overview)

이 문서는 **VMware Ping 확인**, **Snapshot 사용법**, **Putty 설정 방법**, **리눅스 기본 명령어 및 경로이동 실습**까지 초보자도 쉽게 따라할 수 있도록 정리한 자료입니다.

---

# 💡 핵심 개념 요약 (Key Concepts)

## 📡 VMware Ping 확인

- 터미널에서 `ping` 명령어로 네트워크 연결을 확인할 수 있습니다.
- **`Ctrl + C`** : Ping을 멈추거나 터미널 작업을 취소하는 단축키입니다.

---

## 📸 Snapshot

> **Snapshot**은 가상 머신의 특정 시점 상태를 저장하는 기능입니다.

- 복구용 백업을 만들 때 유용합니다.
- 문제가 생기면 Snapshot 시점으로 간편하게 복구할 수 있습니다.

---

## 🔐 Putty 설정

- Putty를 실행해 IP 주소 입력 후 접속합니다.
- 로그인 시 입력
  ```
  login as: root
  root@192.168.10.10's password: 1
  ```
- **administrator(Windows)** vs **root(Linux)** : 모두 최고 관리자 계정이지만, 사용하는 OS에 따라 부르는 이름이 다릅니다.

---

## 🔑 패스워드 지정

> 리눅스에서는 관리자(root)와 일반 사용자 계정에 대해 각각 비밀번호를 설정할 수 있습니다.

```bash
# 관리자(root) 비밀번호 변경
[root@localhost ~]# passwd

# 특정 사용자(user1) 비밀번호 변경
[root@localhost ~]# passwd user1
```

- 비밀번호는 보통 8자 이상이어야 합니다.

---

## 🔁 재부팅 & 종료 명령어

### 재부팅
```bash
reboot
shutdown -r now
init 6
```

### 종료
```bash
poweroff
shutdown -h now
halt
init 0
```

---

## 🧠 리눅스 런레벨 (Run Level)

| 런레벨 | 설명 | 특징 |
|:---|:---|:---|
| 0 | Halt | 시스템 중지 (기본값으로 설정 불가) |
| 1 | Single user mode | 단일 사용자 모드, 네트워크 미사용, 복구 작업용 |
| 2 | Multiuser without NFS | 네트워크 없이 다중 사용자 모드 |
| 3 | Full multiuser mode | 네트워크 지원 다중 사용자 모드 |
| 4 | Unused | 사용자가 직접 정의 가능 |
| 5 | X11 | GUI (그래픽 환경) 모드 |
| 6 | Reboot | 시스템 재시작 (기본값 설정 불가) |

---

## 🛠️ 리눅스 주요 명령어

- `ifconfig` : 네트워크 정보 확인 📡
- `pwd` : 현재 디렉토리 경로 출력 📂

### 경로 이동 방법

**1. 절대 경로 (root / 부터 시작)**
```bash
cd /
pwd

cd /home/user1
pwd

cd /dev
pwd

cd /boot
pwd
```

**2. 상대 경로 (현재 위치 기준)**
```bash
cd user1   # 현재 위치에서 하위 디렉토리로 이동
cd .       # 현재 디렉토리 유지
cd ..      # 상위 디렉토리 이동
cd ..      # 다시 상위로 이동
cd etc     # 하위 디렉토리 etc로 이동
cd ~       # 홈 디렉토리로 이동
```

### 특수문자
- `.` : 현재 디렉토리
- `..` : 상위 디렉토리
- `~` : 사용자 홈 디렉토리

---

# 🧪 예제 또는 비유 (Examples or Analogies)

## 📝 문제 01 (절대 경로)

```bash
# 환경 세팅
mkdir -p /test/a/b/c/ /test1/f/g/h/

# 절대 경로로 이동
cd /test/a
cd /test1/f/g
cd /test/a/b/c/
cd /test1/f/g/h
```

---

## 📝 문제 02 (상대 경로)

```bash
# 시작 위치 이동
cd /test/a

# 상대 경로 이동
cd b/c
cd ../..
cd ../test1/f
cd g/h
```

---

# ⚠ 주의사항 (Cautions)

- 패스워드는 꼭 8자리 이상으로 설정하세요.
- Ping이 안 되면 VMware 네트워크 설정을 확인하세요.
- Snapshot은 작업 전후 자주 찍어두는 습관을 들이세요.

---

# ✅ 한 줄 요약 (1-Line Summary)

> VMware와 Putty를 통해 리눅스 서버에 접속하고, 기본 명령어와 경로 이동을 자유자재로 다루자! 🚀
~~~

