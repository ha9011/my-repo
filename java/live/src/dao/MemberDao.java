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

	public int access(String id, String pw) {
		String sql = "SELECT * FROM MEMBER WHERE ID=?";
		int result=-1;
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setNString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getNString("PW").equals(pw)) {
					result=1; //모두일치
				}else {
					result=0; //비번불일치
				}
			}else {
				result=-1; //비번 불일치
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
				id = rs.getNString("PW"); // 미정
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return pw;
	} 
	


}
