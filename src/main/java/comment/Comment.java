package comment;

public class Comment {
	private int cmtNum;
	private String cmtDate;
	private String cmtContent;
	private int cmtParent;
	private int cmtAction;
	private int partyNum;
	private String userID;
	
	public int getCmtNum() {
		return cmtNum;
	}
	public void setCmtNum(int cmtNum) {
		this.cmtNum = cmtNum;
	}
	public String getCmtDate() {
		return cmtDate;
	}
	public void setCmtDate(String cmtDate) {
		this.cmtDate = cmtDate;
	}
	public String getCmtContent() {
		return cmtContent;
	}
	public void setCmtContent(String cmtContent) {
		this.cmtContent = cmtContent;
	}
	public int getCmtParent() {
		return cmtParent;
	}
	public void setCmtParent(int cmtParent) {
		this.cmtParent = cmtParent;
	}
	public int getCmtAction() {
		return cmtAction;
	}
	public void setCmtAction(int cmtAction) {
		this.cmtAction = cmtAction;
	}
	public int getPartyNum() {
		return partyNum;
	}
	public void setPartyNum(int partyNum) {
		this.partyNum = partyNum;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
}
