~~~markdown
# 📚 SourceTree & Git Workflow 정리

---

# 📌 개요 (Overview)

이번 문서는 **SourceTree를 통한 Git 관리 방법**과 다양한 브랜치 전략 (Reset, Merge, Rebase 등) 과정을 실습을 통해 정리했습니다.

---

# 💡 핵심 개념 요약 (Key Concepts)

## 🛠️ 사용 프로그램 (IDE)

```plaintext
IDE(GIT) : Eclipse (JAVA, JSP/SERVLET)
CMD : STS3 (전자정부 Framework)
SourceTree : Intellij
깃크라켄 : VSCode
```

---

# 🖥️ SourceTree 주요 기능

## 1. Commit
- 파일 변경 사항을 로컬 저장소에 기록
- Commit Message는 명확하게 작성

## 2. Reset
- **Reset Hard** : 모든 작업 폴더를 강제로 특정 커밋 시점으로 이동
- **Reset Soft** : 커밋은 지우되 파일 수정사항은 유지

## 3. Branch
- 새로운 기능을 개발할 때 브랜치를 생성하여 관리
- 브랜치 이동은 **더블 클릭**

## 4. Merge
- 다른 브랜치에서 작업한 내용을 병합(Merge)
- 충돌(Conflict) 발생 시 수동으로 해결 후 Commit

---

# 🧪 실습 문제 01 (Commit & Merge)

### TEST2_1 폴더에 SourceTree 연결 후 실습

**순서:**
1. `aaa.txt` 파일 생성 후 V0.0 master Commit
2. `dev` 브랜치 생성 ➔ `dev.txt` 생성 ➔ "V0.1 dev init" Commit
3. `feature/func1` 브랜치 생성 ➔ `func1.txt` 생성 ➔ "V0.2 func1.txt add" Commit
4. `dev` 브랜치로 이동
5. `feature/func2` 브랜치 생성 ➔ `func2.txt` 생성 ➔ "V0.2 func2.txt add" Commit
6. `feature/func1` ➔ `dev` 병합
7. `feature/func2` ➔ `dev` 병합
8. `dev` ➔ `master` 병합

⚠️ 병합 충돌이 발생하면 적절히 수정 후 Commit

---

# 🌐 Git 연동

- GitHub에 연결하여 원격 저장소 관리
- Push/ Pull을 통해 GitHub와 동기화

---

# 🧪 실습 문제 02 (Rebase & Merge)

**목표:** `SOURCE_TREE_2` GitHub 레포지토리 관리

**순서:**

1. GitHub에 `SOURCE_TREE_2` 저장소 생성 (Readme 체크)
2. SourceTree로 Clone
3. `developer` 브랜치 생성 ➔ `dev.txt` 추가 ➔ "V0.0 Dev's init" Commit
4. `feature/board` 브랜치 생성 ➔ `board.txt` 추가 ➔ "V0.1 feature/board init" Commit
5. `feature/auth` 브랜치 생성 ➔ `auth.txt` 추가 ➔ "V0.1 feature/auth init" Commit
6. `developer` 브랜치로 이동 ➔ `Readme.md` 수정 ➔ "V0.1 RebaseMerge" Commit
7. `feature/board` 브랜치에서 `developer`로 rebase
8. `developer`에서 rebase된 `feature/board` 병합
9. `feature/auth` 브랜치에서 `developer`로 rebase
10. `developer`에서 rebase된 `feature/auth` 병합
11. `developer` 브랜치를 `main`으로 병합
12. 전체 수정사항을 GitHub로 push

✅ 핵심: **rebase 시 브랜치 순서(위치)를 정확히 맞출 것!**

---

# ⚠ 주의사항 (Cautions)

- Reset Hard는 복구 불가이므로 신중히 사용할 것
- rebase 후 merge할 때 conflict 발생 가능성 있음
- 항상 push 전 `commit`을 먼저 완료해야 함

---

# ✅ 한 줄 요약 (1-Line Summary)

> SourceTree로 Git 브랜치 전략을 마스터하고 실전 협업 준비 완료! 🚀
~~~

