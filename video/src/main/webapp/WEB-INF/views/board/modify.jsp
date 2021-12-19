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

<div class="bigPictureWrapper">
	<div class="bigPicture">
	</div>
</div>    
   
<div class="row">
	<div class="col-lg-12">
    	<div class="panel panel-default">
	    	<div class="panel-heading" style="background: skyblue; color:#fff">
                      문의글 수정페이지
            </div>
            <!-- /.panel-heading -->
           	<div class="panel-body">
           		<form role="form" action="/board/modify" method="post">
<!-- pageNum, amount 값 hidden으로 추가  -->
           			<input type="hidden" name="pageNum" value="${cri.pageNum }" />
           			<input type="hidden" name="amount" value="${cri.amount }" />
           			<input type="hidden" name="type" value="${cri.type }" />
					<input type="hidden" name="keyword" value="${cri.keyword }" />
<!-- (S.719) Post처리부분 CSRF로 보안처리 -->
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					
           			<div class="form-group">
           				<label>번호</label>
           				<input class="form-control" name="bno" value="${board.bno}" readonly="readonly"/>           				
           			</div>
           			<div class="form-group">
           				<label>제목</label>
           				<input class="form-control" name="title" value="${board.title}" />           				
           			</div>
           			<div class="form-group">
           				<label>내용</label>
           				<textarea class="form-control" rows="3" name="content" >${board.content}</textarea>
           			</div>
           			<div class="form-group">
           				<label>작성자</label>
           				<input class="form-control" name="writer" value="${board.writer}" readonly="readonly"/>           				
           			</div>
           			<div class="form-group">
           				<label>작성일</label>
           				<input class="form-control" name="regDate" value='<fmt:formatDate pattern ="yyyy/MM/dd" value="${board.regDate}" />' readonly="readonly"/>           				
           			</div>
           			<div class="form-group">
           				<label>수정일</label>
           				<input class="form-control" name="updateDate" value='<fmt:formatDate pattern ="yyyy/MM/dd" value="${board.updateDate}" />' readonly="readonly"/>           				
           			</div>
           			
<!-- (S.719) 수정 및 삭제 로그인 확인 처리 -->
					<sec:authentication property="principal" var="pinfo" />
					<sec:authorize access="isAuthenticated()">
           			<c:if test="${pinfo.username eq board.writer}">
           			<button type="submit" data-oper="modify" class="btn btn-primary">수정</button>
           			<button type="submit" data-oper="remove" class="btn btn-danger">삭제</button>
           			</c:if>
           			</sec:authorize>
           			<button type="submit" data-oper="list" class="btn btn-info">목록</button>
           		</form>
           	</div>
			<!-- end panel-body -->
		</div>
        <!-- end panel -->
	</div>               
</div>
<!-- /.row -->

<!-- seit.584 -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading" style="background: tomato; color:#fff">첨부파일</div>
			<div class="panel-body" >			
				<div class="form-group uploadDiv">
					<input type="file" name="uploadFile" multiple="multiple" >
				</div>				
				
				<div class='uploadResult' style="background: skyblue;">
					<ul>
					</ul>
				</div>				
			</div>
		</div>
	</div>
</div>

<script>
//(seit.584~585)첨부파일 수정
$(document).ready(function(){
	(function(){
		
		var bno = '<c:out value="${board.bno}" />';
		console.log(bno);
		
		$.getJSON("/board/getAttachList", {bno:bno}, function(arr){
			console.log(bno);
			console.log(arr);
			
			var str="";
			
			$(arr).each(function(i, attach){
				console.log(attach.fileName);
//				이미지 파일
				if(attach.fileType){
					var fileCallPath = encodeURIComponent( attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
					console.log(fileCallPath);
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"'data-type='"+attach.fileType+"'><div>"
						+ "<span>"+attach.fileName+"</span>"
						+ "<button data-file=\'"+fileCallPath+"\' data-type='image' calss='btn btn-warning btn-circle'>"
						+ "<i class='fa fa-times'></i></button><br/>"
						+ "<img src='/display?fileName="+fileCallPath+"'>"
						+ "</div></li>";
				}else{
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"'data-type='"+attach.fileType+"'><div>"
						+ "<span>"+attach.fileName+"</span><br/>"
						+ "<button data-file=\'"+fileCallPath+"\' data-type='file' calss='btn btn-warning btn-circle'>"
						+ "<i class='fa fa-times'></i></button><br/>"
						+ "<img src='/resources/img/attach.png'>"
						+ "</div></li>";
				}
			});
			$(".uploadResult ul").html(str);
			
		}); //getJSON 끝
	})(); // 즉시실행함수 끝
	
//	(seit.588) X버튼을 이용한 첨부파일 삭제 처리 함수
	$(".uploadResult").on("click", "button", function(e){
		
		console.log("delete File");
		
		if(confirm("삭제하시겠습니까?")){
			
			var targetLi = $(this).closest("li");
			targetLi.remove();
		}		
	}); // X버튼 함수 끝
	
/*(seit.589) input태그의 내용이 변경되는 것을 감지해서 처리, 파일 업로드시 필요한 코드 */
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
//	(s.725) 시큐리티 설정
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
			data: formData,
			type: 'POST',
			beforeSend: function(xhr){ // (s.725) 시큐리티 설정
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
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
});
</script>

<script>
	$(document).ready(function(){
		
		var formObj=$("form");
		
		$('button').on("click", function(e){
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			console.log(operation);
			
			if(operation === 'remove'){
				formObj.attr("action","/board/remove");
				
			}else if(operation === 'list'){
				formObj.attr("action","/board/list").attr("method","get");
				//formObj.empty();			
/* 페이지 넘버와 게시물 개수는 복사(clone)한 뒤 나머지 모든 불필요한 파라메터 값을 삭제(empty) 후,
	복사해둔 정보만 /board/list 뒤에 합쳐서(append) 전송(submit) */
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name='type']").clone();
				
				formObj.empty();
				formObj.append(pageNumTag).append(amountTag).append(keywordTag).append(typeTag);
				//formObj.append(amountTag);
				
//			(seit.590)게시물 수정 이벤트 처리
			}else if(operation === 'modify'){
				
				console.log("submit clicked");
				
				var str = "";
				
				$(".uploadResult ul li").each(function(i, obj){
					
					var jobj = $(obj);
					
					console.dir(jobj);
					
					str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
				});
				
				formObj.append(str).submit();
			}
			
			formObj.submit();
		});
	});
</script>

<%@include file="../includes/footer.jsp" %>