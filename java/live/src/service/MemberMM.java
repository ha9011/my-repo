
package service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import bean.Forward;
import bean.Product;
import dao.MemberDao;
import dao.ProductDao;

public class MemberMM {
	HttpServletRequest request;
	HttpServletResponse response;
	
	
	
	Forward fw = null;
	public MemberMM(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	
	//로그인 할때 실행되는 친구
	public Forward access() {
		HttpSession session = request.getSession();
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		MemberDao mDao = new MemberDao();
		int result = mDao.access(id,pw);  //1:성공 -1:아이디오류 0:pw부재
		
		mDao.close();
		
		if(result == -1) {
			request.setAttribute("msgAccess", "아이디 또는 비밀번호가 틀립니다.");
		}else{
<<<<<<< HEAD
			session.setAttribute("id",id);
=======
			session.setAttribute("id", id);
>>>>>>> 021b4c713caee19f309b3038803403f9960ee2d5
			session.setAttribute("membertype",result);
		}

		fw = new Forward();
		fw.setPath("./main.jsp");
		fw.setRedireact(false);
		return fw;
	}

	//로그아웃 시 실행되는 포워드
	public Forward logout() {
		
		HttpSession session=request.getSession();
		session.invalidate();//세션 초기화 
		
		fw = new Forward();
		fw.setPath("./main.jsp");
		fw.setRedireact(false);
		return fw;
	}

	//아이디 찾기시 실행되는 포워드 
	public Forward searchId() {
		
		String name = request.getParameter("name"); //이름이랑 이메일 받아옴 
		String email = request.getParameter("email");
		String findId = null;
		MemberDao mDao = new MemberDao(); //DB연결
		
		
		findId = mDao.findId(name, email);
		 
		if(findId.equals("")) {
			request.setAttribute("id","아이디가 없습니다.");//찾는 정보와 일치하지 않을 때
		}else {
			request.setAttribute("id",findId);
		}
		
		fw = new Forward();
		fw.setPath("./SearchId.jsp");
		fw.setRedireact(false);
		return fw;
	}

	//비밀번호 찾기 시 실행되는 포워드 
	public Forward searchPw() {
		
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String findPw = null;
		MemberDao mDao = new MemberDao();
		
		
		findPw = mDao.findPw(id, email, name);
		
		if(findPw.equals("")) {
			request.setAttribute("pw","비밀번호가 없습니다."); //찾는 정보와 일치하지 않을 때 
		}else {
			request.setAttribute("pw",findPw);
		}
		
		fw = new Forward();
		fw.setPath("./SearchPw.jsp");
		fw.setRedireact(false);
		
		return fw;
	}
	
	//민호 ----------------------------------------------------------------------------------------------
	public Forward join() {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw1");
		String name = request.getParameter("name");
		String phonenum = request.getParameter("phonenum");
		String gender = request.getParameter("gender");
		String email = request.getParameter("email");
		String gest = request.getParameter("h_or_g");

		MemberDao mDao = new MemberDao();
		mDao.join(id,pw,name,phonenum,email,gest, gender);
		fw = new Forward();
		fw.setPath("./index.jsp");
		fw.setRedireact(false);
		return fw;
	}//----------------------------------------------------------------

	
<<<<<<< HEAD
	
	
	//하동원 구역
=======
<<<<<<< HEAD
=======
	public Forward registHousechdate() {  // 정보만 requset에 담기
		
<<<<<<< HEAD
		
		
		MultipartRequest multipartRequest = new MultipartRequest(request, uploadDir, maxSize, encoding, new DefaultFileRenamePolicy());
		
		
		String housetype = request.getParameter("housetype");
=======
		String mindate = request.getParameter("mindate");
		String maxdate = request.getParameter("maxdate");
		int oneprice = Integer.parseInt(request.getParameter("oneprice"));
>>>>>>> c85219736a5ae2f6bd46fb62a0e7059adb928a28
		
<<<<<<< HEAD
		int attendanceNum = 0;
		if(request.getParameter("attendanceNum").equals("direct")) {
			attendanceNum = Integer.parseInt(request.getParameter("attendanceDir"));
		}else {
			attendanceNum = Integer.parseInt(request.getParameter("attendanceNum"));
		}
		String address = request.getParameter("address");
		String addressDetail = request.getParameter("addressDetail");
=======
		
>>>>>>> 50242e7e0a40ed78dbba4dd6ad2d96b3e6c13893

		String mainpic = request.getParameter("mainpic");

		System.out.println("넘어온 값 확인 ");
<<<<<<< HEAD
		System.out.println("유형 : "+housetype);
		System.out.println("수 : "+attendanceNum);
		System.out.println("주소 : "+address);
		System.out.println("디테일주소 : "+addressDetail);

		System.out.println("사진 : "+mainpic);
		
		

		request.setAttribute("housetype", housetype);
		request.setAttribute("attendanceNum", attendanceNum);
		request.setAttribute("address", address);
		request.setAttribute("addressDetail", addressDetail);

		request.setAttribute("mainpic", mainpic);  // Chrysanthemum.jpg  
=======
		System.out.println("첫날 : "+mindate);
		System.out.println("막날 : "+maxdate);
		System.out.println("1박가격 : "+oneprice);
		
		request.setAttribute("mindate", mindate);
		request.setAttribute("maxdate", maxdate);
		request.setAttribute("oneprice", oneprice);  
		
		
		
		// 넘어 오는 거 확인
		System.out.println("넘어 오는 모든 값 확인");

		String housetype = (String)request.getAttribute("housetype");
		String attendance = (String)request.getAttribute("attendance");
		String address = (String)request.getAttribute("address");
		String addressDetail = (String)request.getAttribute("addressDetail");
		String realFileName = (String)request.getAttribute("realFileName"); // 다시 하기
		
		String parkarea = (String)request.getAttribute("parkarea"); // 다시 하기
		String roomscnt = (String)request.getAttribute("roomscnt"); // 다시 하기
		String bathcnt = (String)request.getAttribute("bathcnt"); // 다시 하기
		String bedcnt = (String)request.getAttribute("bedcnt"); // 다시 하기
		String toiletcnt = (String)request.getAttribute("toiletcnt"); // 다시 하기
		String picscollect = (String)request.getAttribute("picscollect"); // 다시 하기
		
		// mindate maxdate oneprice  // 저장되 있음
		
		System.out.println("housetype : " + housetype);
		System.out.println("attendance : " + attendance);
		System.out.println("address : " + address);
		System.out.println("addressDetail : " + addressDetail);
		System.out.println("realFileName : " + realFileName);
		
		System.out.println("parkarea : " + parkarea);
		System.out.println("roomscnt : " + roomscnt);
		System.out.println("bathcnt : " + bathcnt);
		System.out.println("bedcnt : " + bedcnt);
		System.out.println("toiletcnt : " + toiletcnt);
		System.out.println("picscollect : " + picscollect);
		
		System.out.println("첫날 : "+mindate);
		System.out.println("막날 : "+maxdate);
		System.out.println("1박가격 : "+oneprice);
		
		
		
		
		
		
		
		//db에 넣기 
		
		
		
>>>>>>> 50242e7e0a40ed78dbba4dd6ad2d96b3e6c13893
		
		
		
		
		

		fw = new Forward();
		fw.setPath("./registHouseDetail.jsp");
		fw.setRedireact(false);
		return fw;
		
		
	}

>>>>>>> cceba8272900e9eeccdd66992194936a05bed4a8

>>>>>>> 2aa0f0166fba13fc4ad5b51a5e5ba90b36195453
	
	
	
	
	public String getAjaxduplicateID(String ID) {
		// 멤버다오 리서트의 리턴값을 받아온다
		String test = "";
		MemberDao mDao = new MemberDao(); //연결
		test=mDao.getDuplicateID(ID); // 테스트에 리서트 값을 넣어준다 
		
		mDao.close();
		
		System.out.println("중복 결과 값 : " + test);
		return test; //테스트 값을 사인업 석세스로 날려준다  
		
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//이예상 구역

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


	// 평민호 구역
//	public Forward checkId() {
//		string
//		return null;
//	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
