package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
	
	

	

}
