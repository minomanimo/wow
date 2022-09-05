package member;

public class Routine {
	private String userid;
	private String day;
	
	private String[] name;
	private int[] sets;
	private int[] kg;
	private int[] reps;
	public Routine(String userid, String day, String[] name, int[] sets, int[] kg, int[] reps) {
		this.userid=userid;
		this.day=day;
		this.name=name;
		this.sets=sets;
		this.kg=kg;
		this.reps=reps;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	
	public String[] getName() {
		return name;
	}
	public void setName(String[] name) {
		this.name = name;
	}
	public int[] getSets() {
		return sets;
	}
	public void setSets(int[] sets) {
		this.sets = sets;
	}
	public int[] getKg() {
		return kg;
	}
	public void setKg(int[] kg) {
		this.kg = kg;
	}
	public int[] getReps() {
		return reps;
	}
	public void setReps(int[] reps) {
		this.reps = reps;
	}
	
}
