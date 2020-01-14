package service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import bean.Forward;
import bean.Product;
import dao.MemberDao;
import dao.ProductDao;

public class ProductMM {
	HttpServletRequest request;
	HttpServletResponse response;
	Forward fw = null;
	
	public ProductMM(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	
	

	public String getAjaxduplicateID(String ID) {
		
		String test = "";
		ProductDao pDao = new ProductDao();
		test=pDao.getDuplicateID(ID);
		
		pDao.close();
		
		Gson gs = new Gson();
		
		
		String showinfo = gs.toJson(test);
		
		return showinfo;
		
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//----------예상-------------------------------------------------------------------------------------------
	
	
public Forward searchHouse() { //처음 검색 페이지
		
	
		String destination = request.getParameter("destination");
		String checkin = request.getParameter("checkin");
		String checkout = request.getParameter("checkout");
		String person = request.getParameter("person");
		
		String searchHouse = null;
		
		ProductDao pDao = new ProductDao();
		
		searchHouse = pDao.searchHouse(destination,checkin,checkout,person);
		
		pDao.close();
		
		
		request.setAttribute("result",searchHouse);
		request.setAttribute("destination",destination);
		fw = new Forward();
		fw.setPath("./SearchDetail.jsp");
		fw.setRedireact(false);
		return fw;
	}//처음 검색 페이지 끝
	
	
	
	
	public String getAjaxchangeSearch() { //-- 재검색
		String destination = request.getParameter("data");
		System.out.println(destination);
		
		
		String searchHouse = null;
		
		ProductDao pDao = new ProductDao();
		
		searchHouse = pDao.searchHouse(destination);
		
		pDao.close();
		
		
		return searchHouse;
	}//-- 재검색 끝

	
	
	
	public Forward houseupload() {//관리자 게시글 승인
		String adminH = null;
		
		ProductDao pDao = new ProductDao();
		adminH = pDao.adminH();
		
		pDao.close();
		
		request.setAttribute("HU",adminH);
		
		
		fw = new Forward();
		fw.setPath("./AdminInfo.jsp");
		fw.setRedireact(false);
		return fw;
	}//관리자 게시글 승인 끝

	
	

	public String getAjaxhouseupload() { //-- 승인, 거절 AJAX
		String adminH = null;
		String data=request.getParameter("data");
		ArrayList<String> app = new  ArrayList<String>();
		Gson gs = new Gson();
		app = gs.fromJson(data, new TypeToken<ArrayList<String>>() {
		}.getType());
		
		System.out.println(app);//[,]
		
		String req = null;
		
		ProductDao pDao = new ProductDao();
		
		pDao.req(app);
		
		adminH = pDao.adminH();
		
		pDao.close();
		
		return adminH ;
	}//-- 승인, 거절 AJAX 끝

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//---------------------------동원-------------------------------------------------------------------------
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//----------민호-------------------------------------------------------------------------------------------
	public Forward detailregiinfo(){
		
		String detailId = request.getParameter("rgnum"); //방번호를 디테일 아이디에 넣기,디테일 창에 방에대한 정보 넣으려고
		System.out.println(detailId); //디테일 아이디 확인 
		String detailregiinfo = null; //변수 선언 
		
		String outreple = null; // 변수 선언 
		
		ProductDao pDao = new ProductDao(); //프로덕트 다오 연결 
		
		detailregiinfo = pDao.detailregiinfo(detailId); //디테일레지 인포에 디테일아이디에 담긴 방번호로  방정보 긁어서 다른 디테일 레지인포에 저장
		
		pDao.close(); //연결 종료 
		
		
		request.setAttribute("result",detailregiinfo); // 리설트 이엘에 필요한 방정보들 저장  
		
		
		
		
		
		//
		MemberDao mDao = new MemberDao(); // 엠다오 연결 
		outreple = mDao.outreple(detailId); // 아웃리플에 방번호로  그 방에 관련된 리플 긁어오기
		mDao.close(); // 엠다오 연결 종료 하고 
		request.setAttribute("reple", outreple); // 리플 이엘에 아웃리플 정보 담기 
		fw = new Forward(); // 값을 가지고 가기위한 포워딩 객체
		fw.setPath("./detail&reservation.jsp"); //여기까지 범위 설정 
		fw.setRedireact(false); // 값을 갖고 넘어가기 위한 포워딩
		return fw; //포워드에 데이터 담긴거 리턴 
		
		
		
	}




	public String inputrreple(ArrayList<String> mList) {
		MemberDao mDao = new MemberDao();
		String inrreple= null;
		
		HttpSession session =request.getSession();
		String id=(String)session.getAttribute("id");
		
		
		int reple = mDao.inrreple(mList,id); // 테스트에 리서트 값을 넣어준다
		  if(reple==0) {
			  System.out.println("인서트 실패");
			  return null;
		  } 
		  
		  inrreple=mDao.inrreple(mList.get(1));
		  
		System.out.println("대댓글 입력");
		System.out.println(mList);
		
		
		
		return inrreple;
	}




	public String showrreple(String replenum) {
		
		String inrreple= null;
		MemberDao mDao = new MemberDao();
		inrreple=mDao.inrreple(replenum);
		  
		System.out.println("대댓글 출력");
		
		
		
		return inrreple;
	}






	
}
