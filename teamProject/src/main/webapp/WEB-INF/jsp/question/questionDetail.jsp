<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QUESTION</title>
<style>
   body {
     font-family: Arial, sans-serif;
     margin: 20px;
     color: #333;
   }

   h3 {
     color: #333;
     border-bottom: 1px solid #333;
     padding-bottom: 10px;
   }

   table {
     width: 70%;
     border-collapse: collapse;
     margin-top: 20px;
   }

   th, td {
     border: 1px solid #ccc;
     padding: 10px;
     text-align: left;
   }

   th {
     background-color: #e6e6e6;
   }

   #contents {
     padding-top: 15px;
   }

   #buttons {
     padding-top: 20px;
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

   button:hover {
     background-color: #555;
   }

   table {
     border: 1px solid #ccc;
     border-radius: 4px;
   }

   th, td {
     border: 1px solid #ccc;
     padding: 10px;
   }
   textarea {
	width:80%;
	height: 200px;
	}
	#answer_buttons {
	text-align: right;
	}

 </style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function delQuestion(questionNum) {
	if(!confirm('질문을 삭제하시겠습니까?')) return;
	$.ajax({
		url:'/question/delete/'+ questionNum,
		method:'get',
		cache:false,
		dataType:'json',
		success:function(res) {
			alert(res.deleted ? '삭제 성공':'삭제 실패');
			location.href='/question/list';
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
}
</script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function delAnswer(answerNum) {
	if(!confirm('답변을 삭제하시겠습니까?')) return;
	$.ajax({
		url:'/answer/delete/'+ answerNum,
		method:'get',
		cache:false,
		dataType:'json',
		success:function(res) {
			alert(res.deleted ? '삭제 성공':'삭제 실패');
			location.href='/question/detail/${question.questionNum}';
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
}
</script>
<script type="text/javascript">
function checkPassword() {
    var correctPassword = '${question.questionPassword}'; // 서버에서 가져온 질문의 비밀번호
    var inputPassword = document.getElementById('questionPassword').value; // 사용자가 입력한 비밀번호

    if (inputPassword === correctPassword) {
        // 비밀번호가 일치하는 경우
        isPasswordCorrect = true;
        document.getElementById('passwordForm').style.display = 'none'; // 입력 폼 숨기기
        document.getElementById('questionDetailForm').style.display = 'block'; // 상세보기 폼 보여주기
    } else {
        // 비밀번호가 일치하지 않는 경우
        alert('비밀번호가 일치하지 않습니다.');
        isPasswordCorrect = false;
    }
}
</script>
</head>
<body>
<%@ include file="../menu.jsp" %>
<!-- 상세보기를 보기 전 비밀번호를 입력 폼을 띄움 --> 
<div id="passwordForm">
이 글은 비밀글입니다. 비밀번호를 입력하여 주세요.
관리자는 OK 버튼을 눌러주세요. 
        <label for="questionPassword">Password </label>
        <input type="password" id="questionPassword" name="questionPassword">
        <button type="button" onclick="checkPassword();">OK</button>
    </div>

<div id="questionDetailForm" style="display: none;">
<h3>QUESTION</h3>
	<table>
		<tr><th>Subject</th><td id="title" colspan="3">${question.questionTitle}</td></tr>
		<tr><th>Writer</th><td id="author">${question.questionAuthor}</td>
	    <th>Date</th>
	    <td id="date">${question.questionDate}
	    </td>
		</tr>
		<tr><td id="contents" colspan="4">
			<textarea id="question" style="white-space:pre;" readonly>${question.questionContents}</textarea>
			</td>
		</tr>
	</table>
	
	<!-- 답변이 있는 경우 -->
	<c:if test="${answer != null }">
		<table id="answerTable">
			<tr><td>${answer.answerAuthor}</td><td>${answer.answerDate}</td></tr>
			<tr><td colspan="3"><textarea id="answer" style="white-space:pre;" readonly>${answer.answerContents}</textarea></td></tr>
			<c:if test="${member.memberClass == '관리자'}">
				<tr><td colspan="3"><nav id="answer_buttons">
					<button type="button" onclick="location.href='/answer/editForm/${question.questionNum}'">수정</button>
					<button type="button" onclick="return delAnswer(${answer.answerNum});">삭제</button>
				</nav></td></tr>
			</c:if>
		</table>
	</c:if>
	<nav id="buttons">
		<c:if test="${member.memberClass == '관리자' || member.memberID == question.questionAuthor}">
			<button type="button" onclick="location.href='/question/editForm/${question.questionNum}'">수정</button>
			<button type="button" onclick="javascript:delQuestion(${question.questionNum});">삭제</button>
		</c:if>
		<c:if test="${member.memberClass == '관리자'}">
		<button type="button" onclick="location.href='/answer/addForm/${question.questionNum}'">답글달기</button>
		</c:if>
		<button type="button" onclick="location.href='/question/add'">새로운 글 작성</button>
		<button type="button" onclick="location.href='/question/list'">목록보기</button>
	</nav>
	</div>
</body>
</html>