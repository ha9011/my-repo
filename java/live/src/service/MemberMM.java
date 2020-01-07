
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

	
	//로그인 할때 실행되는 친구ㄴ
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

	//하동원 구역
	
	public Forward registHouse() {  // 정보만 requset에 담기
		
		String housetype = request.getParameter("housetype");
		
		int attendanceNum = 0;
		if(request.getParameter("attendanceNum").equals("direct")) {
			attendanceNum = Integer.parseInt(request.getParameter("attendanceDir"));
		}else {
			attendanceNum = Integer.parseInt(request.getParameter("attendanceNum"));
		}
		String address = request.getParameter("address");
		String addressDetail = request.getParameter("addressDetail");
		String mainpic = request.getParameter("mainpic");
		


		
		System.out.println("넘어온 값 확인 ");
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
		
		
		
		
		
		fw = new Forward();
		fw.setPath("./registHouseDetail.jsp");
		fw.setRedireact(false);
		return fw;
	}
	
	
	
	public String getAjaxduplicateID(String ID) {
		
		String test = "";
		MemberDao mDao = new MemberDao();
		test=mDao.getDuplicateID(ID);
		
		mDao.close();
		
		System.out.println("중복 결과 값 : " + test);
		return test;
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//이예상 구역
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 평민호 구역
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
