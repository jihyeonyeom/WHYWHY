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
	
	public int login(String userID, String userPassword) { // 로그인
		String SQL = "SELECT userPassword FROM user WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				}
				else
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디가 없음
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
	
	public int join(User user) { // 회원가입
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
		return -1; // 데이터베이스 오류
	}
	
	public User profileView(User user, String sessionID) { // 로그인 된 회원의 정보 불러오기
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
	
	public int profileChange(User user, String userID, String userPassword) { // 로그인 된 회원의 정보 수정
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
					return pstmt2.executeUpdate(); // 비밀번호 일치
				}
				else
					return 0; // 비밀번호 불일치
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
