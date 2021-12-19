<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
	<meta charset="utf-8">
	<title>Home</title>
</head>
<body>
<h1>
	Hello 
</h1>

<P>  The time on the server is ${serverTime}. </P>
<a href="/member/login">로그인</a>
<a href="/main">메인페이지</a>
<a href="/board/list">문의</a>
<a href="/video/list">동영상게시판</a>

<p>일반 아이디 </p>

<p>관리자 아이디</p>
</body>

</html>
