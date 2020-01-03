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
