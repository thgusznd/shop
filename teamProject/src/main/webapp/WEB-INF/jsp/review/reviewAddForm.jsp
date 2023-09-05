<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>리뷰 쓰기</title>
<style type="text/css">
	#myform fieldset{
	    display: inline-block;
	    direction: rtl;
	    border:0;
	}
	#myform fieldset legend{
	    text-align: right;
	}
	#myform input[type=radio]{
	    display: none;
	}
	#myform label{
	    font-size: 3em;
	    color: transparent;
	    text-shadow: 0 0 0 #f0f0f0;
	}
	#myform label:hover{
	    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}
	#myform label:hover ~ label{
	    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}
	#myform input[type=radio]:checked ~ label{
	    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function addReview() {
	var formdata = new FormData($('#addForm')[0]);
	$.ajax({
		url:'/review/add',
		method:'post',
		enctype:'multipart/form-data',
		processData:false,
		contentType:false,
		timeout:3600,
		cache:false,
		data:formdata,
		dataType:'json',
		success:function(res) {
			alert(res.added ? '리뷰 등록 성공':'리뷰 등록 에러');
			if(res.added) location.href='/review/get/'+res.reviewNum;
		},
		error:function(xhr,status,err) {
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
<h2>리뷰 쓰기</h2>
	<div><label>상품명 :</label><a href="/item/detail/${itemNum}">${goods}</a></div>
<form id="addForm" action="/review/add" method="post" onsubmit="return addReview();">
	<input type="hidden" name="reviewParentsNum" value="${itemNum}">
	<input type="hidden" name="reviewAuthor" value="${memberID}">
	<div>
		<label for="reviewContents">내 용</label>
		<textarea rows="5" cols="25" name="reviewContents" id="reviewContents" required></textarea>
	</div>
	<div>
		<label>사진 첨부</label>
		<input type="file" name="files" onchange="preview(event);" multiple>
	</div>
	<div id="thumbnail_view"></div>
	<div id="myform">
		<link href="/assets/css/star.css" rel="stylesheet"/>
		<fieldset>
			<span>별점을 선택해주세요</span>
			<input type="radio" name="reviewStar" value="5" id="rate1">
				<label for="rate1">★</label>
			<input type="radio" name="reviewStar" value="4" id="rate2">
				<label for="rate2">★</label>
			<input type="radio" name="reviewStar" value="3" id="rate3">
				<label for="rate3">★</label>
			<input type="radio" name="reviewStar" value="2" id="rate4">
				<label for="rate4">★</label>
			<input type="radio" name="reviewStar" value="1" id="rate5">
				<label for="rate5">★</label>
		</fieldset>
	</div>
	<div id="btn">
		<button type="reset">취소</button>
		<button type="submit">등록</button>
	</div>
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