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

	// ------------////////////민호
	// 구역------------------------------------------------------------------------------------------------------------

	public int inputreple(ArrayList<String> mList) {

		String sql = "INSERT INTO REPLE VALUES(RP_SEQ.NEXTVAL,?,SYSDATE,?,?,?)"; // 시퀀스로 댓글번호,아이디 ,시간,댓글내용,비밀글,방번호
		int result = 0; // 인서트 성공 실패를 판단하기위해 인트 변수

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, mList.get(2));
			pstmt.setNString(2, mList.get(3));
			pstmt.setNString(3, mList.get(0));
			pstmt.setNString(4, mList.get(1)); // sql문 순서에 맞게 엔스트링을 넣어준다
			result = pstmt.executeUpdate(); // sql값을 리설트에 담기

			if (result == 0) { // 댓글 저장 성공 실패 여부 확인 if 문
				System.out.println("댓글저장실패");
			} else {
				System.out.println("댓글저장성공");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result; // 리설트 값을 리턴

	}

	public String outreple(String string) {
		String sql = "SELECT * FROM reple where RP_RGNUM=?"; // 시퀀스로 댓글번호,아이디 ,시간,댓글내용,비밀글,방번호

		ArrayList<ArrayList<HashMap<String, String>>> mList = new ArrayList<ArrayList<HashMap<String, String>>>(); // 데이터
																													// 포장하고

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, string);
			rs = pstmt.executeQuery(); // 결과 값을 rs에 올리고

			while (rs.next()) { // 아이디가 있으면 리설트에 아이디를 넣어준다
				ArrayList<HashMap<String, String>> mList1 = new ArrayList<HashMap<String, String>>(); // 제일 처음 리스트에서 하나
																										// 열어서 넣어주는것
																										// !!데이터 형태 잘
																										// 생각하기

				HashMap<String, String> innerH = new HashMap<String, String>(); // 제일 안쪽에 데이터 형식

				innerH.put("RP_NUM", rs.getNString("RP_NUM")); // 데이터를 (키,데이터) 형태로 넣어주기
				innerH.put("RP_ID", rs.getNString("RP_ID"));
				innerH.put("RP_TIME", rs.getNString("RP_TIME"));
				innerH.put("RP_CONTENT", rs.getNString("RP_CONTENT"));
				innerH.put("RP_TYPE", rs.getNString("RP_TYPE"));
				innerH.put("RP_RGNUM", rs.getNString("RP_RGNUM"));

				mList1.add(innerH); // 제일 안에 데이터를 하나 밖에 넣어주고
				mList.add(mList1); // 그 중간 데이터를 제일 밖에 넣어주고
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		Gson gs = new Gson(); // json으로 받아온걸 자동으로 객체로 전환 하기 위한 gson 오픈

		String result = gs.toJson(mList); // 리설트에 gs.toJson(mList)담기 --->쥐슨으로 제이슨에 엠리스트를 객체로 바꿔서 리설트에 담았다

		System.out.println(result); // 리설트가 잘 넘어왔나 확인하고

		return result; // 리설트 값을 리턴

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

	public String MyReser(String id) {

		String Sql = "SELECT H_MAINPIC,R_RGNUM,R_H_RGNUM,R_HOSTID,R_CHECKIN,R_CHECKOUT,R_PERSON,R_TOTALPRICE,R_TYPE FROM RESERVATION R,REGISTHOUSE H WHERE  R.R_H_RGNUM=H.H_RGNUM AND R_GUESTID=?";

		ArrayList<ArrayList<HashMap<String, String>>> ReserList = new ArrayList<ArrayList<HashMap<String, String>>>();

		try {
			pstmt = con.prepareStatement(Sql);
			pstmt.setNString(1, id);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				ArrayList<HashMap<String, String>> Reservation = new ArrayList<HashMap<String, String>>();
				HashMap<String, String> myreser = new HashMap<String, String>();

				myreser.put("H_MAINPIC", rs.getNString("H_MAINPIC"));
				myreser.put("R_RGNUM", rs.getNString("R_RGNUM"));
				myreser.put("R_H_RGNUM", rs.getNString("R_H_RGNUM"));
				myreser.put("R_HOSTID", rs.getNString("R_HOSTID"));
				myreser.put("R_CHECKIN", rs.getNString("R_CHECKIN"));
				myreser.put("R_CHECKOUT", rs.getNString("R_CHECKOUT"));
				myreser.put("R_PERSON", rs.getNString("R_PERSON"));
				myreser.put("R_TOTALPRICE", rs.getNString("R_TOTALPRICE"));
				myreser.put("R_TYPE", rs.getNString("R_TYPE"));

				Reservation.add(myreser);
				ReserList.add(Reservation);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Gson gs = new Gson();

		String result = gs.toJson(ReserList);
		System.out.println("데이터 담기 오나요");
		System.out.println(result);

		return result;
	}

	public int cancelroom(String cancel) {
		String sql = "UPDATE RESERVATION SET R_TYPE = 2  WHERE R_RGNUM =? ";
		int result = 0;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, cancel);
			result = pstmt.executeUpdate();
			if (result == 0) {
				System.out.println("방취소실패");
			} else {
				System.out.println("방취소성공");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
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
