<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%	
	//값 가져오기
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	
	//쿼리 실행
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
	String sql = "SELECT * FROM question q INNER JOIN "
				+"(select qnum, sum(COUNT) from item GROUP BY qnum) t "
				+"ON q.num=t.qnum ";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, qnum); 
	ResultSet rs = stmt.executeQuery();
		
		//갯수를 count의 수 를 저장
		int count = 0;
		if (rs.next()) {
			count = rs.getInt("totalCount");
		}
		
		//count가 0일때 데이터를 지움
		if (count == 0) {
			String deleteItems = "DELETE FROM item WHERE qnum = ?";
			PreparedStatement itemStmt = conn.prepareStatement(deleteItems);
			itemStmt.setInt(1, qnum);
			itemStmt.executeUpdate();
			itemStmt.close();
			
			String deleteQuestionSql = "DELETE FROM question WHERE num = ?";
			PreparedStatement deleteQuestionStmt = conn.prepareStatement(deleteQuestionSql);
			deleteQuestionStmt.setInt(1, qnum);
			deleteQuestionStmt.executeUpdate();
			
			System.out.println("삭제가 완료되었습니다.");
			response.sendRedirect("/poll/pollList.jsp");	
		} else{
			System.out.println("이미 진행중인 투표입니다.");
			response.sendRedirect("/poll/pollList.jsp");			
		}
%>
</body>
</html>