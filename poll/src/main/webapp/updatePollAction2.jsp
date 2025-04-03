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
	Question q = new Question();
		q.setNum(qnum);
		q.setTitle(title);
		q.setStartdate(startdate);
		q.setEnddate(enddate);
		q.setType(type);

	// 2. 기존 item 삭제
	ItemDao itemDao = new ItemDao(); 
	int inum = 1;	

	for (String content : contents) {
	    if (content != null && !content.trim().equals("")) {
	        Item item = new Item();          // DTO 객체 생성
	        item.setQnum(qnum);              // 설문 번호
	        item.setInum(inum++);            // 보기 번호 (자동 증가)
	        item.setContent(content);        // 보기 내용
	
	        itemDao.insertItem(item);        // DAO를 통해 DB 삽입
	    }
	}
	
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