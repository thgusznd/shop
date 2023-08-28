<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function logout() {
	if(!confirm('로그아웃할까요?')) return;
	$.ajax({
		url : '/member/logout',
		method:'get',
		cache:false,
		dataType:'json',
		success:function(res){
			alert(res.logout ? '로그아웃 성공':'로그아웃 실패');
			if(res.logout) location.href='/member/';
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
}
</script>
<script>
	// + 버튼을 눌렀을 때 item 들의 상세 카테고리가 나오게 하는 코드 
	function toggleTable() {
		var table = document.getElementById("additionalTable");
		var title = document.getElementById("title");
		var button = document.getElementById("toggleButton");

		if (table.style.display === "none") {
			table.style.display = "table"; // 테이블을 보여주고 
			button.innerText = "-"; // + 에서 - 로 아이콘 변경 
		} else {
			table.style.display = "none"; // 테이블을 숨기고 
			button.innerText = "+"; // - 에서 + 로 변경 
		}
	}
</script>
<style type="text/css">
	table#always {
       width: 100%;
       margin: 0 auto;
       border-collapse: collapse;
       background-color: white; 
       border: 1px solid #ccc;
       border-radius: 5px;
       margin-top: 20px;
       font-size: 10pt;
   }
   
   table#always td {
       padding: 10px;
       margin: 0;
   }
   #aseado {
       width: 100px;
       font-size: 25pt;
       font-weight: bold;
       padding-left: 20px;
   }
   a {
       text-decoration: none; 
       color: #333;
   }
   a:hover {
       color: #666; 
   }
   #toggleButton {
   	   font-size: 15pt;
   	   margin-left: 20px;
   }
   table#additionalTable {
  	   width:200px;
   	   margin-bottom: 40px;
   	   margin-left: 30%;
   }
   
</style>
</head>
<body>
	<table id="always">
		<tr>
		<td>
			<div class="aseado-container">
				<span id="aseado"><a href="/item/list/page/1">𝐚𝐬𝐞𝐚𝐝𝐨</a></span>
			</div>
		</td>
			<td><a id="title" onclick="toggleTable()">STORE</a>
				<a id="toggleButton" onclick="toggleTable()"> + </a>
			</td>
			<td>
			<a href="/notice/list">NOTICE</a> <br/>
			FAQ <br/>
			<a href="/question/list">Q&A </a>
			</td>
			<td><a href="/review/list">REVIEW</a></td>
			<td>
			<c:if test="${member.memberID == null}">
				<a href="/member/login">LOGIN</a><br/>
			</c:if>
			<c:if test="${member.memberID != null}">
				<a href="/member/mypage/${member.memberID}">MY PAGE</a><br/>
			</c:if>
			<a href="/cart/list">CART (0)</a><br/>
			<a href="javascript:logout();">LOGOUT</a>
			</td>	
		</tr>
	</table>
	<table id="additionalTable" style="display: none;">
		<tr>
			<td><a href="/item/list/page/1">All</a></td>
			<td><a href="/item/list/page/1/Top">Top</a></td>
			<td><a href="/item/list/page/1/Bottom">Bottom</a></td>
		</tr>
		<tr>
			<td><a href="/item/list/page/1/Outer">Outer</a></td>
			<td><a href="/item/list/page/1/Hat">Hat</a></td>
			<td><a href="/item/list/page/1/Bag">Bag</a></td>
		</tr>
		<tr>
			<td><a href="/item/list/page/1/Shoes">Shoes</a></td>
			<td><a href="/item/list/page/1/Beauty">Beauty</a></td>
			<td><a href="/item/list/page/1/Acc">Acc</a></td>
		</tr>
	</table>
</body>
</html>