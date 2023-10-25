<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>장바구니 목록</title>
<link rel="stylesheet" type="text/css" href="styles.css"> 
<style type="text/css">
	body {
	    font-family: Arial, sans-serif;
	    margin: 0;
	    padding: 0;
	    background-color: #f2f2f2;
	}
	
	main {
	    max-width: 800px;
	    margin: 20px auto;
	    background-color: #fff;
	    padding: 20px;
	    border: 1px solid #ccc;
	    border-radius: 5px;
	    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	}
	
	h2 {
	    text-align: center;
	}
	
	table {
	    width: 100%;
	    border-collapse: collapse;
	    margin-top: 20px;
	}
	
	th, td {
	    padding: 10px;
	    text-align: center;
	    border-bottom: 1px solid #ccc;
	}
	
	th {
	    background-color: #f9f9f9;
	}
	
	.product-image img {
	    max-width: 100px;
	    height: auto;
	}
	
	.quantity input {
	    width: 40px;
	    padding: 5px;
	    text-align: center;
	}
	
	button {
	    padding: 8px 16px;
	    background-color: #333;
	    color: #fff;
	    border: none;
	    border-radius: 5px;
	    cursor: pointer;
	    margin: 5px;
	}
	
	button:hover {
	    background-color: #444;
	}
	
	#buttons {
	    text-align: right;
	    margin-top: 20px;
	}
	
	#buttons button {
	    margin-left: 10px;
	}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function checkAll() {
    if($("#cboxAll").is(':checked')) {
        $("input[name=cartNum]").prop("checked", true);
    } else {
        $("input[name=cartNum]").prop("checked", false);
    }
}

function modifyQty(cartNum) { //수량 수정 
	var quantity = $('#quantity'+cartNum).val();
	$.ajax({
		url:'/cart/update',
		method:'post',
		cache:false,
		dataType:'json',
		data: {
	            cartNum: cartNum,
	            quantity: quantity
	       	  },
		success:function(res){
			alert(res.updated ? '수정 성공':'수정 실패');
			location.reload();
		},
		error:function(xhr,status,err){
			error('에러:' + status+"/"+err);
		}
	});
}

function removeItem() {   
	   if(!confirm('선택된 상품을 장바구니에서 제거하시겠어요?')) return false;
	   
	   var selectedItems = $("input[name=cartNum]:checked");
	    if (selectedItems.length == 0) {
	        alert("삭제할 상품을 선택해주세요");
	        return;
	    }
	    var cartnums = [];
	    selectedItems.each(function() {
	        cartnums.push($(this).val()); 
	    });
}


function clearCart() {
	   if(!confirm('정말로 장바구니를 비울까요?')) return;
	   $.ajax({
	      url:'/cart/clear',
	      method:'get',
	      cache:false,
	      dataType:'json',
	      success:function(res){
	    	  if(res.msg){
			  		alert(res.msg);
			  }else{
		  	  		alert(res.cleared ? '장바구니 비우기 완료' : '장바구니 비우기 에러');
			  		location.href="/cart/list";
			  }
	      },
	      error:function(xhr,status,err){
	         alert('에러:'+status + '/' + err);
	      }
	   });
	   return false;
	}
	
function add_Order() {
    if (!confirm("결제 하시겠습니까?")) return;
    var cartnums = [];
    $("input[name=cartNum]:checked").each(function() {
    	cartnums.push($(this).val());
    });

    if (cartnums.length === 0) {
        alert("결제하실 상품을 먼저 선택해주세요.");
        return false;
    }
    return true;

}

</script>
</head>
<body>
<%@ include file="../menu.jsp" %>
<main>
<h2>${memberID}님의 장바구니</h2>
<form id="orderForm" method="post" action="/order/addOrderForm" onsubmit="return add_Order();">
<table>
	<label>전체선택<input type="checkbox" id="cboxAll" name="cboxAll" onclick="checkAll();"></label>
	<tr>
		<th><button type="button" onclick="location.href='javascript:removeItem()'">삭제</button></th>
		<th></th>
		<th>상품명</th>
		<th>가격</th>
		<th>수량</th>
	</tr>
	<c:forEach var="c" items="${list}">
      <tr>
      	 <td>
      	 	<input type="checkbox" name="cartNum" value="${c.cartNum}">
      	 </td>
         <td class="product-image">
             <a href="/item/detail/${c.itemNum}">
             <img src="${pageContext.request.contextPath}/items/${fn:split(c.fnames, ',')[0]}"></a>
         </td>
         <td>${c.goods}</td>
         <td>${c.price}</td>
         <td>
			<input type="number" class="quantity" id="quantity${c.cartNum}" value="${c.quantity}" min="1" max="50">
			<button type="button" onclick="modifyQty(${c.cartNum});">수정</button>
			</td>
		</tr>
	</c:forEach>
</table>
	<p>
	<div id="buttons">
		<button type="button" onclick="location.href='/item/list/page/1'">계속 쇼핑</button>
		<button type="submit">결제</button>
		<button type="button" onclick="location.href='javascript:clearCart();'">장바구니 비우기</button>
	</div>
</form>
</main>
</body>
</html>