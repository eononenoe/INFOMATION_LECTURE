# 02

> **프로그램**
> 

```jsx
**IDE(GIT)      -**  Ecplipse(JAVA, JSP/SERVLET)
CMD           -  STS3(전자정부  Framework)
SourceTree    -  Intellij
깃크라켄       -  Vscode
```

---

> **Sourcetree Download**
> 

![image.png](image.png)

![image.png](image%201.png)

![image.png](image%202.png)

![image.png](image%203.png)

![image.png](image%204.png)

![image.png](image%205.png)

![image.png](image%206.png)

![image.png](image%207.png)

---

> **Sourcetree Commit**
> 

![image.png](image%208.png)

![image.png](image%209.png)

![image.png](image%2010.png)

![image.png](image%2011.png)

![image.png](image%2012.png)

---

> **Sourcetree Reset Hard**
> 

![image.png](image%2013.png)

![image.png](image%2014.png)

![image.png](image%2015.png)

![image.png](image%2016.png)

---

> **Sourcetree Reset Soft**
> 

![image.png](image%2017.png)

![image.png](image%2018.png)

![image.png](image%2016.png)

---

> **Sourcetree Branch**
> 

![image.png](image%2019.png)

![image.png](image%2020.png)

![image.png](image%2021.png)

![image.png](image%2022.png)

```jsx
브런치 이동 : 더블클릭
```

---

> **Sourcetree Merge**
> 

![image.png](image%2023.png)

![image.png](image%2024.png)

---

> 문제 01
> 

```jsx
TEST2_1 폴더에 SourceTree 연결
1 Commit 적용 하기
- aaa.txt 파일생성후 V0.0 master Commit
- dev branch 생성 후 dev.txt 파일 생성 후 "V0.1 dev init" Commit
- feature/func1 branch 생성 후 func1.txt 파일 생성 후 "V0.2 func1.txt add" Commit
- dev branch 로 이동
- feature/func2 branch 생성 후 func1.txt 파일 생성 후 "V0.2 func2.txt add" Commit
- feature/func1 branch 를 dev 에 병합
- feature/func2 branch 를 dev 에 병합
- master 에 dev 병합
- 발생하는 충돌이 있을시 적절하게 해결 후 Commit merge 할 것
```

![image.png](image%2025.png)

![image.png](image%2026.png)

![image.png](image%2027.png)

![image.png](image%2028.png)

![image.png](image%2029.png)

![image.png](image%2030.png)

![image.png](image%2031.png)

![image.png](image%2032.png)

![image.png](image%2033.png)

![image.png](image%2034.png)

![image.png](image%2035.png)

![image.png](image%2036.png)

---

> Git 연동
> 

![image.png](image%2037.png)

![image.png](image%2038.png)

---

> 문제 02
> 

```jsx
1 SOURCE_TREE_2 GITHUB REPO 생성(Readme생성체크 해서 main브랜치 생성하기)
2 SourceTree 로 Clone 하기
3 developer branch 생성 후 파일추가(dev.txt) 후 "V0.0 Dev's init" Commit
4 feature/board branch 생성 후 board.txt 파일 생성하고 "V0.1 feature/board init" Commit
5 feature/auth branch 생성 후 auth.txt 파일 생성하고 "V0.1 feature/auth init" Commit
6 developer branch 로 이동 후  Readme.md 수정("V0.1 RebaseMerge") 한 다음 commit
7 feature/board branch 를 developer branch로 rebase 처리(developer보다 feature/board branch 가 위에 있어야함)
8 developer branch 에서 rebase 된 feature/board branch 를 병합
9 feature/auth branch 를 developer branch로 rebase 처리(developer보다 feature/board branch 가 위에 있어야함)
10 developer branch 에서 rebase 된 feature/auth branch 를 병합
11 developer branch 를 main 으로 병합
12 수정사항 전부를 githug로 push 
```

![image.png](image%2039.png)

![image.png](image%2040.png)

![image.png](image%2041.png)

![image.png](image%2042.png)

![image.png](image%2043.png)

![image.png](image%2044.png)

![image.png](image%2045.png)

![image.png](image%2046.png)

![image.png](image%2047.png)

![image.png](image%2048.png)

![image.png](image%2049.png)