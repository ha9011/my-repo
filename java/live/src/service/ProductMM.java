package service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

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
		HttpSession session = request.getSession();
		
		String loginID = (String)session.getAttribute("id");
		String destination = request.getParameter("destination");
		String checkin = request.getParameter("checkin");
		String checkout = request.getParameter("checkout");
		String person = request.getParameter("person");
		
		String searchHouse = null;
		
		String searchLike = null;
		
		String showlikereviewcnt = null;
		
		ProductDao pDao = new ProductDao();
		
		searchHouse = pDao.searchHouse(destination,checkin,checkout,person);
		
		System.out.println("아이디 검사 : " +  loginID);
		if(loginID==null) {
			request.setAttribute("searchLike","[]");
		}else {
			System.out.println("라이크 검사 ");
			searchLike = pDao.searchLike(loginID);
			request.setAttribute("searchLike",searchLike);
		}
		
		showlikereviewcnt = pDao.showlikereviewcnt();
		
		
		pDao.close();
		
		request.setAttribute("result",searchHouse);  // 집 
		
		request.setAttribute("destination",destination);  // 검색창에 목적지 
		
		request.setAttribute("showlikereviewcnt",showlikereviewcnt);  // 검색창에 목적지 
		
		
		
		
		
		
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
		String adminP = null;
		ProductDao pDao = new ProductDao();
		adminH = pDao.adminH();
		adminP = pDao.adminP();
		
		
		
		pDao.close();
		
		request.setAttribute("HU",adminH);
		
		request.setAttribute("DOWN",adminP);
		
		
		fw = new Forward();
		fw.setPath("./AdminInfo.jsp");
		fw.setRedireact(false);
		return fw;
	}//관리자 게시글 승인 끝

	
	

	public String getAjaxhouseupload() { //-- 승인, 거절 AJAX
		
		
		ArrayList<String> resultList = new ArrayList<String>();
		String data=request.getParameter("data");
		
		ArrayList<String> app = new  ArrayList<String>();
		
		Gson gs = new Gson();
		app = gs.fromJson(data, new TypeToken<ArrayList<String>>() {
		}.getType());
		
		System.out.println(app);//[,]
		
		
		String adminH = null;
		String adminP = null;
		String req = null;
		
		
		ProductDao pDao = new ProductDao();
		
		pDao.req(app);// insert
		
		adminH = pDao.adminH(); // select
		
		adminP = pDao.adminP(); // select
		
		
		System.out.println("======================");
		System.out.println(adminH);
		System.out.println(adminP);
		resultList.add(adminH);
		resultList.add(adminP);
		
		
		pDao.close();
		
		
		String result = gs.toJson(resultList);
		System.out.println("#####");
		System.out.println(result);
		
		return result ;
	}//-- 승인, 거절 AJAX 끝

	
	
	
	

	public Forward hostupload() { //호스트가 업로드한 게시물 현황
		HttpSession session = request.getSession(true); //세션아이디 가져감
	    
	    String id = (String) session.getAttribute("id"); 
	    
		String hostH = null;
		
		ProductDao pDao = new ProductDao();
		hostH = pDao.hostH(id);
		
		pDao.close();
		
		request.setAttribute("hostH",hostH);
		
		
		fw = new Forward();
		fw.setPath("./HostInfo.jsp");
		fw.setRedireact(false);
		return fw;
	}//호스트가 업로드한 게시물 현황 끝
	
	
	
	


	public Forward myhouse() { //호스트 집 리스트
		HttpSession session = request.getSession(true); //세션아이디 가져감
	    
	    String id = (String) session.getAttribute("id"); 
	    
		String hostHL = null;
		
		ProductDao pDao = new ProductDao();
		hostHL = pDao.hostHL(id);
		
		pDao.close();
		
		request.setAttribute("hostHL",hostHL);
		
		
		fw = new Forward();
		fw.setPath("./HostInfo.jsp");
		fw.setRedireact(false);
		return fw;
	}//호스트 집 리스트 끝 

	
	


	public Forward reserlist() { //호스트가 받은 예약리스트 
		HttpSession session = request.getSession(true); //세션아이디 가져감
	    
	    String id = (String) session.getAttribute("id"); 
	    
		String reserlist = null;
		
		ProductDao pDao = new ProductDao();
		reserlist = pDao.reservlist(id);
		
		pDao.close();
		
		request.setAttribute("reserlist",reserlist);
		System.out.println(reserlist);
		
		fw = new Forward();
		fw.setPath("./HostInfo.jsp");
		fw.setRedireact(false);
		return fw;
	} //호스트가 받은 예약리스트 끝

	
	


	public String getAjaxrequestlist() {  //호스트 예약 승인 거절
		HttpSession session = request.getSession(true); //세션아이디 가져감
	    
	    String id = (String) session.getAttribute("id"); 
	    
		String reservlist= null;
		String data=request.getParameter("data");
		
		ArrayList<String> ap = new  ArrayList<String>();
		
		Gson gs = new Gson();
		ap = gs.fromJson(data, new TypeToken<ArrayList<String>>() {
			
		}.getType());
		
		System.out.println(ap);//[,]
		

		
		ProductDao pDao = new ProductDao();
		
		pDao.reserlist(ap);

		reservlist = pDao.reservlist(id);
		
		pDao.close();
		return reservlist ;
	}//-- 승인, 거절 AJAX 끝



	public Forward checkoutlist() {
		
		HttpSession session = request.getSession(true); //세션아이디 가져감
	    
	    String id = (String) session.getAttribute("id"); 
	    
		String  checkoutlist= null;
		
		ProductDao pDao = new ProductDao();
		checkoutlist = pDao.checkoutlist(id);
		
		pDao.close();
		request.setAttribute("checkoutlist",checkoutlist);
		System.out.println(checkoutlist);
		
		fw = new Forward();
		fw.setPath("./HostInfo.jsp");
		fw.setRedireact(false);
		return fw;

	}

	


	public Forward hostreview() {
		HttpSession session = request.getSession(true); //세션아이디 가져감
	    
	    String id = (String) session.getAttribute("id");  
	    String contents = request.getParameter("contents");
	    String score =request.getParameter("hscore");
	    String rgnum =request.getParameter("hrgnum");
	    int result=0;
	  

	    System.out.println("방ㄴㄴㄴㄴㄴ");
	    System.out.println(rgnum);
	    
	    
	    
	    MemberDao mDao = new MemberDao(); 
		ProductDao pDao = new ProductDao();
		result=pDao.hostreview(id,contents,score,rgnum);
		
		  if (result == 0) { // 리서트 실패하면 출력 되면 안되니깐 if 문을 열고 리턴 null로 끝
				System.out.println("인서트 실패");
				return null;
			}
		  
		  mDao.updatereserveGreview(rgnum);
		  pDao.close();
		  
		  fw = new Forward();
			fw.setPath("./HostInfo.jsp");
			fw.setRedireact(false);
			return fw;
	}




	public Forward tophouse() {
		
		String tophouse = null;
		
		ProductDao pDao = new ProductDao();
		tophouse = pDao.tophouse();
		
		pDao.close();
		
		request.setAttribute("tophouselist",tophouse);
		System.out.println(tophouse);
		System.out.println("여기까지 오니?");
		fw = new Forward();
		fw.setPath("./main.jsp");
		fw.setRedireact(false);
		return fw;
	}
	
	

	public Forward topstar() {
		
		String topstar = null;
		
		ProductDao pDao = new ProductDao();
		topstar = pDao.topstar();
		
		pDao.close();
		
		request.setAttribute("topstarlist",topstar);
		System.out.println(topstar);
		System.out.println("오고 있니???");
		fw = new Forward();
		fw.setPath("./main.jsp");
		fw.setRedireact(false);
		return fw;
		
	}
	




	
	
	
	
	
	
	
	
	
	
	
	
	
	
//---------------------------동원-------------------------------------------------------------------------
	
	public String getAjaxlikechecked() {
		
		int exist = 0;
		String a = request.getParameter("data");
		ArrayList<String> likearr = new ArrayList<String>();
		
		
		Gson gs = new Gson();
		
		likearr = gs.fromJson(a, new TypeToken<ArrayList<String>>(){}.getType());
		
		
		MemberDao mDao = new MemberDao();    // select 부터 있는지 없는 지 검색 // 1 아니면 0을 뱉어야함  (있고 / 없고)
		exist = mDao.existChLike(likearr);
		
		if(exist==0) { // 0이면 insert
			mDao.insertLike(likearr);
		}else if(exist==1) { // 1이면 update
			mDao.updateLike(likearr);
		}
		
		
		
		return "성공";
	}
	
	
	public String getAjaxshowreview() {

		String showreview=request.getParameter("showreview"); // 각 예약 번호
		System.out.println("각 예약 번호 : "+showreview);
		
		HashMap<String, String> greview = new HashMap<String, String>();
		
		MemberDao mDao = new MemberDao();    // select 부터 있는지 없는 지 검색 // 1 아니면 0을 뱉어야함  (있고 / 없고)
		
		
		
		return mDao.showguestreview(showreview); 
	}
	
	
	
	//paging reple show
	public String getAjaxShowPageReple() {
		
		String pagingReple=request.getParameter("reple"); // 각 예약 번호
		ArrayList<String> likearr = new ArrayList<String>();
		Gson gs = new Gson();
		
		likearr = gs.fromJson(pagingReple, new TypeToken<ArrayList<String>>(){}.getType());
		
		MemberDao mDao = new MemberDao();
		String inrreple= null;
		
		int num = Integer.parseInt(likearr.get(0));
		int e = Integer.parseInt(likearr.get(1))*10;
		int s = e-9;

		System.out.println("시작 : "+ s);
		System.out.println("끝 : "+ e);
		//셀렉트 조건 긁어오기
		inrreple=mDao.pagingInReple(num,s,e);
		
		
		System.out.println("대댓글 입력");
		//System.out.println(inrreple);
		
		
		
		return inrreple;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//----------민호-------------------------------------------------------------------------------------------
	public Forward detailregiinfo(){
		

		
		
		String detailId = request.getParameter("rgnum");
		System.out.println(detailId);
		String detailregiinfo = null;
		String outreple = null;
		String hostId = null;
		String checkDate = null;
		
		
		ProductDao pDao = new ProductDao();
		detailregiinfo = pDao.detailregiinfo(detailId);
		pDao.close();
		request.setAttribute("result",detailregiinfo);
		
		
		MemberDao mDao1 = new MemberDao();
		outreple = mDao1.outreple(detailId);
		mDao1.close();
		request.setAttribute("reple", outreple);
		
		

		MemberDao mDao2 = new MemberDao();
		hostId = mDao2.findHostId(detailId);
		mDao2.close();
		request.setAttribute("findhostid", hostId);
		
		
		MemberDao mDao3 = new MemberDao();
		checkDate = mDao3.checkReserDate(detailId); // 예약된 날짜 긁어오기.
		mDao3.close();
		
		
		request.setAttribute("checkDate", checkDate);
		
		
		request.setAttribute("rgnum", detailId);
		
		
		

	
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
