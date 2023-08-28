<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function editAnswer() {
	if(!confirm('수정 완료하시겠습니까?')) return;
	
	var formdata = $('#answerEditForm').serialize();
	$.ajax({
		url:'/answer/edit',
		data:formdata,
		method:'post',
		cache:false,
		dataType:'json',
		success:function(res) {
			alert(res.editAnswer ? '수정 완료':'수정 실패');
			location.href='/question/detail/${question.questionNum}';
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
	return false;
}

</script>
</head>
<body>
<%@ include file="../menu.jsp" %>
<h3>QUESTION</h3>
	<table>
		<tr><th>Subject</th><td id="title" colspan="3">${question.questionTitle}</td></tr>
		<tr>
			<th>Writer</th>
				<td id="author">${question.questionAuthor}</td>
		    <th>Date</th>
			    <td id="date">
			    	${question.questionDate}
			    </td>
		</tr>
		<tr><td id="contents" colspan="4">
			<textarea id="question" style="white-space:pre;" readonly>${question.questionContents}</textarea>
			</td>
		</tr>
	</table>
	<!-- 답변이 있는 경우 -->
	<c:if test="${answer != null }">
	<form id="answerEditForm" onsubmit="return editAnswer();">
	<input type="hidden" name="answerNum" value="${answer.answerNum}">
		<table id="answerTable">
			<tr>
				<td>${answer.answerAuthor}</td>
				<td>${answer.answerDate}</td>
			</tr>
			<tr><td colspan="3"><textarea name="answerContents" style="white-space:pre;">${answer.answerContents}</textarea></td></tr>
			<!-- 관리자만 수정 및 삭제 가능하도록 -->
			<c:if test="${member.memberClass == '관리자'}">
				<tr>
					<td colspan="3">
						<nav id="answer_buttons">
						<button type="submit">완료</button>
						<button type="button" onclick="return delAnswer(${answer.answerNum});">삭제</button>
						</nav>
					</td>
				</tr>
			</c:if>
		</table>
	</form>
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
</body>
</html>