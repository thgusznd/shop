<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NOTICE</title>
<style>
  body {
    font-family: Arial, sans-serif;
    margin:0 auto;
    padding: 20px;
    text-align: center;
  }

  h3 {
  	width: 80%;
  	margin:0 auto;
    margin-bottom: 20px;
    padding-bottom: 5px;
    border-bottom: 1px solid #ccc;
    text-align:left;
    color: #333;
  }

  table {
    width: 80%;
    margin:0 auto;
    border-collapse: collapse;
    background-color: #fff;
    border: 1px solid #ccc;
    border-radius: 5px;
  }

  th, td {
    padding: 10px;
    text-align: left;
    border-bottom: 1px solid #ccc;
  }

  a {
    text-decoration: none;
    color: #333;
  }

  a:hover {
    text-decoration: underline;
  }

  button {
    padding: 10px 20px;
    background-color: #333;
    margin-top:10px;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    
  }

  button:hover {
    background-color: #555;
  }
</style>
</head>
<body>
<%@ include file="../menu.jsp" %>
<h3>QUESTION</h3>
	<table>
	  <tr>
	    <th>NO</th><th>SUBJECT</th><th>WRITER</th><th>DATE</th>
	  </tr>
	  <c:forEach var="q" items="${questionList}">
	    <tr>
	      <td>${q.questionNum}</td>
	      <td><a href="/question/detail/${q.questionNum}">${q.questionTitle}</a></td>
	      <td>${q.questionAuthor}</td>
	      <td>${q.questionDate}</td>
	    </tr>
	  </c:forEach>
	</table>
	<c:if test="${member.memberClass == '관리자'}">
	  <button type="button" onclick="location.href='/question/add'">새로운 글 작성</button>
	</c:if>
</body>
</html>