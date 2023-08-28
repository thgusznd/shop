<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>장바구니 목록</title>
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
	var qty = $('#qty'+cartNum).val();
	$.ajax({
		url:'/cart/update',
		method:'post',
		cache:false,
		dataType:'json',
		data: {
	            cartNum: cartNum,
	            qty: qty
	       	  },
		success:function(res){
			alert(res.updated ? '수정 성공':'수정 실패');
		},
		error:function(xhr,status,err){
			error('에러:' + status+"/"+err);
		}
	});
}

function removeItem() {
	if(!confirm('선택된 상품을 장바구니에서 제거하시겠어요?')) return false;
	var  formdata = $('#deleteForm').serialize();

	$.ajax({
		url:'/cart/delete',
		method:'Post',
		data:formdata,
		cache:false,
		dataType:'json',
		success:function(res){
			alert(res.deleted ? '삭제 성공':'삭제 실패');
			location.href="/cart/list";

		},
		error:function(xhr,status,err){
			alert('에러:'+status+"/"+err);
		}
	});
	
	return false;
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
	        cartnums.push($(this).val()); // 선택한 각 상품의 cartnum을 배열에 추가
	    });
	   var  formdata = $('#deleteForm').serialize();
	   alert(formdata);
	   $.ajax({
	      url:'/cart/delete',
	      method:'Post',
	      data:JSON.stringify(cartnums),
	      cache:false,
	      contentType: 'application/json',
	      dataType:'json',
	      success:function(res){
	         alert(res.deleted ? '삭제 성공':'삭제 실패');
	         location.href="/cart/list";

	      },
	      error:function(xhr,status,err){
	         alert('에러:'+status+"/"+err);
	      }
	   });
	   
	   return false;
	}

function clearCart() {
	   if(!confirm('정말로 장바구니를 비울까요?')) return;
	   $.ajax({
	      url:'/cart/clear',
	      method:'get',
	      cache:false,
	      dataType:'json',
	      success:function(res){
	         alert(res.cleared ? '장바구니를 비웠습니다':'비우기 실패');
	         location.href='/cart/list';
	      },
	      error:function(xhr,status,err){
	         alert('에러:'+status + '/' + err);
	      }
	   });
	   
	}
	
function add_Order(){ //결제
	if(!confirm("결제 하시겠습니까?")) return;
	
	var selectedItems = $("input[name=cartNum]:checked");
    if (selectedItems.length == 0) {
        alert("결제할 상품을 선택해주세요");
        return;
    }

    var cartnums = []; // 선택한 상품들의 cartnum을 담을 배열

    selectedItems.each(function() {
        cartnums.push($(this).val()); // 선택한 각 상품의 cartnum을 배열에 추가
    });

	$.ajax({
		url:"/order/add",
		method:'post', 
		contentType: 'application/json', // 요청의 Content-Type을 application/json으로 설정
		data:JSON.stringify(cartnums),
		success:function(res){
			alert(res.ordered ? '결제 완료' : '결제 실패');
			//location.href="/order/list";
		},
		error:function(xhr, status, err){
			alert(status + "/" + err);
		}
	});
}

</script>
</head>
<body>
<main>
<h2>${memberID}님의 장바구니</h2>
<form id="deleteForm" method="post" action="/cart/delete" onsubmit="return removeItem();">
<table>
<label>전체선택<input type="checkbox" id="cboxAll" name="cboxAll" onclick="checkAll();"></label>
<tr><th>번호</th><th>상품명</th><th>가격</th><th>수량</th><th><button type="submit">삭제</button></th></tr>
	<c:forEach var="c" items="${list}">
		<tr>
			<td>${c.cartNum}</td>
			<td>${c.itemNum}</td>
			<td>${c.price}</td>
			<td>
			<input type="number" class="quantity" id="quantity${c.cartNum}" value="${c.quantity}" min="1" max="50">
			<button type="button" onclick="modifyQty(${c.cartNum});">수정</button>
			</td>
			<td><input type="checkbox" name="cartNum" value="${c.cartNum}"></td>
		</tr>
	</c:forEach>
</table>
</form>
	<p>
	<nav>
		[<a href="/item/list">계속 쇼핑</a>]
		[<a href="javascript:add_Order();">결제</a>]
		[<a href="javascript:clearCart();">장바구니 비우기</a>]
	</nav>
</main>
</body>
</html>