<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>review List</title>
<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
        }
        main {
            max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h6 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #333;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 10px;
            text-align: center;
            vertical-align: middle;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f8f8f8;
        }
        .star-rating {
            font-size: 20px;
            color: #ffcc00;
        }
        .review-image img {
            width: 200px;
            border: 1px solid #ccc;
        }
        .review-content {
            font-size: 18px;
            color: #333;
            margin-bottom: 10px;
        }
        .author, .like-count {
            font-size: 16px;
            color: #555;
        }
        .pagination {
            text-align: center;
            margin-top: 20px;
        }
        .pagination a, .pagination span {
            display: inline-block;
            padding: 5px 10px;
            margin: 0 5px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            color: #555;
            cursor: pointer;
        }
        .pagination a:hover {
            background-color: #f2f2f2;
        }
        .current-page {
            background-color: #333;
            color: #fff;
        }
    </style>
</head>
<body>
    <%@ include file="../menu.jsp" %>
    <main>
        <h6>𝐫𝐞𝐯𝐢𝐞𝐰</h6>
        <table>
            <c:forEach var="r" items="${reviewList}" varStatus="loop">
                <c:if test="${loop.index % 4 == 0}">
                    <tr>
                </c:if>
                <td>
                    <div class="star-rating">
                        <c:forEach begin="1" end="${r.reviewStar}">
                            ★
                        </c:forEach>
                    </div>
                    <div class="review-image">
                        <a href="/review/get/${r.reviewNum}">
                            <img src="${pageContext.request.contextPath}/reviewPhoto/${fn:split(r.reviewAttachNames, ',')[0]}">
                        </a>
                    </div>
                    <div class="review-content">
                        <a href="/review/get/${r.reviewNum}">${r.reviewContents}</a>
                    </div>
                    <div class="author">
                        작성자: ${r.reviewAuthor}
                    </div>
                    <div class="like-count">
                        👍🏻 ${r.reviewLikeCnt}
                    </div>
                </td>
                <c:if test="${loop.index % 4 == 3 or loop.last}">
                    </tr>
                </c:if>
            </c:forEach>
        </table>
        <div class="pagination">
            <c:forEach var="pn" items="${pageInfo.navigatepageNums}">
                <c:choose>
                    <c:when test="${pn == pageInfo.pageNum}">
                        <span class="current-page">${pn}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="javascript:void(0);" onclick="loadReviewList(${itemNum}, ${pn});">${pn}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </main>
</body>
</html>