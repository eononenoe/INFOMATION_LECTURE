~~~markdown
# 📚 Linux 기본 명령어 (mv, rm, cat, head, tail, more, 리다이렉션, 파이프라인) 정리

---

# 📌 개요 (Overview)

이번 문서에서는 **파일/디렉토리 이동**, **삭제**, **텍스트 출력**, **리다이렉션**, **파이프라인** 사용법을 실습 중심으로 다룹니다.

---

# 💡 핵심 개념 요약 (Key Concepts)

## 🚚 mv (Move)

> 파일이나 디렉토리를 이동하거나 이름 변경하는 명령어

### 실습 환경
```bash
mkdir /mvfile /mvtest
cd /mvfile
touch 1 2 3 4
mkdir a b c
cd /mvtest
```

### 실습 예시
```bash
mv /mvfile/1 /mvtest/1
mv /mvfile/2 /mvtest
mv /mvfile/a ./
mv /mvfile/3 /mvfile/b /mvfile/c /mvtest
mv /mvfile/4 /mvtest/sa
```

---

## 🗑️ rm (Remove)

> 파일 및 디렉토리를 삭제하는 명령어

### 주요 옵션
- `-f` : 강제 삭제
- `-r` : 디렉토리 삭제
- `-i` : 삭제 전 물어보기

### 실습 환경
```bash
mkdir /rmtest
cd /rmtest
touch 1 2 3 4
mkdir a b c
```

---

## 📄 cat (Concatenate)

> 파일 내용을 출력하는 명령어

### 주요 옵션
- `-n` : 행 번호 표시

### 실습 예시
```bash
cat /etc/passwd
cat -n /etc/passwd
```

---

## 🧹 head & tail

> 파일의 처음(head) 또는 끝(tail) 부분을 출력

### 주요 옵션
- `-숫자` : 지정된 줄 수 만큼 출력

### 실습 예시
```bash
head /etc/passwd
head -5 /etc/passwd
tail /etc/passwd
tail -5 /etc/passwd
```

---

## 📜 more

> 파일을 화면 단위로 출력 (스크롤 가능)

### 실습 예시
```bash
more /etc/passwd
more -4 /etc/passwd
```

---

## 🔗 논리연산자 (&&, ||)

| 연산자 | 의미 | 설명 |
|:---|:---|:---|
| `&&` | AND | 왼쪽 명령어 성공 시 오른쪽 실행 |
| `||` | OR | 왼쪽 명령어 실패 시 오른쪽 실행 |

### 실습 예시
```bash
mkdir /andtest && touch /andtest/testfile1
mkdir /ortest || touch /ortest/testfile1
```

✅ **미니문제**
- /andtest 디렉토리 만들고 and 파일 생성 (한줄 명령어)
- /ortest 디렉토리 만들고 or 파일 생성 (한줄 명령어)

---

# 🧪 리다이렉션 (Redirection)

> 표준 입출력을 파일로 대체하는 기능

### 표준 출력
```bash
cat > a
hello
Ctrl+C

cat a  # hello 출력
```

### [>] 덮어쓰기
```bash
cat > a
test
```

### [>>] 추가하기
```bash
cat >> b
bbb
cat >> b
Aaa
```

### 파일 합치기
```bash
cat a b > c
tail -2 c > d
```

### 표준 입력
```bash
cat > a
5
3
4
2
1
Ctrl+C

sort < a  # 오름차순 정렬
```

### 표준 에러
```bash
ls -al /wrongpath 2> errfile
```

### 표준 출력+에러 모두 저장
```bash
ls -al /etc/ /wrongpath &> errfile3
```

✅ **미니문제**
1. /etc 디렉토리 목록을 /retest/a 저장
2. /etc/passwd 위 7줄을 /retest/b 저장
3. /etc/inittab 아래 4줄을 /retest/c 저장
4. a, b, c를 합쳐 d 파일 생성

---

# 🔥 파이프라인 (Pipeline)

> 한 명령어의 출력 결과를 다른 명령어의 입력으로 넘기는 기능

### 실습 예시
```bash
ls -al /dev | cat -n | more
```

---

# 📝 참고: 세미콜론 (;) 

> 여러 명령어를 한 번에 실행할 때 사용합니다.

### 실습 예시
```bash
mkdir /test100 ; touch /test100/a ; ls -al /test100
```

---

# ⚠ 주의사항 (Cautions)

- `mv`, `rm` 사용 시 파일이나 디렉토리 실수 삭제 주의!
- `>` 사용 시 기존 파일 내용이 덮어써지니 조심!
- 파이프라인과 리다이렉션을 섞어 쓰면 복잡한 작업도 간단하게 처리할 수 있어요.

---

# ✅ 한 줄 요약 (1-Line Summary)

> 파일 이동, 삭제, 출력, 입출력 제어까지 자유자재로 다루면 리눅스 장인이 된다! 🧙‍♂️✨
~~~

