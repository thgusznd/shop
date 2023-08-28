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
    margin: 0;
    padding: 20px;
    background-color: #f2f2f2;
  }

  h3 {
    margin-bottom: 20px;
    padding-bottom: 5px;
    border-bottom: 1px solid #ccc;
    color: #333;
  }

  table {
    width: 100%;
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

  th {
    background-color: #f2f2f2;
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
<h3>NOTICE</h3>
<table>
  <tr>
    <th>NO</th><th>SUBJECT</th><th>DATE</th>
  </tr>
  <c:forEach var="n" items="${noticeList}">
    <tr>
      <td>${n.noticeNum}</td>
      <td><a href="/notice/detail/${n.noticeNum}">${n.noticeTitle}</a></td>
      <td>${n.noticeDate}</td>
    </tr>
  </c:forEach>
</table>
<c:if test="${member.memberClass == '관리자'}">
  <button type="button" onclick="location.href='/notice/addForm'">새로운 글 작성</button>
</c:if>
  <button type="button" onclick="location.href='/member/mypage/${member.memberID}'">(임시)마이페이지</button>
</body>
</html>