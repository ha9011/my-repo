package service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		MemberDao mDao = new MemberDao();
		int result = mDao.access(id,pw);  //1:성공 -1:아이디오류 0:pw부재
		
		mDao.close();
		if(result == -1) {
			request.setAttribute("msgAccess", "ID가 존재하지 않습니다.");
		}else if(result == 0) {
			request.setAttribute("msgAccess", "PW가 틀립니다.");
		}else if(result == 1) {
			HttpSession session = request.getSession();
			session.setAttribute("id", id);
		}else {
			
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


	
	
	
}
