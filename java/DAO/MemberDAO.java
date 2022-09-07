package DAO;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import member.*;

public class MemberDAO {
	//싱글톤 처리
	private MemberDAO(){
		
	}
	private static MemberDAO instance=new MemberDAO();
	public static MemberDAO getInstance() {
		return instance;
	}
	public Connection getConnection() throws Exception{
		Connection conn=null;
		String url="jdbc:mysql://127.0.0.1:3306/wow";
		String db_id="root";
		String db_pw="iotiot";
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn=DriverManager.getConnection(url, db_id,db_pw);
		return conn;
	}
	//회원추가
	public static void close(Connection conn, PreparedStatement pstmt) {
		try {
			if(pstmt!=null)pstmt.close();
			if(conn!=null)conn.close();
		}catch(Exception e) {
			System.out.println("MemberDAO.close() 실행중 오류발생"+e);
		}
	}
	
	public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {
			if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(conn!=null)conn.close();
		}catch(Exception e) {
			System.out.println("MemberDAO.close() 실행중 오류발생"+e);
		}
	}
	public int insertMember(Member m) {
		int result=-1;
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="insert into member (id,pwd,name,phone,birth,email,admin) values (?,?,?,?,?,?,?);";
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, m.getId());
			pstmt.setString(2, m.getPwd());
			pstmt.setString(3, m.getName());
			pstmt.setString(4, m.getPhone());
			pstmt.setString(5, m.getBirth());
			pstmt.setString(6, m.getEmail());
			pstmt.setInt(7, 0);
			result=pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("insertMember 실행중 오류발생 : "+e);
		}finally {
			try {
				MemberDAO.close(conn, pstmt);
			}catch(Exception ex) {
				System.out.println("insertMember 종료중 오류발생 : "+ex);
			}
		}
		return result;
	}
	//로그인처리
	public int memberCheck(String id, String pwd) {
		int result=-1;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select pwd from member where id=?;";
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("pwd").equals(pwd)&&rs.getString("pwd")!=null) {
					result=1;
				}else {
					result=0;
				}
			}else {
				result=-1;
			}
		}catch(Exception e){
			System.out.println("memberCheck 실행중 오류발생 : "+e);
		}finally {
			try {
				MemberDAO.close(conn, pstmt, rs);
			}catch(Exception ex) {
				System.out.println("memberChec 종료중 오류발생 : "+ex);
			}
		}
		return result;
	}
	//회원정보 가져오기
	public Member getMember(String id) {
		MemberDAO mDAO=MemberDAO.getInstance();
		Member m=new Member();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from member where id=?;";
		try {
			conn=mDAO.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				String userid=rs.getString("id");
				String pwd=rs.getString("pwd");
				String name=rs.getString("name");
				String phone=rs.getString("phone");
				String birth=rs.getString("birth");
				String email=rs.getString("email");
				int admin=rs.getInt("admin");
				m.setId(userid);
				m.setPwd(pwd);
				m.setName(name);
				m.setPhone(phone);
				m.setBirth(birth);
				m.setEmail(email);
				m.setAdmin(admin);
			}
		}catch(Exception e) {
			System.out.println("getMember 실행중 오류발생 : "+e);
		}finally {
			try {
				MemberDAO.close(conn, pstmt, rs);
			}catch(Exception ex) {
				System.out.println("getMember 종료중 오류발생 : "+ex);
			}
		}
		return m;
	}
	//아이디 중복체크
	public boolean idCheck(String id) {
		boolean hasId=false;
		String sql="select id from member where id=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				hasId=true;
			}
		} catch (Exception e) {
			System.out.println("idCheck 실행중 오류발생 : "+e);
		}finally {
			try {
				MemberDAO.close(conn, pstmt, rs);
			}catch(Exception ex){
				System.out.println("idCheck 종료중 오류발생 : "+ex);
			}
		}
		return hasId;
	}
	//운동목록 가져오기
	public ArrayList<WorkList> getWorkList(String part) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ArrayList<WorkList> list=new ArrayList<WorkList>();
		WorkList wl;
		String sql="select * from workout_list where part=?;";
		
		try {
			conn=getConnection();
			if(part.equals("all")) {
				sql="select * from workout_list;";
				pstmt=conn.prepareStatement(sql);
			}
			else {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, part);
			}
			rs=pstmt.executeQuery();
			while(rs.next()) {
				wl=new WorkList();
				wl.setPart(rs.getString("part"));
				wl.setName(rs.getString("name"));
				wl.setYtlink1(rs.getString("ytlink1"));
				wl.setYtlink2(rs.getString("ytlink2"));
				wl.setYtlink3(rs.getString("ytlink3"));
				wl.setExp(rs.getString("exp"));
				list.add(wl);
			}
		}catch(Exception e) {
			System.out.println("getWorkList() 실행중 오류발생 : "+e);
		}finally{
			try {
				MemberDAO.close(conn, pstmt, rs);
			}catch(Exception ex) {
				System.out.println("getWorkList() 종료중 오류발생 : "+ex);
			}
		}
		return list;
	}
	//운동찾기
	public ArrayList<String> searchWork(String keyword){
		ArrayList<String> name=new ArrayList<String>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select name from workout_list;";
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				if(rs.getString("name").contains(keyword)) {
					name.add(rs.getString("name"));
				}
			}
			if(name.size()==0) {
				name.add("결과가 없습니다.");
			}
		}catch(Exception e) {
			System.out.println("searchWork() 실행중 오류발생"+e);
		}finally {
			try {
				MemberDAO.close(conn, pstmt, rs);
			}catch(Exception ex) {
				System.out.println("searchWork() 종료중 오류발생"+ex);
			}
		}
		return name;
	}
	//운동 삭제
	public int deleteList(String name) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		int delete=0;
		String sql="delete from workout_list where name=?;";
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, name);
			delete=pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("deleteList() 실행중 오류발생 : "+e);
		}finally {
			try {
				MemberDAO.close(conn, pstmt);
			}catch(Exception ex) {
				System.out.println("deleteList() 종료중 오류발생 : "+ex);
			}
		}
		return delete;
	}
	//운동목록,영상링크 가져오기
	public String[] getLink(String name) {
		String[] arr=new String[4];
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from workout_list where name=?;";
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				arr[0]=rs.getString("ytlink1");
				arr[1]=rs.getString("ytlink2");
				arr[2]=rs.getString("ytlink3");
				arr[3]=rs.getString("exp");
			}
		}catch(Exception e) {
			System.out.println("getLink() 실행중 오류발생 : "+e);
		}finally {
			try {
				MemberDAO.close(conn, pstmt, rs);
			}catch(Exception ex) {
				System.out.println("getLink() 종료중 오류발생 : "+ex);
			}
		}
		return arr;
	}
	public int writeCommu(String userid, String category, String title, String content) {
		int flag=0;
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="insert into community (id, category, title, content, likes, dislike, time, visible) values (?, ?, ?, ?, ?, ?, ?, 1);";
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, category);
			pstmt.setString(3, title);
			pstmt.setString(4, content);
			pstmt.setString(5, "0");
			pstmt.setString(6, "0");
			LocalDateTime time=LocalDateTime.now(ZoneId.of("Asia/Seoul"));
			DateTimeFormatter format=DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			String timeformat=time.format(format);
			pstmt.setString(7, timeformat);
			flag=pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("writeCommu() 실행중 오류발생"+e);
		}finally {
			try {
				MemberDAO.close(conn, pstmt);
			}catch(Exception ex){
				System.out.println("writeCommu() 종료중 오류발생"+ex);
			}
		}
		return flag;
	}
	public ArrayList<Community> getCommu(String category, String userid,String time1, int currentPage) {
		Community com;
		int start=(currentPage-1)*20;
		ArrayList<Community> list=new ArrayList<Community>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from community where visible=1";
		
		try {
			conn=getConnection();
			
			if(category!=null) {
				if(category.equals("popular")) {
					sql+=" order by likes desc limit ?, ?;";
					pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1, start);
					pstmt.setInt(2, 20);
				}else {
					sql+=" and category='"+category+"' order by num desc limit ?, ?;";
					pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1, start);
					pstmt.setInt(2, 20);
					//System.out.println(sql);
				}
			}
			if(category==null && userid==null && time1==null){
				sql+=" order by num desc limit ?, ?;";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, 20);
				//System.out.println(sql);
			}
			if(userid!=null && time1==null) {
				sql+=" and id='"+userid+"' order by num desc limit ?, ?;";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, 20);
				//System.out.println(sql);
			}
			if(time1!=null && userid!=null) {
				sql+=" and time='"+time1+"' and id='"+userid+"';";
				//System.out.println(sql);
				pstmt=conn.prepareStatement(sql);
			}
			
			
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				int num=rs.getInt("num");
				String id=rs.getString("id");
				String cat=rs.getString("category");
				String title=rs.getString("title");
				String content=rs.getString("content");
				String like=rs.getString("likes");
				String dislike=rs.getString("dislike");
				String time=rs.getString("time");
				com=new Community(num, id, cat, title, content, like, dislike,time);
				list.add(com);
			}
		}catch(Exception e) {
			System.out.println("getCommu() 실행중 오류발생"+e);
		}finally {
			try {
				MemberDAO.close(conn, pstmt, rs);
			}catch(Exception ex) {
				System.out.println("getCommu() 종료중 오류발생"+ex);
			}
		}
		return list;
	}
	public int getNumberOfRows(String category, String id) {
		int row=0;
		String sql="select count(num) from community where visible=1 ";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=getConnection();
			if(category!=null) {
				if(category.equals("popular")) {
					pstmt=conn.prepareStatement(sql);
				}else {
					sql+=" and category=?;";
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1, category);
				}
			}else if(id!=null) {
				sql+=" and id=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, id);
			}else {
				pstmt=conn.prepareStatement(sql);
			}
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				row=rs.getInt(1);
			}
		}catch(Exception e) {
			System.out.println("getNumberOfRows() 실행중 오류발생"+e);
		}finally {
			try {
				MemberDAO.close(conn, pstmt, rs);
			}catch(Exception ex){
				System.out.println("getNumberOfRows() 종료중 오류발생"+ex);
			}
		}
		return row;
	}
	public int setGetLikes(String like,int islike,String id,String time,String likedid) {
		int liked=0;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select num from community where id=? and time=?;";
		try {
			conn=getConnection();
			
			//num값 받아오기
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, time);
			rs=pstmt.executeQuery();
			rs.next();
			int num=rs.getInt(1);
			rs.close();
			pstmt.close();
			
			//좋아요 기록 체크
			sql="select * from likes where id=? and main_num=?;";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, likedid);
			pstmt.setInt(2, num);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				liked=rs.getInt("islike");
				
			}else {
				sql="insert into likes (id, main_num, islike, date) values (?, ?, ?, ?);";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, likedid);
				pstmt.setInt(2, num);
				pstmt.setInt(3, islike);
				LocalDate now=LocalDate.now();
				DateTimeFormatter formatter=DateTimeFormatter.ofPattern("yyyy/MM/dd");
				String formatNow=now.format(formatter);
				pstmt.setString(4, formatNow);
				pstmt.executeUpdate();
				liked=-1;
				
				//좋아요 업데이트
				sql="update community set ";
				if(islike==1) {
					sql+="likes=? where id=? and time=?";
				}else {
					sql+="dislike=? where id=? and time=?";
				}
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, like);
				pstmt.setString(2, id);
				pstmt.setString(3, time);
				pstmt.executeUpdate();
				pstmt.close();
			}
		}catch(Exception e) {
			System.out.println("setGetLikes() 실행중 오류발생"+e);
		}finally {
			try {
				MemberDAO.close(conn, pstmt,rs);
			}catch(Exception ex) {
				System.out.println("setGetLikes() 종료중 오류발생"+ex);
			}
		}
		return liked;
	}
	public int writeComment(String userid, String comment, int main_num, int recomment, int comment_num) {
		int success=0;
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="insert into comments (comment_id, comment, main_num, recomment";
		
		try {
			conn=getConnection();
			if(recomment==1) {
				sql+=", comment_num) values (?,?,?,?,?);";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, comment);
				pstmt.setInt(3, main_num);
				pstmt.setInt(4, recomment);
				pstmt.setInt(5, comment_num);
			}else {
				sql+=") values (?,?,?,?);";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, comment);
				pstmt.setInt(3, main_num);
				pstmt.setInt(4, recomment);
			}
			success=pstmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("writeCommu() 실행중 오류발생");
		}finally {
			try {
				MemberDAO.close(conn, pstmt);
			}catch(Exception ex){
				System.out.println("writeCommu() 종료중 오류발생");
			}
		}
		return success;
	}
	public ArrayList<Comment> getComment(int main_num) {
		ArrayList<Comment> list=new ArrayList<Comment>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Comment com;
		String sql="select * from comments where main_num=?";
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, main_num);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				int num=rs.getInt("num");
				String comment_id=rs.getString("comment_id");
				String comment=rs.getString("comment");
				int main_num1=rs.getInt("main_num");
				int recomment1=rs.getInt("recomment");
				int comment_num1=rs.getInt("comment_num");
				com=new Comment(num,comment_id, comment, main_num1, recomment1, comment_num1);
				list.add(com);
			}
		}catch(Exception e) {
			System.out.println("getComment() 실행중 오류발생"+e);
		}finally {
			try {
				MemberDAO.close(conn, pstmt, rs);
			}catch(Exception ex) {
				System.out.println("getComment() 종료중 오류발생"+ex);
			}
		}
		return list;
	}
	public void deleteContent(int num) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="update community set visible=0 where num='"+num+"';";
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("deleteContent() 실행중 오류발생"+e);
		}finally {
			try {
				MemberDAO.close(conn, pstmt);
			}catch(Exception ex) {
				System.out.println("deleteContent() 종료중 오류발생"+ex);
			}
		}
	}
	public ArrayList<String> updateContent(int num, String title, String content){
		ArrayList<String> list=new ArrayList<String>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql=null;
		
		try {
			conn=getConnection();
			if(title==null && content==null) {
				sql="select * from community where num='"+num+"';";
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					String title1=rs.getString("title");
					String content1=rs.getString("content");
					list.add(title1);
					list.add(content1);
				}
			}else {
				sql="update community set title=?, content=? where num=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, title);
				pstmt.setString(2, content);
				pstmt.setInt(3, num);
				int work=pstmt.executeUpdate();
				list.add(Integer.toString(work));
			}
		}catch(Exception e) {
			System.out.println("updateContent() 실행중 오류발생 "+e);
		}finally {
			try {
				MemberDAO.close(conn, pstmt, rs);
			}catch(Exception ex) {
				System.out.println("updateContent() 종료중 오류발생 "+ex);
			}
		}
		return list;
	}
	public void setRoutine(ArrayList<Routine> Rlist) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="delete from routine where id=? and day=?";
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, Rlist.get(0).getId());
			pstmt.setString(2, Rlist.get(0).getDay());
			pstmt.executeUpdate();
			for(int i=0; i<Rlist.size(); i++) {
				sql="insert into routine (userid, day, idx, name, sets, kg, reps) values (?,?,?,?,?,?,?)";
				pstmt=conn.prepareStatement(sql);
				
				pstmt.setString(1, Rlist.get(i).getId());
				pstmt.setString(2, Rlist.get(i).getDay());
				pstmt.setInt(3, i);
				pstmt.setString(4, Rlist.get(i).getName());
				pstmt.setInt(5, Rlist.get(i).getSets());
				pstmt.setInt(6, Rlist.get(i).getKg());
				pstmt.setInt(7, Rlist.get(i).getReps());
				
				pstmt.executeUpdate();
			}
		}catch(Exception e) {
			System.out.println("setRoutine() 실행중 오류발생 : "+e);
			e.printStackTrace();
		}finally {
			MemberDAO.close(conn, pstmt, rs);
		}
	}
	public ArrayList<Routine> getRoutine(String id, String day){
		ArrayList<Routine> list=new ArrayList<Routine>();
		Routine r=null;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from routine where userid=? and day=?";
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, day);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				String userid=rs.getString("userid");
				String days=rs.getString("day");
				int idx=rs.getInt("idx");
				String name=rs.getString("name");
				int sets=rs.getInt("sets");
				int kg=rs.getInt("kg");
				int reps=rs.getInt("reps");
				r=new Routine(userid, days, idx, name, sets, kg, reps);
				list.add(r);
			}
		}catch(Exception e) {
			System.out.println("getRoutine() 실행중 오류발생 : "+e);
		}finally {
			MemberDAO.close(conn, pstmt, rs);
		}
		return list;
	}
	public void setDaysOfRoutine(String[] day, String id) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="delete from dayselect where id=?";
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			for(int i=0; i<day.length; i++) {
				sql="insert into dayselect (day, id) values (?, ?)";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, day[i]);
				pstmt.setString(2, id);
				pstmt.executeUpdate();
			}
			
		}catch(Exception e) {
			System.out.println("setDaysOfRoutine() 실행중 오류발생 : "+e);
		}finally {
			MemberDAO.close(conn, pstmt);
		}
	}
	public ArrayList<String> getDaysOfRoutine(String id) {
		ArrayList<String> list=new ArrayList<String>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from dayselect where id=?";
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				list.add(rs.getString("day"));
			}
		}catch(Exception e) {
			System.out.println("getDaysOfRoutine() 실행중 오류발생"+e);
		}finally {
			MemberDAO.close(conn, pstmt, rs);
		}
		return list;
	}
}
