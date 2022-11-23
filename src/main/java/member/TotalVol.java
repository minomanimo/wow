package member;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class TotalVol {
	private int total;
	private String today;
	private String[] days;
	
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public String getToday() {
		return today;
	}
	public void setToday(String today) {
		this.today = today;
	}
	public String[] getDays() {
		return days;
	}
	public void setDays() {
		LocalDate now=LocalDate.now();
		DateTimeFormatter format=DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String today=now.format(format);
		String[] spl=today.split("-");
		days=new String[7];
		for(int i=0; i<7; i++) {
			int day=Integer.parseInt(spl[2])-6+i;
			days[i]=spl[0]+"-"+spl[1]+"-"+day;
		}
	}
}
