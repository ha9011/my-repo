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

@WebServlet({"/access","/logout","/SearchId","/SearchPw"})
public class Home extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd=request.getServletPath();
		Forward fw = null;
		MemberMM mm  = new MemberMM(request, response);
		ProductMM pm = new ProductMM(request, response);
		

		if(cmd.equals("/joinfrm")){
			System.out.println("회원가입 접근");
			String id = request.getParameter("id");
			String pw = request.getParameter("pw1");
			String name = request.getParameter("name");
			String phonenum = request.getParameter("phonenum");
			String email = request.getParameter("email");
			String gest = request.getParameter("h_or_g");
			System.out.println("test");
			System.out.println(id+ pw+ name+ phonenum+ email+ gest);
			mm.join(id,pw,name,phonenum,email,gest);
			
			
			fw = new Forward();
			fw.setPath("main.jsp");
			fw.setRedireact(false);
		}else if(cmd.equals("/access")) { //로그인 폼으로 연결
			fw=mm.access();
		}else if(cmd.equals("/logout")) { //로그아웃으로 연결
			fw=mm.logout();
		}else if(cmd.equals("/SearchId")) { // 아이디 찾기 연결
			System.out.println("접근아이디");
			fw=mm.searchId();
		}else if(cmd.equals("/SearchPw")) { //비밀번호 찾기 연결
			fw=mm.searchPw();
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
