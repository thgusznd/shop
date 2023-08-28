<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>notice Detail</title>
<style type="text/css">
  body {
    font-family: Arial, sans-serif;
    margin: 20px;
    background-color: #f2f2f2;
    color: #333;
  }

  h3 {
    color: #0066cc;
    border-bottom: 1px solid #0066cc;
    padding-bottom: 10px;
  }

  table {
    width: 100%;
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

  tr:nth-child(even) {
    background-color: #f2f2f2;
  }

  tr:hover {
    background-color: #ddd;
  }

  input[type="text"],
  textarea {
    width: 90%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
  }
  textarea{
  	height: 400px;
  }

  #buttons {
    padding-top: 20px;
  }

  button[type="submit"],
  button[type="button"] {
    padding: 10px 20px;
    background-color: #333;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-right: 10px;
  }

  button[type="submit"]:hover,
  button[type="button"]:hover {
    background-color: #555;
  }

</style>
  
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function delNotice(noticeNum) {
	if(!confirm('현재 공지사항을 삭제하시겠습니까?')) return;
	$.ajax({
		url:'/notice/delete/noticeNum',
		method:'get',
		cache:false,
		dataType:'json',
		success:function(res) {
			alert(res.deleted ? '삭제 성공':'삭제 실패');
			location.href='/notice/list';
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
}

function saveEditNotice() {
	if(!confirm('수정 완료하시겠습니까?')) return;
	
	var formdata = $('#editForm').serialize();
	$.ajax({
		url:'/notice/edit',
		data:formdata,
		method:'post',
		cache:false,
		dataType:'json',
		success:function(res) {
			alert(res.updated ? '수정 완료':'수정 실패');
			location.href='/notice/detail/${notice.noticeNum}';
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
}
</script>
</head>
<body>
<%@ include file="../menu.jsp" %>
<h3>게시글 상세보기</h3>
<form id="editForm" onsubmit="return saveEditNotice();">
	<input type="hidden" name="noticeNum" value="${notice.noticeNum }">
	<table>
		<tr><th>글 제목</th>
			<td colspan="3"><input type="text" name="noticeTitle" value="${notice.noticeTitle }"></td>
		</tr>
		<tr>
			<th>작성자</th><td id="author">${notice.noticeAuthor}</td>
			<th>작성일</th><td id="date">${notice.noticeDate}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="3"><textarea name="noticeContents">${notice.noticeContents}<c:out value="${noticeContents}"/></textarea></td>
		</tr>
	</table>
	<nav id="buttons">
	<button type="submit">수정 완료</button>
	<button type="button" onclick="javascript:delNotice(${notice.noticeNum});">삭제</button>
	</nav>
</form>
</body>
</html>