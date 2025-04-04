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


	// 1. question 업데이트
	QuestionDao questionDao = new QuestionDao();
	Question q = new Question();
	q.setNum(Integer.parseInt(request.getParameter("qnum")));
	q.setTitle(request.getParameter("title"));
	q.setStartdate(request.getParameter("startdate"));
	q.setEnddate(request.getParameter("enddate"));
	q.setType(Integer.parseInt(request.getParameter("type")));
	questionDao.updateQuestion(q);
	

	// 2. 기존 item 삭제
	ItemDao itemDao = new ItemDao();
	Item item=itemDao.deleteItemTwo(qnum);
	
	// 3. 새 item 삽입(새로넣을값들 다 넣어줌)
	itemDao.insertItemList(qnum, contents);

	response.sendRedirect("/poll/pollList2.jsp");
%>