<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>
<%
//questionDao완성 / pollList출력
	//question 테이블 리스트-> 페이징 -> title링크(startdate오늘날짜enddate) -> 투표프로그램
	//QuestionDao.selectQuestionList(Paging)
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage=2;
	Paging paging = new Paging();
	paging.setCurrentPage(currentPage);
	paging.setRowPerPage(rowPerPage);
	
	QuestionDao questionDao = new QuestionDao();
	ArrayList<Question> list = questionDao.selectQuestionList(paging);
	int totalRow = questionDao.selectQuestionCount();
	int lastPage = paging.getLastPage(totalRow);
	
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pollList</title>
</head>
<body>
	<h1>설문리스트</h1>
	<table>
				<tr>
					<th>num</th>
					<th>title</th>
					<th>startdate</th>
					<th>enddate</th>
					<th>type</th>
				</tr>
		<%
			for(Question q : list){
		%>
				<tr>
					<td><%=q.getNum()%></td>
					<td><%=q.getTitle()%></td>
					<td><%=q.getStartdate()%></td>
					<td><%=q.getEnddate()%></td>
					<td><%=q.getType()%></td>
				</tr>
		<%		
			}
		%>
	</table>
	<!-- for each 문 ArrayList<Question> list 출력 title링크
	(startdate <= 오늘날짜 <= enddate) 투표시작전, 투표종료, 투표하기-->
	<div>
	<a href="/poll/pollList.jsp?currentPage=1">[첫페이지로]</a>
<%
	if(currentPage > 1){
%>
		<a href="/poll/pollList.jsp?currentPage=<%= currentPage - 1 %>">이전</a>
<%
	}
	for(int i = 1; i <=lastPage ; i++){

%>
		<a href="/poll/pollList.jsp?currentPage=<%=i %>">[<%=i %>]</a>
<%
		}
	
	if(currentPage < lastPage){
%>
		<a href="/poll/pollList.jsp?currentPage=<%= currentPage + 1 %>">다음</a>
<%
	}
%>
</div>
</body>
</html>