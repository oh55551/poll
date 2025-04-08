<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "model.*"%>
<%@ page import= "dto.*"%>
<%
		int num = Integer.parseInt(request.getParameter("num"));
		String name = request.getParameter("name");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		String ip = request.getParameter("ip"); 
		int ref = Integer.parseInt(request.getParameter("ref"));
		int pos = Integer.parseInt(request.getParameter("pos"));
		int depth = Integer.parseInt(request.getParameter("depth"));
		int count = Integer.parseInt(request.getParameter("count"));

		
	BoardDao boardDao = new BoardDao();
	Board b = new Board();
		b.setNum(num);
		b.setName(name);
		b.setSubject(subject);
		b.setContent(content);
		b.setIp(ip);
		b.setRef(ref);
		b.setPos(pos);
		b.setDepth(depth);
		b.setCount(count);

	boardDao.updateBoard(b);
	response.sendRedirect("/poll/board/boardList.jsp");
%>