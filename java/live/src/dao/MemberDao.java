package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;

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

	public boolean join(String id, String pw, String name, String phonenum, String email, String gest, String gender) {// 게스트 , 성별
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
			if(result==0) {//실패
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
					result = 1; // 모두일치
				} else {
					result = 0; // 비번불일치
				}
			} else {
				result = -1; // 비번 불일치
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
			pstmt=con.prepareStatement(sql);
			pstmt.setNString(1, name);
			pstmt.setNString(2, email);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
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
		String pw ="";
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setNString(1, name);
			pstmt.setNString(2, email);
			pstmt.setNString(3, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				pw = rs.getNString("PW"); // 미정
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return pw;
	} 
	
	
	///////////////////////////하동원 구역
	
	public String  getDuplicateID(String iD) {
		
		System.out.println("iD : "+iD);
		String sql = "SELECT * FROM MEMBER WHERE ID = ? "; //아이디 뽑아오는 쿼리문
		String result = "없음"; 
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, iD);
			rs= pstmt.executeQuery();
			
			while(rs.next()) { //아이디가 있으면 리설트를 아이디를 넣어준다
				result = rs.getNString("ID");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result; //리설트 값을 리턴 
	}
























	//////////////민호 구역






























	///////////////////////예상 구역

}
