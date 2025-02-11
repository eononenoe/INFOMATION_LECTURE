# 01

> **05 ArrayObject.html**
> 

```jsx
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <script>
        // // 배열 ?
        // let arr = ['str1', 'str2', null, true, false, undefined, { name: "홍길동", age: 15 }];
        // console.log(typeof arr);
        // console.log(typeof arr[0]);
        // console.log(typeof arr[1]);
        // console.log(typeof arr[2]);
        // console.log(typeof arr[3]);
        // console.log(typeof arr[4]);
        // console.log(typeof arr[5]);
        // console.log(typeof arr[6], arr[6]);

        // //----------------------------------------
        // //            배열의 동적 확장 확인
        // //----------------------------------------
        // arr[7] = 100;
        // arr[10] = 'helloworld';
        // console.log(arr);
        // console.log(arr[8], arr[9], arr[10]);
        // console.log('길이 : ', arr.length);

        // //----------------------------------------
        // //  배열 함수 사용해보기(forEach) - 반복문
        // //----------------------------------------
        // arr.forEach((item) => {
        //     console.log('item', item);
        // });

        // //----------------------------------------
        // //         배열 함수 사용해보기
        // //      push - 마지막 idx에 요소추가
        // //      pop - 마지막 idx에 요소 제거
        // //----------------------------------------
        // arr.push('aaa'); arr.push('bbb'); arr.push('ccc');
        // console.log(arr);
        // arr.pop(), arr.pop();
        // console.log(arr);

        // 정렬(sort), 누적(reduce), 필터(fileter), 재구성(map)
        //----------------------------------------
        //               정렬(sort)
        //----------------------------------------
        // let arr_2 = [10, 15.2, "t1", "t2", 30, true, null, 100, { name: '티모', age: 555 }, 20];
        // arr_2.sort // 배열의 요소들이 문자열로 변환되어 사전편찬순서로 정렬, 기본값은 오름차순
        //            // object와 null은 순서에 따라 정렬
        // arr_2.forEach((item) => { console.log(item) });
        // console.log(arr_2);
        // array2.sort(() => { }); //콜백함수 형태

        // 약식표현
        // array2.sort((a, b) => {
        // return b - a;
        // }); // 내림차순 정렬
        // array2.forEach((item) => console.log("item : ", item));

        // func1(); //사용자 함수 호출

        //-----------------------------------------
        //              필터(fileter)
        //-----------------------------------------

        // filter() 함수는
        // 배열의 요소를 순회하면서 콜백 함수를 사용하여 원하는 조건에 따라 필터링하는 함수입니다.
        // 필터링된 배열을 반환합니다.

        // let arr_3 = [10, 15.2, "t1", "t2", 30, true, null, 100, { name: '티모', age: 555 }, 20];
        // let fileter_arr1 = arr_3.filter((item) => { typeof item == "number" });
        // // console.log(filtered_arr1);

        // arr_3.filter(item=>typeof item == 'string').forEach(item=>console.log(item));

        //----------------------------------------
        // 누적  누산된 결과값 = 배열.reduce((누산변수,item)=>{return 연산로직}, 누산변수의 초기 값)
        //-----------------------------------------
        // let arr_4 = [10, 15.2, "t1", "t2", 30, true, null, 100, { name: '티모', age: 555 }, 20];

        // const r_val = arr_4.filter((item)=>{return typeof item=="number"})
        //      .reduce((sum,item)=>{return sum+item},0)

        // console.log("r_val : ",r_val)
        //-----------------------------------------
        //    배열 object 처리 [{},{},{},{}...]
        //-----------------------------------------
        // let arr_5 = [
        //     {pid:"1",pname:"모니터",price:"100",amount:"50"},
        //     {pid:"2",pname:"노트북",price:"80",amount:"20"},
        //     {pid:"3",pname:"컴퓨터",price:"250",amount:"120"},
        //     {pid:"4",pname:"냉장고",price:"300",amount:"10"},
        //     {pid:"5",pname:"선풍기",price:"20",amount:"60"},
        // ];
        // arr_5.forEach(item=>console.log(item));
        // console.log('---------');
        // // arr_5.forEach((item,index)=>console.log(index,item.pname));
        // arr_5.forEach((item,index)=>console.log(index,item["pname"]));

        // console.log('---------');
        // // 각 item의 가격이 100만원이상인 object만 필터링(>=, <=)
        // const fileter_arr1 = arr_5.filter(item=>item.price>=100)
        // console.log(fileter_arr1)
        // console.log('---------')
        // // 각 item의 수량이 30개 이하인 object만 필터링(>=,<=)
        // const fileter_arr2 = arr_5.filter(item=>item.amount<=30)
        // console.log(fileter_arr2)
        // console.log('---------')
        // const r_val1 =  arr_5.filter(item=>item.price>=100).reduce((sum,item)=>sum+item.price,0);
        // console.log('가격이 100만원 이상인 item의 가격총합 : ',r_val1)

        //-----------------------------------------
        //    재구성 배열.map((item)=>{return 재구성할item});
        //-----------------------------------------
        // let arr_6 = [
        //     { pid: "1", pname: "모니터", price: "100", amount: "50" },
        //     { pid: "2", pname: "노트북", price: "200", amount: "15" },
        //     { pid: "3", pname: "컴퓨터", price: "250", amount: "30" },
        //     { pid: "4", pname: "냉장고", price: "70", amount: "19" },
        //     { pid: "5", pname: "선풍기", price: "10", amount: "200" },
        // ];
        // 수량이 50이상인 요소만 필터링해서 / price가 낮은값 우선 오름차순 / 요소마다 price*amount 항목을 추가
        // maped_arr = arr_6.filter((item) => { return item.amount >= 30 })
        //     .sort((a, b) => { return a.price - b.price }) // 오름차순 
        //     //.sort((a,b)=>{return b.price-a.price}) // 내림차순
        //     .map((item) => {
        //         console.log('in map..', item);
        //         item = { ...item, 'total_price': item.price * item.amount };
        //         return item;
        //     });
        // console.log('---RESULT---')
        // console.log(maped_arr);

        //-----------------------------------------
        //                 문제
        //-----------------------------------------
        let employees = [
            { id: 1, name: "김철수", age: 35, department: "개발", salary: 6000, years: 10 },
            { id: 2, name: "이영희", age: 28, department: "디자인", salary: 5000, years: 5 },
            { id: 3, name: "박지성", age: 40, department: "마케팅", salary: 7000, years: 15 },
            { id: 4, name: "손흥민", age: 30, department: "개발", salary: 6500, years: 7 },
            { id: 5, name: "정우성", age: 45, department: "경영", salary: 9000, years: 20 },
            { id: 6, name: "한지민", age: 29, department: "디자인", salary: 5200, years: 6 },
            { id: 7, name: "강호동", age: 50, department: "경영", salary: 8500, years: 25 },
            { id: 8, name: "유재석", age: 42, department: "마케팅", salary: 7500, years: 18 },
            { id: 9, name: "송중기", age: 32, department: "개발", salary: 6200, years: 8 },
            { id: 10, name: "수지", age: 26, department: "디자인", salary: 4800, years: 3 }
        ];

        //연봉이(salary) 6000이상이면서 근속연수(years)가 7년이상인 직원만 필터링해서 배열로 저장 확인
        maped_arr = employees.filter((item)=>{return item.salary>=6000 && item.years>=7});
        console.log(maped_arr)

        //모든 직원의 연봉(salary) 기준으로 내림차순 정렬한 배열 새로 만들기
        maped_arr = employees.filter((item)=>{return item.salary>=6000 && item.years>=7})
        .sort((a,b)=>{return b.salary - a.salary})
        console.log(maped_arr)

        //모든 직원의 연봉(salary) 에 근속연수*100 만큼의 보너스를 추가하여 total_salary필드를 추가한 배열을 반환
        maped_arr = employees.filter((item)=>{return item.salary>=6000 && item.years>=7})
        .sort((a,b)=>{return b.salary - a.salary})
        .map((item)=>{
            item = {...item,total_salary:item.salary+item.years*100}
            return item;
        })
        console.log(maped_arr)

        //department(부서) 별로 직원들의 연봉총합을 구하세요
        const department_total = employees.reduce((acc, employee) => {
            // 만약 부서가 아직 없으면 그 부서의 연봉 총합을 시작함
            if (!acc[employee.department]) {
                acc[employee.department] = 0;
            }
            // 연봉을 더함
            acc[employee.department] += employee.salary;
            return acc;
        },{});
        console.log(department_total)

        const ex_4 = employees.reduce((sum,item)=>{
            sum[item.department]=(sum[item.department]==undefined? 0 : sum[item.department]) + item.salary;
            return sum;
        },{});
        console.log(ex_4);

        //연봉(salary)가 가장높은 직원을 찾아 객체하나만 반환(문서에서 find를 찾아보세요 - !)
        const ex_5 = employees.sort((a,b)=>{return b.salary-a.salary;})[0]
        console.log(ex_5);

        // FIND 써보기...
        const max = 
        employees.map((item)=>{
            return item.salary
        }).sort((a,b)=>{return b-a})[0];

        const max_object = employees.find(item=>{return item.salary==max})
        console.log(max_object)
        

    </script>

</body>

</html>
```

---

> **06 OpenData_Test.html**
> 

```jsx
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width='device-width', initial-scale=1.0">
    <title>Document</title>
    
    <script  src="./js/중구맛집.js"></script>
</head>
<body>
    
    

    <script>
        //------------------------------------
        // 중구맛집확인
        //------------------------------------
        // console.log("전체데이터 :",중구맛집);

        //------------------------------------
        // 배열OBJ 만 추출
        //------------------------------------
        const 중구맛집_data = 중구맛집.data;
        // console.log("중구맛집_data :",중구맛집_data);

        //------------------------------------
        // FD_CS(음식카테고리)가 '한식'인 맛집만 추출
        //------------------------------------
        const 중구맛집_한식 =  중구맛집_data.filter((item)=>{return item.FD_CS=='한식'})
        // console.log("중구맛집_한식 :",중구맛집_한식);

        //------------------------------------
        // 중구맛집_한식에서 상호명,메뉴,주소만 추출해서 새로운 배열로 재구성
        //------------------------------------
        let 중구맛집_한식_상호명메뉴주소 =
            중구맛집_한식
                .sort((a,b)=>{return a.BZ_NM.localeCompare(b.BZ_NM)})
                .map((item)=>{
                    return {"BZ_NM":item.BZ_NM,"MNU":item.MNU,"GNG_CS":item.GNG_CS};
                })
                

        console.log("중구맛집_한식_상호명메뉴주소",중구맛집_한식_상호명메뉴주소);
       
        //------------------------------------
        // 중구맛집_한식_상호명메뉴주소 에서 MNU(메뉴) 의 값을 메뉴명:가격(숫자)으로 분리
        //------------------------------------
        const RenewaledMenu = 중구맛집_한식_상호명메뉴주소.map((item)=>{
            // <br /> 제거
            let replcedBrMenu =   item.MNU.replaceAll('<br />',"\n")
            // console.log("replcedBrMenu",replcedBrMenu);
            // \n를 기준으로 배열로 자르기
            let menu_arr = replcedBrMenu.trim().split("\n");
            // console.log(menu_arr);
            // \n를 기준으로 잘린 배열의 재구성
            const renewaled_menu = 
                // 메뉴중 가격에 있는 요소의 '원', ',' 제거하기
                menu_arr.map((menu)=>{
                    //공백 기준 자르기(배열)
                    let splited_space = menu.trim().split(/[\s~]+/g);    // ' ', ~ 를 기준으로 자르기
                    // splited_space.splice(' ');
                    // console.log(splited_space)
                    // 가격에 '원'제거, ','제거
                    let removed_arr =  splited_space.map((menu_2)=>{
                        const renewalItem = menu_2.trim().replace(/(\d{1,3})(?:,\d{3})*(?:원)?/g ,(match,str)=>{
                            // console.log(match,str);
                            const num = match.replace(',','').replace('원','');
                            // console.log('num',num);
                            return num;
                        });
                        return renewalItem.match(/\d/) ?  Number(renewalItem)  : renewalItem; 
                    })
                    return removed_arr;
                })
            // console.log("renewaled_menu",renewaled_menu);
            return {"BZ_NM":item.BZ_NM,"GNG_CS":item.GNG_CS ,"MNU":renewaled_menu};
        })
        console.log("RenewaledMenu",RenewaledMenu);

        //RenewaledMenu에서 주문 리스트(특정 상호명을 선택해서 메뉴추가작업의 결과값을 넣어주시면 됩니다)
        //장모님 국밥 메뉴 주문 리스트
        let order_list  = [];
        
        order_list = [
        //    {"OID":"주문번호",'BZ_NM':'상호명',"GNG_CS":'주소',"MNU":"메뉴명","PRC":"가격","AMT":"수량"} //수량은 임의로
            {"OID":"1111-1111",'BZ_NM':"장모님국밥","GNG_CS":"대구광역시 중구 삼덕동2가 149-6", "MNU":"돼지국밥","PRC":9000,"AMT":5},
            {"OID":"1111-1112",'BZ_NM':"장모님국밥","GNG_CS":"대구광역시 중구 삼덕동2가 149-6", "MNU":"수육","PRC":28000,"AMT":2},
            {"OID":"1111-1113",'BZ_NM':"장모님국밥","GNG_CS":"대구광역시 중구 삼덕동2가 149-6", "MNU":"순대한접시","PRC":12000,"AMT":2},
            {"OID":"1111-1114",'BZ_NM':"장모님국밥","GNG_CS":"대구광역시 중구 삼덕동2가 149-6", "MNU":"섞어국밥","PRC":9000,"AMT":4},
        ]

        // 1 주문 아이템 리스트의 아이템당 지불금액을 구하세요  
        // ex {OID : "1111-1111" ,PRICE_AMOUNT:45000}
        // ex {OID : "1111-1112" ,PRICE_AMOUNT:56000}
        // ...
        console.log("---결과---")
        const OID_PAY = order_list.map((item)=>{
            return {"OID" : item.OID,"PRICE_AMOUNT":item.PRC}
        })
        console.log(OID_PAY)

        // 2 총 지불 금액을 구하세요 -
        // ex {TOTALPRICE :PRICE*AMOUNT의 합}
        console.log("---결과---")
        const OTALPRICE = order_list.map((item)=>{
            return {"OID" : item.OID,"PRICE_AMOUNT":item.PRC,TOTALPRICE:item.PRC*item.AMT}
        })
        console.log(OTALPRICE)

    </script>

</body>
</html>
```