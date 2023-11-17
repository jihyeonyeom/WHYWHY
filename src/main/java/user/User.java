package user;

import java.sql.Date;

public class User {
	private String userID;
	private String userPassword;
	private String checkPassword;
	private String userName;
	private String userBirthyy;
	private String userBirthmm;
	private String userBirthdd;
	private String userPhone;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getCheckPassword() {
		return checkPassword;
	}
	public void setCheckPassword(String checkPassword) {
		this.checkPassword = checkPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserBirthyy() {
		return userBirthyy;
	}
	public void setUserBirthyy(String userBirthyy) {
		this.userBirthyy = userBirthyy;
	}
	public String getUserBirthmm() {
		return userBirthmm;
	}
	public void setUserBirthmm(String userBirthmm) {
		this.userBirthmm = userBirthmm;
	}
	public String getUserBirthdd() {
		return userBirthdd;
	}
	public void setUserBirthdd(String userBirthdd) {
		this.userBirthdd = userBirthdd;
	}
	public Date stringToDate() {
		String year = getUserBirthyy();
		String month = getUserBirthmm();
		String day = getUserBirthdd();
		Date birthday = Date.valueOf(year + "-" + month + "-" + day);
		return birthday;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	
}
