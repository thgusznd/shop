<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>로그인</title>
  <script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
  <script type="text/javascript">
    function login() {
      var formdata = $('#loginForm').serialize();
      $.ajax({
        url: '/member/login',
        data: formdata,
        method: "post",
        cache: false,
        dataType: 'json',
        success: function (res) {
          if (res.login == true) {
            alert("로그인 성공");
            location.href = "/member/mypage/" + res.memberID;
          } else {
            alert("로그인 실패");
          }
        },
        error: function (err) {
          alert(err);
        }
      });
      return false;
    }
  </script>
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
				if(res.logout) location.href='/member/login';
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

    form {
      margin:0 auto;
      border: 1px solid #ccc;
      border-radius: 5px;
      background-color: #fff;
      padding: 20px;
      max-width: 400px;
    }

    h2 {
      color: #333;
      font-size: 24px;
      text-align: center;
      margin-bottom: 20px;
    }

    input[type="text"],
    input[type="password"] {
      width: 90%;
      padding: 10px;
      margin-bottom: 15px;
      border: 1px solid #ccc;
      border-radius: 4px;
      outline: none;
      transition: border-color 0.3s ease-in-out;
    }

    input[type="text"]:focus,
    input[type="password"]:focus {
      border-color: #666;
    }

    button[type="submit"] {
      width: 100%;
      padding: 12px;
      background-color: #333;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
      margin-bottom: 10px;
    }

    button[type="button"] {
      background-color: transparent;
      border: none;
      color: #666;
      cursor: pointer;
      font-size: 14px;
      margin-right: 10px;
    }

    button[type="button"]:last-child {
      margin-right: 0;
    }

    .action-buttons {
      display: flex;
      justify-content: space-between;
    }

    .join-button {
      width: 100%;
      padding: 12px;
      background-color: #444;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
    }

    .join-button:hover {
      background-color: #555;
    }
  </style>
</head>
<body>
<%@ include file="../menu.jsp" %>
	<br>
	<form id="loginForm" action="/member/login" method="post" onsubmit="return login();">
	  <h2>Login</h2>
	  <div>
	    <input type="text" id="memberID" name="memberID" placeholder="ID" onfocus="this.placeholder=''" onblur="this.placeholder='ID'">
	  </div>
	  <div>
	    <input type="password" id="memberPwd" name="memberPwd" placeholder="PASSWORD" onfocus="this.placeholder=''" onblur="this.placeholder='PASSWORD'">
	  </div>
	  <div>
	    <button type="submit">Login</button>
	  </div>
	  <div class="action-buttons">
	    <button type="button" onclick="location.href='/member/findIDForm'">Forgot ID?</button>
	    <button type="button" onclick="location.href='/member/findPwdForm'">Forgot PW?</button>
	  </div>
	  <div>
	    <button type="button" class="join-button" onclick="location.href='/member/join'">회원가입</button>
	  </div>
	</form>
</body>
</html>