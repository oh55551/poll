package model;
import java.sql.*;
import java.util.*;

import dto.Paging;
import dto.Question;
//question table의 crud담당
public class QuestionDao {
	
	public ArrayList<HashMap<String, Object>> selectQuestionList() throws ClassNotFoundException, SQLException {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT q.num, q.title, q.startdate, q.enddate, t.cnt FROM question q INNER JOIN (SELECT qnum, SUM(COUNT) cnt FROM item GROUP BY qnum)t ON q.num = t.qnum";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("num", rs.getInt("num"));
			m.put("title", rs.getString("title"));
			m.put("startdate", rs.getString("startdate"));
			m.put("enddate", rs.getString("enddate"));
			m.put("cnt", rs.getInt("cnt"));
			list.add(m);
		}
		return list;
	}

	
	public int selectQuestionCount() throws SQLException {
	    int count = 0;
	    String sql = "SELECT COUNT(*) FROM question"; 
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    ResultSet rs = stmt.executeQuery();
	        if (rs.next()) {
	            count = rs.getInt(1);
	        }
			return count;
	    }        
	
	public ArrayList<Question> selectQuestionList(Paging p) throws ClassNotFoundException, SQLException{
		ArrayList<Question> list = new ArrayList<>();
		Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
        String sql = "SELECT * FROM question ORDER BY num DESC LIMIT ?, ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, p.getBeginRow()); 
        stmt.setInt(2, p.getRowPerPage());
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
        	Question q = new Question();
            q.setNum(rs.getInt("num"));
            q.setTitle(rs.getString("title"));
            q.setStartdate(rs.getString("startdate"));
            q.setEnddate(rs.getString("enddate"));
            q.setType(rs.getInt("type"));
            list.add(q);
        }
        conn.close();
		// 물음표값에 넣기
//		p.getCurrentPage();
//		p.getRowPerPage();
		return list;
	}
	
	//입력 후 자동으로 생성된 키값을 반환값
	public int insertQuestion(Question question) throws ClassNotFoundException, SQLException {
		int pk = 0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		PreparedStatement stmt = null;
		//입력이지만 키값을 받아올때 사용
		ResultSet rs = null;
		String sql = "insert into question(title, startdate, enddate, type) values(?,?,?,?)";
		//Statement.RETURN_GENERATED_KEYS 옵션 : insert 후 select max(pk) from ... 실행
		stmt=conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setString(1, question.getTitle());
		stmt.setString(2, question.getStartdate());
		stmt.setString(3, question.getEnddate());
		stmt.setInt(4, question.getType());
		int row = stmt.executeUpdate();	// insert
		rs=stmt.getGeneratedKeys(); //select max(num) from question
		if(rs.next()) {
			pk = rs.getInt(1);
		}
		
		
		return pk;
	}
	
	 public void updateQuestion(Question q) throws Exception {
	    	Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
	        String sql = "UPDATE question SET title=?, startdate=?, enddate=?, type=? WHERE num=?";
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setString(1, q.getTitle());
	        stmt.setString(2, q.getStartdate());
	        stmt.setString(3, q.getEnddate());
	        stmt.setInt(4, q.getType());
	        stmt.setInt(5, q.getNum());
	        stmt.executeUpdate();
	        stmt.close();
	        conn.close();
	}
}
