# 01

### Controller/file

---

> DownloadController.java
> 

```java
package Controller.file;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Service.FileServiceImpl;

public class DownloadController implements SubController{
	private FileServiceImpl fileService;

	public DownloadController() throws Exception{
		fileService = FileServiceImpl.getInstance();
	}

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {

		try {

			//GET
			//if(req.getMethod().equals("GET")) {
			//	req.getRequestDispatcher("/WEB-INF/view/file/list.jsp").forward(req, resp);
			//	return ;
			//}

			//파라미터

			//유효성

			//서비스
			boolean isUploaded = fileService.download(req,resp);
			//뷰
			//req.setAttribute("map", map);
			//req.getRequestDispatcher("/WEB-INF/view/file/list.jsp").forward(req, resp);

		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}

```

---

> ListController.java
> 

```java
package Controller.file;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Service.FileServiceImpl;

public class ListController implements SubController{
	private FileServiceImpl fileService;

	public ListController() throws Exception{
		fileService = FileServiceImpl.getInstance();
	}

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {

		try {

			//GET
			//if(req.getMethod().equals("GET")) {
			//	req.getRequestDispatcher("/WEB-INF/view/file/list.jsp").forward(req, resp);
			//	return ;
			//}

			//파라미터

			//유효성

			//서비스
			Map<String , List<File> > map = fileService.getFileList();
			//뷰
			req.setAttribute("map", map);
			req.getRequestDispatcher("/WEB-INF/view/file/list.jsp").forward(req, resp);

		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}

```

---

> Properties.java
> 

```java
package Controller.file;

public class Properties {
	public static String ROOT_PATH = "c:";
	public static String UPLOAD_PATH = "upload";
}

```

---

> UploadController.java
> 

```java
package Controller.file;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Controller.SubController;
import Domain.Service.FileServiceImpl;

public class UploadController implements SubController{

	private FileServiceImpl fileService;

	public UploadController() throws Exception{
		fileService = FileServiceImpl.getInstance();
	}

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {

		try {

			//GET
			if(req.getMethod().equals("GET")) {
				req.getRequestDispatcher("/WEB-INF/view/file/upload.jsp").forward(req, resp);
				return ;
			}
			//파라미터
			//유효성
			//서비스
			boolean isUpload = fileService.upload(req, resp);
			//뷰
			if(isUpload)
				resp.sendRedirect(req.getContextPath() + "/file/upload");

		}catch(Exception e) {
			e.printStackTrace();
		}

	}

}

```

---

### Domain/Service

---

> BookServiceImpl.java
> 

```java
package Domain.Service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import Domain.Dao.BookDao;
import Domain.Dao.BookDaoImpl;
import Domain.Dao.BookReplyDaoImpl;
import Domain.Dto.BookDto;
import Domain.Dto.BookReplyDto;
import Domain.Dto.Criteria;
import Domain.Dto.PageDto;

public class BookServiceImpl {

	//
	private BookDao bookDao;
	private BookReplyDaoImpl bookReplyDaoImpl;

	//싱글톤 패턴
	private static BookServiceImpl instance;
	private BookServiceImpl() throws Exception{
		bookDao = BookDaoImpl.getInstance();
		bookReplyDaoImpl = BookReplyDaoImpl.getInstance();
	}
	public static BookServiceImpl getInstance() throws Exception{
		if(instance==null)
			instance = new BookServiceImpl();
		return instance;
	}

	//TX 처리 + 비즈니스 유효성검사(도서추가 -)
	public boolean bookRegistration(BookDto bookDto) throws Exception{

		int result = bookDao.insert(bookDto);

		return result>0;

	}

	public Map<String,Object> getAllBooks() throws Exception {
		Map<String,Object> response = new LinkedHashMap();

		List<BookDto> list =  bookDao.selectAll();
		if(list.size()>0) {
			response.put("status", true);
			response.put("list", list);
		}else {
			response.put("status", false);
		}

		return response;
	}

	public Map<String, Object> getAllBooks(Criteria criteria) throws Exception{
		Map<String,Object> response = new LinkedHashMap();

		if(criteria.getType()==null || criteria.getType().isEmpty())
		{
			int offset = (criteria.getPageno()-1) * criteria.getAmount();

			//페이지별 건수
			List<BookDto> list =  bookDao.selectAll(offset,criteria.getAmount());

			//PageDto
			long totalCount = bookDao.count();
			PageDto pageDto = new PageDto(totalCount,criteria);
			System.out.println("Service pageDto : " + pageDto);

			if(list.size()>0) {
				response.put("status", true);
				response.put("list", list);
				response.put("pageDto", pageDto);
			}else {
				response.put("status", false);
			}
		}
		else
		{
			int offset = (criteria.getPageno()-1) * criteria.getAmount();
			//페이지별 건수
			int amount = criteria.getAmount();
			String type = criteria.getType();
			String keyword = criteria.getKeyword();
			List<BookDto> list =  bookDao.selectAll(offset,amount,type,keyword);

			//PageDto
			long totalCount = bookDao.count(criteria);
			PageDto pageDto = new PageDto(totalCount,criteria);
			System.out.println("Service pageDto : " + pageDto);

			if(list.size()>0) {
				response.put("status", true);
				response.put("list", list);
				response.put("pageDto", pageDto);
			}else {
				response.put("status", false);
			}

		}

		return response;
	}

	public Map<String, Object> getBook(String bookCode) throws Exception{

		Map<String, Object> response = new LinkedHashMap();

		BookDto bookDto =  bookDao.select(bookCode);

		if(bookDto == null)
			response.put("status", false);
		else {
			response.put("status", true);
			response.put("bookDto", bookDto);
		}

		return response;
	}
	public boolean modifyBook(BookDto bookDto) throws Exception{

		int result = bookDao.update(bookDto);

		return result>0;
	}

	public boolean removeBook(String bookCode) throws Exception{

		int result = bookDao.delete(bookCode);

		return result>0;
	}

	public boolean bookReplyAdd(BookReplyDto dto) throws Exception{
		int result = bookReplyDaoImpl.insert(dto);
		return result>0;
	}

	public List<BookReplyDto> getAllBookReply(String bookCode) throws Exception{
		List<BookReplyDto> list =  bookReplyDaoImpl.selectAll(bookCode);
		return list;
	}
	public long bookReplyCount(String bookCode) throws Exception{
		long cnt = bookReplyDaoImpl.count(bookCode);
		return cnt;
	}

}

```

---

> FileServiceImpl.java
> 

```java
package Domain.Service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import Controller.file.Properties;

public class FileServiceImpl {
	//싱글톤 패턴
	private static FileServiceImpl instance;
	private FileServiceImpl() throws Exception {
		System.out.println("[SERVICE] UserServiceImpl init...");
	};
	public static FileServiceImpl getInstance() throws Exception {
		if(instance==null)
			instance = new FileServiceImpl();
		return instance ;
	}

	public boolean upload(HttpServletRequest req , HttpServletResponse resp) throws IOException, ServletException {

		LocalDateTime now = LocalDateTime.now();
		//yyyyMMdd_HHmmss 폴더명
		String folderName =now.format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
		//업로드 경로 설정
		String UploadPath = Properties.ROOT_PATH
							+File.separator // '/'
							+Properties.UPLOAD_PATH
							+File.separator
							+folderName
							+File.separator;
		//디렉토리 생성( c:\\\\upload\\\\20250421_102933\\\\ )
		File dir = new File(UploadPath);
		if(!dir.exists())
			dir.mkdirs();

		Collection<Part> parts =  req.getParts();
		for(Part part :parts) {

			System.out.println("PART's NAME : " + part.getName());
			System.out.println("PART's SIZE : " + part.getSize());
			String contentDisp = part.getHeader("content-disposition");
			String [] tokens =contentDisp.split(";");
			String filename = tokens[2].trim().substring(10 , tokens[2].trim().length()-1);
			System.out.println("contentDisp : " + contentDisp);
			System.out.println("tokens[2] : " + tokens[2]);
			System.out.println("filename : " + filename);

			part.write(UploadPath+filename);
		}

		return true;
	}
	public Map<String , List<File> > getFileList() {

		Map<String , List<File> > map = new LinkedHashMap();

		String UploadPath = Properties.ROOT_PATH
				+File.separator // '/'
				+Properties.UPLOAD_PATH;

		File dir = new File(UploadPath);
		if(dir.exists()&&dir.isDirectory()) {
			File [] folders =  dir.listFiles();	//폴더찾기
//			Arrays.stream(folders).forEach(System.out::println);
			for(File folder : folders) {
				File [] list = folder.listFiles();	//폴더 내 파일
				System.out.println("DIR : " + folder.getName());
				Arrays.stream(list).forEach(System.out::println);
				map.put(folder.getName(), Arrays.stream(list).collect(Collectors.toList()) );
			}

		}

		return map;
	}
	public boolean download(HttpServletRequest req, HttpServletResponse response) throws IOException {
		String folder = req.getParameter("folder");
		String filename = req.getParameter("filenmae");
		System.out.println("FILENAME : " + filename + "folder : " + folder);

		String downloadPath = "";
		downloadPath = Properties.ROOT_PATH
				+ File.separator
				+ Properties.UPLOAD_PATH
				+ File.separator
				+ folder
				+ File.separator
				+ filename;

		response.setHeader("Content-Type","application/octet-stream;charset-utf-8");
		response.setHeader("Content-Disposition","attachment; filename=TEST.txt"+ URLEncoder.encode(filename,"UTF-8").replaceAll("\\\\+",""));

		FileInputStream in = new FileInputStream(downloadPath);
		ServletOutputStream bout = response.getOutputStream();

		byte[] buff = new byte[4096];
		while(true){
			int data = in.read(buff);
			if(data==-1)
				break;
			bout.write(buff,0,data);
			bout.flush();
		}
		bout.close();
		in.close();

		return true;
	}
}

```

---

> UserServiceImpl.java
> 

```java
package Domain.Service;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import Domain.Dao.UserDao;
import Domain.Dao.UserDaoImpl;
import Domain.Dao.ConnectionPool.ConnectionPool;
import Domain.Dto.UserDto;

public class UserServiceImpl {

	//
	private UserDao userDao ;
	private ConnectionPool connectionPool ;	//TX

	//싱글톤 패턴
	private static UserServiceImpl instance;
	private UserServiceImpl() throws Exception {
		userDao = UserDaoImpl.getInstance();
		connectionPool = ConnectionPool.getInstance();
		System.out.println("[SERVICE] UserServiceImpl init...");
	};
	public static UserServiceImpl getInstance() throws Exception {
		if(instance==null)
			instance = new UserServiceImpl();
		return instance ;
	}

	//회원가입(+TX처리필요)
	public boolean userJoin(UserDto userDto) throws Exception{
		boolean isJoin = false;
		try {

			connectionPool.beginTransaction();
			isJoin  = userDao.insert(userDto)>0; //sql 질의 다수
			connectionPool.commitTransaction();

		}catch(SQLException e) {
			connectionPool.rollbackTransaction();
		}

		return  isJoin;
	};

	public Map<String,Object> login(UserDto userDto,HttpSession session) throws Exception {
		Map<String,Object> response = new LinkedHashMap();

		boolean isLogin = false;
		try {

			//connectionPool.beginTransaction();

			UserDto userDb  = userDao.select(userDto.getUsername());	//sql 질의 다수

			if(userDb==null) {
				response.put("isLogin", false);
				response.put("message", "동일한 계정이 존재하지 않습니다.");
			}else {

				//패스워드 일치여부 확인(암호화 전)
				if(!userDto.getPassword().equals(userDb.getPassword())) {
					response.put("isLogin", false);
					response.put("message", "패스워드가 일치하지 않습니다.");
				}else {
					//ID/패스워드 일치 -> 로그인처리
					session.setAttribute("isAuth", true);
					session.setAttribute("username",userDb.getUsername());
					session.setAttribute("role", userDb.getRole());
					session.setMaxInactiveInterval(60*10);

					response.put("isLogin", true);
					response.put("message", "로그인 성공!");
				}
			}
			//connectionPool.commitTransaction();
		}catch(SQLException e) {
			//connectionPool.rollbackTransaction();
		}
		return response;
	}

	public Map<String, Object> logout(HttpSession session) throws Exception  {
		session.invalidate();
		Map<String, Object> response = new LinkedHashMap();
		response.put("isLogout",true);
		return response;
	}

}

```

---

### WEB-INF/view/file

> list.jsp
> 

```
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>FILE LIST</h1>
	<%@page import="java.util.*,java.io.*" %>
	<%
		Map< String,List<File> > map = request.getAttribute("map")!=null?
									 ( Map<String,List<File>> )request.getAttribute("map")
									 :null;
		if(map!=null)
		{
			for(String folder : map.keySet())
			{
		%>
			<h3>폴더명 : <%=folder %></h3>
		<%
				List<File> list = map.get(folder);
				for(File file : list)
				{
		%>
					<a href="${pageContext.request.contextPath}/file/download?folder=<%=folder%>&filename=<%=file.getName()%>"><%=file.getName()%></a>
		<%
				}

				out.println("<hr/>");
			}
		}
		%>

</body>
</html>

```

---

> upload.jsp
> 

```
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>FILE UPLOAD</h1>
	<form action="${pageContext.request.contextPath}/file/upload"
		method="post" enctype="multipart/form-data">
		<input type="file" name="files" multiple />
		<button>업로드</button>
	</form>
	<hr>

	<style>
		div {
			width: 300px;
			height: 200px;
			border: 1px solid;
		}

		.drag-block {
			display: flex;
			justify-content: left;
			align-items: center;
			flex-wrap: wrap;
			width: 100%;
			height: 100%;
		}

		.d4 {
			width: 500px;
			height: 500px;
			padding: 10px;
			border: 5px dashed gray;
			position: relative;
			color: gray;
		}

		.d4::after {
			content: "+";
			font-size: 7rem;
			display: flex;
			justify-content: center;
			align-items: center;
			margin: 0;
			width: 100%;
			height: 100%;
			position: relative;
			top: -20px;
		}

		.preview {
			width: 150px;
			height: 500px;
			border: 1px solid;
			padding: 10px;
			display: flex;
			justify-content: start;
			align-items: center;
			overflow-y: auto;
			overflow-x: hidden;
			gap: 5px;
			flex-direction: column;
		}

		.preview::-webkit-scrollbar {
			display: none;
		}
		</style>

	<a href="javascript:void(0)" class="image-upload-btn">업로드</a>
	<div class="drag-block">
		<div class="d4"></div>
		<div class="preview"></div>
	</div>

	<!-- axios -->
	<script src="<https://cdnjs.cloudflare.com/ajax/libs/axios/1.8.4/axios.min.js>" integrity="sha512-2A1+/TAny5loNGk3RBbk11FwoKXYOMfAK6R7r4CpQH7Luz4pezqEGcfphoNzB7SM4dixUoJsKkBsB6kg+dNE2g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script>

			const formData = new FormData();

	        let maxSize = 1024 * 1024 * 1   // 최대 업로드 가능 사이즈 (1Mb)
	        function isValid(file)              // 유효성 체크 함수
	        {

	            if (!file.type.startsWith("image/")) {
	                //이미지 파일인지
	                alert("이미지 파일만 업로드 가능합니다.")
	                return false;
	            }
	            else if (file.size >= (1024 * 1024 * 1)) {
	                //사이즈가 maxSize를 초과하는지
	                alert("파일 업로드의 최대 사이즈는 1 MB입니다.")
	                return false;
	            } else {
	                return true;
	            }
	        }

	        const d4El = document.querySelector('.d4');
	        d4El.addEventListener('dragenter', (e) => {
	            e.preventDefault();
	            console.log('dragenter', e)
	        })
	        d4El.addEventListener('dragover', (e) => {
	            e.preventDefault();
	            d4El.style.border = "5px dashed lightgray";
	            d4El.style.color = "lightgray";
	            console.log('dragover', e)
	        })
	        d4El.addEventListener('dragleave', (e) => {
	            d4El.style.border = "5px dashed gray";
	            d4El.style.color = "gray";
	            e.preventDefault();

	            console.log('dragleave', e)
	        })
	        d4El.addEventListener('dragend', (e) => {
	            e.preventDefault();

	            console.log('dragend', e)
	        })
	        d4El.addEventListener('drop', (e) => {
	            e.preventDefault();
	            d4El.style.border = "5px dashed gray";
	            d4El.style.color = "gray";

	            console.log('drop', e)
	            console.log('drop', e.target)
	            console.log('drop', e.dataTransfer)
	            console.log('drop', e.dataTransfer.files)

	            const files = e.dataTransfer.files;
	            formData.append("files",files[0]);

	            for (let i = 0; i < files.length; i++) {
	                console.log('drop', e.dataTransfer.files[i])
	                const file = e.dataTransfer.files[i];

	                //유효성 확인(FN)
	                if (!isValid(file)) return;

	                //미리보기로 이미지 보여주기
	                const previewEl = document.querySelector('.preview');
	                const newImgEl = document.createElement('img');
	                newImgEl.src = URL.createObjectURL(file);
	                newImgEl.setAttribute('style', 'width:100%;height:100%;object-fit:contain;height:150px;border:1px solid;padding:2px;');
	                previewEl.prepend(newImgEl);
	            }
	        })

	        const imageUploadBtnEl = document.querySelector(".image-upload-btn");
	        const path ='${pageContext.request.contextPath}';
	        imageUploadBtnEl.addEventListener('click',()=>{
				console.log("image-add-btn clicked..");

				// 비동기함수 (axios 사용)
				axios 	.post(path+`/file/upload`,formData,{ headers : {'Content-Type':'multipart/form-data'} })
						.then(resp=>console.log(resp))
						.catch(error=>console.log(error))
	        });

		</script>
</body>
</html>

```

---

### resources/css/book

---

> read.css
> 

```
@charset "UTF-8";

.reply-block .reply-header textarea{
	height : 40px;

}
.reply-block .reply-body .item{

	display:flex;
	align-items : center;
	gap:20px;
	border : 1px solid;
	margin: 10px 0;
}
.reply-block .reply-body .item>*{
	/* border : 1px solid */;
}

```

---

### resources/js/book

---

> read.js
> 

```
/**
 *
 */
console.log("read.js..");

//!!!!!! - 오류
//const path=`${pageContext.request.contextPath}`;
console.log('path : ',path)

const replyAddBtn = document.querySelector(".reply-add-btn")

replyAddBtn.addEventListener('click',()=>{

	const contents = document.querySelector('.reply-header textarea').value;
	axios
		.get(`${path}/book/reply/create?bookCode=${bookCode}&contents=${contents}`)
		.then((resp)=>{
			console.log(resp);
			document.querySelector('.reply-header textarea').value='';
			receiveReplyData();
		})
		.catch((error)=>{ console.log(resp); })

	//createReplyItem();
})

function receiveReplyData(){
	axios
		.get(`${path}/book/reply/list?bookCode=${bookCode}`)
		.then((resp)=>{

			//기존 items의 노드제거
			const itemsEl = document.querySelector('.reply-body .items');
			while(itemsEl.firstChild){
				itemsEl.removeChild(itemsEl.firstChild)
			}

			console.log(resp);
			const data = resp.data;
			const cnt = data.replyCnt;
			const replyCntEl=document.querySelector(".reply-cnt");
			replyCntEl.innerHTML=cnt;
			const items = data.replyList;
			items.forEach(item=>createReplyItem(item))

		})
		.catch((error)=>{ console.log(resp); })
}
receiveReplyData();

function createReplyItem(item){
	const itemEl = document.createElement('div');
	itemEl.className='item';
	const leftEl = document.createElement('div');
	leftEl.className='left';
	const profileEl = document.createElement('div');
	profileEl.className='profile';
	const usernameEl = document.createElement('div');
	usernameEl.className='username';
	usernameEl.innerHTML=item.username;
	const rightEl = document.createElement('div');
	rightEl.className='right';

	const dateEl = document.createElement('div');
	dateEl.className='date';
	dateEl.innerHTML=item.createAt;
	const contentEl = document.createElement('div');
	contentEl.className='content';

	const textAreaEl = document.createElement('textarea');
	textAreaEl.value=item.contents

	const buttonGroupEl = document.createElement('div');
	buttonGroupEl.className='button-group';
	//연결
	leftEl.appendChild(profileEl);
	leftEl.appendChild(usernameEl);

	contentEl.appendChild(textAreaEl);
	rightEl.appendChild(dateEl)
	rightEl.appendChild(contentEl)
	rightEl.appendChild(buttonGroupEl)

	itemEl.appendChild(leftEl);
	itemEl.appendChild(rightEl);

	const itemsEl = document.querySelector('.items');
	itemsEl.appendChild(itemEl);
}

```

---