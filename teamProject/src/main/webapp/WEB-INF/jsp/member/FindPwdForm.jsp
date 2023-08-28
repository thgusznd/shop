<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find Pwd</title>
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
	<style>
	  body {
	    font-family: Arial, sans-serif;
	    margin: 20px;
	    background-color: #f2f2f2;
	    color: #333;
	  }
	
	  h3 {
	    margin-bottom: 20px;
	    padding-bottom: 5px;
	    border-bottom: 1px solid #ccc;
	    color: #333;
	  }
	
	  form {
	    max-width: 400px;
	    margin: 0 auto;
	    padding: 20px;
	    background-color: #fff;
	    border: 1px solid #ccc;
	    border-radius: 5px;
	  }
	
	  div {
	  	margin-top:10px;
	    margin-bottom: 10px;
	  }
	
	  label {
	    display: block;
	    font-weight: bold;
	  }
	
	  input[type="text"] {
	    width: 95%;
	    padding: 10px;
	    margin-top:10px;
	    margin-bottom: 10px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	  }
	
	  button[type="submit"] {
	    padding: 10px 20px;
	    background-color: #333;
	    color: #fff;
	    border: none;
	    border-radius: 4px;
	    cursor: pointer;
	  }
	
	  button[type="submit"]:hover {
	    background-color: #555;
	  }
	  
	  fieldset {
	   	text-align:center;
	   	border: none;
	   	padding: 0;
	   	margin: 0;
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
</style>

<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
  function findPwd() {
	var formdata = $('#findPwd').serialize();
  
    $.ajax({
      url: '/member/findID',
      data: formdata,
      method: "post",
      cache: false,
      dataType: 'json',
      success: function (res) {
        if(res.found){
        	location.href="/member/showPwd/"+res.foundMember.memberID;
        } else {
          alert(res.msg);
        }
      },
      error: function (err) {
        alert(err);
      }
    });
    return false;
  }
  
  function showInput(inputType) {
      if (inputType === 'email') {
          document.getElementById('emailInput').style.display = 'block';
          document.getElementById('phoneInput').style.display = 'none';
      } else if (inputType === 'phone') {
          document.getElementById('emailInput').style.display = 'none';
          document.getElementById('phoneInput').style.display = 'block';
      }
  }
</script>
</head>
<body>
<%@ include file="../menu.jsp" %>
<form id="findPwd" action="/member/findPwd" method="post" onsubmit="return findPwd();">
	<fieldset>
    <h3>Find Pwd</h3>
	    <input type="radio" id="findTypeEmail" name="findType" value="memberEmail" onclick="showInput('email')" checked> 이메일
	    <input type="radio" id="findTypePhone" name="findType" value="memberPhone" onclick="showInput('phone')"> 휴대폰번호
	</fieldset>
	id <input type="text" id="memberID" name="memberID">
	name <input type="text" id="memberName" name="memberName">
	<div id="emailInput">
	    e-mail <input type="text" id="memberEmail" name="memberEmail">
	</div>
	<div id="phoneInput" style="display:none;">
	    mobile <input type="text" id="memberPhone" name="memberPhone">
	</div>
	<div>
    <button type="submit">OK</button>
	</div>
</form>
</body>
</html>