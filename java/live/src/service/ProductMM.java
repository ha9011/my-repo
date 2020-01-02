package service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import bean.Forward;
import bean.Product;
import dao.ProductDao;

public class ProductMM {
	HttpServletRequest request;
	HttpServletResponse response;
	Forward fw = null;
	public ProductMM(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	public Forward insertProduct() {
		HttpSession session = request.getSession();
		
		String uploadPath = request.getRealPath("./upload");
		System.out.println("path=" + uploadPath);
		File dir = new File(uploadPath);
		if(dir.exists()) {  //존재 할 경우
			
		}else { //존재 하지 않을 경우, 
			dir.mkdir();  // mkdirs; 부모폴더까지 생성
		}
		
		int size = 10*1024*1024;
		try {
			MultipartRequest multi = new MultipartRequest(request, uploadPath,size,"utf-8", new DefaultFileRenamePolicy());
			String kind = multi.getParameter("p_kind"); //new or best
			System.out.println("==========p_kind======== : "+ kind);
			String name = multi.getParameter("p_name"); 
			int price = Integer.parseInt(multi.getParameter("p_price")); 
			int qty = Integer.parseInt(multi.getParameter("p_qty")); 
			String contents = multi.getParameter("p_contents"); 
			String oriFileName = multi.getOriginalFileName("p_file");
			String sysFileName = multi.getFilesystemName("p_file");
			
			Product product = new Product();
			product.setP_id(session.getAttribute("id").toString());
			product.setP_kind(kind);
			product.setP_name(name);
			product.setP_qty(qty);
			product.setP_contents(contents);
			product.setP_price(price);
			product.setP_oriFileName(oriFileName);
			product.setP_sysFileName(sysFileName);
			
			ProductDao pDao = new ProductDao();
			boolean result = pDao.insertProduct(product);
			
			if(result) {  //pDao.insertProduct(product)
				System.out.println("상품등록 성공");
			}else {
				System.out.println("상품등록 실패");
			}
			
			//신상품등록 후엔 신상품페이지로
			//인기상품등록후엔 인기상품페이지로...
			if(kind.equals("new")) {
				//session
				session.setAttribute("page", "newItem");
			}else {//"best"
				session.setAttribute("page", "bestItem");
			}
			
			pDao.close();
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	
		Forward fw = new Forward();
		fw.setPath("./index.jsp");
		fw.setRedireact(true);
		return fw;
		
		
	}

	public Forward getItemList(String kind) {
		//로그인 한 경우만 리스트를 볼 수 있다면...
		
		//세션이 널이니깐 로그인 전에는 main에 초기화면이 나오는 것
//		if(request.getSession().getAttribute("id")==null) {
//			Forward fw = new Forward();
//			fw.setPath("./");
//			fw.setRedireact(true);
//			return fw;
//		}
//		
		
		ProductDao pDao = new ProductDao();
		List<Product> pList = null;
		pList=pDao.getItemList(kind);
		pDao.close();

		Gson gs = new Gson();
		String pListHtml = gs.toJson(pList);
		System.out.println("====");
		System.out.println("===gson=== "+pListHtml);
		request.setAttribute("pListHtml", pListHtml);
		
// 		make Stringbuilder 방법
//		if(pList!=null && pList.size()!=0) {
//			String pListHtml=makeHtml_pList(pList);
//			request.setAttribute("pListHtml", pListHtml);
//		}
//		
		Forward fw = new Forward();
		fw.setPath("./main.jsp");
		fw.setRedireact(false);
		return fw;
	}

	// LIST 추가
	private String makeHtml_pList(List<Product> pList) {
		StringBuilder sb = new StringBuilder();
	
		for(Product p : pList) {
			sb.append("<div>");
			sb.append("<img src='upload/"+p.getP_sysFileName() +"' width='100'>");
			sb.append("</div>");
		}
		return sb.toString();
	}

	public Forward showDetailInfo(String codeNum) {
		// TODO Auto-generated method stub
		ProductDao pDao = new ProductDao();
		List<Product> pList = null;
		pList=pDao.getShowInfo(codeNum);
		pDao.close();
		
		Gson gs = new Gson();
		String showinfo = gs.toJson(pList);
		System.out.println("====");
		System.out.println("===showinfo=== "+showinfo);
		
		request.setAttribute("showinfo", showinfo);
		
		Forward fw = new Forward();
		fw.setPath("./ProductShow.jsp");
		fw.setRedireact(false);
		return fw;
	}

	public String getAjaxDetail(String pCode) {
		
		ProductDao pDao = new ProductDao();
		List<Product> pList = null;
		pList=pDao.getShowInfo(pCode);
		pDao.close();
		
		Gson gs = new Gson();
		String showinfo = gs.toJson(pList);
		
		
		
		return showinfo;
	}

	
	
	//장바구니에 담기 (1.있는지 없는지 체크 -> 2(1).있으면 업데이트 2(2).없으면 인서트)
	public Forward insertCart(String cartcode, String cartcount) {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		System.out.println("접속 아이디 : " + id);
		ProductDao pDao = new ProductDao();
		boolean result = pDao.insertProduct(id, cartcode, cartcount);
		
		if(result) {
			System.out.println("카트인서트 성공");
		}else {
			System.out.println("카트인서트 실패");
		}
		
		Forward fw = new Forward();
		fw.setPath("./index.jsp");
		fw.setRedireact(true);
		return fw;
	}

	public Forward showCart() {
		//관리자 유무
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		System.out.println("접속 아이디 확인 : " + id);
		ProductDao pDao = new ProductDao();
		
		ArrayList<HashMap<String,String>> pMap = null;
		
		if(id.equals("admin")) { // 관리자 일경우
			pMap = pDao.showCart(id);
		}else { // 일반 유저일 경우
			
			pMap = pDao.showCart(id);
			
		}
		
		Gson gs = new Gson();
		String a = gs.toJson(pMap);
		
		request.setAttribute("showcart", a);
		
		Forward fw = new Forward();
		fw.setPath("./showcart.jsp");
		fw.setRedireact(false);
		return fw;
	}

	public String getAjaxDelete(ArrayList<ArrayList<String>> dlist) {
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		ProductDao pDao = new ProductDao();
		boolean resultDel = false;
		
		// 1. 일단 지우고 
		for(ArrayList<String> a : dlist) {
			//System.out.println("asdasd : "+a.get(1));
			resultDel = pDao.cartTableDel(id, a.get(1)); //아이디, 상품
		}
		
		
		//지워졌으면
		if(resultDel) {
			System.out.println("지워졌으니 다시 보여주기");
			List<HashMap<String, String>> pList = null;
			pList=pDao.showCart(id);
			pDao.close();
			
			Gson gs = new Gson();
			String showinfo = gs.toJson(pList);
			return showinfo;
		}else {
			return null;
		}
		
		
	}

	public String getAjaxOrderAddCartDel(ArrayList<ArrayList<String>> dlist) {
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		ProductDao pDao = new ProductDao();
		String orderNum = null; // 인서트하고 난 후 주문번호담기
		
		//일단 추가 하기 [new45, 7]
		int total = 0;
		
		for(ArrayList<String> a : dlist) {
			//각 돈 총합하는 친구
			total+= pDao.orderTotalMoney(id, a.get(1), a.get(0)); //상품명, 상품갯수
		}
		
		System.out.println("총 total " + total);
		
		/////////////////orderlist에 추가//////////////
		
		orderNum = pDao.orderlistAdd(id, total, dlist);
		
		//////////////////////////////////////////////////////
		
		//insert가 됬으면...
		if(orderNum != null) {
			
			//디테일 한 곳에 넣기
			//일단 추가 하기 [new45, 7]
			for(ArrayList<String> a : dlist) {
				pDao.detailOrderListAdd(id, orderNum, a.get(1), a.get(0)); //상품명, 상품갯수
			}
			
			//db에 재고 업데이트하기
			for(ArrayList<String> a : dlist) {
				pDao.productStockUpdate(a.get(1), a.get(0)); //상품명, 상품갯수
				
			}
			
			
			return getAjaxDelete(dlist);
	
		}else { //실패했으면
			
			
			return null;
		}
		
		
	}

	
	//주문내역 보기
	public Forward showOrder() {
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		ProductDao pDao = new ProductDao();
		
		ArrayList<ArrayList<String>> oList = null;
		oList = pDao.showOrderList(id);
		
		Gson gs = new Gson();
		String json = gs.toJson(oList);
		System.out.println("데이터 확인");
		System.out.println(json);
		request.setAttribute("orderlist", json);
		
		Forward fw = new Forward();
		fw.setPath("./orderlist.jsp");
		fw.setRedireact(false);
		return fw;
	}

	public String getAjaxOrderDetail(String cartDelList) {
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		ProductDao pDao = new ProductDao();
		
		ArrayList<ArrayList<String>> resultList = null;
		resultList = pDao.getOrderDetailList(cartDelList);
		
		Gson gs = new Gson();
		String json = gs.toJson(resultList);
		System.out.println("데이터 확인");
		System.out.println(json);
		
		
		return json;
	}

	public String getAjaxShowUserInfo(String userName) {
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		ProductDao pDao = new ProductDao();
		
		ArrayList<ArrayList<String>> resultList = null;
		resultList = pDao.getUserInfo(userName);
		
		Gson gs = new Gson();
		String json = gs.toJson(resultList);
		System.out.println("유저 정보 확인 확인");
		System.out.println(json);
		
		return json;
	}

	public String getAjaxShowProductInfo(String productCode) {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		ProductDao pDao = new ProductDao();
		
		ArrayList<ArrayList<String>> resultList = null;
		resultList = pDao.getProInfo(productCode);
		
		Gson gs = new Gson();
		String json = gs.toJson(resultList);
		System.out.println("상품 정보 확인 확인");
		System.out.println(json);
		
		return json;
	}

	
	//
	public String getAjaxshowUserProInfo(String userId, String productCode) {
		
		ProductDao pDao = new ProductDao();
		ArrayList<ArrayList<String>> resultList = null;
		resultList = pDao.getUserProInfo(userId, productCode);
		
		Gson gs = new Gson();
		String json = gs.toJson(resultList);
		System.out.println("상품 정보 확인 확인");
		System.out.println(json);
		
		return json;
	}
	
	
}
