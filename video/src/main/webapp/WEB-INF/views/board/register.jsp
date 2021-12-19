<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>   

<style>
	.uploadResult{ width:100%; background:gray;}
	.uploadResult ul{ 
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	.uploadResult ul li{
		list-style: none;
		padding: 10px;
		align-content: center;
		text-align: center;
	}
	.uploadResult ul li img{
		width: 100px;
	}
/* (Seit.542) 원본 화면 출력 CSS */
	.uploadResult ul li span{color: white;}
	.bigPictureWrapper{
		position: absolute;
		display: none;
		justify-content: center;
		align-items: center;
		top: 0%;
		width: 100%;
		height: 100%;
		background: gray;
		z-index: 100;
		background: rgba(255,255,255,0.5);
	}
	.bigPicture {
		position: relative;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.bigPicture img { width: 600px; }
	
</style>
    
<%@include file="../includes/header.jsp" %>

<div class="row">
	<div class="col-lg-12">
    	<h1 class="page-header">Q & A</h1>
   	</div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->            
<div class="row">
	<div class="col-lg-12">
    	<div class="panel panel-default">
	    	<div class="panel-heading">
           	글쓰기
            </div>
            <!-- /.panel-heading -->
           	<div class="panel-body">
           		<form role="form" action="/board/register" method="post">
           			<div class="form-group">
           				<label>제목</label>
           				<input class="form-control" name="title"/>           				
           			</div>
           			<div class="form-group">
           				<label>내용</label>
           				<textarea class="form-control" rows="3" name="content"></textarea>
           			</div>
           			<div class="form-group">
           				<label>작성자</label>
           				<input class="form-control" name="writer" readonly="redonly"
           					value='<sec:authentication property="principal.member.userid"/>' />         				
           			</div>
           			<button type="submit" class="btn btn-primary">등록</button>
           			<button type="reset" class="btn btn-warning">초기화</button>
      			<!-- (S.714)CSRF 토큰 설정 - 스프링 시큐리티를 적용한 post방식일 때는 반드시 설정! -->
      				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
           		</form>
           	</div>
			<!-- end panel-body -->
		</div>
        <!-- end panel -->
	</div>               
</div>
<!-- /.row -->
<!-- (Seit.554) 첨부파일 등록 부분-->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">파일 첨부</div>
			<div class="panel-body">
			
				<div class="form-group uploadDiv">
					<input type="file" name="uploadFile" multiple />
				</div>
				
				<div class="uploadResult">
					<ul>
					
					</ul>
				</div>
				
			</div> <!-- /panel-body -->			
		</div> <!-- /panel panel-default -->
	</div> <!-- /col-lg-12 -->
</div> <!-- /row -->

<script>

$(document).ready(function(e){
/* (Seit.556) submit버튼 처리  */	
	var formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e){
		
		e.preventDefault();
		
		console.log("submit clicked");
/* -> (Seit.564) 수정  */
		var str="";
		
		$(".uploadResult ul li").each(function(i, obj){
			
			var jobj = $(obj);
			
			console.dir("console.dir:" +jobj);
			
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
		});
		
		formObj.append(str).submit();
		
	});
	
/* input태그의 내용이 변경되는 것을 감지해서 처리, 파일 업로드시 필요한 코드 */
	var regex = new RegExp("(.*?)\.(exe|sh)$");	// 확장자명이 exe, sh인 파일 업로드 제한
	var maxSize = 5242880; // 5MB
	
	function checkExtension(fileName, fileSize){
		
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}
	
//	(S.721) 게시물 등록 시 첨부파일 처리(시큐리티 적용)
	var csrfHeaderName ="${_csrf.headerName}";
	var csrfTokenValue ="${_csrf.token}";
	
	$("input[type='file']").change(function(e){
		
		var formData = new FormData();
		
		var inputFile = $("input[name='uploadFile']");
		
		var files = inputFile[0].files;
		
		for(var i=0; i<files.length; i++){
			
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("uploadFile", files[i]);			
		}	
	
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false,
			beforeSend: function(xhr){  // 로그인 보안 설정
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data: formData,
			type: 'POST',
			dataType: 'json',
			success: function(result){
				console.log("ajax: "+result);
				console.log(result);
				showUploadResult(result); // 업로드 결과 처리 함수
			}
		});	
	});
	
	function showUploadResult(uploadResultArr){
		
		if(!uploadResultArr || uploadResultArr.length == 0){
			return;
		}
		
		var uploadUL = $(".uploadResult ul");
		
		var str = "";
		
		$(uploadResultArr).each(function(i, obj){
			
			// 이미지 타입
			if(obj.image){
				
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>"
					+ "<span>"+obj.fileName+"</span>"
					+ "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'>"
					+ "<i class='fa fa-times'></i></button><br/>"
					+ "<img src='/display?fileName="+fileCallPath+"'>"
					+ "</div></li>";				
			// 이미지가 아닌 모든 파일
			}else{
				
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
				var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>"					
					+ "<span>"+obj.fileName+"</span>"
					+ "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'>"
					+ "<i class='fa fa-times'></i></button><br/>"
					+ "<img src='/resources/img/attach.png'></a>"
					+ "</div></li>";
					//+ "<a href='/download?fileName="+fileCallPath+"'>"
			}			
		});
		
		uploadUL.append(str);
	}
	
/* (Seit.560) 첨부파일의 변경 처리 x버튼 처리*/
	$(".uploadResult").on("click", "button", function(e){
		
		console.log("delete file");
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url: '/deleteFile',
			data: {fileName: targetFile, type: type},
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			dataType: 'text',
			type: 'POST',
			success: function(result){
				alert(result);
				targetLi.remove();
			}
			
		});
		
	});
	

	
});

</script>

<%@include file="../includes/footer.jsp" %>
        