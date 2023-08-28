<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
     width: 80%;
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
</style>

<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function answeAdd() {
	if(!confirm('답변을 저장하시겠습니까?')) return;
	
	var formdata = $('#answerAddForm').serialize();
	$.ajax({
		url:'/answer/add',
		data:formdata,
		method:'post',
		cache:false,
		dataType:'json',
		success:function(res) {
			alert(res.added ? '작성 완료':'작성 실패');
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
		<tr><th>Writer</th><td id="author">${question.questionAuthor}</td>
			<th>Date</th><td id="date">${question.questionDate}</td>
		</tr>
		<tr><td id="contents" colspan="4">
			<textarea style="white-space:pre;" readonly>${question.questionContents}</textarea>
			</td>
		</tr>
	</table>
	<p>
	<h4>ANSWER</h4>
	<form id="answerAddForm" onsubmit="return answeAdd();">
		<input type="hidden" id="pQuestionNum" name="pQuestionNum" value="${question.questionNum}">
		<table id="answerTable">
			<tr><td><input type="text" id="answerAuthor" name="answerAuthor" value="𝐚𝐬𝐞𝐚𝐝𝐨"></td></tr>
			<tr><td><textarea style="white-space:pre;" id="answerContents" name="answerContents"></textarea></td></tr>
		</table>
		<button type="submit">완료</button>
		<button type="button" onclick="location.href='/question/list'">목록보기</button>
	</form>
	
</body>
</html>