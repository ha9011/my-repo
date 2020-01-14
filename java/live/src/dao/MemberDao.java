package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;

import com.google.gson.Gson;

import bean.Forward;

public class MemberDao {
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;

	public MemberDao() {
		con = JdbcUtil.getConnection();
	}

	public void close() {
		JdbcUtil.close(rs, pstmt, con);
	}

	public boolean join(String id, String pw, String name, String phonenum, String email, String gest, String gender) {// 게스트
																														// ,
																														// 성별
		String sql = "insert into MEMBER values(?,?,?,?,?,?,default,?)";
		int result = 0;
		try {

			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, id);
			pstmt.setNString(2, pw);
			pstmt.setInt(3, Integer.parseInt(gender));
			pstmt.setNString(4, name);
			pstmt.setNString(5, email);
			pstmt.setNString(6, phonenum);

			pstmt.setInt(7, Integer.parseInt(gest));

			result = pstmt.executeUpdate();
			System.out.println("insert test result : " + result);
			if (result == 0) {// 실패
				System.out.println("회원가입 실패");
				return false;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("회원가입 성공");
		return true;
	}

	public int access(String id, String pw) {
		String sql = "SELECT * FROM MEMBER WHERE ID=?";
		int result = -1;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getNString("PW").equals(pw)) {

					result = Integer.parseInt(rs.getNString("TYPE")); // 모두일치
				} else {
					result = -1; // 비번불일치
				}
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}

	// DB에서 아이디 찾음
	public String findId(String name, String email) {

		String sql = "SELECT * FROM MEMBER WHERE NAME=? AND EMAIL=? ";
		String id = "";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, name);
			pstmt.setNString(2, email);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				id = rs.getNString("ID"); // 미정

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return id;
	}

	// DB에서 비밀번호 찾음
	public String findPw(String id, String email, String name) {
		String sql = "SELECT * FROM MEMBER WHERE NAME=? AND EMAIL=? AND ID=? ";
		String pw = "";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, name);
			pstmt.setNString(2, email);
			pstmt.setNString(3, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pw = rs.getNString("PW"); // 미정

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return pw;
	}

	/// ------------------////////////////////////하동원
	/// 구역-----------------------------------------------------------------------------

	public String getDuplicateID(String iD) {

		System.out.println("iD : " + iD);
		String sql = "SELECT * FROM MEMBER WHERE ID = ? "; // 아이디 뽑아오는 쿼리문
		String result = "없음";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, iD);
			rs = pstmt.executeQuery();

			while (rs.next()) { // 아이디가 있으면 리설트를 아이디를 넣어준다
				result = rs.getNString("ID");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result; // 리설트 값을 리턴
	}

	public String findHostId(String detailId) {

		System.out.println("detailId : " + detailId);

		String sql = "SELECT H_ID FROM REGISTHOUSE WHERE H_RGNUM = ? "; // 아이디 뽑아오는 쿼리문
		String result = "없음";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, detailId);
			rs = pstmt.executeQuery();

			while (rs.next()) { // 아이디가 있으면 리설트를 아이디를 넣어준다
				result = rs.getNString("H_ID");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result; // 리설트 값을 리턴

	}

	public int existChLike(ArrayList<String> likearr) { // 아이디 존재 유무
		// ["0","아이디","68"]

		int result = 0;

		String sql = "SELECT count(*) cnt FROM LIKETABLE WHERE L_H_RGNUM=? and  L_ID=?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, likearr.get(2));
			pstmt.setNString(2, likearr.get(1));

			rs = pstmt.executeQuery();

			while (rs.next()) {
				result = rs.getInt("cnt");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}

	public int insertLike(ArrayList<String> likearr) {
		// ["0","아이디","68"]
		String sql = "insert into LIKETABLE values(?,?,?)";
		int result = 0;
		try {

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(likearr.get(2)));
			pstmt.setNString(2, likearr.get(1));
			pstmt.setInt(3, Integer.parseInt(likearr.get(0)));

			result = pstmt.executeUpdate();
			System.out.println("insert test result : " + result);

			if (result == 0) {// 실패
				System.out.println("insert 실패");
				return result;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.println("insert 성공");
		return result;

	}

	
	public int updateLike(ArrayList<String> likearr) {
		// ["0","아이디","68"]
		String sql = "UPDATE LIKETABLE SET L_TYPE =? WHERE L_H_RGNUM = ? and L_ID = ?";
		
		int result = 0;
		try {

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(likearr.get(0)));
			pstmt.setInt(2, Integer.parseInt(likearr.get(2)));
			pstmt.setNString(3, likearr.get(1));
			
			result = pstmt.executeUpdate();
			System.out.println("UPDATE test result : " + result);

			if (result == 0) {// 실패
				System.out.println("UPDATE 실패");
				return result;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.println("UPDATE 성공");
		return result;

	}

	
	public String checkReserDate(String detailId) {
		
		String sql = "SELECT * FROM RESERVATION where R_H_RGNUM=? AND R_TYPE = 1"; // 시퀀스로 댓글번호,아이디 ,시간,댓글내용,비밀글,방번호

		ArrayList<ArrayList<String>> mList = new ArrayList<ArrayList<String>>();
        //[ [in1, out1], [in2, out2] ]
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, detailId);
			rs = pstmt.executeQuery();

			while (rs.next()) { // 아이디가 있으면 리설트를 아이디를 넣어준다
				ArrayList<String> mList1 = new ArrayList<String>();

				mList1.add(rs.getNString("R_CHECKIN"));
				mList1.add(rs.getNString("R_CHECKOUT"));

				mList.add(mList1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		Gson gs = new Gson();

		String result = gs.toJson(mList);

		System.out.println(result);

		return result; // 리설트 값을 리

	}
		
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// ------------////////////민호
	// 구역------------------------------------------------------------------------------------------------------------

	public int inputreple(ArrayList<String> mList) {

		String sql = "INSERT INTO REPLE VALUES(RP_SEQ.NEXTVAL,?,SYSDATE,?,?,?)"; // 시퀀스로 댓글번호,아이디 ,시간,댓글내용,비밀글,방번호
		int result = 0;

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, mList.get(2));
			pstmt.setNString(2, mList.get(3));
			pstmt.setNString(3, mList.get(0));
			pstmt.setNString(4, mList.get(1));
			result = pstmt.executeUpdate();

			if (result == 0) {
				System.out.println("댓글저장실패");
			} else {
				System.out.println("댓글저장성공");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result; // 리설트 값을 리

	}

	public String outreple(String string) {
		String sql = "SELECT * FROM reple where RP_RGNUM=?"; // 시퀀스로 댓글번호,아이디 ,시간,댓글내용,비밀글,방번호

		ArrayList<ArrayList<HashMap<String, String>>> mList = new ArrayList<ArrayList<HashMap<String, String>>>();

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, string);
			rs = pstmt.executeQuery();

			while (rs.next()) { // 아이디가 있으면 리설트를 아이디를 넣어준다
				ArrayList<HashMap<String, String>> mList1 = new ArrayList<HashMap<String, String>>();

				HashMap<String, String> innerH = new HashMap<String, String>();

				innerH.put("RP_NUM", rs.getNString("RP_NUM"));
				innerH.put("RP_ID", rs.getNString("RP_ID"));
				innerH.put("RP_TIME", rs.getNString("RP_TIME"));
				innerH.put("RP_CONTENT", rs.getNString("RP_CONTENT"));
				innerH.put("RP_TYPE", rs.getNString("RP_TYPE"));
				innerH.put("RP_RGNUM", rs.getNString("RP_RGNUM"));

				mList1.add(innerH);
				mList.add(mList1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		Gson gs = new Gson();

		String result = gs.toJson(mList);

		System.out.println(result);

		return result; // 리설트 값을 리

	}

	public int inrreple(ArrayList<String> mList, String id) {
		String sql = "INSERT INTO RREPLE VALUES(RRP_SEQ.NEXTVAL,?,?,SYSDATE,?)";
		int result = 0;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, mList.get(1));
			pstmt.setNString(2, id);
			pstmt.setNString(3, mList.get(0));
			result = pstmt.executeUpdate();

			if (result == 0) {
				System.out.println("댓글저장실패");
			} else {
				System.out.println("댓글저장성공");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}

	public String inrreple(String string) {
		String sql = "SELECT * FROM rreple where RRP_RP_NUM=?";
		System.out.println();
		ArrayList<ArrayList<HashMap<String, String>>> mList = new ArrayList<ArrayList<HashMap<String, String>>>();

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, string);

			rs = pstmt.executeQuery();
			while (rs.next()) { // 아이디가 있으면 리설트를 아이디를 넣어준다
				ArrayList<HashMap<String, String>> mList1 = new ArrayList<HashMap<String, String>>();

				HashMap<String, String> innerH = new HashMap<String, String>();

				innerH.put("RRP_NUM", rs.getNString("RRP_NUM"));
				innerH.put("RRP_RP_NUM", rs.getNString("RRP_RP_NUM"));
				innerH.put("RRP_ID", rs.getNString("RRP_ID"));
				innerH.put("RRP_TIME", rs.getNString("RRP_TIME"));
				innerH.put("RRP_CONTENT", rs.getNString("RRP_CONTENT"));

				mList1.add(innerH);
				mList.add(mList1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Gson gs = new Gson();

		String result = gs.toJson(mList);

		System.out.println(result);

		return result;

	}

//--------------예상-----------------------------------------------------------------------	마이페이지 정보를 뿌려줌
	public String Myinfo(String id) {
		System.out.println("id : " + id);
		String Sql = "SELECT PROFILE, ID, NAME, EMAIL, PHONE FROM MEMBER WHERE ID=?";

		ArrayList<ArrayList<HashMap<String, String>>> List = new ArrayList<ArrayList<HashMap<String, String>>>();

		try {
			pstmt = con.prepareStatement(Sql);
			pstmt.setNString(1, id);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				ArrayList<HashMap<String, String>> info = new ArrayList<HashMap<String, String>>();
				HashMap<String, String> myinfo = new HashMap<String, String>();
				myinfo.put("ID", rs.getNString("ID"));
				myinfo.put("NAME", rs.getNString("NAME"));
				myinfo.put("EMAIL", rs.getNString("EMAIL"));
				myinfo.put("PHONE", rs.getNString("PHONE"));
				myinfo.put("PROFILE", rs.getNString("PROFILE"));

				info.add(myinfo);
				List.add(info);

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Gson gs = new Gson();

		String result = gs.toJson(List);

		System.out.println(result);

		return result;
	} // 마이페이지 끝

	public void changepropic(String propic, String id) { // 프로필 사진 변경 및 저장
		String sql = "UPDATE MEMBER SET PROFILE =? WHERE ID = ?";
		int result = 0;
		try {

			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, propic);
			pstmt.setNString(2, id);

			result = pstmt.executeUpdate();
			System.out.println("insert test result : " + result);
			if (result == 0) {// 실패
				System.out.println("프로필 실패");

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("프로필 성공");

	}

	

}// 프로필 사진 변경 및 저장 끝

//--------------------------------------------------------------------------------------------------------------------------
