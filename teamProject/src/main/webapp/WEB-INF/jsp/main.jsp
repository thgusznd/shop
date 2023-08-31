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

<div class="product-container">
   <c:forEach var="item" items="${topItems}">
      <div class="product">
         <a href="/item/detail/${item.itemNum}"><img src="${pageContext.request.contextPath}/items/${item.inames}"></a>
         <br/>
         <h4 class="product-name">${item.goods}</h4>
         <p class="product-price">${item.price}원</p>
         <br/>
         <div><label>구매횟수</label> ${item.purchaseCnt}</div>
      </div>
   </c:forEach>
</div>

<button type="button" onclick="location.href='/member/join'">회원가입</button>
<button type="button" onclick="location.href='/member/login'">로그인</button>
<button type="button" onclick="location.href='javascript:logout();'">로그아웃</button>
<button type="button" onclick="location.href='/member/mypage/${memberID}'">마이페이지</button>
</body>
</html>