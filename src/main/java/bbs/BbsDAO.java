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
	
	public String getDate() { // 현재 날짜 가져오기
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
		return ""; //데이터베이스 오류
	}
	
	public int getNext() { // 자동으로 partyNum 1씩 증가하기 위한 메소드
		String SQL="SELECT partyNum FROM bbs ORDER BY partyNum DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 게시물인 경우
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int write(String bbsTitle, String userID, String bbsContent, int maxNum, String categoryName,
			String fileName, String fileRealName) { // 게시글 작성
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
		return -1; // 데이터베이스 오류
	}
	
	public int makeParty(String userID) { // 게시글 작성 했을 경우 작성자를 파티장으로 파티 생성
		String SQL = "INSERT INTO party VALUES (?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - 1);
			pstmt.setString(2, userID);
			pstmt.setString(3, "파티장");
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<Bbs> getList(int pageNumber, String categoryName) { // 게시글 목록 불러오기
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
	
	public String getUserName(String userID) { // 유저 닉네임 불러오기
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
	
	public int partyJoinCheck(int partyNum, String userID) { // 파티장에게 파티 가입 신청
		String SQL = "INSERT INTO partyJoinCheck VALUES (?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, partyNum);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int partyJoinRefuse(int partyNum, String userID) { // 파티가입 거절 AND 파티가입 수락 시 신청 목록에서 삭제
		String SQL = "DELETE FROM partyJoinCheck WHERE partyNum = ? AND userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, partyNum);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	
	public int joinParty(int partyNum, String userID) { // 파티장이 파티 가입 수락
		String SQL = "INSERT INTO party VALUES (?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, partyNum);
			pstmt.setString(2, userID);
			pstmt.setString(3, "파티원");
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int joinParty_two(int partyNum, int nowNum) { // 파티에 가입했을 경우 모집 현재인원 1증가
		String SQL = "UPDATE bbs SET nowNum = ? WHERE partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, nowNum + 1);
			pstmt.setInt(2, partyNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int joinParty_three(int partyNum, int bbsAction) { // 모집인원이 꽉찾을 시 bbsAction에 0값을 넣어서 게시글 목록에서 내리기
		String SQL = "UPDATE bbs SET bbsAction = ? WHERE partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsAction);
			pstmt.setInt(2, partyNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<Bbs> getPartyList(String userID) { // 가입 파티 목록
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
	
	public Bbs getBbs(int partyNum) { // 파티번호로 게시글 내용 불러오기
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
	
	public int update(int partyNum, String bbsTitle, String bbsContent, int maxNum) { // 게시글 수정
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
		return -1; // 데이터베이스 오류
	}
	
	public int updateFile(int partyNum, String bbsTitle, String bbsContent, String fileName, String fileRealName, int maxNum) { // 파일 수정이 있는 경우
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
		return -1; // 데이터베이스 오류
	}
	
	public int delete(int partyNum) { // 게시글 삭제
		String SQL = "UPDATE bbs SET bbsAction = 0 WHERE partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, partyNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete_two(int partyNum) { // 게시글 삭제
		String SQL = "DELETE FROM party WHERE partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, partyNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int checkMyParty(String userID, int partyNum) { // 사용자가 가입된 파티인지 체크함
		String SQL = "SELECT partyNum FROM party WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				if(partyNum == rs.getInt("partyNum")) {
					return 1; // 가입 파티일 경우
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 가입 파티가 아닐시
	}
	
	public int partyOut(String userID, int partyNum) { // 파티 탈퇴
		String SQL = "DELETE FROM party WHERE userID = ? AND partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, partyNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int partyOut_two(int partyNum, int nowNum) { // 파티 탈퇴시 bbs테이블의 현재인원 -1을 하고 글을 목록에 보여지게끔 bbsAction = 1 로 설정을 바꿔줌
		String SQL = "UPDATE bbs SET nowNum = ?, bbsAction = 1 WHERE partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, nowNum - 1);
			pstmt.setInt(2, partyNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<Bbs> getMember(int partyNum) { // 파티원 목록 불러오기
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
	
	public ArrayList<Bbs> getWaitMember(int partyNum) { // 파티 가입신청 목록 불러오기
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
	
	public int partyDeport(String userID, int partyNum) { // 파티 추방
		String SQL = "DELETE FROM party WHERE userID = ? AND partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, partyNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int partyDeport_two(int partyNum, int nowNum) { // 파티 추방시 bbs테이블의 현재인원 -1을 하고 글을 목록에 보여지게끔 bbsAction = 1 로 설정을 바꿔줌
		String SQL = "UPDATE bbs SET nowNum = ?, bbsAction = 1 WHERE partyNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, nowNum - 1);
			pstmt.setInt(2, partyNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
