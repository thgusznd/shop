<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>전체 주문 내역</title>
</head>
<body>
<main>
<h3>전체 주문 내역</h3>
<table>
<tr><th>결제일</th><th>주문번호</th><th>상품별 주문번호</th><th>상품명</th><th>옵션정보</th><th>수량</th><th>주문자명</th><th>주문상태</th></tr>
	<c:forEach var="o" items="${orderList_admin}">
		<tr>
			<td>${o.paymentDate}</td>
			<td>${o.orderNum}</td>
			<td>${o.itemOrderNum}</td>
			<td>${o.goods}</td>
			<td>${o.option1}</td>
			<td>${o.quantity}</td>
			<td>${o.buyer}</td>
			<td>${o.orderStatus }</td>
		</tr>	
	</c:forEach>
</table>
</main>
</body>
</html>