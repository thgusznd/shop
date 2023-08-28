<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Item Detail Edit</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
	function editItem() {
		var formData = $('#editForm').serialize();
		$.ajax({
			url:'/item/update',
			method:'post',
			cache:false,
			data:formData,
			dataType:'json',
			success:function(res){
				alert(res.updated ? '수정 완료':'수정 실패');
				if(res.updated) location.href='/item/detail/${item.itemNum}';
			},
			error:function(xhr,status,err){
				alert('에러:' + err);
			}
		});
		return false;
	}
	
	$(function(){
		$('#addAttachForm').css('display','none');
	});

	function showHiddenForm() {
	    $('#addAttachForm').css('display', 'block');
	 }

	function addAttach() {
		var formdata = new FormData($('#addAttachForm')[0]);
		$.ajax({
			url:'/item/addAttach',
			method:'post',
			enctype:'multipart/form-data',
			cache:false,
			data:formdata,
			dataType:'json',
			processData:false,
			contentType:false,
			timeout:3000,
			success:function(res){
				alert(res.addAttach ? '첨부파일 추가 성공':'첨부 추가 실패');
				location.reload();
			},
			error:function(xhr,status,err){
				alert('에러:' + err);
			}
		});
		return false;
	}
	$(document).ready(function() {
	    $("#files").change(function() {
	    	previewImages(this);
	    });
	  
	$("button[type='reset']").click(function() {
	   $('#preview').attr('src', ''); // 이미지 src 비우기
	   $('#preview').css('display', 'none'); // 이미지 숨기기
	 });
	});
	
	function previewImages(input) {
		  if (input.files && input.files.length > 0) {
		    var previewContainer = $("#preview-container");
		    previewContainer.empty();

		    for (var i = 0; i < input.files.length; i++) {
		      var reader = new FileReader();

		      reader.onload = function (e) {
		        var imageContainer = $("<div>").css("display", "inline-block");
		        var image = $("<img>")
		          .attr("src", e.target.result)
		          .css("width", "200")
		          .css("height", "250px")
		          .css("margin-top", "20px")
		          .css("margin-left", "10px");

		        var deleteButton = $("<button>")
		          .text("x")
		          .attr("type", "button")
		          .click(function () {
		            $(this).parent().remove(); // Remove the image container when 'x' is clicked
		            $("#files").val(""); // Reset the input file element
		          });

		        imageContainer.append(image);
		        imageContainer.append(deleteButton);
		        previewContainer.append(imageContainer);
		      };

		      reader.readAsDataURL(input.files[i]);
		    }
		  }
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
		width: 70%;
		margin: 0 auto;
		margin-top: 30px;
		background-color: #fff;
		padding: 20px;
		border: 1px solid #ccc;
		border-radius: 5px;
	}

	table {
		width: 100%;
		border-collapse: collapse;
		margin-top: 20px;
	}

	table td {
		padding: 10px;
		border-bottom: 1px solid #ccc;
	}

	.image-container {
		position: relative;
		display: inline-block;
	}

	img {
		width: 70%;
		max-height: 400px;
		object-fit: cover;
		border: 1px solid #ccc;
		border-radius: 5px;
		margin-top: 10px;
	}

	.delete-link {
		position: absolute; 
		bottom: 5px;
		right: 32%;
		background-color: #fff;
		color: #f00;
		font-size: 18px;
		border: none;
		cursor: pointer;
		font-size: 20pt;
	}

	textarea {
		width: 70%;
		height: 200px;
		padding: 5px;
		border: 1px solid #ccc;
		border-radius: 5px;
		resize: vertical;
		margin-top: 10px;
	}

	input {
		width: 30%;
	}

	input[type="text"],
	button {
		padding: 10px;
		border: 1px solid #ccc;
		border-radius: 5px;
		margin-bottom: 10px;
	}

	button {
		margin-top: 10px;
		background-color: #333;
		color: #fff;
		cursor: pointer;
	}

	button:hover {
		background-color: #444;
	}
	
	#addAttachForm {
    display: none;
  	}
  	
  	#preview-container {
	  display: flex;
	  flex-wrap: wrap;
	}
	
	#preview-container div {
	  margin: 10px;
	}
	
	#preview-container img {
	  max-width: 200px;
	  max-height: 250px;
	}
	
</style>
</head>
<body>
<%@ include file="../menu.jsp" %>
<main>
	<h2>Item Detail Edit</h2>
	<form id="editForm" onsubmit="return editItem();">
		<input type="hidden" name="itemNum" value="${item.itemNum}">
		<table>
			<tr><td>
				상품명 <input type="text" name="goods" value="${item.goods}">
			</td></tr>
			<tr><td>
				제품 이미지<br> 
				<c:forEach var="list" items="${item.attList}">
					<c:if test="${item.attList != null}">
						<div class="image-container">
							<img src="<c:url value='/items/${list.itemAttachName}' />">
							<a href="javascript:deleteAttach(${list.itemAttachNum},'${list.itemAttachName}');" class="delete-link" title="첨부파일 삭제">x</a>
						</div>
					</c:if>
				</c:forEach>
					<button type="button" id="addAttach" onclick="showHiddenForm()">이미지 추가</button>
			</td></tr>
			<tr><td>
				판매가 
				<input type="text" name="price" value="${item.price}"> 원 
			</td></tr>
			<tr><td>
				상품 설명 <br>
				<textarea name="explains" style="white-space:pre;">${item.explains}</textarea>
			</td></tr>
		</table>
		<button type="submit">저장</button>
	</form>
	
	<form id="addAttachForm" onsubmit="return addAttach();">
		<fieldset>
			<legend>첨부파일 추가</legend>
			<input type="hidden" name="itemAttachParentsNum" value="${item.itemNum}">
			<input type="file" id="files" name="files" multiple>
			<div id="preview-container"></div>
			<div style="margin-top:0.5em;">
				<button type="reset">취소</button>
				<button type="submit">저장</button>
			</div>
		</fieldset>
	</form>
</main>
</body>
</html>
