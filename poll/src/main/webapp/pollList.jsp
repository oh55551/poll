<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
	
	ItemDao itemDao = new ItemDao();
	Item item = new Item();
	
	QuestionDao questionDao = new QuestionDao();	
	ArrayList<Question> list = questionDao.selectQuestionList(paging);
	int totalRow = questionDao.selectQuestionCount();
	int lastPage = paging.getLastPage(totalRow);
	
	Date today = new Date(); 
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pollList</title>
</head>
<body>
	<h1>설문리스트</h1>

	<table border="1">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>시작날짜</th>
					<th>끝나는날짜</th>
					<th>복수투표</th>
					<th>투표</th>
					<th>삭제</th>
					<th>수정</th>
					<th>종료일자수정</th>
					<th>결과</th>
				</tr>
		<%
			for (Question q : list) {
				Date start = java.sql.Date.valueOf(q.getStartdate());
				Date end = java.sql.Date.valueOf(q.getEnddate());
		
				String status = "";
				if (today.before(start)) {
					status = "투표시작전";
				} else if (today.after(end)) {
					status = "투표종료";
				} else {
					status = "<a href='/poll/insertPollForm.jsp?num=" + q.getNum() + "'>투표하기</a>";
				}
		%>
			<tr>
				<td><%= q.getNum() %></td>
				<td>
					<a href="/poll/insertPollForm.jsp?num=<%= q.getNum() %>"><%= q.getTitle() %>
				</td>
				<td><%= q.getStartdate() %></td>
				<td><%= q.getEnddate() %></td>
				<td><%= q.getType() %></td>
				<td><%= status %></td>
				<td>
					<a href="/poll/deletePoll.jsp?qnum=<%=q.getNum()%>"> 삭제 </a>
				</td>
				<td>
					<a href="/poll/updatePollForm.jsp?qnum=<%= q.getNum() %>"> 수정 </a>
				</td>
				<td>
					<a href="/poll/updateQuestionEnddateForm.jsp?qnum=<%= q.getNum() %>"> 종료일자수정 </a>
				</td>
				<td>결과</td>
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
<!--요구사항
		// 삭제버튼 : 투표가 한명도 참여가 안됐으면 삭제가능
		 // 수정버튼 :  투표수정(원래내용 지우고 그 내용 재입력) (updatePollForm	-> updatePollAction : update question, delete item, insert item)
		 // 종료날짜수정버튼 : 아직 시작안했을때 종료날짜(오늘이전은 수정불가능)만 수정가능 updateQuestionEnddateForm.jsp  -->
</div>
</body>
</html>