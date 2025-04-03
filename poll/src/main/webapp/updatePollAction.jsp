<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, dto.*, model.*" %>
<%
	//Form 값 가져오기
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	String title = request.getParameter("title");
	String startdate = request.getParameter("startdate");
	String enddate = request.getParameter("enddate");
	int type = Integer.parseInt(request.getParameter("type"));
	String[] contents = request.getParameterValues("content");

	//쿼리실행 준비
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");

	// 1. question 업데이트
	String sql = "UPDATE question SET title=?, startdate=?, enddate=?, type=? WHERE num=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, title);
	stmt.setString(2, startdate);
	stmt.setString(3, enddate);
	stmt.setInt(4, type);
	stmt.setInt(5, qnum);
	stmt.executeUpdate();
	stmt.close();

	// 2. 기존 item 삭제(qnum만 삭제해도 다 삭제됨)
	String sql2 = "DELETE FROM item WHERE qnum=?";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, qnum);
	stmt2.executeUpdate();
	stmt2.close();

	// 3. 새 item 삽입(새로넣을값들 다 넣어줌)
	String sql3 = "INSERT INTO item(qnum, inum, content, count) VALUES (?, ?, ?, 0)";
	PreparedStatement stmt3 = conn.prepareStatement(sql3);

	// contents 값 삽입
	int inum = 1;
	for (String c : contents) {
		stmt3.setInt(1, qnum);
		stmt3.setInt(2, inum++); //보기번호를 1번부터 차례로
		stmt3.setString(3, c);	 //보기내용
		stmt3.executeUpdate();
	}
	stmt3.close();
	conn.close();

	response.sendRedirect("/poll/pollList.jsp");
%>