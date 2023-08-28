<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile Modify Edit</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
    function editMember(){
        var formdata = $('#editForm').serialize();
        $.ajax({ 
            url:'/member/mypage/edit',
            data:formdata,
            method:"post",
            cache:false, 
            dataType:'json', 
            success:function(res){
            	if(res.updated){
            		  alert("회원정보 수정 완료");
            		  var memberID = "${member.memberID}";
            		  location.href = "/member/mypage/" + memberID;
            		} else {
            		  alert("회원정보 수정 에러");
            		}
            },
            error:function(err){ 
                alert(err);
            }
        });
        return false;
    }
</script>

<script type="text/javascript">
    function unregister(memberID) {
        if (!confirm('회원탈퇴 후 30일 이후에 회원가입이 가능합니다. 그래도 탈퇴하시겠습니까?')) return false;
        $.ajax({
            url: '/member/unregister',
            data: { memberID: memberID }, // Corrected the data parameter here
            method: "post",
            cache: false,
            dataType: 'json',
            success: function (res) {
                if (res.unregister) {
                    alert("탈퇴가 완료되었습니다. 이용해주셔서 감사합니다.");
                    location.href = "/member/";
                } else {
                    alert("회원 탈퇴 에러");
                }
            },
            error: function (err) {
                alert(err);
            }
        });
        return false;
    }
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //주소 검색 후 우편번호 및 주소를 불러와주는 기능 
    function findAddr(){
        new daum.Postcode({
            oncomplete: function(data) {
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

<style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
        padding: 0;
        background-color: #f2f2f2;
        text-align: center;
    }

    h2 {
        margin-bottom: 20px;
        padding-bottom: 5px;
        border-bottom: 1px solid #ccc;
        color: #333;
    }

    form {
        max-width: 600px;
        margin: 0 auto;
        margin-top:10px;
        padding: 20px;
        background-color: #fff;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    th, td {
        padding: 10px;
        text-align: left;
        border-bottom: 1px solid #ccc;
    }

    th {
        background-color: #f2f2f2;
    }

    input[type="text"], input[type="password"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 4px;
        outline: none;
        transition: border-color 0.3s ease-in-out;
    }

    input[type="text"]:focus, input[type="password"]:focus {
        border-color: #666;
    }

    #buttons {
        display: flex;
        justify-content: space-between;
        margin-top: 20px;
    }

    #buttons button {
        padding: 10px 20px;
        background-color: #333;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    #buttons button:last-child {
        background-color: #e63946;
    }
</style>
</head>
<body>
<%@ include file="../menu.jsp" %>
<h2>Profile Modify</h2>
저희 쇼핑몰을 이용해 주셔서 감사합니다. ${member.memberName}님은 ${member.memberClass} 입니다.
	<form id="editForm" action="/member/mypage/edit" method="post" onsubmit="return editMember();">
	    <table>
	        <tr>
	            <th>id</th>
	            <td><input type="text" id="memberID" name="memberID" value="${member.memberID}"></td>
	        </tr>
	        <tr>
	            <th>password</th>
	            <td><input type="password" id="memberPwd" name="memberPwd" value="${member.memberPwd}"></td>
	        </tr>
	        <tr>
	            <th>name</th>
	            <td><input type="text" id="memberName" name="memberName" value="${member.memberName}"></td>
	        </tr>
	        <tr>
	        	<th>address</th>
	            <td>
	                <input id="post" name="post" type="text" placeholder="우편번호" value="${member.post}" readonly onclick="findAddr()">
	                <input id="member_addr" name="address" type="text" placeholder="주소" value="${member.address}" readonly> <br>
	                <input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소" value="${member.detailAddress} ">
	            </td>    
	        </tr>
	        <tr>
	            <th>phone</th>
	            <td><input type="text" id="memberPhone" name="memberPhone" value="${member.memberPhone}"></td>
	        </tr>
	        <tr>
	            <th>e-mail</th>
	            <td><input type="text" id="memberEmail" name="memberEmail" value="${member.memberEmail}"></td>
	        </tr>
	        <tr>
	            <th>birth</th>
	            <td><input type="text" id="memberBirth" name="memberBirth" value="${member.memberBirth}"></td>
	        </tr>
	        </table>
	        <div id="buttons">
	            <button type="reset">cancel</button>
	            <button type="submit">edit</button>
	            <button type="button" onclick="javascript:unregister('${member.memberID}');">회원탈퇴</button>
	        </div>
	</form>
</body>
</html>
