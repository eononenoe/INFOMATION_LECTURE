# ⚠️ 예외 처리: @ExceptionHandler & @ControllerAdvice

📌 **개요 (Overview)**  
스프링 MVC에서 예외가 터졌을 때 그냥 에러 페이지 띄우는 거 말고,  
**내가 직접 지정한 메서드**로 처리할 수 있게 해주는 기능이 있음.  
그게 바로 `@ExceptionHandler`랑 `@ControllerAdvice`!

---

## 💡 핵심 개념 요약 (Key Concepts)

### ✋ @ExceptionHandler
- **특정 컨트롤러 안에서만** 발생한 예외를 처리함
- 메서드 위에 `@ExceptionHandler(예외클래스.class)` 붙이면 됨
- 그 컨트롤러에서 예외 나면 이 메서드로 이동해서 처리함
- 리턴값은 보통 **에러 페이지 경로** (`return "errorPage"`)  

### 🧢 @ControllerAdvice
- **여러 컨트롤러 전체에서 공통 예외 처리**하고 싶을 때 사용
- 한 군데에 예외 처리 로직 몰아넣을 수 있어서 관리가 편함
- `@ExceptionHandler`는 여기서도 같이 씀

---

## 🧪 예제 코드 정리 (Examples)

### 📄 MemoController – 특정 컨트롤러 내 예외 처리

```java
@Controller
@RequestMapping("/memo")
@Slf4j
public class MemoController {

    // 이 컨트롤러에서 FileNotFoundException 터지면 여기서 처리
    @ExceptionHandler(FileNotFoundException.class)
    public String fileNotFoundExceptionHandler(Exception error, Model model) {
        log.info("MemoController's fileNotFoundExceptionHandler...error " + error);
        model.addAttribute("error", error);
        return "memo/error"; // error 페이지로 이동
    }

    @GetMapping("/ex_test")
    public void ex_test() throws FileNotFoundException {
        System.out.println("GET /memo/ex_test");
        throw new FileNotFoundException("파일이 없다.."); // 강제로 예외 던짐
    }
}
```

### 🌐 GlobalExceptionHandler – 전역 예외 처리

```java
@ControllerAdvice
public class GlobalExceptionHandler {

    // FileNotFoundException 처리
    @ExceptionHandler(FileNotFoundException.class)
    public String error1(Exception ex, Model model) {
        System.out.println("GlobalExceptionHandler FileNotFoundException... ex " + ex);
        model.addAttribute("error", ex);
        return "memo/error";
    }

    // ArithmeticException 처리
    @ExceptionHandler(ArithmeticException.class)
    public String error2(Exception ex, Model model) {
        System.out.println("GlobalExceptionHandler ArithmeticException... ex " + ex);
        model.addAttribute("error", ex);
        return "memo/error";
    }

    // 나머지 모든 예외 처리
    @ExceptionHandler(Exception.class)
    public String error3(Exception ex, Model model) {
        System.out.println("GlobalExceptionHandler Exception... ex " + ex);
        model.addAttribute("error", ex);
        return "memo/error";
    }
}
```

---

## ⚠ 주의사항 (Cautions)

- `@ExceptionHandler` 메서드의 매개변수로 `Exception`이나 `Model` 넣을 수 있음  
- `@ExceptionHandler(Exception.class)` 같이 작성하면 **모든 예외 처리용 catch-all**  
- `@ControllerAdvice` 클래스는 꼭 `@Component` 또는 `@RestControllerAdvice`처럼 빈으로 등록돼야 함

---

## ✅ 한 줄 요약 (1-Line Summary)

> `@ExceptionHandler`는 **컨트롤러에서 터진 예외를 직접 처리**,  
> `@ControllerAdvice`는 **전체 컨트롤러에서 공통적으로 예외 처리**하는 데 쓰는 도구임!
