<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "model.*" %>
<%@ page import = "java.io.*" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String filename= request.getParameter("filename");

	//db삭제
	ImageDao imageDao = new ImageDao();
	imageDao.deleteImage(num);
	
	//파일삭제
	String path=request.getServletContext().getRealPath("upload");
 	File file = new File(path, filename); // new  file 경로에 파일이 없으면 빈파일을 생성
 	if(file.exists()){//빈파일이 아니라면
 		file.delete();
 	}
 	response.sendRedirect("/poll/imageboard/imageList.jsp");
%>
