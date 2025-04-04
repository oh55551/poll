package model;

import java.sql.*;
import java.util.ArrayList;

import dto.Item;
import dto.Question;

//Item table의 crud담당
public class ItemDao {
	public void insertItemList(int qnum, String[] contents) throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");

		String sql = "INSERT INTO item(qnum, inum, content) VALUES (?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);

		int inum = 1;
		for (String content : contents) {
			if (content != null && !content.trim().equals("")) {
				stmt.setInt(1, qnum);
				stmt.setInt(2, inum++);
				stmt.setString(3, content);
				stmt.executeUpdate();
			}
		}

		stmt.close();
		conn.close();
	}
	
	public Item deleteItemTwo(int qnum) throws ClassNotFoundException, SQLException {
		Item i = null;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "DELETE FROM Item WHERE qnum = ?";
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		stmt.executeUpdate();
		return i;
	}
	
	public int selectItemCountByQnum(int qnum) throws ClassNotFoundException, SQLException {
		int count=0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT qnum, SUM(COUNT) cnt FROM item GROUP BY qnum HAVING qnum = ?";
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		rs = stmt.executeQuery();
		if(rs.next()) {
			count=rs.getInt("cnt"); //rs.getInt(1)
		}
		return count;
	}
	
	public void updateItemCountPlus(int inum, int qnum) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "update item set count = count+1 where qnum = ? and inum = ?";
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		stmt.setInt(2, inum);
		int row = stmt.executeUpdate();
		if(row==1) {
			System.out.println("ItemDao.updateItemCountPlus#입력성공");
		}else {
			System.out.println("ItemDao.updateItemCountPlus#입력실패");
		}
	}
	
	//updateItemForm에 쓰이고, questionOneResult에 쓰임
	public ArrayList<Item> selectItemListByQnum(int qnum) throws ClassNotFoundException, SQLException{
		ArrayList<Item> list = new ArrayList<Item>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select * from item where qnum=? order by inum asc";
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		rs = stmt.executeQuery();
		// 외부 JDBC 라이브러리에 의존하는 ResultSet을 ArrayList타입으로 변경
		while(rs.next()) {
			Item i = new Item();
			i.setQnum(qnum);
			i.setInum(rs.getInt("inum"));
			i.setContent(rs.getString("content"));
			i.setCount(rs.getInt("count"));
			list.add(i);
		}
		return list;
	}
	
	
	public int insertItem(Item item) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "insert into item(qnum, inum, content) values(?,?,?)";
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, item.getQnum());
		stmt.setInt(2, item.getInum());
		stmt.setString(3, item.getContent());
		int row= stmt.executeUpdate();
		if(row == 1) {
			System.out.println("ItemDao.insertItem - 입력성공");
		} else {
			System.out.println("ItemDao.insertItem - 입력실패");
		}
		return row;
		
	}
	

	public int selectItemCount() throws SQLException {
	    int count = 0;
	    String sql = "SELECT COUNT(*) FROM item"; 
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    ResultSet rs = stmt.executeQuery();
	        if (rs.next()) {
	            count = rs.getInt(1);
	        }
			return count;
	    }        
	

}
