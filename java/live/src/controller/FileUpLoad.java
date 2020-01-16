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

@WebServlet({"/registHouse","/registHouseDetail","/registHousechdate","/profileupdate", "/registGuestReview"})
public class FileUpLoad extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String cmd=request.getServletPath();
		Forward fw = null;
		MemberMM mm  = new MemberMM(request, response);
		ProductMM pm = new ProductMM(request, response);
		FileServiceMM fs = new FileServiceMM(request, response);
		

		if(cmd.equals("/registHouse")){
			System.out.println("집등록 1단계 접근");
			fw = fs.executefirst();
		}else if(cmd.equals("/registHouseDetail")){
			System.out.println("집등록 2단계 접근");
			fw = fs.executesecond();
		}else if(cmd.equals("/registHousechdate")) { //집 마지막 데이터
			System.out.println("집등록 3단계 접근");
			fw=fs.registHousechdate();
		}else if(cmd.equals("/profileupdate")) { //집 마지막 데이터
			System.out.println("프로필변경");
			fw=fs.updateprofile();
		}else if(cmd.equals("/registGuestReview")) { // 게스트 -> 리뷰 -> 사진 등록
			System.out.println("게스트 수정");
			fw=fs.updateguestreview();
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
