<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, dto.*, model.*" %>
<%
	//값 가져오기
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	QuestionDao questionDao = new QuestionDao();
	ItemDao itemDao = new ItemDao();
	Question question = questionDao.selectQuestionOne(qnum);
	Question q=new Question();




	// item 목록 가져오기
	ArrayList<Item> itemList = itemDao.selectItemListByQnum(qnum);
	
	// 항목이 전부 다르므로 분리해서 저장 할 수 있게 배열생성
	String[] contents = new String[8];
	for (int i = 0; i < 8; i++) {
		if (itemList.size() > i) {
			contents[i] = itemList.get(i).getContent();
		} else {
			contents[i] = "";
		}
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문 수정</title>
</head>
<body>
<h2>설문 수정</h2>
<form action="/poll/updatePollAction2.jsp" method="post">
	<input type="hidden" name="qnum" value="<%= qnum %>">
	<table border="1">
			<tr>
				<td>질문</td>
				<td colspan="2">
					<input type="text" name="title" value="<%= q.getTitle() %>">
				</td>
			</tr>
			
			<tr>
				<td rowspan="8">항목</td>
				<td>1) <input type="text" name="content" value="<%= contents[0] %>"></td>
				<td>2) <input type="text" name="content" value="<%= contents[1] %>"></td>
			</tr>
			
			<tr>
				<td>3) <input type="text" name="content" value="<%= contents[2] %>"></td>
				<td>4) <input type="text" name="content" value="<%= contents[3] %>"></td>
			</tr>
			<tr>
				<td>5) <input type="text" name="content" value="<%= contents[4] %>"></td>
				<td>6) <input type="text" name="content" value="<%= contents[5] %>"></td>
			</tr>
			<tr>
				<td>7) <input type="text" name="content" value="<%= contents[6] %>"></td>
				<td>8) <input type="text" name="content" value="<%= contents[7] %>"></td>
			</tr>
			<tr>
				<td>시작일</td>
				<td><input type="date" name="startdate" value="<%=  q.getStartdate() %>"></td>
			</tr>
			<tr>
				<td>종료일</td>
				<td><input type="date" name="enddate" value="<%= q.getEnddate() %>"></td>
			</tr>
			<tr>
				<td>복수투표</td>
				<td>
					<input type="radio" name="type" value="1">yes
					<input type="radio" name="type" value="0">no
				</td>
			</tr>
	</table>
	<button type="submit">수정 완료</button>
	<a href="/poll/pollList2.jsp">취소</a>
</form>
</body>
</html>