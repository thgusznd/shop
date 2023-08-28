<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Page</title>
    
     <style>
        body {
            font-family: Arial, sans-serif;
            font-size: 10pt;
            margin: 20px;
            padding: 0;
            background-color: #f2f2f2;
            text-align: center;
        }
        h2 {
        	margin-top:100px;
            margin-bottom: 20px;
            padding-bottom: 5px;
            border-bottom: 1px solid #ccc;
            color: #333;
        }
        table#always {
            width: 100%;
            border-collapse: collapse;
            background-color: white; 
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 20px;
            font-size: 10pt;
        }
        
        table#always td {
            padding: 10px;
        }
        #pure {
            font-size: 25pt;
            font-weight: bold;
        }
        table#mypage {
            width: 80%;
            border-collapse: collapse;
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin: 10 auto;
        }
        table {
            width: 80%;
            border-collapse: collapse;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #ccc;
        }
        th {
            background-color: #f2f2f2;
        }
        button {
            padding: 10px 20px;
            background-color: #333;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }
        .mypage-btns {
            margin-bottom: 20px;
        }
        a {
            text-decoration: none; 
            color: #333;
        }

        a:hover {
            color: #666; 
        }
        #cpc{
        	text-align: right;
        }
        #cpcdata{
        	text-align: left;
        }
        .table-wrapper {
            margin-top: 50px; 
            display: flex;
            justify-content: center;
        }
    </style>

</head>
<body>
<%@ include file="../menu.jsp" %>
<h2>My Page</h2>

<button type="button">ORDER</button>
<button type="button">POINT</button>
<button type="button">COUPON</button>
<button type="button">QUESTION</button>
<button type="button" onclick="location.href='/member/mypage/edit/${member.memberID}'">PROFILE</button>
    <div class="table-wrapper">
    <table id="mypage">
       <tr>
	        <td colspan="4" rowspan="3">${member.memberName} 님은 현재 ${member.memberClass}입니다.</td>
	        <td rowspan="3" id="cpc">
	            CART<br/>
	            POINT<br/>
	            COUPON
	        </td>
	        <td rowspan="3" id="cpcdata">
	            0개 <br/>
	            <c:set var="point" value="${member.point}"/>
	            <fmt:formatNumber value="${point}" type="number"/>
	            원 <br/>
	            0개
	        </td>
    	</tr>
    </table>
    </div>
    
    <div class="table-wrapper">
    <table id="order">
    	<tr>
    		<th colspan="5">나의 주문처리 현황</th>
    	</tr>
    	<tr>
    		<th>배송준비중</th>
    		<th>배송중</th>
    		<th>배송완료</th>
    		<th rowspan="3" >
    			취소 <br/>
    			교환 <br/>
    			반품 
    		</th>
    	</tr>
    	<tr> 
    		<td>0</td><td>0</td><td>0</td> 
    		<td rowspan="3" > 
    			0 <br/>
    			0 <br/>
    			0
    		</td>
    	</tr>
    </table>
    </div>
</body>
</html>