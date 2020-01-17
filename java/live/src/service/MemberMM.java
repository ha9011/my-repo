
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
		fw.setPath("./main");
		fw.setRedireact(false);
		return fw;
	}

	// 로그아웃 시 실행되는 포워드
	public Forward logout() {

		HttpSession session = request.getSession();
		session.invalidate();// 세션 초기화

		fw = new Forward();
		fw.setPath("./main");
		fw.setRedireact(false);
		return fw;
	}

	// 아이디 찾기시 실행되는 포워드
	public String searchId(ArrayList<String> mList) {

		
		String findId = "";
		MemberDao mDao = new MemberDao(); // DB연결

		 findId = mDao.findId(mList); // 엠다오에 인풋리플 리턴값을 리플에 담기 //엠다오로 가
		 
		 mDao.close();
		
		if(findId.equals("")) {
			findId="아이디가 존재하지 않습니다.";
		} 
		// 엠다오 연결 클로스
		return findId;
	}

	// 비밀번호 찾기 시 실행되는 포워드
	public String searchPw(ArrayList<String> mList) {

		
		String findPw = "";
		MemberDao mDao = new MemberDao();

		findPw = mDao.findPw(mList);
		 
		mDao.close();
		
		if(findPw.equals("")) {
			findPw="해당정보의 비밀번호가 존재하지 않습니다.";
		} 
			
		
		
		return findPw;
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
		fw.setPath("./loginform.jsp");
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
		String guestid = request.getParameter("guestid"); // 게스트
		String regnum = request.getParameter("regnum"); // 방번호
		System.out.println(sdate);
		System.out.println(edate);
		System.out.println(tprice);
		System.out.println(tperson);
		System.out.println(hostid);
		System.out.println(guestid);
		System.out.println(regnum);

		int result = 0;
		ProductDao pDao = new ProductDao(); // 연결
		result = pDao.reservation(regnum, guestid, hostid, sdate, edate, tperson, tprice);

		System.out.println("reservation : " + result);

		fw = new Forward();
		fw.setPath("./main");
		fw.setRedireact(false);
		return fw;
	}

// 이예상 구역-------------------------------------------------------------------------------------

	public Forward guestInfo() { // 게스트 마이페이지
		HttpSession session = request.getSession(true);

		String id = (String) session.getAttribute("id");

		String Myinfo = null;
		String MyReser = null;
		String Write=null;
		
		
		MemberDao mDao = new MemberDao();
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
	}// 게스트 마이페이지 끝

	public Forward AdminInfo() {// 관리자 마이페이지

		HttpSession session = request.getSession(true);

		String id = (String) session.getAttribute("id");

		String Myinfo = null;

		MemberDao mDao = new MemberDao();
		Myinfo = mDao.Myinfo(id);

		mDao.close();

		request.setAttribute("result", Myinfo);
		fw = new Forward();
		fw.setPath("./AdminInfo.jsp");
		fw.setRedireact(false);
		return fw;

	} // 관리자 마이페이지 끝

	public Forward HostInfo() {// 호스트 마이페이지
		HttpSession session = request.getSession(true);

		String id = (String) session.getAttribute("id");

		String Myinfo = null;

		MemberDao mDao = new MemberDao();
		Myinfo = mDao.Myinfo(id);

		mDao.close();

		request.setAttribute("result", Myinfo);
		fw = new Forward();
		fw.setPath("./HostInfo.jsp");
		fw.setRedireact(false);
		return fw;

	}// 호스트 마이페이지 끝

//------------------------------------------------------------------------------------------------------------------------------------------------

// 평민호 구역
//댓글 저장 구역
	public String inputreple(ArrayList<String> mList) { // 컨트롤러에서 넘어온 스트링 들은 엠리스트
		MemberDao mDao = new MemberDao(); // 엠다오 연결
		System.out.println(mList); // 엠리스트 잘 왔나 확인
		String outreple = null; // 출력을 위해서 담을 아웃리플 선언

		int reple = mDao.inputreple(mList); // 엠다오에 인풋리플 리턴값을 리플에 담기 //엠다오로 가  // insert 
		if (reple == 0) { // 리서트 실패하면 출력 되면 안되니깐 if 문을 열고 리턴 null로 끝
			System.out.println("인서트 실패");
			return null;
		}

		//mList.get(1)  방번호
		//mList.get(4) 방띠
		
		// 총 글 갯수가 필요.
		int num = Integer.parseInt(mList.get(1));
		int e = Integer.parseInt(mList.get(4))*10;
		int s = e-9;

		System.out.println("시작 : "+ s);
		System.out.println("끝 : "+ e);
		//셀렉트 조건 긁어오기
		outreple=mDao.pagingInReple(num,s,e);
		
		
		
		mDao.close();// 엠다오 연결 클로스

		return outreple;// 스트링 리플 리턴값
	}

	public String cancelroom(String cancel) {
		MemberDao mDao = new MemberDao(); // 엠다오 연결
		System.out.println("예약취소버튼 값 받아옴 ");
		System.out.println(cancel);
		 int cancel1=mDao.cancelroom(cancel);
		 if (cancel1 == 0) { 
				System.out.println("취소 실패");
				return null;
			}
		return null;
	}



}
