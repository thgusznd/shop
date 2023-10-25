<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰</title>
<style>
	body {
		font-family: Arial, sans-serif;
		margin: 0;
		padding: 0;
		background-color: #f2f2f2;
	}

	#container {
		width: 80%;
		margin: 0 auto;
		margin-top: 30px;
		background-color: #fff;
		padding: 20px;
		border: 1px solid #ccc;
		border-radius: 5px;
	}

	.product-container {
		display: flex;
		flex-wrap: wrap;
		justify-content: space-between;
		margin-top: 20px;
	}

	.product {
		flex-basis: 19%;
		box-sizing: border-box;
		padding: 20px;
		margin-bottom: 20px;
		background-color: #fff;
		border: 1px solid #ccc;
		border-radius: 5px;
	}

	.product a {
		text-decoration: none;
		color: #333;
	}

	.product img {
		max-width: 100%;
		height: auto;
		border: 1px solid #ccc;
		border-radius: 5px;
		margin-bottom: 10px;
	}

	.product #itemPrice {
		margin-top: 10px;
		color: #666;
		text-align: right;
	}

	.product #itemName {
		margin-bottom: 10px;
		font-weight: bold;
	}

	.product #reviewLikeCnt {
		margin-top: 10px;
		color: #666;
	}

	.product #reviewLikeCnt {
		font-size: 0.8em;
	}

	@media (max-width: 768px) {
		.product {
			flex-basis: 100%;
		}
	}
</style>
</head>
<body>
<%@ include file="menu.jsp" %>

<div id="container">
	<h2>🔥 𝐓𝐨𝐩 𝟏𝟎 𝐏𝐨𝐩𝐮𝐥𝐚𝐫 𝐈𝐭𝐞𝐦𝐬 </h2>
	<div class="product-container">
	   <c:forEach var="item" items="${topItems}">
	      <div class="product">
	         <div id="itemImage">
	         	<a href="/item/detail/${item.itemNum}">
	         	<img src="${pageContext.request.contextPath}/items/${fn:split(item.inames, ',')[0]}">
	         </div>
	         <div id="itemName">
	         	<a href="/item/detail/${item.itemNum}">${item.goods}</a>
	         </div>
	         <div id="itemPrice">
	         	<fmt:formatNumber value="${item.price}" type="number"/> 원
	         </div>
	      </div>
	   </c:forEach>
	</div>
	
	<h2>🔥 𝐓𝐨𝐩 𝟓 𝐁𝐞𝐬𝐭 𝐑𝐞𝐯𝐢𝐞𝐰𝐬 </h2>
	<div class="product-container">
	   <c:forEach var="review" items="${topReviews}">
	      <div class="product">
	         <div id="reviewImage">
	         	<a href="/review/get/${review.reviewNum}"><img src="${pageContext.request.contextPath}/reviewPhoto/${fn:split(review.reviewAttachNames, ',')[0]}"></a>
	         </div>
	         <div id="reviewContents">
	         	<a href="/review/get/${review.reviewNum}">${review.reviewContents}</a>
	         </div>
	         <div id="reviewLikeCnt">
	         	👍🏻 ${review.reviewLikeCnt}
	         </div>
	      </div>
	   </c:forEach>
	</div>
</div>
</body>
</html>