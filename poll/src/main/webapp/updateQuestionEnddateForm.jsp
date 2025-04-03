<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, dto.*, model.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	//값 가져오기
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	String enddate = request.getParameter("enddate");
	
	//enddate가 null이면 오류가 나므로 null이 아닐때 쿼리실행
	if (enddate == null || enddate.equals("")) {
%>
<h2>종료일 수정</h2>
<form action="/poll/updateQuestionEnddateForm.jsp" method="post">
	<input type="hidden" name="qnum" value="<%= qnum %>">
	<label>종료일자:</label>
	<input type="date" name="enddate">
	<button type="submit">변경</button>
</form>
	
<%	}else{
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
	String sql = "UPDATE question SET enddate = ? WHERE num = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, enddate);
	stmt.setInt(2, qnum);
	int row = stmt.executeUpdate();

	response.sendRedirect("/poll/pollList.jsp");
}
%>
