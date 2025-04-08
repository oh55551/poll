package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
import dto.*;

import dto.*;


public class BoardDao {
	public void updateBoard(Board b) throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		PreparedStatement stmt = null;
		ResultSet rs= null;
		String sql = "UPDATE board SET name=?, subject=?, content=?, ref=?, pos=?, depth=?, ip=?, count=? WHERE num=?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, b.getName());
		stmt.setString(2, b.getSubject());
		stmt.setString(3, b.getContent());
		
		stmt.setInt(4, b.getRef());
		stmt.setInt(5, b.getPos());
		stmt.setInt(6, b.getDepth());
		
		stmt.setString(7, b.getIp());
		stmt.setInt(8, b.getCount());
		stmt.setInt(9, b.getNum());
		int row = stmt.executeUpdate();
		System.out.println("업데이트 실행됨. 반영된 행 수: " + row);
	}
	
	public int deleteBoard(Board b) throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		PreparedStatement stmt = null;
		ResultSet rs= null;
		String sql = "delete from board where num = ? and pass = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, b.getNum());
		stmt.setString(2, b.getPass());
		int row = stmt.executeUpdate();
		return row;
	}
	
	
	public void insertBoard(Board b) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs= null; //입력 직후 pk값 반환받기위해
		String sql = "insert into board(name, subject, content, ref, pass, ip) values (?, ?, ?, ?, ?, ?)";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		conn.setAutoCommit(false);//executeUpdate()시마다 자동커밋기능을 false
		
		stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); //ref==0면 입력직후 pk를 반환받기위해
		stmt.setString(1, b.getName());
		stmt.setString(2, b.getSubject());
		stmt.setString(3, b.getContent());
		stmt.setInt(4, b.getRef());
		stmt.setString(5, b.getPass());
		stmt.setString(6, b.getIp());
		int row = stmt.executeUpdate();
		rs = stmt.getGeneratedKeys();
		int pk = 0;
		if(rs.next()) {
			pk=rs.getInt(1);
		}
		PreparedStatement stmt2 = null;
		String sql2 = "update board set ref=? where num = ?"; 
		
		stmt2 = conn.prepareStatement(sql2);
		//update 쿼리가 실패하면 이전의 insert도 롤백 : conn.rollback();
		stmt2.setInt(1, pk);
		stmt2.setInt(2, pk);
		stmt2.executeUpdate();
		conn.commit(); //conn.setAutoCommit(false); 코드때문에 필요
		conn.close();
	}
	


	
	//새글 입력(부모글)
	public void insertBoardReply(Board b) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		conn.setAutoCommit(false);//executeUpdate()시마다 자동커밋기능을 false
		
		//ref가 같고 pos값이 현재글보다 크거나 같다면 pos=pos+1
		PreparedStatement stmt2=null;
		String sql2="update board set pos=pos+1 where ref=? and pos >= ?";
		stmt2=conn.prepareStatement(sql2);
		stmt2.setInt(1, b.getRef());
		stmt2.setInt(2, b.getPos());
		int row2 = stmt2.executeUpdate();
		
		//답글 입력		
		PreparedStatement stmt = null;
		String sql = "insert into board(name, subject, content, ref, pos, depth, pass, ip) values (?, ?, ?, ?, ?, ?, ?, ?)";
		
		//트랜잭션(2개이상의(CUD)쿼리 한 묶음처럼 처리하고자 할때)
		
		stmt = conn.prepareStatement(sql); 
		stmt.setString(1, b.getName());
		stmt.setString(2, b.getSubject());
		stmt.setString(3, b.getContent());
		
		stmt.setInt(4, b.getRef());
		stmt.setInt(5, b.getPos());
		stmt.setInt(6, b.getDepth());
		
		stmt.setString(7, b.getPass());
		stmt.setString(8, b.getIp());
		
		int row = stmt.executeUpdate();
		
		conn.commit(); //conn.setAutoCommit(false); 코드때문에 필요
		conn.close();
	}
	
	public Board selectBoardOne(int num) throws ClassNotFoundException, SQLException {
		Board b = null;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select * from board where num= ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		rs = stmt.executeQuery();
		//rs->board
		if(rs.next()) {
			b = new Board();
			b.setNum(rs.getInt("num"));
			b.setName(rs.getString("name"));
			b.setSubject(rs.getString("subject"));
			b.setContent(rs.getString("content"));
			b.setPos(rs.getInt("pos"));
			b.setRef(rs.getInt("ref"));
			b.setDepth(rs.getInt("depth"));
			b.setRegdate(rs.getString("regdate"));
			b.setIp(rs.getString("ip"));
			b.setCount(rs.getInt("count"));
		}
		return b;
	}
	
	public ArrayList<Board> selectBoardList(Paging p) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select * from board order by ref desc, pos asc limit ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		rs = stmt.executeQuery();
		ArrayList<Board> list = new ArrayList<>();
		//rs => list
		while(rs.next()) {
			Board b = new Board();
			b.setNum(rs.getInt("num"));
			b.setName(rs.getString("name"));
			b.setSubject(rs.getString("subject"));
			b.setPos(rs.getInt("pos"));
			b.setRef(rs.getInt("ref"));
			b.setDepth(rs.getInt("depth"));
			b.setCount(rs.getInt("count"));
			list.add(b);
		}
		return list;
	}
}
