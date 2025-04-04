~~~markdown
# 📚 Git & GitHub 기본 정리

---

# 📌 개요 (Overview)

이번 문서는 **Git 기본 사용법**과 **GitHub 협업 방법(Pull Request, Branch, Merge)**까지 초보자를 위한 버전 관리 입문편입니다.

---

# 💡 핵심 개념 요약 (Key Concepts)

## 🛠️ Git 기본 구조

- **Working Directory(WD)** : 작업 디렉토리
- **Staging Area(SA)** : 커밋 준비 영역
- **Repository(HEAD)** : 커밋된 버전들이 저장되는 곳

## 📝 주요 Git 명령어
```bash
git init                # 저장소 초기화
git status              # 파일 변경 상태 확인
git add 파일명           # 스테이징에 추가
git commit -m "메시지"    # 커밋 생성
git log                 # 커밋 이력 보기
git log --oneline       # 커밋 이력 요약 보기
```

✅ 버전 되돌리기 (Reset)
```bash
git reset --hard 커밋ID  # 완전 초기화(WD, SA, HEAD)
git reset --soft 커밋ID  # WD 유지, SA 초기화
git reset --mixed 커밋ID # WD 유지, SA만 초기화
```

---

# 🤝 GitHub Pull Request 흐름

### Pull Request란?
> 다른 사람이 작업한 내용을 본인 프로젝트에 반영할 때 사용하는 기능입니다.

### 절차
1. GitHub 저장소를 Fork (복제)
2. 개인 저장소에서 브랜치 생성 & 작업
3. 작업 완료 후 Pull Request 요청
4. 리뷰 & Merge 승인

✅ 협업 시 주의사항:
- 항상 pull 하고 push 하자! (최신 상태 유지)
- Conflict(충돌) 발생 시 수동으로 해결해야 함

---

# 🔧 GitHub 업로드 요약

### 기본 업로드 절차
```bash
git clone <GitHub 저장소 주소>
cd <폴더 이동>

git branch        # 로컬 브랜치 확인
git branch -r     # 원격 브랜치 확인
git fetch origin  # 원격 업데이트 가져오기
git status        # 상태 확인
git push origin   # 원격 저장소로 업로드
```

### 브랜치 작업 및 업로드
```bash
git branch dev          # 브랜치 생성
git switch dev          # dev 브랜치로 이동

# 작업 후

git add *
git commit -m "메시지"
git push origin dev
```

✅ 누가 수정했을 경우
```bash
git pull origin 브랜치명
```

---

# 🧪 Git 실습 문제 요약

### 실습 문제 핵심 흐름

1. git init 으로 저장소 초기화
2. 파일 추가 및 여러 커밋 생성
3. 브랜치 생성(dev, feature)
4. 브랜치 병합(merge) 및 충돌 해결(conflict)
5. master/main 브랜치로 병합 완료

✅ **항상 pull -> push 순서 기억!**

---

# ⚠ 주의사항 (Cautions)

- git reset 사용 시 데이터가 복구 불가능할 수 있으니 조심
- 병합할 때 conflict가 나면 차분히 수정 후 `git add`, `git merge --continue`
- GitHub 업로드 전에 항상 `git status`로 상태 점검하기

---

# ✅ 한 줄 요약 (1-Line Summary)

> Git과 GitHub를 자유자재로 다루면 협업이 10배 쉬워진다! 🌟🚀
~~~

