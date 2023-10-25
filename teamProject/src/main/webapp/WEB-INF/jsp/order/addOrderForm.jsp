<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Order Form</title>
	<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
        }
        .order-container {
            max-width: 1000px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h3 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            margin-top: 50px;
        }
        form {
            text-align: left;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: left;
            vertical-align: middle;
            border-bottom: 1px solid #ddd;
        }
        .totalPrice th {
		    width: 100px; 
		    word-wrap: break-word;
		}
        select, input[type="submit"] {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 100%;
            box-sizing: border-box;
            margin-bottom: 10px;
        }
        input[type="hidden"] {
            display: none;
        }
        button[type="submit"] {
            display: block;
            margin: 0 auto;
            background-color: #333;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            padding: 10px 20px;
            transition: background-color 0.3s;
        }
        button[type="submit"]:hover {
            background-color: #555;
        }
        .product-row {
		    border-bottom: 1px solid #ddd;
		}
		
		.product-image img {
		    max-width: 100px;
		    border: 1px solid #ccc;
		}
		
		.product-name,
		.product-price,
		.product-quantity,
		.product-subtotal {
		    padding: 10px;
		    text-align: center;
		    vertical-align: middle;
		}
		
		.product-price,
		.product-subtotal {
		    font-weight: bold;
		}
		
		.product-quantity {
		    font-style: italic;
		}
		
		.product-row th {
		    text-align: center;
		}
		
		.paymentMethod th{
			width: 130px;
		}
		
		table.totalPrice tr:nth-child(4) td {
		    color: blue; 
		}
    </style>
	<script type="text/javascript">
    var shippingFee = parseInt(document.getElementById("shippingFee").value);
    var totalPrice = parseInt(document.getElementById("totalPrice").value);
    
    function updateReserveDiscount() {
        var reserveDiscount = parseInt(document.getElementById("reserveDiscount").value);
        
        console.log("reserveDiscount:", reserveDiscount);
        console.log("totalPrice:", totalPrice);
        console.log("shippingFee:", shippingFee);
        
        var finalPrice = totalPrice - reserveDiscount + shippingFee;
        
        document.getElementById("paymentButton").innerText = finalPrice.toLocaleString() + "원 결제하기";
    }
</script>
</head>
<body>
	<%@ include file="../menu.jsp" %>
	<div class="order-container">
		<h3>𝐎𝐫𝐝𝐞𝐫 / 𝐏𝐚𝐲𝐦𝐞𝐧𝐭</h3>
		<form id="addOrderForm" method="post" action="/order/add" onsubmit="return addOrderForm();">
		<table>
			<tr><th>배송지 정보</th></tr>
		    <tr>
		        <td>
		            <input type="hidden" name="payeeName" id="payeeName" value="${member.memberName}">
		            <input type="hidden" name="contact" id="contact" value="${member.memberPhone}">
		            ${member.memberName} <br> ${member.memberPhone}
		        </td>
		    </tr>
		    <tr>
		        <td colspan="4">
		            (${member.post}) ${member.address} ${member.detailAddress}
		        </td>
		    </tr>
		    <tr>
		        <td colspan="4">
		            <select name="shippingNote" id="shippingNote">
		                <option value="1">부재 시 경비실에 맡겨주세요</option>
		                <option value="2">부재 시 택배함에 넣어주세요</option>
		                <option value="3">부재 시 집 앞에 놔주세요</option>
		                <option value="4">배송 전 연락 바랍니다</option>
		                <option value="5">파손의 위험이 있는 상품입니다. 배송 시 주의해 주세요</option>
		                <option value="6">직접입력</option>
		            </select>
		        </td>
		    </tr>
		</table>
		<h3>상품 정보</h3>
		<table>
			<tr class="product-row">
				<th colspan="2">상품정보</th>
				<th>가격</th>
				<th>수량</th>
				<th>합계</th>
			</tr>
			
			<c:set var="totalPrice" value="0" />
			<c:set var="subtotal" value="${c.price * c.quantity}" />
			<c:set var="finalPrice" value="0" />
			
			<c:set var="totalSaveMoney" value="0" />
			<c:set var="subtotalSaveMoney" value="0" />
			
			<c:forEach var="c" items="${cartList}">
			    <tr class="product-row">
			        <td class="product-image">
			            <input type="hidden" name="itemNum" id="itemNum" value="${c.itemNum}">
			            <a href="/item/detail/${c.itemNum}">
			                <img class="product-image" src="${pageContext.request.contextPath}/items/${fn:split(c.fnames, ',')[0]}">
			            </a>
			        </td>
			        <td class="product-name">
			            ${c.goods}
			        </td>
			        <td class="product-price">
			            <input type="hidden" name="itemSellingPrice" id="itemSellingPrice" value="${c.price}">
			            <fmt:formatNumber value="${c.price}" type="number"/>원
			        </td>
			        <td class="product-quantity">
			            <input type="hidden" name="quantity" id="quantity" value="${c.quantity}">
			            ${c.quantity}개
			        </td>
			        <td class="product-subtotal">
			            <c:set var="subtotal" value="${c.price * c.quantity}" />
			            <c:set var="subtotalSaveMoney" value="${subtotal * 0.01}" />
			            <fmt:formatNumber value="${subtotal}" type="number"/>원
			        </td>
			    </tr>
			    <c:set var="totalPrice" value="${totalPrice + subtotal}" />
			    <input type="hidden" id="totalPrice" name="totalPrice" value="${totalPrice}">
			    <c:set var="totalSaveMoney" value="${totalSaveMoney + subtotalSaveMoney}" />
			</c:forEach>
		</table>
		
		<h3>할인/적립금/배송비</h3>
		<table class="totalPrice">
			<c:set var="shippingFee" value="0" />
				<tr>
					<th>상품 금액</th>
					<td><fmt:formatNumber value="${totalPrice}" type="number"/>원</td>
				</tr>
				<tr>
				    <th>적립금 사용</th>
				    <c:set var="reserveDiscount" value="0" />
				    <td>
				        <c:if test="${member.saveMoney >= 5000}">
							<input type="number" name="reserveDiscount" id="reserveDiscount" oninput="updateReserveDiscount()" value="0" min="0" max="${member.saveMoney}" />
				        </c:if>
					    <fmt:formatNumber value="${member.saveMoney}" type="number"/> 원 
				    </td>
				</tr>
				<tr>
					<th>적립 예상 금액</th>
					<td><fmt:formatNumber value="${totalSaveMoney}" type="number"/> 원 </td>
				</tr>
				<tr>
					<th>배송비</th>
					<td>
						<c:if test="${totalPrice>=200000}"> 
							<span style="color: blue;">배송비 무료</span>
							<c:set var="shippingFee" value="0" />
						</c:if>
						<c:if test="${totalPrice<200000}"> 
							<span style="color: black;">3,000 원</span>
							<c:set var="shippingFee" value="3000" />
						</c:if>
						<input type="hidden" id="shippingFee" name="shippingFee" value="${shippingFee}">
					</td>
				</tr>
				<c:set var="finalPrice" value="${totalPrice - reserveDiscount + shippingFee}" />
		</table>
		
		<h3>결제 정보</h3>
		<table class="paymentMethod">
			<tr>
				<th>결제 수단</th>
					<td>
						카드 결제 <br>
						무통장 입금
					</td>
			</tr>
			<tr>
				<th>품절 시 환불 안내</th>
				<td>결제하신 수단으로 취소됩니다.<br>
				 현금 환불의 경우, 예금정보가 일치해야 환불 처리가 가능합니다. 은행명, 계좌번호, 예금주명을 정확히 기재 부탁드립니다.<br>
				 환불 받으신 날짜 기준으로 3~5일(주말 제외) 후 결제대행사에서 직접 고객님의 계좌로 환불 처리됩니다.
				</td>
			</tr>
		</table> 
			<button type="submit" id="paymentButton">
	    		<fmt:formatNumber value="${finalPrice}" type="number"/>원 결제하기
			</button>
		</form>
	</div>
</body>
</html>