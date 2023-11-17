package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CommentDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public CommentDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/WHYWHY";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() { // ���� ��¥ ��������
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //�����ͺ��̽� ����
	}
	
	public int getNext() { // 1�� �ڵ� ����
		String SQL = "SELECT cmtNum FROM comment ORDER BY cmtNum DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // ù ��° �Խù��� ���
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public int write(String cmtContent, String userID, int cmtParent, int partyNum) { // ���, ��� �ۼ�
		String SQL = "INSERT INTO comment VALUES(?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, getDate());
			pstmt.setString(3, cmtContent);
			pstmt.setInt(4, cmtParent);
			pstmt.setInt(5, 1);
			pstmt.setInt(6, partyNum);
			pstmt.setString(7, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public int update(int cmtNum, String cmtContent) { // ��� ����
		String SQL = "UPDATE comment SET cmtContent = ? WHERE cmtNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, cmtContent);
			pstmt.setInt(2, cmtNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public int delete(int cmtNum, int cmtParent) { // ��� ����
		String SQL = "UPDATE comment SET cmtAction = 0 WHERE cmtNum = ? OR cmtParent = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, cmtNum);
			pstmt.setInt(2, cmtParent);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public Comment getCmt(int partyNum) { // ��� �ϳ� �ҷ�����
		String SQL = "SELECT * FROM comment WHERE partyNum = ? AND cmtAction = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, partyNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Comment cmt = new Comment();
				cmt.setCmtNum(rs.getInt(1));
				cmt.setCmtDate(rs.getString(2));
				cmt.setCmtContent(rs.getString(3));
				cmt.setCmtParent(rs.getInt(4));
				cmt.setCmtAction(rs.getInt(5));
				cmt.setPartyNum(rs.getInt(6));
				cmt.setUserID(rs.getString(7));
				return cmt;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ArrayList<Comment> getList(int partyNum) { // ��ü ��� �ҷ�����
		String SQL = "SELECT * FROM comment WHERE partyNum = ? AND cmtAction = 1 AND cmtParent = 0 ORDER BY cmtNum DESC";
		ArrayList<Comment> list = new ArrayList<Comment>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, partyNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Comment cmt = new Comment();
				cmt.setCmtNum(rs.getInt(1));
				cmt.setCmtDate(rs.getString(2));
				cmt.setCmtContent(rs.getString(3));
				cmt.setCmtParent(rs.getInt(4));
				cmt.setCmtAction(rs.getInt(5));
				cmt.setPartyNum(rs.getInt(6));
				cmt.setUserID(rs.getString(7));
				list.add(cmt);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Comment> getCommentList(int partyNum, int cmtNum) { // �亯 ��� �ҷ�����
		String SQL = "SELECT * FROM comment WHERE partyNum = ? AND cmtAction = 1 AND cmtParent = ? ORDER BY cmtNum DESC";
		ArrayList<Comment> list = new ArrayList<Comment>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, partyNum);
			pstmt.setInt(2, cmtNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Comment cmt = new Comment();
				cmt.setCmtNum(rs.getInt(1));
				cmt.setCmtDate(rs.getString(2));
				cmt.setCmtContent(rs.getString(3));
				cmt.setCmtParent(rs.getInt(4));
				cmt.setCmtAction(rs.getInt(5));
				cmt.setPartyNum(rs.getInt(6));
				cmt.setUserID(rs.getString(7));
				list.add(cmt);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}


