package service;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import bean.Forward;
import bean.Product;
import dao.MemberDao;
import dao.ProductDao;

public class FileServiceMM {
	HttpServletRequest request;
	HttpServletResponse response;
	Forward fw = null;
	
	
	public FileServiceMM(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}
	
	public Forward executefirst() {
		HttpSession session = request.getSession();
		// db sq번호 얻기
		//db에 넣기 
		String id = (String)session.getAttribute("id");
		ProductDao pDao = new ProductDao();
		int reginum = pDao.registerSQ(id);
		
		
		
		//C:\git_repo\my-repo\java\live\WebContent\img\mainhouse
		String uploadPath = "C:/git_repo/my-repo/java/live/WebContent/img/mainhouse/";
		String uploadRealPath = "./img/mainhouse/";
		int size = 10 * 1024 * 1024; // 10Mb까지
		String housetype = null; 
		String attendance = null;
		String address = null;
		String addressDetail = null;
		String x = null;
		String y = null;

		String sysfileName = null;// upload폴더(서버)에 저장된 파일이름
		String orifileName = null;// 원래 파일 이름

		File forder = new File(uploadPath);
		if (!forder.exists()) {
			forder.mkdir();
			System.out.println("폴더가 생성됌");
		}

		try {

			MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "utf-8",new DefaultFileRenamePolicy());

			housetype = multi.getParameter("housetype");
			attendance = multi.getParameter("attendanceNum");
			address = multi.getParameter("address");
			addressDetail = multi.getParameter("addressDetail");
			orifileName = multi.getOriginalFileName("mainpic");
			sysfileName = multi.getFilesystemName("mainpic");
			x = multi.getParameter("x");
			y = multi.getParameter("y");
			// 응닫페이지 출력

			System.out.println("housetype : " + housetype);
			System.out.println("attendance : " + attendance);
			System.out.println("address" + address);
			System.out.println("addressDetail : " + addressDetail);
			System.out.println("orifileName : " + orifileName);
			System.out.println("sysfileName : " + sysfileName);
			System.out.println("x : " + x);
			System.out.println("y : " + y);
			System.out.println("uploadPath : " + uploadPath);

			request.setAttribute("housetype", housetype);
			request.setAttribute("attendance", attendance);
			request.setAttribute("address", address);
			request.setAttribute("addressDetail", addressDetail);
			request.setAttribute("orifileName", orifileName);
			request.setAttribute("sysfileName", sysfileName);
			request.setAttribute("reginum", reginum);
			request.setAttribute("x", x);
			request.setAttribute("y", y);
			

			int i = -1;
			i = sysfileName.lastIndexOf("."); // 파일 확장자 위치
			String realFileName = id+reginum+"_" + sysfileName.substring(i, sysfileName.length()); // 현재시간과 확장자 합치기

			File oldFile = new File(uploadPath + sysfileName);
			File newFile = new File(uploadPath + realFileName);

			System.out.println(realFileName);
			System.out.println(sysfileName);

			oldFile.renameTo(newFile); // 파일명 변경
			request.setAttribute("realFileName", uploadRealPath+realFileName);
			
		} catch (IOException e) {
			e.printStackTrace();
		}

		fw = new Forward();
		fw.setPath("./registHouseDetail.jsp");
		fw.setRedireact(false);
		return fw;

	}

	public Forward executesecond() throws IOException {
	
		HttpSession session = request.getSession();
		String picscollect = "";
		String reginum = "";
		String id = (String)session.getAttribute("id");
		
		System.out.println("등록 번호 : " +reginum);
		System.out.println("id : " +id);		
		
		boolean isMultipart = ServletFileUpload.isMultipartContent(request); // multipart로 전송되었는가를 체크
		if (isMultipart) { // multipart로 전송 되었을 경우
			File temporaryDir = new File("c:/tmp/"); // 업로드 된 파일의 임시 저장 폴더를 설정
			
			//C:\git_repo\my-repo\java\live\WebContent\img\mainhouse
			//String uploadPath = "C:/git_repo/my-repo/java/live/WebContent/img/mainhouse/";
			
			String realDir = "C:/git_repo/my-repo/java/live/WebContent/img/detailhouse/";
			String uploadRealPath = "./img/detailhouse/";
			// tmp의 폴더의 전송된 파일을 upload 폴더로 카피 한다.
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(1 * 1024 * 1024); // 1메가가 넘지 않으면 메모리에서 바로 사용
			factory.setRepository(temporaryDir); // 1메가 이상이면 temporaryDir 경로 폴더로 이동
			// 실제 구현단계 아님 설정단계였음
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(10 * 1024 * 1024);
			// 최대 파일 크기(10M)
			List<FileItem> items;
			
			
			try {
				items = upload.parseRequest(request);
				Iterator iter = items.iterator(); // Iterator 사용
				while (iter.hasNext()) {
					FileItem fileItem = (FileItem) iter.next(); // 파일을 가져온다

					if (fileItem.isFormField()) { // 업로드도니 파일이 text형태인지 다른 형태인지 체크
													// text형태면 if문에 걸림
						try {
							System.out.println(
									"폼 파라미터: " + fileItem.getFieldName() + "=" + fileItem.getString("UTF-8"));
							request.setAttribute(fileItem.getFieldName(), fileItem.getString("UTF-8")); // 제일 중요 <= 침대 욕조 수 등 갯수 정리
							if(fileItem.getFieldName().equals("reginum")) {
								reginum = fileItem.getString("UTF-8");
							}
						
						} catch (UnsupportedEncodingException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					} else { // 파일이면 이부분의 루틴을 탄다
						if (fileItem.getSize() > 0) { // 파일이 업로드 되었나 안되었나 체크 size>0이면 업로드 성공
							String fieldName = fileItem.getFieldName();
							String fileName = fileItem.getName();
							String contentType = fileItem.getContentType();
							boolean isInMemory = fileItem.isInMemory();
							long sizeInBytes = fileItem.getSize();
							//System.out.println("파일 [fieldName] : " + fieldName + "<br/>");
							System.out.println("파일 [fileName] : " + fileName + "<br/>");
							//System.out.println("파일 [contentType] : " + contentType + "<br/>");
							//System.out.println("파일 [isInMemory] : " + isInMemory + "<br/>");
							//System.out.println("파일 [sizeInBytes] : " + sizeInBytes + "<br/>");
							
							
							File uploadedFile = new File(realDir, id+reginum+"_"+fileName); // 실제 디렉토리에 fileName으로 카피 된다.   // 파일 이름 변경
							
							picscollect+=uploadRealPath+id+reginum+"_"+fileName+",";
							
							try {
								fileItem.write(uploadedFile);
							} catch (Exception e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							fileItem.delete(); // 카피 완료후 temp폴더의 temp파일을 제거
						}
					}
				}
			} catch (FileUploadException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} // 실제 업로드 부분(이부분에서 파일이 생성된다)

			
		} else {
			System.out.println("인코딩 타입이 multipart/form-data 가 아님.");
		}

		System.out.println("reginum ** 확인 : " + reginum);
		System.out.println(picscollect);
		request.setAttribute("picscollect", picscollect);            // 제일 중요 <= 침대 욕조 수 등 갯수 정리
		
		fw = new Forward();
		fw.setPath("./registHousechdate.jsp");
		fw.setRedireact(false);
		return fw;

	}
	
	public Forward registHousechdate() {  // 정보만 requset에 담기
		
		HttpSession session = request.getSession();
		String reginum = request.getParameter("reginum");
		String id = (String)session.getAttribute("id");
		System.out.println("등록 번호 : " +reginum);
		System.out.println("id : " +id);	
		
		
		String mindate = request.getParameter("mindate");
		String maxdate = request.getParameter("maxdate");
		int oneprice = Integer.parseInt(request.getParameter("oneprice"));
		
		String housetype = request.getParameter("housetype");
		String attendance = request.getParameter("attendance");
		String address = request.getParameter("address");
		String addressDetail = request.getParameter("addressDetail");
		String realFileName = request.getParameter("realFileName");
		
		String parkarea = request.getParameter("parkarea");
		String roomscnt = request.getParameter("roomscnt");
		String bathcnt = request.getParameter("bathcnt");
		String bedcnt = request.getParameter("bedcnt");
		String toiletcnt = request.getParameter("toiletcnt");
		String picscollect = request.getParameter("picscollect");
		
		String x = request.getParameter("x");
		String y = request.getParameter("y");
		
		System.out.println("넘어온 값 확인 ");
		System.out.println("첫날 : "+mindate);
		System.out.println("막날 : "+maxdate);
		System.out.println("1박가격 : "+oneprice);
		

		System.out.println("reginum : "+reginum);
		
		
		
		
		// 넘어 오는 거 확인
		System.out.println("넘어 오는 모든 값 확인");

//		String housetype = (String)request.getAttribute("housetype");
//		String attendance = (String)request.getAttribute("attendance");
//		String address = (String)request.getAttribute("address");
//		String addressDetail = (String)request.getAttribute("addressDetail");
//		String realFileName = (String)request.getAttribute("realFileName"); // 다시 하기
//		
//		String parkarea = (String)request.getAttribute("parkarea"); // 다시 하기
//		String roomscnt = (String)request.getAttribute("roomscnt"); // 다시 하기
//		String bathcnt = (String)request.getAttribute("bathcnt"); // 다시 하기
//		String bedcnt = (String)request.getAttribute("bedcnt"); // 다시 하기
//		String toiletcnt = (String)request.getAttribute("toiletcnt"); // 다시 하기
//		String picscollect = (String)request.getAttribute("picscollect"); // 다시 하기
		
		// mindate maxdate oneprice  // 저장되 있음
		
		System.out.println("housetype : " + housetype);//
		System.out.println("attendance : " + attendance);//
		System.out.println("address : " + address);//
		System.out.println("addressDetail : " + addressDetail);//
		System.out.println("realFileName : " + realFileName);//
		
		System.out.println("parkarea : " + parkarea);//
		System.out.println("roomscnt : " + roomscnt);//
		System.out.println("bathcnt : " + bathcnt);//
		System.out.println("bedcnt : " + bedcnt);//
		System.out.println("toiletcnt : " + toiletcnt);//
		System.out.println("picscollect : " + picscollect);//
		
		System.out.println("첫날 : "+mindate);//
		System.out.println("막날 : "+maxdate);//
		System.out.println("1박가격 : "+oneprice);//

		System.out.println("x : "+x);//
		System.out.println("y : "+y);//
		
		//db에 넣기 
		ProductDao pDao = new ProductDao();
		pDao.registerHouse(reginum, id,housetype, attendance, address, addressDetail, realFileName, parkarea, roomscnt, bathcnt, bedcnt, toiletcnt, picscollect, mindate, maxdate, oneprice,y,x);
		
		
		
		System.out.println("디비 전달");
		//
		
		fw = new Forward();
		fw.setPath("./main");
		fw.setRedireact(false);
		return fw;
		
		
	}
	
	//게스트 리뷰 입니다. == 동원 ==
	public Forward updateguestreview() {
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		String hrenum = "";
		String hscore = "";
		String tareviewCont = "";    
		
		String picscollect = "";   // 사진의 모든 경로 담기
		
		String Myinfo = null;
		String MyReser = null;
		String Write=null;
		
		
		
		System.out.println("id : " +id);		
		
		boolean isMultipart = ServletFileUpload.isMultipartContent(request); // multipart로 전송되었는가를 체크
		if (isMultipart) { // multipart로 전송 되었을 경우
			File temporaryDir = new File("c:/tmp/"); // 업로드 된 파일의 임시 저장 폴더를 설정
			
			//C:\git_repo\my-repo\java\live\WebContent\img\mainhouse
			//String uploadPath = "C:/git_repo/my-repo/java/live/WebContent/img/mainhouse/";
			
			String realDir = "C:/git_repo/my-repo/java/live/WebContent/img/reviewpics/";
			String uploadRealPath = "./img/reviewpics/";
			// tmp의 폴더의 전송된 파일을 upload 폴더로 카피 한다.
			
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(1 * 1024 * 1024); // 1메가가 넘지 않으면 메모리에서 바로 사용
			factory.setRepository(temporaryDir); // 1메가 이상이면 temporaryDir 경로 폴더로 이동
			// 실제 구현단계 아님 설정단계였음
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(10 * 1024 * 1024);
			// 최대 파일 크기(10M)
			List<FileItem> items;
			
			
			try {
				items = upload.parseRequest(request);
				Iterator iter = items.iterator(); // Iterator 사용
				while (iter.hasNext()) {
					FileItem fileItem = (FileItem) iter.next(); // 파일을 가져온다

					if (fileItem.isFormField()) { // 업로드도니 파일이 text형태인지 다른 형태인지 체크
													// text형태면 if문에 걸림
						try {
							System.out.println("폼 파라미터: " + fileItem.getFieldName() + "=" + fileItem.getString("UTF-8"));
							
							//request 영역에 저장 저장 할 필요없음.
							//request.setAttribute(fileItem.getFieldName(), fileItem.getString("UTF-8")); // 제일 중요 <= 침대 욕조 수 등 갯수 정리
							
							if(fileItem.getFieldName().equals("hrenum")) {  // 예약 번호 담기
								hrenum = fileItem.getString("UTF-8");
							}else if(fileItem.getFieldName().equals("hscore")) { // 점수 담기
								hscore = fileItem.getString("UTF-8");
							}else if(fileItem.getFieldName().equals("tareviewCont")) { // 글 내용 담기
								tareviewCont = fileItem.getString("UTF-8");
							}
						
						} catch (UnsupportedEncodingException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					} else { // 파일이면 이부분의 루틴을 탄다
						if (fileItem.getSize() > 0) { // 파일이 업로드 되었나 안되었나 체크 size>0이면 업로드 성공
							String fieldName = fileItem.getFieldName();
							String fileName = fileItem.getName();
							String contentType = fileItem.getContentType();
							boolean isInMemory = fileItem.isInMemory();
							long sizeInBytes = fileItem.getSize();
							
							System.out.println("파일 [fileName] : " + fileName );
						
							
							

							
							//파일 이름 변경
							File uploadedFile = new File(realDir, id+hrenum+"_"+fileName); // 실제 디렉토리에 fileName으로 카피 된다.   // 파일 이름 변경
							//파일 이름에 다 넣기
							picscollect+=uploadRealPath+id+hrenum+"_"+fileName+",";
							
							
							
							try {
								fileItem.write(uploadedFile);
							} catch (Exception e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							fileItem.delete(); // 카피 완료후 temp폴더의 temp파일을 제거
						}
					}
				}
			} catch (FileUploadException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} // 실제 업로드 부분(이부분에서 파일이 생성된다)

			
		} else {
			System.out.println("인코딩 타입이 multipart/form-data 가 아님.");
		}

		
		//System.out.println("reginum ** 확인 : " + reginum);
		//System.out.println(picscollect);
		//request.setAttribute("picscollect", picscollect);            // 제일 중요 <= 침대 욕조 수 등 갯수 정리
		
		//Insert에 넣고, 
//		String id = (String)session.getAttribute("id");
//		String hrenum = "";
//		String hscore = "";
//		String tareviewCont = "";    
//		
//		String picscollect = ""; 
		
		MemberDao mDao = new MemberDao();
		
		 mDao.insertreview(hrenum,id,tareviewCont,picscollect,hscore);
		
		//Reservation 업데이트 하기-> 확정으로 바꿔주기 0->1
		 
		 mDao.updatereservereview(hrenum);  //R_REVIEW
		
		 
		 
		
			Myinfo = mDao.Myinfo(id);
			MyReser = mDao.MyReser(id);
			Write = mDao.Write(id);
			
			mDao.close();

			request.setAttribute("result", Myinfo);
			request.setAttribute("MyReser", MyReser);
			request.setAttribute("sleepwell", Write);

		 
		fw = new Forward();
		fw.setPath("./guestInfo.jsp");
		fw.setRedireact(false);
		return fw;
	}
	
	
	
	
	
	
//-----------------------------------------------------------------------------예상
	public String updateprofile() {
		HttpSession session = request.getSession();
		// db sq번호 얻기
		//db에 넣기 
		String id = (String)session.getAttribute("id");
		
		String re = "";
		
		
		String uploadPath= "C:/git_repo/my-repo/java/live/WebContent/img/profile/";
		System.out.println(uploadPath);
		
		//C:\gitlive\my-repo\java\live\WebContent\img\profile
		//C:\git_repo\my-repo\java\live\WebContent\img\mainhouse
		String uploadRealPath = "./img/profile/";
		
		int size = 10 * 1024 * 1024; // 10Mb까지
		
		String sysfileName = null;// upload폴더(서버)에 저장된 파일이름
		String orifileName = null;// 원래 파일 이름

		File forder = new File(uploadRealPath);
		if (!forder.exists()) {
			forder.mkdir();
			System.out.println("폴더가 생성됌");
		}

		
		try {

			MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "utf-8",new DefaultFileRenamePolicy());

			
			orifileName = multi.getOriginalFileName("propic");
			sysfileName = multi.getFilesystemName("propic");
			// 응닫페이지 출력

		
			System.out.println("orifileName : " + orifileName);
			System.out.println("sysfileName : " + sysfileName);

			
			request.setAttribute("uploadRealPath", uploadRealPath);
			request.setAttribute("orifileName", orifileName);
			request.setAttribute("sysfileName", sysfileName);
	//		request.setAttribute("reginum", reginum);
			
			

			int i = -1;
			i = sysfileName.lastIndexOf("."); // 파일 확장자 위치
			String realFileName = id+"_" + sysfileName.substring(i, sysfileName.length()); // 현재시간과 확장자 합치기

			File oldFile = new File(uploadPath + sysfileName);// 원래이름
			
			File newFile1 = new File(uploadPath + realFileName);
			newFile1.delete();
			File newFile = new File(uploadPath + realFileName);//새로운 이름

			System.out.println(realFileName);
			System.out.println(sysfileName);

			
			
			oldFile.renameTo(newFile); // 파일명 변경
			
			request.setAttribute("realFileName", uploadRealPath+realFileName);
			re = uploadRealPath+realFileName;
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		
		
		 MemberDao mDao = new MemberDao();
		
		 mDao.changepropic(re,id);
		
		

		
		String Myinfo=null;
		
		  Myinfo=mDao.Myinfo(id);
		  
		  mDao.close();
		  
	//	  request.setAttribute("result",Myinfo);
	//	  fw = new Forward();
		//  fw.setPath("./guestInfo.jsp");
		//  fw.setRedireact(false);
		  return "전달성공";

	}

	
	
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


