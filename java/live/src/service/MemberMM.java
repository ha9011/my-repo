
package service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

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

	// 로그인 할때 실행되는 친구
	public Forward access() {
		HttpSession session = request.getSession();
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");

		MemberDao mDao = new MemberDao();
		int result = mDao.access(id, pw); // 1:성공 -1:아이디오류 0:pw부재

		mDao.close();

		if (result == -1) {
			request.setAttribute("msgAccess", "아이디 또는 비밀번호가 틀립니다.");
		} else {
			session.setAttribute("id", id);
			session.setAttribute("membertype", result);
		}

		fw = new Forward();
		fw.setPath("./main.jsp");
		fw.setRedireact(false);
		return fw;
	}

	// 로그아웃 시 실행되는 포워드
	public Forward logout() {

		HttpSession session = request.getSession();
		session.invalidate();// 세션 초기화

		fw = new Forward();
		fw.setPath("./main.jsp");
		fw.setRedireact(false);
		return fw;
	}

	// 아이디 찾기시 실행되는 포워드
	public Forward searchId() {

		String name = request.getParameter("name"); // 이름이랑 이메일 받아옴
		String email = request.getParameter("email");
		String findId = null;
		MemberDao mDao = new MemberDao(); // DB연결

		findId = mDao.findId(name, email);

		if (findId.equals("")) {
			request.setAttribute("id", "아이디가 없습니다.");// 찾는 정보와 일치하지 않을 때
		} else {
			request.setAttribute("id", findId);
		}

		fw = new Forward();
		fw.setPath("./SearchId.jsp");
		fw.setRedireact(false);
		return fw;
	}

	// 비밀번호 찾기 시 실행되는 포워드
	public Forward searchPw() {

		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String findPw = null;
		MemberDao mDao = new MemberDao();

		findPw = mDao.findPw(id, email, name);

		if (findPw.equals("")) {
			request.setAttribute("pw", "비밀번호가 없습니다."); // 찾는 정보와 일치하지 않을 때
		} else {
			request.setAttribute("pw", findPw);
		}

		fw = new Forward();
		fw.setPath("./SearchPw.jsp");
		fw.setRedireact(false);

		return fw;
	}

	// 민호
	// ----------------------------------------------------------------------------------------------
	public Forward join() {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw1");
		String name = request.getParameter("name");
		String phonenum = request.getParameter("phonenum");
		String gender = request.getParameter("gender");
		String email = request.getParameter("email");
		String gest = request.getParameter("h_or_g");

		MemberDao mDao = new MemberDao();
		mDao.join(id, pw, name, phonenum, email, gest, gender);
		fw = new Forward();
		fw.setPath("./index.jsp");
		fw.setRedireact(false);
		return fw;
	}
	
	
	// 하동원 구역

	public String getAjaxduplicateID(String ID) {
		// 멤버다오 리서트의 리턴값을 받아온다
		String test = "";
		MemberDao mDao = new MemberDao(); // 연결
		test = mDao.getDuplicateID(ID); // 테스트에 리서트 값을 넣어준다

		mDao.close();

		System.out.println("중복 결과 값 : " + test);
		return test; // 테스트 값을 사인업 석세스로 날려준다

	}

	 public Forward reservation() {

			String sdate = request.getParameter("sdate"); // 체크인
			String edate = request.getParameter("edate"); // 체크 아웃
			String tprice = request.getParameter("tprice"); // 토탈
			String tperson = request.getParameter("tperson"); // 인원
			String hostid = request.getParameter("hostid"); // 호스트
			String guestid = request.getParameter("guestid"); //게스트
			String regnum = request.getParameter("regnum"); // 방번호
			System.out.println(sdate);
			System.out.println(edate);
			System.out.println(tprice);
			System.out.println(tperson);
			System.out.println(hostid);
			System.out.println(guestid);
			System.out.println(regnum);
			
			int result =0;
			ProductDao pDao = new ProductDao(); // 연결
			result = pDao.reservation(regnum, guestid, hostid, sdate, edate, tperson, tprice); 
		 
			
			System.out.println("reservation : " + result);
		 
			fw = new Forward();
		    fw.setPath("./main.jsp");
		    fw.setRedireact(false);
		    return fw;
	}


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
// 이예상 구역-------------------------------------------------------------------------------------

	public Forward guestInfo() { //게스트 마이페이지
	      HttpSession session = request.getSession(true);
	           
	      String id = (String) session.getAttribute("id"); 
	          
	           String Myinfo=null;
	           
	           MemberDao mDao = new MemberDao();
	           Myinfo=mDao.Myinfo(id);
	           
	           mDao.close();
	           
	           request.setAttribute("result",Myinfo);
	           fw = new Forward();
	           fw.setPath("./guestInfo.jsp");
	           fw.setRedireact(false);
	           return fw;
	   }//게스트 마이페이지 끝

	

public Forward AdminInfo() {//관리자 마이페이지
	
	HttpSession session = request.getSession(true);
     
     String id = (String) session.getAttribute("id"); 
         
          String Myinfo=null;
          
          MemberDao mDao = new MemberDao();
          Myinfo=mDao.Myinfo(id);
          
          mDao.close();
          
          request.setAttribute("result",Myinfo);
          fw = new Forward();
          fw.setPath("./AdminInfo.jsp");
          fw.setRedireact(false);
          return fw;
	
} //관리자 마이페이지 끝



public Forward HostInfo() {//호스트 마이페이지
	HttpSession session = request.getSession(true);
    
    String id = (String) session.getAttribute("id"); 
        
         String Myinfo=null;
         
         MemberDao mDao = new MemberDao();
         Myinfo=mDao.Myinfo(id);
         
         mDao.close();
         
         request.setAttribute("result",Myinfo);
         fw = new Forward();
         fw.setPath("./HostInfo.jsp");
         fw.setRedireact(false);
         return fw;

}//호스트 마이페이지 끝
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//------------------------------------------------------------------------------------------------------------------------------------------------



// 평민호 구역

  public String inputreple(ArrayList<String> mList) { // TODO Auto-generated method stub
	  MemberDao mDao = new MemberDao(); // 연결 test =
	  System.out.println(mList);
	  String outreple = null;
	  
	  
	  int reple = mDao.inputreple(mList); // 테스트에 리서트 값을 넣어준다
	  if(reple==0) {
		  System.out.println("인서트 실패");
		  return null;
	  } 
	  
	  outreple = mDao.outreple(mList.get(1));
	  mDao.close();
	  
	  System.out.println("ajax 대댓글 작성 성공");
	  
	  
	  return outreple;//스트링;
  }

 


}


