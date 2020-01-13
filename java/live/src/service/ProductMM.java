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
		
		String detailId = request.getParameter("id");
		System.out.println(detailId);
		String detailregiinfo = null;
		
		String outreple = null;
		
		ProductDao pDao = new ProductDao();
		
		detailregiinfo = pDao.detailregiinfo(detailId);
		
		pDao.close();
		
		
		request.setAttribute("result",detailregiinfo);
		
		
		MemberDao mDao = new MemberDao();
		outreple = mDao.outreple(detailId);
		
		
		  mDao.close();
		request.setAttribute("reple", outreple);
		
		
		
		
		
		fw = new Forward();
		fw.setPath("./detail&reservation.jsp");
		fw.setRedireact(false);
		return fw;
		
		
		
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
