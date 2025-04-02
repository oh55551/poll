package model;

import java.sql.*;

import dto.Item;

//Item table의 crud담당
public class ItemDao {
	public void insertItem(Item item) throws ClassNotFoundException, SQLException {
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
		conn.close(); // 여러개있을때 문제될수있으므로 꼭 해주기
	}
}
