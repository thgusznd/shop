<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>공지사항 작성</title>
<style type="text/css">
   body {
     font-family: Arial, sans-serif;
     margin: 20px;
     background-color: #f2f2f2;
   }

   h3 {
     color: #333;
   }

   table {
     width: 80%;
     border-collapse: collapse;
   }

   th, td {
     border: 1px solid #ccc;
     padding: 8px;
     text-align: left;
   }

   th {
     background-color: #e6e6e6;
     color: #333;
   }

   tr:nth-child(even) {
     background-color: #f2f2f2;
   }

   tr:hover {
     background-color: #ddd;
   }

   a {
     color: #0066cc;
     text-decoration: none;
   }
   
   input{
   	width:300px;
   }
   textarea{
   	width:500px;
   	height: 300px;
   }
   button {
     padding: 10px 20px;
     background-color: #333;
     color: #fff;
     border: none;
     border-radius: 4px;
     cursor: pointer;
   }

   button:hover {
     background-color: #555;
   }
 </style>


<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function saveNotice() {
	if(!confirm('현재 글을 저장하시겠습니까?')) return;
	
	var formdata = $('#addForm').serialize();
	$.ajax({
		url:'/notice/addResult',
		data:formdata,
		method:'post',
		cache:false,
		dataType:'json',
		success:function(res) {
			alert(res.added ? '작성 완료':'작성 실패');
			location.href='/notice/detail/'+res.noticeNum;
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
<main>
	<h3>공지사항 작성</h3>
	<form id="addForm" onsubmit="return saveNotice();">
	<table>
		<tr><th>글 제목</th>
			<td><input type="text" name="noticeTitle"></td>
		</tr>
		<tr><th>작성자</th>
			<td><input type="hidden" name="noticeAuthor" value="${memberID}">${memberID}</td>
		</tr>
		<tr><th>내용</th>
			<td><textarea name="noticeContents"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" id="buttons">
				<button type="reset">내용 지우기</button>
				<button type="submit">저장</button>
				<button type="button" onclick="location.href='/notice/list'">목록보기</button>
			</td>
		</tr>
	</table>
	</form>
</main>
</body>
</html>