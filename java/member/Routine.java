package member;

public class Routine {
	private int num;
	private String id;
	private String day;
	private int idx;
	private String name;
	private int sets;
	private int kg;
	private int reps;
	private int[] setsarr;
	private int[] kgarr;
	private int[] repsarr;
	public Routine() {}
	public Routine(String id, String day, int idx, String name, int sets, int kg, int reps) {
		this.id=id;
		this.day=day;
		this.idx=idx;
		this.name=name;
		this.sets=sets;
		this.kg=kg;
		this.reps=reps;
	}
	
	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getId() {
		return id;
	}
	public void setId(String userid) {
		this.id = userid;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getSets() {
		return sets;
	}
	public void setSets(int sets) {
		this.sets = sets;
	}
	public int getKg() {
		return kg;
	}
	public void setKg(int kg) {
		this.kg = kg;
	}
	public int getReps() {
		return reps;
	}
	public void setReps(int reps) {
		this.reps = reps;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int[] getSetsarr() {
		return setsarr;
	}

	public void setSetsarr(int[] setarr) {
		this.setsarr = setarr;
	}

	public int[] getKgarr() {
		return kgarr;
	}

	public void setKgarr(int[] kgarr) {
		this.kgarr = kgarr;
	}

	public int[] getRepsarr() {
		return repsarr;
	}

	public void setRepsarr(int[] repsarr) {
		this.repsarr = repsarr;
	}
	
}
