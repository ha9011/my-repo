package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import service.ProductMM;


@WebServlet({"/showUserProInfo","/showProductInfo","/showMemberInfo","/ajaxOrderDetail", "/orderaddlistcartdel","/cartdelete", "/ajaxDetail"})
public class RestController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String cmd = request.getServletPath();
		System.out.println("rest CMD : " + cmd);
		ProductMM pm = new ProductMM(request, response);
		String json = null;
		
		if(cmd.equals("/ajaxDetail")) {
			String pCode = request.getParameter("pCode");
			System.out.println("==pCode== : " + pCode);
			
			json = pm.getAjaxDetail(pCode);
			
		}else if(cmd.equals("/cartdelete")) {
			String cartDelList = request.getParameter("data");
			Gson gs=new Gson();
			ArrayList<ArrayList<String>> dlist = new ArrayList<ArrayList<String>>();
			dlist=gs.fromJson(cartDelList, new TypeToken<ArrayList<ArrayList<String>>>(){}.getType());
			
			json = pm.getAjaxDelete(dlist);
		}else if(cmd.equals("/orderaddlistcartdel")) {
			System.out.println("주문확인버튼 클릭후 서블릿 체크");
			String cartDelList = request.getParameter("data");
			Gson gs=new Gson();
			ArrayList<ArrayList<String>> dlist = new ArrayList<ArrayList<String>>();
			dlist=gs.fromJson(cartDelList, new TypeToken<ArrayList<ArrayList<String>>>(){}.getType());
			
			 
			System.out.println("내용확인 포문");
			//[new45, 7]  이런식으로 나옴.
			for(ArrayList<String> a : dlist) {
				System.out.println(a);
			}
			
			json = pm.getAjaxOrderAddCartDel(dlist);
			
		}else if(cmd.equals("/ajaxOrderDetail")) {
			System.out.println("orderlist Detail 서블릿 체크");
			String orderDetailList = request.getParameter("oNum");
			json = pm.getAjaxOrderDetail(orderDetailList);
		}else if(cmd.equals("/showMemberInfo")) {
			System.out.println("showMemberInfo 서블릿 체크");
			String userName = request.getParameter("data");
			json = pm.getAjaxShowUserInfo(userName);
		}else if(cmd.equals("/showProductInfo")) {
			System.out.println("showProductInfo 서블릿 체크");
			String productCode = request.getParameter("data");
			json = pm.getAjaxShowProductInfo(productCode);
		}else if(cmd.equals("/showUserProInfo")) {
			System.out.println("showUserProInfo 서블릿 체크");
			String userId = request.getParameter("id");
			String productCode = request.getParameter("code");
			System.out.println("유저 : " +  userId + " 코드  : " +  productCode);
			json = pm.getAjaxshowUserProInfo(userId, productCode);
			
		}
		
		
		
		if(json!=null) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.write(json);
		}
		
	}
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}


	

}
