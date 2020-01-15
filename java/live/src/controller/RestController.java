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



@WebServlet({ "/duplicateID","/changeprofilepic","/inputreple","/inputrreple","/showrreple" ,"/changeSearch","/houseupload","/requestlist", "/cancelroom","/hostreview"})

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
		
		}else if (cmd.equals("/inputreple")) { //URL이 넘어와서 이 곳이 시작된다
			System.out.println("댓글저장중"); //넘어왔나 확인
			String Reple=request.getParameter("reple"); //Reple변수에 ajax에서 result를 담은 reple 변수를 담는다
			System.out.println(Reple); //Reple에 잘 담겼나 확인을 한다 
			
			Gson gs = new Gson(); //Gson은  json스트링을 객체로 변형해서 자동으로 셋해준다
			ArrayList<String> mList= new ArrayList<String>(); //데이터를 담을 어레이리스트 mList변수 //어레이 리스트 안에 리스트를 또 넣어서 여러개의 데이터를 한번에 해결하기위해서 
			
			mList = gs.fromJson(Reple, new TypeToken<ArrayList<String>>() { 
			}.getType()); //
			for(int i=0; i<mList.size();i++) { //for 문을 돌려서 안에 들어있는 값을 순서대로 확인
				System.out.println(mList.get(i));// i번째로 넣어서 다 출력	
			}
			
			json=mm.inputreple(mList); // 인풋리플 리턴값을 제이슨에 담았다 outreple값이 담겨있다
		
			 
			 
			 
			 
		
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
		}else if (cmd.equals("/requestlist")){
			System.out.println("업로드 승인");
			json = pm.getAjaxrequestlist();

		}else if (cmd.equals("/cancelroom")) {
			System.out.println("예약취소중");
			String cancel=request.getParameter("cancel");
			json = mm.cancelroom(cancel);
		}else if (cmd.equals("/hostreview")) {
			System.out.println("호스트가 남긴 게스트 별점");
			String starscore=request.getParameter("data");
			json = pm.getAjaxstarscore(starscore);
		}
		
		
		
		
		
		if (json != null) { 
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.write(json); //서블릿 언어 여기서 석세스로 쏴준다
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
