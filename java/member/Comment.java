package member;

public class Comment {
	private int num;
	private String commentId;
	private String comment;
	private int mainNum;
	private int recomment;
	private int commentNum;
	public Comment(int num,String comment_id, String comment, int main_num, int recomment, int comment_num) {
		this.num=num;
		this.commentId=comment_id;
		this.comment=comment;
		this.mainNum=main_num;
		this.recomment=recomment;
		this.commentNum=comment_num;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public int getMainNum() {
		return mainNum;
	}
	public void setMainNum(int main_num) {
		this.mainNum = main_num;
	}
	public int getRecomment() {
		return recomment;
	}
	public void setRecomment(int recomment) {
		this.recomment = recomment;
	}
	public int getCommentNum() {
		return commentNum;
	}
	public void setCommentNum(int comment_num) {
		this.commentNum = comment_num;
	}
	public String getCommentId() {
		return commentId;
	}
	public void setCommentId(String comment_id) {
		this.commentId = comment_id;
	}
	
}
