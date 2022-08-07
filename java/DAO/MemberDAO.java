package DAO;
import java.sql.*;
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
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
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
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
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
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
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
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
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
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
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
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
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
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
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
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			}catch(Exception ex) {
				System.out.println("getLink() 종료중 오류발생 : "+ex);
			}
		}
		return arr;
	}
}
