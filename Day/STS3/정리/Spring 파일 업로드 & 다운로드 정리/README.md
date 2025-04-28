# 📚 Spring 파일 업로드 & 다운로드 정리

## 📌 개요 (Overview)

- 웹 애플리케이션에서 **파일 업로드**와 **파일 다운로드**는 필수 기능 중 하나입니다.
- Spring에서는 **MultipartResolver**를 통해 파일 업로드를 지원하고,
- 파일 다운로드는 **Resource** 객체를 통해 안전하게 처리합니다.

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🌟 파일 업로드
- **폼(form)**에서는 반드시 `enctype="multipart/form-data"`를 설정해야 함.
- 서버 측에서는 **MultipartFile** 객체로 파일을 수신.
- 업로드 디렉토리가 없으면 **동적으로 생성**해야 함.

### 🌟 파일 다운로드
- 다운로드할 파일은 **Resource** 객체로 감싸서 반환.
- `Content-Disposition` 헤더를 통해 **브라우저가 파일을 다운로드**하도록 지시.
- 파일명 깨짐을 막기 위해 **UTF-8 → ISO-8859-1 인코딩** 변환 처리 필요.

### 🌟 필수 라이브러리
```xml
<dependency>
    <groupId>commons-fileupload</groupId>
    <artifactId>commons-fileupload</artifactId>
    <version>1.4</version>
</dependency>
<dependency>
    <groupId>commons-io</groupId>
    <artifactId>commons-io</artifactId>
    <version>2.11.0</version>
</dependency>
```

---

## ⚠ 주의사항 (Cautions)

- 파일 업로드 크기 제한 설정을 WebMvcConfig에 명시해야 함.
- 업로드/다운로드 경로는 **외부 노출에 주의** (ex. 경로 탐색 방지)
- 다운로드 파일명은 **특수문자**나 **한글 깨짐**을 대비해 인코딩.
- 업로드 시 같은 파일명 중복 방지: 보통 **UUID** 등을 사용.

---

## 🧪 예제 코드 (Examples)

### 📦 WebMvcConfig 설정
```java
@Configuration
@EnableWebMvc
public class WebMvcConfig implements WebMvcConfigurer {

    @Bean
    public MultipartResolver multipartResolver() {
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setMaxUploadSize(20971520); // 20MB
        resolver.setMaxUploadSizePerFile(20971520);
        resolver.setMaxInMemorySize(20971520);
        return resolver;
    }

    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/views/");
        viewResolver.setSuffix(".jsp");
        return viewResolver;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
    }
}
```

### 📤 UploadController 파일 업로드
```java
@Controller
@RequestMapping("/upload")
public class UploadController {

    private final String uploadDir = "c:/upload";

    @PostMapping("/reqUpload")
    public String upload(@RequestParam("files") MultipartFile[] files, Model model) throws IOException {
        String path = uploadDir + File.separator + UUID.randomUUID();
        File dir = new File(path);
        if (!dir.exists()) dir.mkdirs();

        for (MultipartFile file : files) {
            file.transferTo(new File(dir, file.getOriginalFilename()));
        }

        model.addAttribute("msg", "upload 성공!");
        return "upload/form";
    }

    @GetMapping("/list")
    public void listFiles(Model model) {
        File root = new File(uploadDir);
        model.addAttribute("rootDir", root);
    }
}
```

### 📥 RestController 파일 다운로드
```java
@RestController
@Slf4j
public class DownloadController {

    @GetMapping(value="/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    public ResponseEntity<Resource> download(String path) throws UnsupportedEncodingException {
        Resource resource = new FileSystemResource(path);
        String filename = resource.getFilename();
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=" + new String(filename.getBytes("UTF-8"), "ISO-8859-1"));
        return new ResponseEntity<>(resource, headers, HttpStatus.OK);
    }
}
```

### 📄 form.jsp (업로드 화면)
```jsp
<form action="${pageContext.request.contextPath}/upload/reqUpload" method="POST" enctype="multipart/form-data">
    <input type="file" name="files" multiple />
    <input type="submit" value="Upload" />
</form>
<a href="${pageContext.request.contextPath}/upload/list">Show File List</a>
```

### 📄 list.jsp (파일 리스트 + 다운로드)
```jsp
<div>
    <c:forEach items='${rootDir.listFiles()}' var='subdir'>
        <hr>FOLDER : ${subdir.getPath()}<hr>
        <c:forEach items='${subdir.listFiles()}' var='file'>
            <a href="javascript:void(0)" data-dir="${subdir.getPath()}" data-file="${file.getName()}" class="item">
                ${file}
            </a><br/>
        </c:forEach>
    </c:forEach>
</div>

<script>
    const projectPath = '${pageContext.request.contextPath}';
    document.querySelectorAll('.item').forEach(item => {
        item.addEventListener('click', function() {
            const filepath = encodeURIComponent(item.getAttribute('data-dir') + "\\" + item.getAttribute('data-file'));
            location.href = projectPath + "/download?path=" + filepath;
        });
    });
</script>
```

---

## ✅ 한 줄 요약 (1-Line Summary)

> Spring에서는 **MultipartFile로 파일 업로드**, **Resource로 파일 다운로드**를 처리하고, 경로 관리와 인코딩 주의사항을 항상 신경쓰자! 🚀