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

@WebServlet({"/orderlist","/showcart","/cartupdate","/detail","/insertproduct","/menu","/bestItem","/access","/newItem","/joinfrm","/logout","/proupfrm"})
public class Home extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd=request.getServletPath();
		Forward fw = null;
		MemberMM mm  = new MemberMM(request, response);
		ProductMM pm = new ProductMM(request, response);
		
		if(cmd.equals("/menu")){
			fw = new Forward();
			fw.setPath("menu.jsp");
			fw.setRedireact(false);
			
		}else if(cmd.equals("/newItem")) {
			fw = pm.getItemList("new");
		}else if(cmd.equals("/bestItem")) {
			fw = pm.getItemList("best");
			
		}else if(cmd.equals("/access")) {
			fw = mm.access();
		}else if(cmd.equals("/logout")) {
			fw = mm.logout();
		}else if(cmd.equals("/proupfrm")) {
			fw=new Forward();
			fw.setPath("./product/proUpFrm.jsp");
		}else if(cmd.equals("/insertproduct")) {
			
			fw = pm.insertProduct();
		}else if(cmd.equals("/detail")) {
			String codeNum = request.getParameter("name");
			System.out.println("codeNum : " + codeNum);
			fw = pm.showDetailInfo(codeNum);
		}else if(cmd.equals("/cartupdate")) {
			
			String cartcode = request.getParameter("cartcode");
			String cartcount = request.getParameter("count");
			System.out.println("카트 업데이트");
			System.out.println("코드 " + cartcode + "갯수 : " + cartcount);
			
			fw = pm.insertCart(cartcode, cartcount);
		
		}else if(cmd.equals("/showcart")) {
			fw = pm.showCart();
		}else if(cmd.equals("/orderlist")) {
			fw = pm.showOrder();
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
