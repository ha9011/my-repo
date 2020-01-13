package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonParseException;
import com.google.gson.reflect.TypeToken;

import service.MemberMM;
import service.ProductMM;



@WebServlet({ "/duplicateID","/changeprofilepic","/inputreple","/inputrreple","/showrreple" ,"/changeSearch","/houseupload"})

public class RestController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String cmd = request.getServletPath();
		System.out.println("rest CMD : " + cmd);

		MemberMM mm = new MemberMM(request, response);
		ProductMM pm = new ProductMM(
				request, response);

		String json = null;

		if (cmd.equals("/duplicateID")) {

			String ID = request.getParameter("data");
			System.out.println("==data== : " + ID);
			json = mm.getAjaxduplicateID(ID);

		}else if (cmd.equals("/changeprofilepic")){
			System.out.println("sadsadsa");
			String ID = request.getParameter("data");
			System.out.println("==data== : " + ID);
			//json = mm.getAjaxchangepropic(ID);
		
		}else if (cmd.equals("/inputreple")) {
			System.out.println("댓글저장중");
			String Reple=request.getParameter("reple");
			System.out.println(Reple);
			
			Gson gs = new Gson();
			ArrayList<String> mList= new ArrayList<String>();
			mList = gs.fromJson(Reple, new TypeToken<ArrayList<String>>() {
			}.getType());
			for(int i=0; i<mList.size();i++) {
				System.out.println(mList.get(i));	
			}
			 json=mm.inputreple(mList);
		
		
		}else if (cmd.equals("/changeSearch")){
			System.out.println("검색어 변경");
			json = pm.getAjaxchangeSearch();
		
		}else if (cmd.equals("/inputrreple")) {
			String RReple=request.getParameter("rreple");
			System.out.println(RReple);
			Gson gs = new Gson();
			ArrayList<String> mList= new ArrayList<String>();
			mList = gs.fromJson(RReple, new TypeToken<ArrayList<String>>() {
			}.getType());
			for(int i=0; i<mList.size();i++) {
				System.out.println(mList.get(i));	
			}
			json = pm.inputrreple(mList);
		}else if (cmd.equals("/showrreple")) {
			String replenum=request.getParameter("replenum");
			
			json = pm.showrreple(replenum);
		}else if (cmd.equals("/houseupload")){
			System.out.println("업로드 승인");
			json = pm.getAjaxhouseupload();
		}
		
		
		
		
		
		
		
		if (json != null) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.write(json);
		}
		

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

}
