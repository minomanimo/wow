package member;

public class Community {
	private String id;
	private String category;
	private String title;
	private String content;
	private String likes;
	private String dislike;
	private String time;
	
	public Community(String id, String category, String title, String content, String likes, String dislike, String time){
		this.id=id;
		this.category=category;
		this.title=title;
		this.content=content;
		this.likes=likes;
		this.dislike=dislike;
		this.time=time;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getLikes() {
		return likes;
	}
	public void setLikes(String likes) {
		this.likes = likes;
	}
	public String getDislike() {
		return dislike;
	}
	public void setDislike(String dislike) {
		this.dislike = dislike;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
}
