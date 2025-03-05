# 03

> MySQL
> 

![image.png](image.png)

```jsx
Information_schema : 메타데이터 제공, 데이터베이스정보제공(테이블, 열, 인덱스...등)
Performance_schema : 시스템성능 관련정보 제공(퀴리성능, 서버리소스 사용현황, 대기중인 이벤트 등)
mysql : 인증정보(사용자 정보, 권한정보 등)
sys : Information_schema, Performance_schema 의 분석을 돕기위해 만들어진 DB(여러View이 포함)
```

![image.png](image%201.png)

![image.png](image%202.png)

![image.png](image%203.png)

```jsx
ctrl + enter 사용
```

---

> DB 구축
> 

![image.png](image%204.png)

![image.png](image%205.png)

![image.png](image%206.png)

![image.png](image%207.png)

![image.png](image%208.png)

---

> 테이블 구축
> 

![image.png](image%209.png)

![image.png](image%2010.png)

![image.png](image%2011.png)

![image.png](image%2012.png)

![image.png](image%2013.png)

```jsx
스네이크 표기법 : "_" 사용 ex)user_id
카멜 표기법 : "대"문자 사용  ex)userName
```

---

> Cmd 행 추가
> 

![image.png](image%2014.png)

```sql
column 추가 : alter table 테이블명 add column 컬럼명 자료형 제약조건
```

---

> Cmd 행 삭제
> 

![image.png](image%2015.png)

![image.png](image%2016.png)

![image.png](image%2017.png)

```sql
column 삭제 : alter table 테이블명 drop 컬럼명
```

---

> Cmd 행 수정
> 

![image.png](image%2018.png)

![image.png](image%2019.png)

![image.png](image%2017.png)

```sql
column 수정 : alter table 테이블명 change column 기존컬럼명 변경컬럼명 변경자료형 제약조건
```

---

> Cmd Insert
> 

![image.png](image%2020.png)

![image.png](image%2021.png)

```sql
insert into 테이블명(컬럼명) values(값);
```

---

> Cmd Update
> 

![image.png](image%2021.png)

![image.png](image%2022.png)

```sql
update 데이터베이스명.테이블명 set 컬럼명 = '추가 값' where 컬럼명 = '찾을 값';
```

---

> Cmd Delete
> 

![image.png](image%2023.png)

```sql
delete  from 테이블 where 컬럼명 = '찾을 값';
```

---

> 문제01
> 

![image.png](image%2024.png)

> 문제 02
> 

![image.png](image%2025.png)

> 문제 03
> 

![image.png](image%2026.png)

> 문제 04
> 

![image.png](image%2027.png)

> 문제 05
> 

![image.png](image%2028.png)

![image.png](image%2029.png)

> 문제 06
> 

![image.png](image%2030.png)

> 문제 07
> 

![image.png](image%2031.png)