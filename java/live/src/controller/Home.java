package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Forward;
import service.FileServiceMM;
import service.MemberMM;
import service.ProductMM;

<<<<<<< HEAD

@WebServlet({"/joinfrm","/access","/logout","/SearchId","/SearchPw","/registHouse","/registHouseDetail"})

=======
@WebServlet({"/joinfrm","/access","/logout","/SearchId","/SearchPw"})
>>>>>>> 50242e7e0a40ed78dbba4dd6ad2d96b3e6c13893
public class Home extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String cmd=request.getServletPath();
		Forward fw = null;
		MemberMM mm  = new MemberMM(request, response);
		ProductMM pm = new ProductMM(request, response);
		FileServiceMM fs = new FileServiceMM(request, response);
		

		if(cmd.equals("/joinfrm")){

			System.out.println("회원가입 접근");
			fw = mm.join();
			fw=mm.join();						
			System.out.println("회원가입 접근");
			fw = mm.join();
			System.out.println("회원가입 접근");
			fw = mm.join();


		}else if(cmd.equals("/access")) { //로그인 폼으로 연결
			System.out.println("로그인접속");
			fw=mm.access();
		}else if(cmd.equals("/logout")) { //로그아웃으로 연결
			fw=mm.logout();
		}else if(cmd.equals("/SearchId")) { // 아이디 찾기 연결
			System.out.println("접근아이디z");
			fw=mm.searchId();
		}else if(cmd.equals("/SearchPw")) { //비밀번호 찾기 연결
			fw=mm.searchPw();
<<<<<<< HEAD
		}else if(cmd.equals("/registHouse")) { //호스트가 집등록 버튼 누를 경우 (1단계) [하동원]
			System.out.println("1단계z");
			fw=mm.registHouse();
		}else if(cmd.equals("/registHouseDetail")) { //호스트가  집등록 (2단계)[하동원]
			System.out.println("2단계");
			fw=mm.registHouse();
=======
		}


		
>>>>>>> 50242e7e0a40ed78dbba4dd6ad2d96b3e6c13893
		
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
