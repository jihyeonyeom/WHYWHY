package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private PreparedStatement pstmt2;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/WHYWHY";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) { // �α���
		String SQL = "SELECT userPassword FROM user WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // �α��� ����
				}
				else
					return 0; // ��й�ȣ ����ġ
			}
			return -1; // ���̵� ����
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; // �����ͺ��̽� ����
	}
	
	public int join(User user) { // ȸ������
		String SQL = "INSERT INTO user VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setDate(4, user.stringToDate());
			pstmt.setString(5, user.getUserPhone());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public User profileView(User user, String sessionID) { // �α��� �� ȸ���� ���� �ҷ�����
		String SQL = "SELECT * FROM user WHERE userID = ?";
		String userID = sessionID;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			User userProfile = null;
			if(rs.next()) {
				String birthday = rs.getDate("userBirth").toString();
				String year = birthday.substring(0, 4);
				String month = birthday.substring(5, 7);
				String day = birthday.substring(8, 10);
		
				userProfile = new User();
				userProfile.setUserID(rs.getString("userID"));
				userProfile.setUserName(rs.getString("userName"));
				userProfile.setUserBirthyy(year);
				userProfile.setUserBirthmm(month);
				userProfile.setUserBirthdd(day);
				userProfile.setUserPhone(rs.getString("userPhone"));
				return userProfile;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} 
		return user;
	}
	
	public int profileChange(User user, String userID, String userPassword) { // �α��� �� ȸ���� ���� ����
		String SQL = "SELECT userPassword FROM user WHERE userID = ?";
		String Query = "UPDATE user SET userName = ?, userBirth = ?, userPhone = ? WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);	
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					pstmt2 = conn.prepareStatement(Query);
					pstmt2.setString(1, user.getUserName());
					pstmt2.setDate(2, user.stringToDate());
					pstmt2.setString(3, user.getUserPhone());
					pstmt2.setString(4, userID);
					return pstmt2.executeUpdate(); // ��й�ȣ ��ġ
				}
				else
					return 0; // ��й�ȣ ����ġ
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
}
