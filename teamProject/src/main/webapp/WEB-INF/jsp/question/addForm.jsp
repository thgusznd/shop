<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>글 추가 폼</title>

<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function saveQuestion() {
	if(!confirm('현재 글을 저장하시겠습니까?')) return;
	
	var formdata = $('#addForm').serialize();
	$.ajax({
		url:'/question/add',
		data:formdata,
		method:'post',
		cache:false,
		dataType:'json',
		success:function(res) {
			alert(res.added ? '작성 완료':'작성 실패');
			location.href='/question/detail/' + res.questionNum;
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
	return false;
}

</script>

<style>
	body {
		font-family: Arial, sans-serif;
		margin: 0;
		padding: 0;
		background-color: #f2f2f2;
	}

	main {
		max-width: 700px;
		margin: 0 auto;
		background-color: #fff;
		padding: 20px;
		border-radius: 5px;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	}

	h3 {
		font-size: 24px;
		color: #333;
		margin-bottom: 20px;
		text-align: left;
	}

	form table {
		width: 100%;
		border-collapse: collapse;
	}

	form th, form td {
		padding: 10px;
		border-bottom: 1px solid #ccc;
	}

	form th {
		text-align: right;
		font-weight: normal;
		width: 10%;
		color: #333;
	}

	form td {
		text-align: left;
	}
	form input[type="text"],
	form textarea {
		padding: 10px;
		border: 1px solid #ccc;
		border-radius: 4px;
	}

	form #buttons {
		text-align: center;
		margin-top: 20px;
	}

	form button {
		padding: 10px 20px;
		background-color: #333;
		color: #fff;
		border: none;
		border-radius: 4px;
		cursor: pointer;
		margin: 5px;
	}

	form button[type="reset"] {
		background-color: #666;
	}

	form button[type="submit"] {
		background-color: #444;
	}

	form button[type="button"] {
		background-color: #555;
	}
	textarea {
		width:600px;
		height: 200px;
	}
</style>

</head>
<body>
<%@ include file="../menu.jsp" %>
<main>
	<h3>Q&A</h3>
	<form id="addForm" onsubmit="return saveQuestion();">
		<table>
			<tr>
				<th>Subject</th>
				<td><input type="text" name="questionTitle" value="문의 드립니다:)" placeholder="Enter subject" readonly></td>
			</tr>
			<tr>
				<th>Writer</th>
				<td><input type="text" name="questionAuthor" value="${memberID}" readonly></td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea name="questionContents" style="white-space:pre;" placeholder="■ 문의 내용이 많은 경우 답변이 지연될 수 있습니다.&#13;■ 배송이 시작되었음에도 배송조회가 되지 않는경우 CJ대한통운(1588-1255)으로 문의해주세요.&#13;&#13;[필수정보]&#13;&#13;상품문의 or 교환/반품 or 배송문의&#13;&#13;- 주문번호:&#13;- 이름:&#13;- 연락처:&#13;- 문의내용:"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" id="buttons">
					<button type="reset">내용 지우기</button>
					<button type="submit">저장</button>
					<button type="button" onclick="location.href='/question/list'">목록</button>
				</td>
			</tr>
		</table>
	</form>
</main>
</body>
</html>
