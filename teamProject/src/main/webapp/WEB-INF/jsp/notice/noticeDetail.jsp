<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NOTICE</title>
<style>
   body {
     font-family: Arial, sans-serif;
     margin: 20px;
     background-color: #f2f2f2;
     color: #333;
   }

   h3 {
     color: #333;
     border-bottom: 1px solid #333;
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

   /* Custom styles for table */
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
	height: 400px;
}

 </style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function delNotice(noticeNum) {
	if(!confirm('현재 공지사항을 삭제하시겠습니까?')) return;
	$.ajax({
		url:'/notice/delete/'+ noticeNum,
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
</script>
</head>
<body>
<%@ include file="../menu.jsp" %>
<h3>NOTICE</h3>
	<table>
		<tr><th>NO</th><td colspan="3">${notice.noticeNum}</td></tr>
		<tr><th>Subject</th><td id="title" colspan="3">${notice.noticeTitle}</td></tr>
		<tr><th>Writer</th><td id="author">${notice.noticeAuthor}</td>
			<th>Date</th><td id="date">${notice.noticeDate}</td>
		</tr>
		<tr><td id="contents" colspan="4">
			<textarea>${notice.noticeContents}<c:out value="${noticeContents}"/></textarea>
			</td>
		</tr>
	</table>
	<p>
	<nav id="buttons">
	<c:if test="${member.memberClass == '관리자'}">
		<button type="button" onclick="location.href='/notice/editForm/${notice.noticeNum}'">수정</button>
		<button type="button" onclick="javascript:delNotice(${notice.noticeNum});">삭제</button>
		<button type="button" onclick="location.href='/notice/addForm'">새로운 글 작성</button>
	</c:if>
	<button type="button" onclick="location.href='/notice/list'">목록보기</button>
	</nav>
</body>
</html>