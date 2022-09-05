package member;

public class Comment {
	private int num;
	private String comment_id;
	private String comment;
	private int main_num;
	private int recomment;
	private int comment_num;
	public Comment(int num,String comment_id, String comment, int main_num, int recomment, int comment_num) {
		this.num=num;
		this.comment_id=comment_id;
		this.comment=comment;
		this.main_num=main_num;
		this.recomment=recomment;
		this.comment_num=comment_num;
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
	public int getMain_num() {
		return main_num;
	}
	public void setMain_num(int main_num) {
		this.main_num = main_num;
	}
	public int getRecomment() {
		return recomment;
	}
	public void setRecomment(int recomment) {
		this.recomment = recomment;
	}
	public int getComment_num() {
		return comment_num;
	}
	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}
	public String getComment_id() {
		return comment_id;
	}
	public void setComment_id(String comment_id) {
		this.comment_id = comment_id;
	}
	
}
