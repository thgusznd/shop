<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	body {
		font-family: Arial, sans-serif;
		margin: 0;
		padding: 0;
		background-color: #f2f2f2;
	}

	main {
		width: 80%;
		margin: 0 auto;
		margin-top: 30px;
		background-color: #fff;
		padding: 20px;
		border: 1px solid #ccc;
		border-radius: 5px;
	}

	h5 {
		font-size: 18px;
		text-align: center;
		margin-bottom: 20px;
	}

	.product-container {
		display: flex;
		flex-wrap: wrap;
	}

	.product {
		flex-basis: 25%;
		flex-grow: 1;
		box-sizing: border-box;
		padding: 10px;
	}

	img {
		width: 250px;
		height: 300px;
		margin-left: 20px;
	}

	@media (min-width: 768px) {
		img {
			width: 350px;
			height: 475px;
		}
	}

	#pagination {
		margin-top: 20px;
		text-align: center;
	}

	#pagination a {
		display: inline-block;
		padding: 5px 10px;
		margin: 2px;
		background-color: #333;
		color: #fff;
		text-decoration: none;
		border-radius: 3px;
	}

	#pagination a:hover {
		background-color: #444;
	}
</style>
</head>
<body>
<%@ include file="../menu.jsp" %>
<main>
	<c:if test="${keyword != null}">
		<h5>keyword : ${keyword}로 검색한 결과</h5>
	</c:if>
	<div class="product-container">
		<c:set var="itemNum" value="${0}"></c:set>
		<c:forEach var="item" items="${pageInfo.list}">
			<c:if test="${item.itemNum != itemNum}">
				<div class="product">
					<a href="/item/detail/${item.itemNum}">
						<img src="${pageContext.request.contextPath}/items/${fn:split(item.fnames, ',')[0]}">
					</a>
				</div>
			</c:if>
		</c:forEach>
	</div>
	<nav id="pagination">
		<c:forEach var="pn" items="${pageInfo.navigatepageNums}">
			<c:choose>
				<c:when test="${pn == pageInfo.pageNum}">
					<span id="pageNum">${pn}</span>
				</c:when>
				<c:otherwise>
					<c:url value="/item/list/page/${pn}" var="pgURL">
						<c:if test="${keyword != null}">
							<c:param name="keyword" value="${keyword}" />
						</c:if>
					</c:url>
					<a href="${pgURL}">${pn}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</nav>
</main>
</body>
</html>
