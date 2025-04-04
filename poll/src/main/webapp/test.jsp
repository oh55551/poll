<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

	<meta charset="UTF-8">
	<title></title>
	<!-- CSS 스타일 정의 -->
	<style>
		p {color:orange;}
		#one {color : blue;}
		.two {color : green;} /*클래스명이 two */
		.three {background-color: yellow;}
	</style>
</head>
<body>
	<div>Good</div>
	<p>Good</p>
	
	<div id="one">Good</div> <!-- id가 같은거 있으면안됨 가능(자바에서 오류날수있어서) -->
	
	<div class="two">Good</div> <!-- 클래스는 여러개 ㄱㅊ -->
	<div class="two three">Test</div>

</body>
</html>