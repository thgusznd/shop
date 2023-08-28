<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Item Detail</title>
<style>
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

	h3 {
		font-size: 24px;
		margin-bottom: 10px;
	}

	table {
		width: 100%;
		border-collapse: collapse;
		margin-top: 20px;
	}

	table th, table td {
		padding: 15px;
		border-bottom: 1px solid #ccc;
	}

	img {
		max-width: 100%;
		height: auto;
		border: 1px solid #ccc;
		border-radius: 5px;
	}

	#buttons {
		text-align: center;
		margin-top: 20px;
	}

	button {
		padding: 10px 20px;
		background-color: #333;
		color: #fff;
		border: none;
		border-radius: 5px;
		cursor: pointer;
		margin-right: 10px;
	}

	button:hover {
		background-color: #444;
	}
</style>
<script type="text/javascript">
	function delItem(itemNum) {
		if(!confirm('현재 아이템을 삭제하시겠습니까?')) return;
		$.ajax({
			url:'/item/delete/'+ itemNum,
			method:'get',
			cache:false,
			dataType:'json',
			success:function(res) {
				alert(res.deleteItem ? '삭제 성공':'삭제 실패');
				location.href='/item/list/page/1';
			},
			error:function(xhr,status,err){
				alert('에러:' + err);
			}
		});
	}
	return;
</script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
    function addCart() {
    	var formdata = $('#addCartForm').serialize();
    	$.ajax({
    		url:'/cart/addCart',
    		data:formdata,
    		method:'post',
    		cache:false,
    		dataType:'json',
    		success:function(res) {
    			alert(res.added ? '작성 완료':'작성 실패');
    			if(res.added) {
	            	if(!confirm("장바구니로 이동할까요?")) return;
	            	location.href = '/cart/list';
	            }
    		},
    		error:function(xhr,status,err){
    			alert('에러:' + err);
    		}
    	});
    	return false;
</script>

</head>
<body>
<%@ include file="../menu.jsp" %>
<main>
<form id="addCartForm" action="/cart/addCart" method="post" onsubmit="return addCart();">
	<input type="hidden" id="itemNum" name="itemNum" value="${item.itemNum}">
	<h3>${item.goods}</h3>
	<table>
		<tr>
			<td colspan="4">
				<c:forEach var="list" items="${item.attList}">
					<img src="<c:url value='/items/${list.itemAttachName}' />">
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th>판매가</th>
			<td colspan="3">
				<input type="hidden" id="price" name="price" value="${item.price}">
		    	<fmt:formatNumber value="${item.price}" type="number"/> 원 
			</td>
		</tr>
		<tr>
			<th>수량</th>
			<td>
				<input type="number" id="quantity" name="quantity" value="1" min="1" max="${item.inventory}">
			</td>
			<th>재고수량</th>
			<td>${item.inventory}</td>
		</tr>
		<tr>
			<td colspan="4" style="text-align: center;">
				<button type="submit">장바구니에 담기</button>
			</td>
		</tr>
		<tr>
			<td colspan="4">${item.explains}</td>
		</tr>
	</table>
</form>
	<p>
	<nav id="buttons">
		<c:if test="${member.memberClass == '관리자'}">
			<button type="button" onclick="location.href='/item/editForm/${item.itemNum}'">수정</button>
			<button type="button" onclick="javascript:delItem(${item.itemNum});">삭제</button>
		</c:if>
	</nav>
	
	===============
	리뷰 관련 칸 
</main>
</body>
</html>
