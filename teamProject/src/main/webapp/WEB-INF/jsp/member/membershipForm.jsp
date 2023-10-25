<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style type="text/css">
	body {
	    font-family: Arial, sans-serif;
	    margin: 0;
	    padding: 20px;
	    background-color: #f2f2f2;
	}
	
	.container {
	    width: 50%;
	    margin: 0 auto;
	    background-color: #fff;
	    padding: 20px;
	    border: 1px solid #ccc;
	    border-radius: 5px;
	    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
	}
	
	form {
	    max-width: 500px;
	    margin: 0 auto;
	}
	
	h1 {
	    text-align: center;
	    margin-bottom: 20px;
	}
	
	.form-group {
	    margin-bottom: 15px;
	}
	
	label {
	    display: block;
	    font-weight: bold;
	    margin-bottom: 5px;
	}
	
	input[type="text"],
	input[type="password"],
	input[type="email"],
	input[type="date"],
	input[type="tel"]{
	    width: 80%;
	    padding: 10px;
	    border: 1px solid #ccc;
	    border-radius: 5px;
	    box-sizing: border-box;
	}
	
	.button-style {
		width:120px;
	    padding: 10px;
	    background-color: #333;
	    color: #fff;
	    border: none;
	    border-radius: 5px;
	    cursor: pointer;
	    font-size: 16px;
	    margin-top: 10px;
	}
	
	.button-style:hover {
	    background-color: #444;
	}
	
	.input-button-group {
        display: flex;
        align-items: center;
    }

    .input-button-group input[type="text"],
    .input-button-group input[type="email"] {
        margin-right: 10px;
    }
</style>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="/resources/js/join.js"></script>
<script type="text/javascript">
	function checkId(){
		let memberID = $("#memberID").val();
		let idCheck = document.getElementsByClassName("idCheck");
		$.ajax({
			url:'/member/checkId',   
			type:'post',  
			data:{memberID:memberID},   
			dataType:'JSON',   
			success : function(checkID){  
				if(memberID.length < 1){
					idCheck[0].textContent = "아이디를 입력해주세요";
					idCheck[0].style.color = 'red';
				}
				else if(checkID != false){
					 idCheck[0].textContent = "사용할 수 있는 아이디입니다.";
					 idCheck[0].style.color = 'blue';
				}
				 else{
					 idCheck[0].textContent = "이미 존재하는 아이디입니다.";
					 idCheck[0].style.color = 'red';
				 }
			},
			error:function(){
				console.log("에러")
			}
		});
	}
	
	//비밀번호 유효성체크
	function checkPw(){
		let memberPwd = $("#memberPwd").val();
		let checkNumber = memberPwd.search(/[0-9]/g);
		let checkEnglish = memberPwd.search(/[a-z]/ig);
		let pwCheck = $(".pwCheck");
		let memberPwdCheck = $("#memberPwd_re").val();
		if(memberPwd.length < 1){
			pwCheck[0].textContent = "비밀번호를 입력해주세요";
			pwCheck[0].style.color = 'red';
		}
	    else  if(!/^(?=.*[a-zA-Z])(?=.*[~!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test(memberPwd)){            
	    	pwCheck[0].textContent = "숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.";
	    	pwCheck[0].style.color = 'red';
	    }
	    else if(checkNumber <0 || checkEnglish <0){
	    	pwCheck[0].textContent = "숫자와 영문자를 혼용하여야 합니다.";
	    	pwCheck[0].style.color = 'red';
	    }
	    else if(/(\w)\1\1\1/.test(memberPwd)){
	    	pwCheck[0].textContent = "같은 문자를 4번 이상 사용하실 수 없습니다.";
	    	pwCheck[0].style.color = 'red';
	    }
	    else{
	    	pwCheck[0].textContent = "";
	    }
	}
	
	//비밀번호 확인
	function checkPW(){
		let memberPwdCheck = $("#memberPwd_re").val();
		let memberPwd = $("#memberPwd").val();
		let pwre = $(".pwRe");
		if(memberPwdCheck < 1){
			pwre[0].textContent = "비밀번호 확인해주세요";
			pwre[0].style.color = 'red';
		}
		else if(memberPwdCheck != memberPwd){
			pwre[0].textContent = "비밀번호가 틀립니다";
			pwre[0].style.color = 'red';
		}
		else{
			pwre[0].textContent = "";
		}
	}
	
	//회원가입 유효성
	$("#joinSubmit").on("click",function(e){
		e.preventDefault();
		
		const joinForm = $("#joinForm");
		let memberEmail = $("#memberEmail").val();
		let idCheck = document.getElementsByClassName("idCheck");
		let memberPhone = $("#memberPhone").val();
		let phoneCheck = $("#phoneCheck").val();
		let memberPwd = $("#memberPwd").val();
		let memberPwdCheck = $("#memberPwd_re").val();
		let memberName = $("#memberName").val();
		let memberBirth = $("#memberBirth").val();
		let post = $("#post").val();
		let detailAddress = $("#detailAddress").val();
		//유효한 형식인지 test
		let checkNumber = memberPwd.search(/[0-9]/g);
		let checkEnglish = memberPwd.search(/[a-z]/ig);
		let regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		e.preventDefault();
		if(memberEmail == ""){
			alert("이메일을 입력해주세요");
		}
		else if(!regEmail.test(memberEmail)){
			alert("이메일 형식으로 작성해주세요");
		}
		else if(memberPwd == ""){
			alert("비밀번호를 입력해주세요");
		}
	    else  if(!/^(?=.*[a-zA-Z])(?=.*[~!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test(memberPwd)){            
	        alert('숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.');
	        return false;
	    }
	    else if(checkNumber <0 || checkEnglish <0){
	        alert("숫자와 영문자를 혼용하여야 합니다.");
	        return false;
	    }
	    else if(/(\w)\1\1\1/.test(memberPwd)){
	        alert('같은 문자를 4번 이상 사용하실 수 없습니다.');
	        return false;
	    }
	    else if(memberPwdCheck == ""){
	    	alert("비밀번호 확인을 해주세요");
	    }
	    else if(memberPwdCheck != memberPwd){
	    	alert("비밀번호가 틀립니다. 비밀번호 확인을 다시 해주세요");
	    }
	    else if(memberName == ""){
	    	alert("이름을 입력해주세요");
	    }
	    else if(memberBirth == ""){
	    	alert("생년월일을 입력해주세요");
	    }
	    else if(post ==""){
	    	alert("우편번호를 입력해주세요");
	    }
	    else if(detailAddress == ""){
	    	alert("상세주소를 입력해주세요");
	    }
	    else{
	    	$("#joinSubmit").on("click", function(e) {
	    		e.preventDefault();
	    	    
	    	    $.ajax({
	    	        url: '/member/add',
	    	        type: 'post',
	    	        data: $('#joinForm').serialize(),
	    	        dataType: 'JSON',
	    	        success: function(res) {
	    	        	alert("test")
	    	            if(res.success!=null) {
	    	                alert(res.success); 
	    	                location.href='/member/';
	    	            } else if(res.existMsg!=null){
	    	            	alert(res.existMsg);
	    	            } else if(res.errorMsg!=null){
	    	            	alert(res.errorMsg);
	    	            }
	    	        },
	    	        error: function() {
	    	            console.log('시스템 에러');
	    	        }
	    	    });
	    	});
	    }
	})
	
	
	
	//이메일 인증 관련 코드
	var timer = null;
	var email_address = "";
	function auth_check()
	{
	   $.ajax({
	      url:'/member/auth_check',
	      method:'get',
	      cache:false,
	      data:{'memberEmail':email_address},
	      dataType:'json',
	      success : function(res){
	         if(res.auth) {
	            clearInterval(timer);
	            $("#emailVerificationMessage").text("이메일 인증 성공");
	         }
	      },
	      error : function(xhr,status,err){
	         alert('에러:' + err);
	      }
	   })
	}

	function reqAuth() {
		   email_address = $('#memberEmail').val();
		   $.ajax({
		      url:'/member/auth/'+email_address,
		      method:'get',
		      cache:false,
		      dataType:'json',
		      success:function(res){
		         if(res.sent){
		            alert('입력하신 이메일 주소로 인증 메일을 보냈습니다\n인증메일의 링크를 클릭해주세요');
		            timer = setInterval(auth_check, 1000);(10)
		         }else{
		            alert('메일 발송 실패. 다시 시도해주세요');
		         }
		      },
		      error:function(xhr,status,err){
		         alert('에러:' + err);
		      }
		   })

		   return false;
		}
	
	//번호만 쳐도 하이픈이 자동으로 나오게
	$(document).ready(function() {
		  $('#memberPhone').on('input', function() {
		    var input = $(this).val().replace(/[^0-9]/g, '');
		    var formatted = input.replace(/(\d{3})(\d{0,4})(\d{0,4})/, function(match, p1, p2, p3) {
		      var result = p1;
		      if (p2) result += '-' + p2;
		      if (p3) result += '-' + p3;
		      return result;
		    });

		    $(this).val(formatted);
		  });
		}); 
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	//주소 검색 후 우편번호 및 주소를 불러와주는 기능 
	function DaumPostcode(){
		new daum.Postcode({
	        oncomplete: function(data) {
	        	
	        	console.log(data);
	        	
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var roadAddr = data.roadAddress; // 도로명 주소 변수
	            var jibunAddr = data.jibunAddress; // 지번 주소 변수
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('post').value = data.zonecode;
	            if(roadAddr !== ''){
	                document.getElementById("member_addr").value = roadAddr;
	            } 
	            else if(jibunAddr !== ''){
	                document.getElementById("member_addr").value = jibunAddr;
	            }
	        }
	    }).open();
	}
</script>

</head>
<body>
<%@ include file="../menu.jsp" %>
	<form name="joinForm" id="joinForm" action="/member/add" method="post">
		<table id="container">
			<tr>
				<td id="result" colspan="2"></td>
			</tr>		
			<tr>
				<th><label for="memberName">이름</label></th>
				<td><input type="text" name="memberName" id="memberName" placeholder="name"></td>
			</tr>	
			<tr>
				<th><label for="memberID">아이디</label></th>
				<td><input type="text" name="memberID" id="memberID" placeholder="id" oninput="checkId()">
				<br><span class="idCheck" id="idCheck"></span></td>
			</tr>
			<tr>
				<th><label for="memberPwd">비밀번호</label></th>
				<td><input type="password" name="memberPwd" id="memberPwd" placeholder="password" oninput="checkPw()">
					<br><span class ="pwCheck"></span>
				</td>
			</tr>
			<tr>
				<th><label for="memberPwd_re">비밀번호 확인</label></th>
				<td><input type="password" name="memberPwd_re" id="memberPwd_re" placeholder="password" oninput="checkPW()">
				<br><span class="pwRe"></span></td>
			</tr>
			<tr>
				<th><label for="memberEmail">이메일</label></th>
				<td>
					<div class="input-button-group">
						<input type="email" name="memberEmail" id="memberEmail" placeholder="email" required>
						<button type="button" onclick="reqAuth();" class="button-style">이메일 인증</button>
					</div>
				<br><span id="emailVerificationMessage"></span> 
			</tr>
			<tr>
				<th><label for="memberBirth">생년월일</label></th>
				<td><input type="Date" name="memberBirth" id="memberBirth"></td>
			</tr>	
			<tr class="zipcode_area">
			   <th>우편번호</th>
			   <td>
			      <div class='input-button-group'>
			         <input readonly name='post' type='text' id='post' placeholder='우편번호'>
			         <input type='button' onclick='DaumPostcode()' value='우편번호 찾기' class='button-style'>
			      </div>   
			   </td>
			</tr>
			<tr class="addr_area">
				<th>주소</th>
				<td><input readonly name="address" type="text" id="member_addr" placeholder="주소"></td>
			</tr>
			<tr>
				<th>상세주소</th>
				<td><input name="detailAddress" type="text" id="detailAddress" placeholder="상세주소"></td>
			</tr>
			<tr>
				<th><label for="memberPhone">전화번호</label></th>
				<td><input type="tel" name="memberPhone" id="memberPhone" placeholder="전화번호입력" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" required>
			</tr>
			<tr>
				<th><label for="memberSex">성별</label></th>
				<td>
					<input type="hidden" id="memberSex" name="memberSex">
					남 <input type="radio" name="memberSex" id="memberSex" value="m" checked>
					여 <input type="radio" name="memberSex" id="memberSex" value="f">
				</td>
			</tr>
			<tr>
				<th><label for="national">국적</label></th>
				<td>
					<input type="hidden" id="national" name="national">
					내국인 <input type="radio" name="national" id="national" value="local" checked>
					외국인 <input type="radio" name="national" id="national" value="foreigner">
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="submit" id="joinSubmit" value="회원가입" class="button-style">
				</th>
			</tr>
		</table>
	</form>
</body>
</html>