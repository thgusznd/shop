<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Item Add Form</title>
<style>
	body {
		font-family: Arial, sans-serif;
		margin: 0;
		padding: 0;
		background-color: #f2f2f2;
	}

	main {
		width: 80%;
		margin: 0 auto;
		margin-top: 30px;
		background-color: #fff;
		padding: 20px;
		border: 1px solid #ccc;
		border-radius: 5px;
	}

	h3 {
		font-size: 24px;
		text-align: center;
		margin-bottom: 20px;
	}

	table {
		width: 100%;
	}

	th, td {
		padding: 10px;
	}

	input[type="file"] {
		display: none;
	}

	label {
		background-color: #333;
		color: #fff;
		padding: 10px;
		border-radius: 5px;
		cursor: pointer;
		margin-right: 10px;
	}

	#preview {
		display: none;
		margin-top : 20px;
		max-width: 150px;
		max-height: 200px;
	}

	input[type="text"],
	input[type="number"],
	select,
	textarea {
		width: 30%;
		padding: 10px;
		margin-bottom: 15px;
		border: 1px solid #ccc;
		border-radius: 4px;
		outline: none;
		transition: border-color 0.3s ease-in-out;
	}

	input[type="text"]:focus,
	input[type="number"]:focus,
	select:focus,
	textarea:focus {
		border-color: #666;
	}

	#category-label {
		vertical-align: top;
	}

	#buttons {
		text-align: center;
	}

	button {
		padding: 12px;
		background-color: #333;
		color: #fff;
		border: none;
		border-radius: 4px;
		cursor: pointer;
		font-size: 16px;
		margin-right: 10px;
		margin-top: 20px;
	}

	button[type="reset"] {
		background-color: #666;
	}

	button:hover {
		background-color: #444;
	}
	textarea {
		width:700px;
		height: 400px;
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
	
	#preview-container button {
	  font-size: 16px;
	  line-height: 1;
	}
	
	#preview-container div {
	  position: relative;
	  width: 200px;
	  height: 250px;
	}
	
	#preview-container button {
	  position: absolute;
	  top: 10px;
	  right: 0px;
	  background-color: red;
	  color: white;
	  border: none;
	  border-radius: 50%;
	  width: 30px;
	  height: 30px;
	  cursor: pointer;
	  display: flex;
	  justify-content: center;
	  align-items: center;
	}
	.files_guide {
		color:gray;
	}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
	function saveItem() {
		var formdata = new FormData($('#addForm')[0]);
		$.ajax({
			url:'/item/add',
			method:'post',
			enctype:'multipart/form-data',
			processData:false,
			contentType:false,
			timeout:3600,
			cache:false,
			data:formdata,
			dataType:'json',
			success:function(res) {
				alert(res.added ? '상품 등록 성공':'상품 등록 실패');
				if(res.added) location.href='/item/detail/'+res.itemNum;
			},
			error:function(xhr,status,err) {
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
</head>
<body>
<%@ include file="../menu.jsp" %>
<main>
	<h3>상품 등록</h3>
	<form id="addForm" onsubmit="return saveItem();">
	<table>
		<tr><th>상품 이미지</th>
			<td>
				<label for="files">이미지 선택 </label>
				<span class="files_guide">* 첫번째 이미지가 메인 이미지가 됩니다.</span>
			    <input type="file" id="files" name="items" multiple>
			    <div id="preview-container"></div>
			</td>
		</tr>
		<tr><th>상품명</th>
			<td><input type="text" name="goods"></td>
		</tr>
		<tr><th>판매가</th>
			<td><input type="text" name="price"> 원</td>
		</tr>
		<tr><th>수량</th>
		<td><input type="number" id="inventory" name="inventory" value="1" min="1" max="100"> 개</td>
		</tr>
		<tr><th id="category">카테고리</th>
	        <td><select name="category" id="category">
	            <option value="Top">Top</option>
	            <option value="Bottom">Bottom</option>
	            <option value="Outer">Outer</option>
	            <option value="Hat">Hat</option>
	            <option value="Shoes">Shoes</option>
	            <option value="Bag">Bag</option>
	            <option value="Acc">Acc</option>
	            <option value="Beauty">Beauty</option>
	        </select></td>
		</tr>
		<tr><th>해시태그</th>
			<td><input type="text" name="hashtag"></td>
		</tr>
		<tr><th>상세설명</th>
			<td><textarea name="explains"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" id="buttons">
				<button type="reset">취소</button>
				<button type="submit">등록</button>
				<button type="button" onclick="location.href='/item/list'">목록보기</button>
			</td>
		</tr>
	</table>
	</form>
</main>
</body>
</html>