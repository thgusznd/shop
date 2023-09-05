<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>리뷰 수정</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function fdel(reviewAttachNum){
	if(!confirm('첨부파일을 삭제하시겠어요?')) return;
	$.ajax({
		url:'/review/remove/'+reviewAttachNum,
		method:'get',
		cache:false,
		dataType:'json',
		success:function(res) {
			alert(res.removed ? '첨부파일 삭제 성공':'첨부파일 삭제 실패');
			if(res.removed) location.reload();
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
}

$(function(){
	$('#attachAddForm').css('display','none');
});

function showHiddenForm() {
	$('#attachAddForm').css('display', 'block');
}

function addAttach() {
	var formdata = new FormData($('#attachAddForm')[0]);
	$.ajax({
		url:'/review/addattach',
		method:'post',
		enctype:'multipart/form-data',
		cache:false,
		data:formdata,
		dataType:'json',
		processData:false,
		contentType:false,
		timeout:3000,
		success:function(res){
			alert(res.added ? '첨부파일 저장 성공':'첨부 저장 에러');
			location.reload();
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
	return false;
}

function updateReview() {
	var serdata = $('#updateForm').serialize();
	$.ajax({
		url:'/review/update',
		method:'post',
		cache:false,
		data:serdata,
		dataType:'json',
		success:function(res){
			alert(res.updated ? '수정 성공':'수정 에러');
			if(res.updated) location.href='/review/get/${r.reviewNum}';
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
	return false;
}
</script>
<style type="text/css">
	.item-image {
	        width: 200px;
	        height: 400px;
	}
	    
	.attachment-container {
	  display: flex;
	  flex-wrap: wrap; 
	  justify-content: flex-start; 
	}
	
	.attachment-container img {
	  margin-right: 10px;
	}
</style>
</head>
<body>
<main>
<h2>리뷰 수정</h2>
<form id="updateForm" action="/review/update" method="post" onsubmit="return updateReview();">
<input type="hidden" name="reviewNum" id="reviewNum" value="${r.reviewNum }">
<table>
	<tr><th>제 목</th>
	<td>
		<input type="text" name="reviewTitle" id="reviewTitle" value="${r.reviewTitle}" required>
	</td>
	</tr>
	<tr><th>내 용</th>
	<td>
		<textarea rows="5" cols="25" name="reviewContents" id="reviewContents" required>${r.reviewContents }</textarea>
	</td>
	</tr>
	<tr><th>작성자</th><td>${r.reviewAuthor}</td></tr>
	<tr>
		<th>첨부</th>
		<td>
			<c:forEach var="att" items="${r.rattList}">
				<c:if test="${att!=null }">
					<img class="item-image" src="${pageContext.request.contextPath}/reviewPhoto/${att.reviewAttachName }">
					[<a id="fdel" title="첨부파일 삭제" href="javascript:fdel(${att.reviewAttachNum});">x</a>]
				</c:if>
			</c:forEach>
			<button type="button" id="attachAdd" onclick="showHiddenForm()">추가</button>
		</td>
	</tr>
</table>
		<div id="btn">
			<button type="reset">취소</button>
			<button type="submit">수정</button>
		</div>
</form>
<p>
	<form id="attachAddForm" onsubmit="return addAttach();">
		<fieldset>
		<legend>첨부파일 추가</legend>
		<input type="hidden" name="reviewParentsNum" value="${r.reviewNum}">
		<input type="file" name="files" onchange="preview(event);" multiple>
		<div id="thumbnail_view"></div>
		<div style="margin-top:0.5em;">
			<button type="reset">취소</button>
			<button type="submit">저장</button>
		</div>
		</fieldset>
	</form>
</main>
<script>
	function preview(evt) {
		var reader = new FileReader();
		
		reader.onload = function(event) {
			let parent = document.querySelector("#thumbnail_view");		
			while(parent.firstChild) {
				parent.removeChild(parent.firstChild);
			}
			var img = document.createElement("img");
			img.setAttribute("src", event.target.result);
			parent.appendChild(img);
		};
		
		reader.readAsDataURL(evt.target.files[0]);
	}
</script>
</body>
</html>