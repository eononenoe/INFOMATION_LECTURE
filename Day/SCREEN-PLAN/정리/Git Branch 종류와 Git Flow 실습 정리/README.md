~~~markdown
# 📚 Git Branch 종류와 Git Flow 실습 정리

---

# 📌 개요 (Overview)

이번 문서는 **Git Branch 종류**와 **Git Flow 전략**을 기반으로 브랜치 관리 및 병합 실습 과정을 정리했습니다.

---

# 💡 핵심 개념 요약 (Key Concepts)

## 🌳 Git Branch 종류

### 1. Main (Master) Branch
- 최종 제품이 존재하는 브랜치
- 항상 안정된 버전만 존재해야 함

### 2. Develop Branch
- 다음 릴리스를 준비하는 개발용 브랜치
- 새로운 기능(feature)들을 통합하는 공간

### 3. Feature Branch
- 각각의 새로운 기능(또는 수정사항)을 개발하는 브랜치
- 작업 완료 후 develop 브랜치로 병합

✅ 브랜치 이름 예시:
- feature/login
- feature/board
- feature/auth

---

# 🧪 실습 문제 (Git Flow 적용)

**목표:** `SOURCE_TREE_3` 프로젝트에 Git Flow 적용 및 브랜치 관리

**진행 순서:**

1. GitHub에 `SOURCE_TREE_3` 저장소 생성
2. SourceTree를 이용해 Clone
3. main 브랜치에서 `main.txt` 생성 후 "V0.0 main Commit"
4. Git Flow를 사용하여 `develop` 브랜치 생성
5. develop 브랜치에서 `dev.txt` 생성 후 "V0.1 dev Commit"
6. feature 브랜치 3개 생성
    - feature/board
    - feature/auth
    - feature/auction
7. 각 feature 브랜치에서 각각 작업 및 "V0.1 feature/브랜치명 Commit"
8. 모든 feature 브랜치를 develop에 rebase merge로 병합
9. develop을 main 브랜치에 새 커밋으로 병합

⚠️ 주의사항:
- rebase merge 시 순서대로 충돌 없이 깔끔히 정리할 것
- 마지막 main 병합 시 충돌 발생 여부 확인

---

# 🧠 유스케이스 요약

**Git Flow 브랜치 전략 흐름**

```plaintext
[Main] ← [Develop] ← [Feature/*]
```

- Feature 작업 ➔ Develop 병합 ➔ Main 병합 순서로 진행
- 각각 독립적으로 기능 개발 가능
- 작업 완료 후 통합과정에서 충돌 방지

✅ Git Flow는 협업 개발 시 필수 전략입니다!

---

# ⚠ 주의사항 (Cautions)

- 항상 push 전에 local 브랜치 상태를 확인할 것
- rebase 시 주의하지 않으면 커밋 이력이 꼬일 수 있음
- feature 브랜치 명명 규칙(feature/기능명)을 반드시 지킬 것

---

# ✅ 한 줄 요약 (1-Line Summary)

> Git Flow 브랜치 전략을 제대로 이해하면 협업과 버전 관리가 10배 수월해진다! 🚀
~~~

