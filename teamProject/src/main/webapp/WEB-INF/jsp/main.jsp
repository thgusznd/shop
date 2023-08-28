<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰</title>
</head>
<body>
<%@ include file="menu.jsp" %>
<button type="button" onclick="location.href='/member/join'">회원가입</button>
<button type="button" onclick="location.href='/member/login'">로그인</button>
<button type="button" onclick="location.href='javascript:logout();'">로그아웃</button>
<button type="button" onclick="location.href='/member/mypage/${memberID}'">마이페이지</button>
</body>
</html>