package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Forward;
import service.MemberMM;
import service.ProductMM;

@WebServlet({"/access","/logout","/SearchId","/SearchPw","/registHouse","/registHouseDetail","/checkId","/joinfrm"})
public class Home extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd=request.getServletPath();
		Forward fw = null;
		MemberMM mm  = new MemberMM(request, response);
		ProductMM pm = new ProductMM(request, response);
		

		if(cmd.equals("/joinfrm")){
			fw=mm.join();						
			
		}else if(cmd.equals("/access")) { //로그인 폼으로 연결
			System.out.println("로그인접속");
			fw=mm.access();
		}else if(cmd.equals("/logout")) { //로그아웃으로 연결
			fw=mm.logout();
		}else if(cmd.equals("/SearchId")) { // 아이디 찾기 연결
			System.out.println("접근아이디");
			fw=mm.searchId();
		}else if(cmd.equals("/SearchPw")) { //비밀번호 찾기 연결
			fw=mm.searchPw();
		}else if(cmd.equals("/registHouse")) { //호스트가 집등록 버튼 누를 경우 (1단계) [하동원]
			System.out.println("1단계");
			fw=mm.registHouse();
		}else if(cmd.equals("/registHouseDetail")) { //호스트가  집등록 (2단계)[하동원]
			System.out.println("2단계");
			fw=mm.registHouse();
		
		}else if(cmd.equals("/checkId")) {//아이디 중복 검사 [평민호]
			fw=mm.checkId();

		}
		
		
		if(fw!=null) {
			if(fw.isRedireact()) {
				response.sendRedirect(fw.getPath());
			}else {
				request.getRequestDispatcher(fw.getPath()).forward(request, response);
			}
		}
		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}
}
