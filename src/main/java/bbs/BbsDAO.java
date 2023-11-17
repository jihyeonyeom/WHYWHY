package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	private Connection conn;
	private ResultSet rs;
	private ResultSet rs2;

	public BbsDAO() {
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
		}catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //�����ͺ��̽� ����
	}
	
	public int getNext() { // �ڵ����� partyNum 1�� �����ϱ� ���� �޼ҵ�
		String SQL="SELECT partyNum FROM bbs ORDER BY partyNum DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // ù ��° �Խù��� ���
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public int write(String bbsTitle, String userID, String bbsContent, int maxNum, String categoryName,
			String fileName, String fileRealName) { // �Խñ� �ۼ�
		String SQL = "INSERT INTO bbs VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, bbsContent);
			pstmt.setInt(4, maxNum);
			pstmt.setInt(5, 0);
			pstmt.setString(6, getDate());
			pstmt.setInt(7, 1);
			pstmt.setString(8, categoryName);
			pstmt.setString(9, userID);
			pstmt.setString(10, fileName);
			pstmt.setString(11, fileRealName);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public int makeParty(String userID) { // �Խñ� �ۼ� ���� ��� �ۼ��ڸ� ��Ƽ������ ��Ƽ ����
		String SQL = "INSERT INTO party VALUES (?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - 1);
			pstmt.setString(2, userID);
			pstmt.setString(3, "��Ƽ��");
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public ArrayList<Bbs> getList(int pageNumber, String categoryName) { // �Խñ� ��� �ҷ�����
		String SQL = "SELECT * FROM bbs WHERE bbsAction = 1 AND categoryName = ? ORDER BY partyNum DESC";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, categoryName);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setPartyNum(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setBbsContent(rs.getString(3));
				bbs.setMaxNum(rs.getInt(4));
				bbs.setNowNum(rs.getInt(5));
				bbs.setBbsDate(rs.getString(6));
				bbs.setBbsAction(rs.getInt(7));
				bbs.setCategoryName(rs.getString(8));
				bbs.setUserID(rs.getString(9));
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public String getUserName(String userID) { // ���� �г��� �ҷ�����
		String SQL = "SELECT * FROM user WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(3);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int partyJoinCheck(int partyNum, String userID) { // ��Ƽ�忡�� ��Ƽ ���� ��û
		String SQL = "INSERT INTO partyJoinCheck VALUES (?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, partyNum);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public int partyJoinRefuse(int partyNum, String userID) { // ��Ƽ���� ���� AND ��Ƽ���� ���� �� ��û ��Ͽ��� ����
		String SQL = "DELETE FROM partyJoinCheck WHERE partyNum = ? AND userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, partyNum);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	
	public int joinParty(int partyNum, String userID) { // ��Ƽ���� ��Ƽ ���� ����
		String SQL = "INSERT INTO party VALUES (?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, partyNum);
			pstmt.setString(2, userID);
			pstmt.setString(3, "��Ƽ��");
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public int joinParty_two(int partyNum, int nowNum) { // ��Ƽ�� �������� ��� ���� �����ο� 1����
		String SQL = "UPDATE bbs SET nowNum = ? WHERE partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, nowNum + 1);
			pstmt.setInt(2, partyNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public int joinParty_three(int partyNum, int bbsAction) { // �����ο��� ��ã�� �� bbsAction�� 0���� �־ �Խñ� ��Ͽ��� ������
		String SQL = "UPDATE bbs SET bbsAction = ? WHERE partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsAction);
			pstmt.setInt(2, partyNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public ArrayList<Bbs> getPartyList(String userID) { // ���� ��Ƽ ���
		String SQL = "SELECT * FROM bbs WHERE partyNum = ? ORDER BY partyNum DESC";
		String SQL2 = "SELECT partyNum FROM party WHERE userID = ?";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt2 = conn.prepareStatement(SQL2);
			pstmt2.setString(1, userID);
			rs2 = pstmt2.executeQuery();
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			while(rs2.next()) {
				pstmt.setString(1, rs2.getString("partyNum"));
				rs = pstmt.executeQuery();
				Bbs bbs = new Bbs();
				while(rs.next()) {
					bbs.setPartyNum(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setBbsContent(rs.getString(3));
					bbs.setMaxNum(rs.getInt(4));
					bbs.setNowNum(rs.getInt(5));
					bbs.setBbsDate(rs.getString(6));
					bbs.setBbsAction(rs.getInt(7));
					bbs.setCategoryName(rs.getString(8));
					bbs.setUserID(rs.getString(9));
					list.add(bbs);
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Bbs getBbs(int partyNum) { // ��Ƽ��ȣ�� �Խñ� ���� �ҷ�����
		String SQL = "SELECT * FROM bbs WHERE partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, partyNum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setPartyNum(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setBbsContent(rs.getString(3));
				bbs.setMaxNum(rs.getInt(4));
				bbs.setNowNum(rs.getInt(5));
				bbs.setBbsDate(rs.getString(6));
				bbs.setBbsAction(rs.getInt(7));
				bbs.setCategoryName(rs.getString(8));
				bbs.setUserID(rs.getString(9));
				bbs.setFileName(rs.getString(10));
				bbs.setFileRealName(rs.getString(11));
				return bbs;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int partyNum, String bbsTitle, String bbsContent, int maxNum) { // �Խñ� ����
		String SQL = "UPDATE bbs SET bbsTitle = ?, bbsContent = ?, maxNum = ? WHERE partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, maxNum);
			pstmt.setInt(4, partyNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public int updateFile(int partyNum, String bbsTitle, String bbsContent, String fileName, String fileRealName, int maxNum) { // ���� ������ �ִ� ���
		String SQL = "UPDATE bbs SET bbsTitle = ?, bbsContent = ?, maxNum = ?, fileName = ?, fileRealName = ? WHERE partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, maxNum);
			pstmt.setString(4, fileName);
			pstmt.setString(5, fileRealName);
			pstmt.setInt(6, partyNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public int delete(int partyNum) { // �Խñ� ����
		String SQL = "UPDATE bbs SET bbsAction = 0 WHERE partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, partyNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public int delete_two(int partyNum) { // �Խñ� ����
		String SQL = "DELETE FROM party WHERE partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, partyNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public int checkMyParty(String userID, int partyNum) { // ����ڰ� ���Ե� ��Ƽ���� üũ��
		String SQL = "SELECT partyNum FROM party WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				if(partyNum == rs.getInt("partyNum")) {
					return 1; // ���� ��Ƽ�� ���
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // ���� ��Ƽ�� �ƴҽ�
	}
	
	public int partyOut(String userID, int partyNum) { // ��Ƽ Ż��
		String SQL = "DELETE FROM party WHERE userID = ? AND partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, partyNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public int partyOut_two(int partyNum, int nowNum) { // ��Ƽ Ż��� bbs���̺��� �����ο� -1�� �ϰ� ���� ��Ͽ� �������Բ� bbsAction = 1 �� ������ �ٲ���
		String SQL = "UPDATE bbs SET nowNum = ?, bbsAction = 1 WHERE partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, nowNum - 1);
			pstmt.setInt(2, partyNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public ArrayList<Bbs> getMember(int partyNum) { // ��Ƽ�� ��� �ҷ�����
		String SQL = "SELECT * FROM party WHERE partyNum = ? ORDER BY partyLeader DESC";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, partyNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setPartyNum(rs.getInt(1));
				bbs.setUserID(rs.getString(2));
				bbs.setPartyLeader(rs.getString(3));
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Bbs> getWaitMember(int partyNum) { // ��Ƽ ���Խ�û ��� �ҷ�����
		String SQL = "SELECT * FROM partyJoinCheck WHERE partyNum = ?";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, partyNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setPartyNum(rs.getInt(1));
				bbs.setUserID(rs.getString(2));
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int partyDeport(String userID, int partyNum) { // ��Ƽ �߹�
		String SQL = "DELETE FROM party WHERE userID = ? AND partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, partyNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public int partyDeport_two(int partyNum, int nowNum) { // ��Ƽ �߹�� bbs���̺��� �����ο� -1�� �ϰ� ���� ��Ͽ� �������Բ� bbsAction = 1 �� ������ �ٲ���
		String SQL = "UPDATE bbs SET nowNum = ?, bbsAction = 1 WHERE partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, nowNum - 1);
			pstmt.setInt(2, partyNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
}
