package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.google.gson.Gson;

import bean.Product;

public class ProductDao {

	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;

	public ProductDao() {
		con = JdbcUtil.getConnection();
	}

	public void close() {
		JdbcUtil.close(rs, pstmt, con);
	}

	public boolean insertProduct(Product product) {
		String sql = "INSERT INTO P(P_CODE, P_ID, P_NAME, P_PRICE,"
				+ "P_QTY, P_CONTENTS, P_DATE, P_ORIFILENAME, P_SYSFILENAME) "
				+ " VALUES(?||P_SEQ.NEXTVAL,?,?,?,?,?,DEFAULT,?,?)";
		
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setNString(1, product.getP_kind());
				pstmt.setNString(2, product.getP_id());
				pstmt.setNString(3, product.getP_name());
				pstmt.setInt(4, product.getP_price());
				pstmt.setInt(5, product.getP_qty());
				pstmt.setNString(6, product.getP_contents());
				pstmt.setNString(7, product.getP_oriFileName());
				pstmt.setNString(8, product.getP_sysFileName());
				
				int result = pstmt.executeUpdate();
				if(result == 0) {
					System.out.println("INSERT 실패");
					return false;
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			System.out.println("INSERT 성공");
			return true;
	}

	public List<Product> getItemList(String kind) {
		
		String sql = "SELECT * FROM PRODUCT WHERE P_CODE LIKE '%'||?||'%'";  // like 쓸때 주의하자
		
		try {
			System.out.println("kind : " + kind);
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, kind);
			
			rs=pstmt.executeQuery();
			List<Product> pList = new ArrayList<Product>();
			
			while(rs.next()) {
				Product product = new Product();
				product.setP_code(rs.getNString("P_CODE"));
				product.setP_sysFileName(rs.getNString("P_SYSFILENAME"));
				pList.add(product);
			}
			return pList;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		
		return null;
	}

	public List<Product> getShowInfo(String codeNum) {
		
		String sql = "SELECT * FROM PRODUCT WHERE P_CODE=?";  // like 쓸때 주의하자
		System.out.println(sql);
		try {
			System.out.println("쿼리시작codeNum : " + codeNum);
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, codeNum);
			
			rs=pstmt.executeQuery();
			List<Product> pList = new ArrayList<Product>();
			
			while(rs.next()) {
				Product product = new Product();
				product.setP_code(rs.getNString("P_CODE"));
				product.setP_id(rs.getNString("P_ID"));
				product.setP_name(rs.getNString("P_NAME"));
				product.setP_price(rs.getInt("P_PRICE"));
				product.setP_qty(rs.getInt("P_QTY"));
				product.setP_contents(rs.getNString("P_CONTENTS"));
				product.setP_date(rs.getDate("P_DATE"));
				product.setP_oriFileName(rs.getNString("P_ORIFILENAME"));
				product.setP_sysFileName(rs.getNString("P_SYSFILENAME"));
				
				
				
				pList.add(product);
			}
			return pList;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		
		
		
		return null;
	}
	
	
	//cart DB에 넣기
	public boolean insertProduct(String id, String cartcode, String cartcount) {
		System.out.println("점검시작 있는지 없는지 유무");
		String CartCheckCnt=null;
		// 있는지 없는 지 보기 
		System.out.println("id : " + id);
		System.out.println("cartcode : " + cartcode);

		
		String sql = "SELECT C_CNT FROM CART WHERE C_ID=? and C_CODE=?";
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setNString(1, id);
			pstmt.setNString(2, cartcode);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				CartCheckCnt=rs.getNString("C_CNT");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		
		
		if(CartCheckCnt!=null) {  // 있으니깐 업데이트 문
			//UPDATE EMP01 SET HIREDATE = SYSDATE, SAL=50, COMM=4000 WHERE ENAME='SCOTT';
			System.out.println("있을경우 업데이트");
			String total = Integer.toString(Integer.parseInt(cartcount)+Integer.parseInt(CartCheckCnt));
			
			String sql1 = "UPDATE CART SET C_CNT=? WHERE C_ID=? and C_CODE=?";
			
			try {
				pstmt = con.prepareStatement(sql1);
		
				pstmt.setNString(1, total);
				pstmt.setNString(2, id);
				pstmt.setNString(3, cartcode);
				
				
				int result = pstmt.executeUpdate();
				if(result == 0) {
					System.out.println("업데이트 실패");
					return false;
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			System.out.println("INSERT 성공");
			return true;
			
			
		}else{ // 인서트 문
			System.out.println("없을경우 인서트");
			String sql2 = "INSERT INTO CART VALUES(?,?,?)";
			
			try {
				pstmt = con.prepareStatement(sql2);
				pstmt.setNString(1, id);
				pstmt.setNString(2, cartcount);
				pstmt.setNString(3, cartcode);
				
				
				int result = pstmt.executeUpdate();
				if(result == 0) {
					System.out.println("INSERT 실패");
					return false;
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			System.out.println("INSERT 성공");
			return true;
		
		}
		
		
		
		
	}

	// 해당 id의 카트를 찾아서 hashMap에 담기
	public ArrayList<HashMap<String, String>> showCart(String id) {
		
		System.out.println("id : " +  id);
		//SELECT c.c_id, c.c_code, p.p_price, c.c_cnt,   c.c_cnt*p.p_price as tot FROM CART C, PRODUCT P  WHERE p.p_code = c.c_code and C_CODE='new45';
		
		String sql = "SELECT c.c_id, c.c_code, p.p_price, c.c_cnt, c.c_cnt*p.p_price as tot FROM CART C, PRODUCT P  WHERE p.p_code = c.c_code and C_ID = ?";
		
		
		ArrayList<HashMap<String,String>> result = new ArrayList<HashMap<String,String>>();

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, id);
			rs=pstmt.executeQuery();
			
			
			while(rs.next()) {
				HashMap<String,String> cartgoods = new HashMap<String, String>();
				cartgoods.put("ID", rs.getNString("C_ID"));
				cartgoods.put("CODE", rs.getNString("C_CODE"));
				cartgoods.put("PRICE", rs.getNString("P_PRICE"));
				cartgoods.put("CNT", rs.getNString("C_CNT"));
				cartgoods.put("TOTAL", rs.getNString("TOT"));
				result.add(cartgoods);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return result;
	}

	public boolean cartTableDel(String id, String code) {
		
		String sql = "DELETE FROM CART WHERE C_ID=? AND C_CODE=?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, id);
			pstmt.setNString(2, code);
			
			int result = pstmt.executeUpdate();
			
			if(result!=0) {
				System.out.println("카트 삭제 성공");
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("카트 삭제 실패");
		return false;
	}
	
	
	
	public int orderTotalMoney(String id, String P_CODE, String P_CNT) {
		int total = 0;//더해질 친구
		
		String CODE = P_CODE;
		System.out.println("id : " +id +" P_CODE : " + P_CODE + " P_CNT : " + P_CNT);
		int CNT = Integer.parseInt(P_CNT);
		
		//총 가격이 필요함. 
		String sql = "SELECT P_PRICE FROM PRODUCT WHERE P_CODE= ? ";
	
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, CODE);
			rs = pstmt.executeQuery();
			while(rs.next()) {
			System.out.println("돈돈돈 ");
			System.out.println(rs.getInt("P_PRICE"));
			total += CNT*rs.getInt("P_PRICE");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(" 각 금액 : " + total);
		
		
		return total;
	}

	public String orderlistAdd(String id, int total, ArrayList<ArrayList<String>> dlist) {
		
		//num, name, total, time

		//INSERT INTO ORDERLIST VALUES('ha'||O_SEQ.NEXTVAL, 'ha', '3000', SYSDATE);
		String sql = "INSERT INTO ORDERLIST VALUES(?||O_SEQ.NEXTVAL, ?, ?, SYSDATE)";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, id);
			pstmt.setNString(2, id);
			pstmt.setInt(3, total);
			int result = pstmt.executeUpdate();
			if(result!=0) {
				System.out.println("성공");
				
				String sql1 = "SELECT * FROM (SELECT * FROM ORDERLIST WHERE O_NAME = ? "
						+ "ORDER BY O_TIEM DESC) WHERE ROWNUM = 1";
				
				pstmt = con.prepareStatement(sql1);
				pstmt.setNString(1, id);
				rs = pstmt.executeQuery();
				String orderNum=null;
				while(rs.next()) {
					System.out.println(rs.getNString("O_NUM"));
					orderNum = rs.getNString("O_NUM");
				}
				System.out.println("추가된 주문번호 : " + orderNum);
				return orderNum;
			
			
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("실패");
		return null;
	}

	//디테일 order에 추가
	public void detailOrderListAdd(String id, String orderNum, String P_CODE, String P_CNT) {
		
		String sql = "INSERT INTO DETAILORDER VALUES(?,?,?,?,?) ";
		
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, orderNum);
			pstmt.setNString(2, id);
			pstmt.setNString(3, P_CODE);
			pstmt.setNString(4, P_CNT);
			pstmt.setNString(5, "구매");
			
			int result = pstmt.executeUpdate();
			
			if(result!=0) {
				System.out.println("오더 디테일 인서트 성공");
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

	public ArrayList<ArrayList<String>> showOrderList(String id) {
		
		ArrayList<ArrayList<String>> DO = new ArrayList<ArrayList<String>>();
		
		String sql = "SELECT * FROM ORDERLIST WHERE O_NAME = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, id);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ArrayList<String> i = new ArrayList<String>();
				i.add(rs.getNString("O_NUM"));
				i.add(rs.getNString("O_NAME"));
				i.add(rs.getNString("O_TOTAL"));
				i.add(rs.getNString("O_TIEM"));
				DO.add(i);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return DO;
	}
	
	//detail order list select 
	public ArrayList<ArrayList<String>> getOrderDetailList(String orderDetailList) {
		System.out.println("주문번호 : " +  orderDetailList);
		
		String sql = "SELECT * FROM DETAILORDER WHERE OD_NUM = ? ";
		
		ArrayList<ArrayList<String>> odl = new ArrayList<ArrayList<String>>();
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, orderDetailList);
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				ArrayList<String> detail = new ArrayList<String>();
				
				detail.add(rs.getNString("OD_NUM"));
				detail.add(rs.getNString("OD_NAME"));
				detail.add(rs.getNString("OD_CODE"));
				detail.add(rs.getNString("OD_CNT"));
				detail.add(rs.getNString("OD_STU"));
				
				odl.add(detail);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return odl;
	}

	public ArrayList<ArrayList<String>> getUserInfo(String userName) {
		
		System.out.println("유어이름 : " +  userName);
		
		String sql = "SELECT * FROM MEMBER WHERE ID = ? ";
		
		ArrayList<ArrayList<String>> uil = new ArrayList<ArrayList<String>>();
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, userName);
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				ArrayList<String> detail = new ArrayList<String>();
				detail.add(rs.getNString("ID"));
				detail.add(rs.getNString("NAME"));
				detail.add(rs.getNString("GENDER"));
				uil.add(detail);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		
		return uil;
	}

	public ArrayList<ArrayList<String>> getProInfo(String productCode) {

		System.out.println("상품코드  : " +  productCode);
		
		String sql = "SELECT P_NAME, P_PRICE, P_CONTENTS, P_SYSFILENAME, P_CODE  FROM PRODUCT WHERE P_CODE = ? ";
		
		ArrayList<ArrayList<String>> pil = new ArrayList<ArrayList<String>>();
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, productCode);
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				ArrayList<String> detail = new ArrayList<String>();
				detail.add(rs.getNString("P_NAME"));
				detail.add(rs.getNString("P_PRICE"));
				detail.add(rs.getNString("P_CONTENTS"));
				detail.add(rs.getNString("P_SYSFILENAME"));
				detail.add(rs.getNString("P_CODE"));
				pil.add(detail);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return pil;
	}

	public ArrayList<ArrayList<String>> getUserProInfo(String userId, String productCode) {
		
		ArrayList<ArrayList<String>> list = new ArrayList<ArrayList<String>>();
		String sql = "select m.id, m.name, m.gender, p.p_name, p.p_price, p.p_qty, p.p_contents, p.p_sysfilename, p.p_code, d.od_cnt, d.od_cnt*p.p_price as total from Product p , MEMBER m, DETAILORDER d where p.p_CODE = d.OD_CODE and m.id = d.OD_NAME AND d.OD_CODE=? and d.OD_NAME = ?";
		System.out.println(userId+" ? "+productCode);
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, productCode);
			pstmt.setNString(2, userId);
			rs=pstmt.executeQuery();
			System.out.println("rr?");
			while(rs.next()) {
				ArrayList<String> innerList = new ArrayList<String>();
				innerList.add(rs.getNString("ID"));
				innerList.add(rs.getNString("NAME"));
				innerList.add(rs.getNString("GENDER"));
				innerList.add(rs.getNString("P_NAME"));
				innerList.add(rs.getNString("P_PRICE"));
				innerList.add(rs.getNString("P_QTY"));
				innerList.add(rs.getNString("P_CONTENTS"));
				innerList.add(rs.getNString("P_SYSFILENAME"));
				innerList.add(rs.getNString("OD_CNT"));
				innerList.add(rs.getNString("TOTAL"));
				list.add(innerList);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return list;
	}

	public void productStockUpdate(String code, String cnt) {
		int oCnt = Integer.parseInt(cnt);
		System.out.println("code : "+code + " cnt : " + oCnt);
		String sql = "UPDATE PRODUCT SET P_QTY=P_QTY-? WHERE P_CODE=?";
		
		try {
			
			pstmt= con.prepareStatement(sql);
			pstmt.setInt(1, oCnt);
			pstmt.setNString(2, code);
			
			int result = pstmt.executeUpdate();
			if(result != 0 ) {
				System.out.println("재고수량성공");
			}else {
				System.out.println("재고수량실패");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	}

	public String  getDuplicateID(String iD) {
		
		System.out.println("iD : "+iD);
		String sql = "SELECT * FROM MEMBER WHERE ID = ? ";
		String result = "";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, iD);
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				result = rs.getNString("ID");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
					
		return result;
	}

	public int registerSQ(String id) {
		
		int result = 0;
		String sql = "INSERT INTO REGISTHOUSE (H_RGNUM, H_ID) VALUeS(REGI_SQ.NEXTVAL, ?)";
		System.out.println("번호 등록@@@@@@@@@@2");
		try {
			
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, id);
			result = pstmt.executeUpdate();
			
			if(result != 0 ) {
				System.out.println("성공");
			}else {
				System.out.println("실패");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String sql1 = "SELECT REGI_SQ.CURRVAL FROM DUAL";
		
		System.out.println("번호 보여주기@@@@@@@@@@2");
		try {
			pstmt = con.prepareStatement(sql1);
		
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				result = rs.getInt("CURRVAL");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
					
		
		return result;
	
		
	}

	public void registerHouse(String reginum, String id, String housetype, String attendance, String address, String addressDetail,
			String realFileName, String parkarea, String roomscnt, String bathcnt, String bedcnt, String toiletcnt,
			String picscollect, String mindate, String maxdate, int oneprice, String y, String x) {
		
		//String sql = "INSERT INTO REGISTHOUSE VALUSE(REGI_SQ.CURRVAL,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		String sql = "update REGISTHOUSE " + 
				"set H_TYPE = ?," + 
				"    H_MAINPIC = ?," + 
				"    H_ATTENDANCE = ?," + 
				"    H_ADDRESS = ?," + 
				"    H_DETAILADD = ?," + 
				"    H_PARKABLE = ?," + 
				"    H_ROOMS = ?," + 
				"    H_BATHROOMS = ?," + 
				"    H_BEDROOMS = ?," + 
				"    H_TOLILET = ?," + 
				"    H_DETAILPICS = ?," + 
				"    H_CHECKIN = ?," + 
				"    H_CHECKOUT = ?," + 
				"    H_ONEPRICE = ?," +  
				"    X = ?," +  
				"    Y = ?" + 
				"    WHERE H_RGNUM = ? and H_ID = ?";
		try {
			
			pstmt= con.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(housetype));//
			pstmt.setNString(2, realFileName);//
			pstmt.setInt(3, Integer.parseInt(attendance));
			pstmt.setNString(4, address);
			pstmt.setNString(5, addressDetail);
			pstmt.setInt(6, Integer.parseInt(parkarea));
			pstmt.setInt(7, Integer.parseInt(roomscnt));
			pstmt.setInt(8, Integer.parseInt(bathcnt));
			pstmt.setInt(9, Integer.parseInt(bedcnt));
			pstmt.setInt(10, Integer.parseInt(toiletcnt));
			pstmt.setNString(11, picscollect);
			pstmt.setNString(12, mindate);
			pstmt.setNString(13, maxdate);
			pstmt.setInt(14, oneprice);
			
			pstmt.setFloat(15, Float.parseFloat(x));
			pstmt.setFloat(16, Float.parseFloat(y));
			
			pstmt.setInt(17, Integer.parseInt(reginum));
			pstmt.setNString(18, id);
			
			int result = pstmt.executeUpdate();
			
			
			if(result != 0 ) {
				System.out.println("하우스등록성공");
			}else {
				System.out.println("하우스등록실패");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
				
		
	}

	

	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//--------------------예상--------------------------------------------------------	
	
	public String searchHouse(String destination, String checkin, String checkout, String person) { //---메인에서 검색함
		String sql= "SELECT * FROM REGISTHOUSE WHERE H_ADDRESS LIKE '%'||?||'%' AND H_CHECKIN <=? AND H_CHECKOUT >= ? AND H_ATTENDANCE >= ? AND H_CHECK=1";
				
		 
		ArrayList<ArrayList<HashMap<String,String>>> List = new ArrayList<ArrayList<HashMap<String,String>>>();
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1,destination);
			pstmt.setNString(2,checkin);
			pstmt.setNString(3,checkout);
			pstmt.setNString(4,person);
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				ArrayList<HashMap<String,String>> seardetail = new ArrayList<HashMap<String,String>>();
				HashMap<String,String>  innerH = new HashMap<String,String>();
				
				innerH.put("H_MAINPIC", rs.getNString("H_MAINPIC"));
				innerH.put("H_RGNUM",rs.getNString("H_RGNUM"));
				innerH.put("H_ADDRESS", rs.getNString("H_ADDRESS"));
				innerH.put("H_DETAILADD", rs.getNString("H_DETAILADD"));
				innerH.put("H_ROOMS", rs.getNString("H_ROOMS"));
				innerH.put("H_TOLILET", rs.getNString("H_TOLILET"));
				innerH.put("H_ONEPRICE", rs.getNString("H_ONEPRICE"));
				
				seardetail.add(innerH); 
				List.add(seardetail);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// TODO Auto-generated method stub
		
		Gson gs = new Gson();
		
		String result = gs.toJson(List); 
		
		System.out.println(result);
		
		return result;
	} //메인 검색 끝
	
	
	
	

	public String searchHouse(String destination) { //---검색창 에서 검색함
		String sql= "SELECT * FROM REGISTHOUSE WHERE H_ADDRESS LIKE '%'||?||'%' AND H_CHECK=1";
				
		
		ArrayList<ArrayList<HashMap<String,String>>> List = new ArrayList<ArrayList<HashMap<String,String>>>();
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1,destination);
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				ArrayList<HashMap<String,String>> seardetail = new ArrayList<HashMap<String,String>>();
				HashMap<String,String>  innerH = new HashMap<String,String>();
				innerH.put("H_MAINPIC", rs.getNString("H_MAINPIC"));
				innerH.put("H_RGNUM",rs.getNString("H_RGNUM"));
				innerH.put("H_ADDRESS", rs.getNString("H_ADDRESS"));
				innerH.put("H_ROOMS", rs.getNString("H_ROOMS"));
				innerH.put("H_TOLILET", rs.getNString("H_TOLILET"));
				innerH.put("H_ONEPRICE", rs.getNString("H_ONEPRICE"));
				
				seardetail.add(innerH); 
				List.add(seardetail);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// TODO Auto-generated method stub
		
		Gson gs = new Gson();
		
		String result = gs.toJson(List); 
		
		System.out.println(result);
		
		return result;
	}//검색창에서 검색 끝 

	
	
	
	public String adminH() { //-- 호스트 집 업로드 승인 
		String sql= "SELECT * FROM REGISTHOUSE WHERE H_CHECK = 0";
		
		ArrayList<ArrayList<HashMap<String,String>>> houseup = new ArrayList<ArrayList<HashMap<String,String>>>();
		
		try {
			pstmt = con.prepareStatement(sql);
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				ArrayList<HashMap<String,String>> houseInfo = new ArrayList<HashMap<String,String>>();
				
				HashMap<String,String>  innerH = new HashMap<String,String>();
				innerH.put("H_RGNUM",rs.getNString("H_RGNUM"));
				innerH.put("H_ID",rs.getNString("H_ID"));
				innerH.put("H_MAINPIC",rs.getNString("H_MAINPIC"));
				innerH.put("H_ATTENDANCE", rs.getNString("H_ATTENDANCE"));
				innerH.put("H_ADDRESS", rs.getNString("H_ADDRESS"));
				innerH.put("H_DETAILADD", rs.getNString("H_DETAILADD"));
				innerH.put("H_PARKABLE", rs.getNString("H_PARKABLE"));
				innerH.put("H_ROOMS", rs.getNString("H_ROOMS"));
				innerH.put("H_BATHROOMS", rs.getNString("H_BATHROOMS"));
				innerH.put("H_BEDROOMS", rs.getNString("H_BEDROOMS"));
				innerH.put("H_TOLILET", rs.getNString("H_TOLILET"));

				
				houseInfo.add(innerH); 
				houseup.add(houseInfo);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// TODO Auto-generated method stub
		
		Gson gs = new Gson();
		
		String HU = gs.toJson(houseup); 
		
		System.out.println(HU);
		
		return HU;
	}// 관리자 집 업로드 승인 끝
	

	
	public void req(ArrayList<String> app) { // 관리자 집 승인  AJAX 
		String sql= "";
		if(app.get(1).equals("승인")){
			 sql += "UPDATE REGISTHOUSE SET H_CHECK =1 WHERE H_RGNUM =?";
		}else {
			 sql += "UPDATE REGISTHOUSE SET H_CHECK =2 WHERE H_RGNUM =?";
		}	
		int result = 0;
		
		System.out.println(sql);
		System.out.println(app);
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, app.get(0));
			
			result = pstmt.executeUpdate();
			
			System.out.println("UPDATE test result : " + result);
			if(result==0) {//실패
				System.out.println("승인실패");
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("승인성공");
		
		
		
		}// 관리자 집 승인  AJAX 끝

	
	
	
	
		public String hostH(String id) {//호스트가 요청한 집 게시물 등록현황
			String sql= "SELECT * FROM REGISTHOUSE WHERE H_ID=? AND H_CHECK = 0";
			
			ArrayList<ArrayList<HashMap<String,String>>> houseup = new ArrayList<ArrayList<HashMap<String,String>>>();
			
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setNString(1,id);
				rs= pstmt.executeQuery();
				
				while(rs.next()) {
					ArrayList<HashMap<String,String>> myhouseinfo = new ArrayList<HashMap<String,String>>();
					
					HashMap<String,String>  innerH = new HashMap<String,String>();
					innerH.put("H_RGNUM",rs.getNString("H_RGNUM"));
					innerH.put("H_MAINPIC",rs.getNString("H_MAINPIC"));
					innerH.put("H_ATTENDANCE", rs.getNString("H_ATTENDANCE"));
					innerH.put("H_ADDRESS", rs.getNString("H_ADDRESS"));
					innerH.put("H_PARKABLE", rs.getNString("H_PARKABLE"));
					innerH.put("H_ROOMS", rs.getNString("H_ROOMS"));
					innerH.put("H_BATHROOMS", rs.getNString("H_BATHROOMS"));
					innerH.put("H_BEDROOMS", rs.getNString("H_BEDROOMS"));
					innerH.put("H_TOLILET", rs.getNString("H_TOLILET"));

					
					myhouseinfo.add(innerH); 
					houseup.add(myhouseinfo);
					
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			// TODO Auto-generated method stub
			
			Gson gs = new Gson();
			
			String hostH = gs.toJson(houseup); 
			
			System.out.println(hostH);
			
			return hostH;
	
	}


		public String hostHL(String id) { //호스트 보유 집 리스트
			String sql= "SELECT * FROM REGISTHOUSE WHERE H_ID=? AND H_CHECK = 1";
			
			ArrayList<ArrayList<HashMap<String,String>>> houseup = new ArrayList<ArrayList<HashMap<String,String>>>();
			
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setNString(1,id);
				rs= pstmt.executeQuery();
				
				while(rs.next()) {
					ArrayList<HashMap<String,String>> myhouseinfo = new ArrayList<HashMap<String,String>>();
					
					HashMap<String,String>  innerH = new HashMap<String,String>();
					innerH.put("H_RGNUM",rs.getNString("H_RGNUM"));
					innerH.put("H_MAINPIC",rs.getNString("H_MAINPIC"));
					innerH.put("H_DETAILADD", rs.getNString("H_DETAILADD"));
					innerH.put("H_ADDRESS", rs.getNString("H_ADDRESS"));

					myhouseinfo.add(innerH); 
					houseup.add(myhouseinfo);
					
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			// TODO Auto-generated method stub
			
			Gson gs = new Gson();
			
			String hostHL = gs.toJson(houseup); 
			
			System.out.println(hostHL);
			
			return hostHL;
	
	}
	
		
		public String searchLike(String loginID) {
			
			String sql= "SELECT * FROM LIKETABLE WHERE L_ID = ?";

			HashMap<String,Integer> likelist =new HashMap<String, Integer>();	
			
			
			
				try {
					pstmt = con.prepareStatement(sql);
					pstmt.setNString(1,loginID);
					
					rs= pstmt.executeQuery();
					
					while(rs.next()) {
						likelist.put(rs.getNString("L_H_RGNUM"), rs.getInt("L_TYPE"));
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				Gson gs = new Gson();
				
				
				String reserlist = gs.toJson(likelist); 
				
				System.out.println(reserlist);
				
				return reserlist;
				
				
		}

	
	
		public String reservlist(String id) {
			
			String sql="SELECT R_PERSON, H_MAINPIC,R_RGNUM, R_GUESTID,R_CHECKIN,R_CHECKOUT,R_TOTALPRICE FROM RESERVATION R ,REGISTHOUSE H WHERE  R.R_H_RGNUM=H.H_RGNUM AND R_HOSTID=?AND R_TYPE=0";
			
			ArrayList<ArrayList<HashMap<String,String>>> reL = new ArrayList<ArrayList<HashMap<String,String>>>();
			
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setNString(1,id);
				rs= pstmt.executeQuery();
				
				while(rs.next()) {
					ArrayList<HashMap<String,String>> reserL = new ArrayList<HashMap<String,String>>();
					
					HashMap<String,String>  innerH = new HashMap<String,String>();
					innerH.put("H_MAINPIC",rs.getNString("H_MAINPIC"));
					innerH.put("R_RGNUM",rs.getNString("R_RGNUM"));
					innerH.put("R_GUESTID",rs.getNString("R_GUESTID"));
					innerH.put("R_PERSON",rs.getNString("R_PERSON"));
					innerH.put("R_CHECKIN",rs.getNString("R_CHECKIN"));
					innerH.put("R_CHECKOUT",rs.getNString("R_CHECKOUT"));
					innerH.put("R_TOTALPRICE",rs.getNString("R_TOTALPRICE"));
					
					
					reserL.add(innerH); 
					reL.add(reserL);
					
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			// TODO Auto-generated method stub
			
			Gson gs = new Gson();
			
		
			String reserlist = gs.toJson(reL); 
			
			System.out.println(reserlist);
			
			return reserlist;
	
	}
		
		

		public void reserlist(ArrayList<String> ap) {// 호스트 예약 승인
			//[1, 승인]
			String sql= "";
			if(ap.get(1).equals("승인")){
				 sql += "UPDATE RESERVATION SET R_TYPE =1 WHERE R_RGNUM =?";
			}else {
				 sql += "UPDATE RESERVATION SET R_TYPE =2 WHERE R_RGNUM =?";
			}	
			int result = 0;
			
			System.out.println(sql);
			System.out.println(ap);
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1,Integer.parseInt(ap.get(0)));
				
				result = pstmt.executeUpdate();
				
				System.out.println("UPDATE test result : " + result);
				
				if(result==0) {//실패
					System.out.println("승인실패123");
					
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			
			}// 호스트 예약 승인  AJAX 끝
		
		

		public String checkoutlist(String id) { // 체크아웃 리스트 가져옴
			String sql="SELECT * FROM RESERVATION WHERE R_CHECKOUT<=SYSDATE AND R_HOSTID=? AND R_GREVIEW=0";
			
			ArrayList<ArrayList<HashMap<String,String>>> checkList = new ArrayList<ArrayList<HashMap<String,String>>>();
			
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setNString(1,id);
				rs= pstmt.executeQuery();
				
				while(rs.next()) {
					ArrayList<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();
					
					HashMap<String,String>  innerH = new HashMap<String,String>();
					innerH.put("R_RGNUM",rs.getNString("R_RGNUM"));
					innerH.put("R_GUESTID",rs.getNString("R_GUESTID"));
					innerH.put("R_CHECKIN",rs.getNString("R_CHECKIN"));
					innerH.put("R_CHECKOUT",rs.getNString("R_CHECKOUT"));
					innerH.put("R_PERSON",rs.getNString("R_PERSON"));
					
					
					list.add(innerH); 
					checkList.add(list);
					
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			// TODO Auto-generated method stub
			
			Gson gs = new Gson();
			
			String checkoutlist = gs.toJson(checkList); 
			
			System.out.println(checkoutlist);
			
			return checkoutlist;
			
	}
	
		public int hostreview(String id, String contents, String score, String rgnum) {
			String sql = "INSERT INTO HOSTREVIEW VALUES(HRV_SEQ.NEXTVAL,?,?,sysdate,?,?)";
			int result = 0; 
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setNString(1,rgnum);
				pstmt.setNString(2,id);
				pstmt.setNString(3,contents);
				pstmt.setNString(4,score);
				result= pstmt.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return result; 
		}
	
	
		

		public String tophouse() { // 후기 많은 숙소 3건 노출 
			String sql="SELECT B.rcnt, A.H_MAINPIC, A.H_RGNUM, A.H_ADDRESS, A.H_DETAILADD FROM REGISTHOUSE A," + 
					"(SELECT COUNT(*) AS rcnt, RH.H_RGNUM AS t FROM GUESTREVIEW G, RESERVATION RV,REGISTHOUSE RH WHERE G.GRV_R_GRNUM = RV.R_RGNUM AND RV.R_H_RGNUM=RH.H_RGNUM GROUP BY RH.H_RGNUM) B WHERE B.t =  A.H_RGNUM  AND ROWNUM <=3 ORDER BY B.rcnt desc";
			
			ArrayList<ArrayList<HashMap<String,String>>> houselist = new ArrayList<ArrayList<HashMap<String,String>>>();
			
			try {
				pstmt = con.prepareStatement(sql);
				rs= pstmt.executeQuery();
				
				while(rs.next()) {
					ArrayList<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();
					
					HashMap<String,String>  innerH = new HashMap<String,String>();
					innerH.put("H_MAINPIC",rs.getNString("H_MAINPIC"));
					innerH.put("H_RGNUM",rs.getNString("H_RGNUM"));
					innerH.put("H_ADDRESS",rs.getNString("H_ADDRESS"));
					innerH.put("H_DETAILADD",rs.getNString("H_DETAILADD"));
					innerH.put("H_cont",rs.getNString("rcnt"));
					
					
					list.add(innerH); 
					houselist.add(list);
					
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			// TODO Auto-generated method stub
			
			Gson gs = new Gson();
			
			String tophouselist = gs.toJson(houselist); 
			
			System.out.println(tophouselist);
			
			return tophouselist;
			
	}
	
		
		
		

		public String topstar() {
			String sql="SELECT  B.rcnt, A.H_MAINPIC, A.H_RGNUM, A.H_ADDRESS, A.H_DETAILADD FROM REGISTHOUSE A," + 
					"(SELECT  ROUND(AVG(GRV_SCORE),1) AS rcnt, RH.H_RGNUM t FROM GUESTREVIEW G, RESERVATION RV,REGISTHOUSE RH WHERE G.GRV_R_GRNUM = RV.R_RGNUM AND RV.R_H_RGNUM=RH.H_RGNUM GROUP BY RH.H_RGNUM) B WHERE B.t =  A.H_RGNUM AND ROWNUM <=3 ORDER BY B.rcnt desc";
			
			ArrayList<ArrayList<HashMap<String,String>>> topsList = new ArrayList<ArrayList<HashMap<String,String>>>();
			
			try {
				pstmt = con.prepareStatement(sql);
				rs= pstmt.executeQuery();
				
				while(rs.next()) {
					ArrayList<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();
					
					HashMap<String,String>  innerH = new HashMap<String,String>();
					innerH.put("H_MAINPIC",rs.getNString("H_MAINPIC"));
					innerH.put("H_RGNUM",rs.getNString("H_RGNUM"));
					innerH.put("H_ADDRESS",rs.getNString("H_ADDRESS"));
					innerH.put("H_DETAILADD",rs.getNString("H_DETAILADD"));
					innerH.put("GRV_SCORE",rs.getNString("rcnt"));
					
					
					list.add(innerH); 
					topsList.add(list);
					
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			// TODO Auto-generated method stub
			
			Gson gs = new Gson();
			
			String topstarlist = gs.toJson(topsList); 
			
			System.out.println(topstarlist);
			
			return topstarlist;
			
	}


		public String reviewdetail() {
			
			String sql="SELECT * FROM GUESTREVIEW";
			
			ArrayList<ArrayList<HashMap<String,String>>> topsList = new ArrayList<ArrayList<HashMap<String,String>>>();
			
			try {
				pstmt = con.prepareStatement(sql);
				rs= pstmt.executeQuery();
				
				while(rs.next()) {
					ArrayList<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();
					
					HashMap<String,String>  innerH = new HashMap<String,String>();
					innerH.put("H_MAINPIC",rs.getNString("H_MAINPIC"));
					innerH.put("H_RGNUM",rs.getNString("H_RGNUM"));
					innerH.put("H_ADDRESS",rs.getNString("H_ADDRESS"));
					innerH.put("H_DETAILADD",rs.getNString("H_DETAILADD"));
					innerH.put("GRV_SCORE",rs.getNString("rcnt"));
					
					
					list.add(innerH); 
					topsList.add(list);
					
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			// TODO Auto-generated method stub
			
			Gson gs = new Gson();
			
			String topstarlist = gs.toJson(topsList); 
			
			System.out.println(topstarlist);
			
			return topstarlist;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
	
	
	
	
//평민호----------------------------------------------------------------------------------------------------------------------------------------------------
	
	public String detailregiinfo(String id) {

		String sql= "SELECT * FROM REGISTHOUSE WHERE H_RGNUM = ?";

		ArrayList<ArrayList<HashMap<String,String>>> detailregiinfo = new ArrayList<ArrayList<HashMap<String,String>>>();	
		
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1,id);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				ArrayList<HashMap<String,String>> seardetail = new ArrayList<HashMap<String,String>>();
				
				HashMap<String,String>  innerH = new HashMap<String,String>();
				innerH.put("H_RGNUM", rs.getNString("H_RGNUM"));
				innerH.put("H_MAINPIC",rs.getNString("H_MAINPIC"));
				innerH.put("H_ATTENDANCE", rs.getNString("H_ATTENDANCE"));
				innerH.put("H_ADDRESS", rs.getNString("H_ADDRESS"));
				innerH.put("H_DETAILADD", rs.getNString("H_DETAILADD"));
				innerH.put("H_PARKABLE", rs.getNString("H_PARKABLE"));
				innerH.put("H_ROOMS", rs.getNString("H_ROOMS"));
				innerH.put("H_BATHROOMS", rs.getNString("H_BATHROOMS"));
				innerH.put("H_BEDROOMS", rs.getNString("H_BEDROOMS"));
				innerH.put("H_TOLILET", rs.getNString("H_TOLILET"));
				innerH.put("H_DETAILPICS", rs.getNString("H_DETAILPICS"));
				innerH.put("H_CHECKIN", rs.getNString("H_CHECKIN"));
				innerH.put("H_CHECKOUT", rs.getNString("H_CHECKOUT"));
				innerH.put("H_ONEPRICE", rs.getNString("H_ONEPRICE"));
				
				seardetail.add(innerH); 
				detailregiinfo.add(seardetail);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// TODO Auto-generated method stub
		
		Gson gs = new Gson();
		
		String result = gs.toJson(detailregiinfo); 
		
		System.out.println(result);
		
		return result;
	}

	public int reservation(String regnum, String guestid, String hostid, String sdate, String edate, String tperson, String tprice) {
		int result = 0;
			
		String sql = "INSERT INTO RESERVATION VALUES(RESER_SQ.NEXTVAL,?,?,?,?,?,?,0,?,0,0)";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,Integer.parseInt(regnum));
			pstmt.setNString(2,guestid);
			pstmt.setNString(3,hostid);
			pstmt.setNString(4,sdate);
			pstmt.setNString(5,edate);
			pstmt.setInt(6,Integer.parseInt(tperson));
			pstmt.setInt(7,Integer.parseInt(tprice));
			
			result = pstmt.executeUpdate();
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
			
		return result;
	}

	public String adminP() {
		String sql= "SELECT * FROM REGISTHOUSE WHERE H_CHECK = 1 OR H_CHECK = 2 ";
		
		ArrayList<ArrayList<HashMap<String,String>>> houseup = new ArrayList<ArrayList<HashMap<String,String>>>();
		
		try {
			pstmt = con.prepareStatement(sql);
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				ArrayList<HashMap<String,String>> houseInfo = new ArrayList<HashMap<String,String>>();
				
				HashMap<String,String>  innerH = new HashMap<String,String>();
				innerH.put("H_RGNUM",rs.getNString("H_RGNUM"));
				innerH.put("H_ID",rs.getNString("H_ID"));
				innerH.put("H_MAINPIC",rs.getNString("H_MAINPIC"));
				innerH.put("H_ATTENDANCE", rs.getNString("H_ATTENDANCE"));
				innerH.put("H_ADDRESS", rs.getNString("H_ADDRESS"));
				innerH.put("H_DETAILADD", rs.getNString("H_DETAILADD"));
				innerH.put("H_PARKABLE", rs.getNString("H_PARKABLE"));
				innerH.put("H_ROOMS", rs.getNString("H_ROOMS"));
				innerH.put("H_BATHROOMS", rs.getNString("H_BATHROOMS"));
				innerH.put("H_BEDROOMS", rs.getNString("H_BEDROOMS"));
				innerH.put("H_TOLILET", rs.getNString("H_TOLILET"));
				innerH.put("H_CHECK", rs.getNString("H_CHECK"));

				
				houseInfo.add(innerH); 
				houseup.add(houseInfo);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// TODO Auto-generated method stub
		
		Gson gs = new Gson();
		
		String HU = gs.toJson(houseup); 
		
		System.out.println(HU);
		
		return HU;
	}

	
	
	public String showlikereviewcnt() {
		
		String sql= "SELECT B.ravg  , B.rcnt, A.H_RGNUM FROM REGISTHOUSE A," + 
		        "(SELECT  ROUND(AVG(GRV_SCORE),1) ravg, COUNT(*) rcnt, RH.H_RGNUM t FROM GUESTREVIEW G, RESERVATION RV,REGISTHOUSE RH WHERE G.GRV_R_GRNUM = RV.R_RGNUM AND RV.R_H_RGNUM=RH.H_RGNUM GROUP BY RH.H_RGNUM) B WHERE B.t =  A.H_RGNUM ";
		 
		ArrayList<ArrayList<HashMap<String,String>>> List = new ArrayList<ArrayList<HashMap<String,String>>>();
		
		try {
			pstmt = con.prepareStatement(sql);
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				ArrayList<HashMap<String,String>> seardetail = new ArrayList<HashMap<String,String>>();
				HashMap<String,String>  innerH = new HashMap<String,String>();
				
				innerH.put("RAVG", rs.getNString("RAVG"));
				innerH.put("RCNT",rs.getNString("RCNT"));
				innerH.put("H_RGNUM", rs.getNString("H_RGNUM"));
				
				
				seardetail.add(innerH); 
				List.add(seardetail);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// TODO Auto-generated method stub
		
		Gson gs = new Gson();
		
		String result = gs.toJson(List); 
		
		System.out.println(result);
		
		return result;
	} //메인 검색 끝

	
	
	
	

	

	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
