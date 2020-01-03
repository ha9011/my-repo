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
		fw.setPath("./index.jsp");
		fw.setRedireact(false);
		return fw;
	}


	public Forward logout() {
		
		HttpSession session=request.getSession();
		session.invalidate();//세션 초기화 
		
		fw = new Forward();
		fw.setPath("./index.jsp");
		fw.setRedireact(false);
		return fw;
	}


	public Forward join(String id, String pw, String name, String phonenum, String email, String gest) {
		
		MemberDao mDao = new MemberDao();
		mDao.join(id,pw,name,phonenum,email,gest);
		/////
		fw = new Forward();
		fw.setPath("./index.jsp");
		fw.setRedireact(false);
		return fw;
	}

	
	
}
