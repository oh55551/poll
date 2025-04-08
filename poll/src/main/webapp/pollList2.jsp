<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>
<%
	// question 테이블 리스트 -> 페이징 -> title 링크(startdate <= 오늘날짜 <= enddate) -> 투표프로그램
	// QuestionDao.selectQuestionList(Paging)
	
	QuestionDao questionDao = new QuestionDao();
	
	ArrayList<HashMap<String, Object>> list
		= questionDao.selectQuestionList();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>pollList</title>
	
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	
	<h1>설문리스트</h1>
	<table class="table table-dark table-hover">
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>시작일</td>
			<td>종료일</td>
			<td>현재투표현황</td>
			<td>투표</td>
			<td>삭제</td>
			<td>수정</td>
			<td>종료일수정</td>
			<td>결과</td>
		</tr>
		<%
			Calendar today = Calendar.getInstance();
			// yyyy-mm-dd
			int year = today.get(Calendar.YEAR);
			int mon = today.get(Calendar.MONTH)+1;
			int date = today.get(Calendar.DATE);
			
			String strToday = year+"-";
			if(mon<10) {
				strToday = strToday + "0" + mon + "-";
			} else {
				strToday = strToday + mon + "-";
			}
			if(date<10) {
				strToday = strToday + "0" + date;
			} else {
				strToday = strToday + date;
			}
			
			System.out.println(strToday);
			
			for(HashMap<String, Object> m : list) {
				String startdate = (String)m.get("startdate");
				String enddate = (String)m.get("enddate");
		%>
			<tr>
				<td><%=m.get("num")%></td>
				<td><%=m.get("title")%></td>
				<td><%=m.get("startdate")%></td>
				<td><%=m.get("enddate")%></td>
				<td><%=m.get("cnt")%> 번</td>
				<td>
					<%
						// 오늘날짜-시작날짜:양수 && 끝날짜 - 오늘날짜:양수
						if(strToday.compareTo(startdate) < 0){
					%>
							투표전
					<% 
						} else if(strToday.compareTo(enddate) > 0){
					%>
							투표종료 
					<%
						} else{					
					%>	
							<a href="/poll/updateItemForm.jsp?qnum=<%=m.get("num")%>">투표하기</a>	
					<% 
						}
					%>
				</td>
				<td>
					<%
						if((Integer)(m.get("cnt")) > 0) {
					%>
							삭제불가
					<%		
						} else {
					%>
							<a href="/poll/deletePoll2.jsp?qnum=<%=m.get("num")%>">삭제</a>
					<%		
						}
					%>
				</td>
				<td>
					<%
						if((Integer)(m.get("cnt")) > 0) {
					%>
							수정불가
					<%		
						} else {
					%>
							<a href="/poll/updatePollForm2.jsp?qnum=<%=m.get("num") %>">수정</a>
					<%		
						}
					%>
				</td>
				<td>
					<%
						if(enddate.compareTo(strToday)>=0){
					%>
							<a href="/poll/updateQuestionEnddateForm2.jsp?qnum=<%=m.get("num")%>">종료일 수정</a>
					<%		
						}else{
					%>
							종료일 수정 불가
					<%		
						}
					%>
				</td>
				<td>
					<%
						if(strToday.compareTo(enddate)> 0){
					%>
							<a class="btn btn-danger" href="/poll/questionOneResult.jsp?qnum=<%=m.get("num")%>">결과보기</a>
					<%		
						}else{
					%>
							투표 진행중
					<%		
						}
					%>
				</td>
		</tr>
		<%		
			}
		%>
	</table>
</body>
</html>
