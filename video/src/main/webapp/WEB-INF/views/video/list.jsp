<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>     
    
<%@include file="../includes/header.jsp" %>
 	
	<div class="row">
	<div class="col-lg-12">
	<h1 class="page-header">강의 목록</h1>
	</div>
	<!-- /.col-lg-12 -->
	</div>
<!-- /.row -->
 	<link rel="stylesheet" type="text/css" href="/resources/slick/slick.css">
  	<link rel="stylesheet" type="text/css" href="/resources/slick/slick-theme.css">
  	<style type="text/css">
    html, body {
      margin: 0;
      padding: 0;
    }

    * {
      box-sizing: border-box;
    }

    .slider {
        width: 100%;
        margin: 100px auto;
    }

    .slick-slide {
      margin: 0px 20px;
    }

    .slick-slide iframe {
      width: 100%;
    }

    .slick-prev:before,
    .slick-next:before {
      color: black;
    }


    .slick-slide {
      transition: all ease-in-out .3s;
      opacity: .2;
    }
    
    .slick-active {
      opacity: .5;
    }

    .slick-current {
      opacity: 1;
    }
  </style>


<section class="regular slider" style="background:ivory">
    <c:forEach items="${list }" var="video">
		<div style="background:ivory">
			<iframe width="300" height="200" src="${video.url }" allowfullscreen></iframe>
			<a class="move" href="${video.vno}"><b>[<c:out value="${video.title }${video.vno}" />]</b></a>
		</div>
	</c:forEach>
  </section>

  <script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
  <script src="/resources/slick/slick.js" type="text/javascript" charset="utf-8"></script>
  <script type="text/javascript">
    
    $(".regular").slick({
      dots: true,
      infinite: true,
      autoplay: true,
      autoplaySpeed: 2000,
      slidesToShow: 4,
      slidesToScroll: 1
    });

  </script>
          
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading" style="background: skyblue; color:#fff">
			<b>강의 목록</b>
				<sec:authentication property="principal" var="pinfo"/>
				<sec:authorize access="hasRole('ROLE_ADMIN')">		
				<button id="regBtn" type="button" class="btn btn-xs pull-right btn-primary">새영상등록</button>
				</sec:authorize>
			</div>			
			<!-- /.panel-heading -->
			<div class="panel-body">
			<table class="table table-striped table-bordered table-hover">
				<thead>
				<tr>
					<th>카테고리</th>
					<th>번호</th>
					<th>제목</th>					
					<th>영상설명</th>
					<th>조회수</th>	
					<th>작성일</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${list }" var="video">
					<tr>
						<td><c:out value="${video.category}" /></td>									
						<td><c:out value="${video.vno}" /></td>
						<td><a class="move" href="${video.vno}"><c:out value="${video.title }" /></a>
						</td>						
						<td>${video.content}</td>
						<td>${video.hits}</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${video.regDate}"/>						
						<sec:authentication property="principal" var="pinfo"/>
						<sec:authorize access="hasRole('ROLE_ADMIN')">
						<button type="button" class="delete btn pull-right btn-danger" data-vno="${video.vno}" style="float:right" >삭제</button>	
						<button class="modyBtn btn pull-right btn-warning" type="button" data-vno="${video.vno}" style="float:right; margin-right:5px;">수정</button>
						</sec:authorize>
						</td>					
					</tr>
				</c:forEach>
				</tbody>                                                                
			</table>
	<!-- 검색 처리 -->
			<div class="row">
				<div class="col-lg-12">
				
				<form action="/video/list" id="searchForm" method="get">
					<select name="type">
						<option value=""
						<c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>--</option>
						<option value="T"
						<c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
						<option value="C"
						<c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
						<option value="Ca"
						<c:out value="${pageMaker.cri.type eq 'Ca'?'selected':'' }"/>>카테고리</option>
						<option value="TC"
						<c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목 or 내용</option>
						<option value="TCa"
						<c:out value="${pageMaker.cri.type eq 'TCa'?'selected':'' }"/>>제목 or 카테고리</option>
						<option value="TCCa"
						<c:out value="${pageMaker.cri.type eq 'TCCa'?'selected':'' }"/>>제목 or 내용 or 카테고리</option>
					</select>
					<input type="text" name="keyword" value="${pageMaker.cri.keyword }"/>					
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }" />
					<input type="hidden" name="amount" value="${pageMaker.cri.amount }"/>
					<button class="btn btn-info">검색</button>
				</form>
	<!-- 페이지 처리 -->
				<form id="actionForm" action="/video/list" method="get">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }" />
					<input type="hidden" name="amount" value="${pageMaker.cri.amount }" />
					<input type="hidden" name="type" value="${pageMaker.cri.type }" />
					<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }" />
				</form>  
				
				</div>			
			</div>
			
	<!-- start Pagination -->		
			<div class="pull-right">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">					
						<li class="paginate_button previous">
						<a href="${pageMaker.startPage -1}">Previous</a>
						</li>
					</c:if>
					
					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active':''}">
						<a href="${num }">${num}</a>
						</li>
					</c:forEach>
					
					<c:if test="${pageMaker.next}">
						<li class="paginate_button next">
						<a href="${pageMaker.endPage+1 }">Next</a>
						</li>
					</c:if>
				</ul>				
			</div>
	<!-- end Pagination -->
			</div><!-- panel-body -->
		</div><!-- panel panel-default -->
	</div><!-- col-lg-12 -->
</div><!-- row -->

<!-- 글쓰기 Modal -->
<div class="modal fade" id="modal-register" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">등록</h4>
			</div>
			<form id = "videoWrite">
				<div class="modal-body">
					<div class="form-group">
           				<label>카테고리</label>
           				<input class="form-control" name="category" />           				
           			</div>
           			<div class="form-group">
           				<label>영상제목</label>
           				<input class="form-control" name="title" />           				
           			</div>
           			<div class="form-group">
           				<label>영상내용</label>
           				<textarea class="form-control" rows="3" name="content"></textarea>
           			</div>
           			<div class="form-group">
           				<label style= "display : block">영상 URL</label>
           				<input class="form-control" name="url" style= "display : inline; float:left; width:85%"/>
           				<button type="button" class="checkVideo btn btn-warning">영상확인<br/></button>        				
           			</div>           	
           			<div class="form-group videoLoading">           				
           			</div>	
				</div><!-- modal body -->
				<div class="modal-footer">
					<sec:authorize access="hasRole('ROLE_ADMIN')">
					<button type="button" class="btn btn-primary" id = "register">등록</button>										
					<button type="reset" class="btn btn-danger">초기화</button>
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					</sec:authorize>					
				</div>
			</form>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<!-- 수정 Modal -->
<div class="modal fade" id="modal-modify" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">등록</h4>
			</div>
				<div class="modal-body">
           			<div class="form-group">
           				<label>영상</label>
           				<div>
           					<iframe width="300" height="200" id="mModifySrc" src="" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
           				</div>           				
           			</div>
           			<div class="form-group">
           				<label>vno</label>
           				<input class="form-control" name="vno" data-vno="" readonly />          				
           			</div>           			
           			<div class="form-group">
           				<label>카테고리</label>
           				<input class="form-control" name="category" readonly />           				
           			</div>
           			<div class="form-group">
           				<label>조회수</label>
           				<input class="form-control" name="hits" readonly />           				
           			</div>
           			<div class="form-group">
           				<label>영상제목</label>
           				<input class="form-control" name="title"/>           				
           			</div>
           			<div class="form-group">
           				<label>영상내용</label>
           				<input class="form-control" rows="3" name="content"></input>
           			</div>
           			<div class="form-group">
           				<label>영상 URL</label>
           				<input class="form-control" name="url" />           				
           			</div>
           			<div class="form-group">
           				<label>작성일</label>
           				<input class="form-control" name="regDate" value="" readonly/>           				
           			</div>

				</div><!-- modal body -->
				<div class="modal-footer">
					<button type="button" class="btn btn-warning" id = "modify">수정</button>
					<button type="button" class="btn btn-danger delete" >삭제</button>
					<!-- (S.714)CSRF 토큰 설정 - post방식일 때는 반드시 설정! 
      					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />-->
				</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->
	
	
<!-- 모듈화 스크립트 추가  오류확인 주석처리-->
<!-- <script src="/resources/js/video.js"></script> -->
<script>
console.log("${video.hits}");

$(document).ready(function(){
	
	var actionForm = $("#actionForm"); // 페이지 이동처리
	
	$(".paginate_button a").on("click", function(e){
		e.preventDefault();
		console.log("click");
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	$(".move").on("click", function(e){
		e.preventDefault();
		actionForm.append("<input type='hidden' name='vno' value='"+
							$(this).attr("href")+"'>");
		actionForm.attr("action","/video/get");
		actionForm.submit();
	});
	
	var searchForm = $("#searchForm");
	$("#searchForm button").on("click", function(e){
	/* 	if(!searchForm.find("option:selected").val()){
			alert("검색 종류를 선택하세요.");
			return false;
		}
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요.");
			return false;
		} */
		
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		
		searchForm.submit();
	});
	
});
//console.log("==========");
//console.log("JS TEST");

//Seit. 415 댓글 목록보기 이벤트 처리  / 수정된 부분 : Seit. 418

/* var videoUL = $(".videoList");

	showList(1);
	
	function showList(page){
		
		console.log("show list : "+page);
		
		videoService.getList(page: page || 1, function(list){
//			댓글 페이징 처리 seit.438

			console.log("list : "+list);				
			
			if(page == -1){				
				showList(pageNum);
				return;
			}
//			댓글 페이징 처리 전
			var str="";
			if(list == null || list.length == 0){
//				replyUL.html("");					
				return;
			}
			
			for(var i =0, len = list.length || 0; i<len; i++){
				str += "<td>"+list[i].vno+"</td>";
				str += "<td>"+list[i].title+"</td>";
				str += "<td>"+list[i].regdate+"</td>";
				str += "<td>"+list[i].uuid+"</td>"				
			}
			
			videoUL.html(str);
			//showReplyPage(replyCnt);
		}); // end functio
	}// ent show list


$(document).ready(function(){
	
	console.log(videoService);
	
	
});
 */
</script>
   
<!--  JS 모듈 --> 
<script src="/resources/js/video.js"></script>

<!-- 모달창 show/hidden 모달창 열기 닫기 -->
<script>

//모달창 보이기 글 등록
$("#regBtn").on("click", function(e){
	
	$("#modal-register").modal("show");
});

//시큐리티 토큰
var csrfHeaderName ="${_csrf.headerName}";
var csrfTokenValue ="${_csrf.token}";
$(document).ajaxSend(function(e, xhr, options){
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});

</script>

<!-- 비디오 게시판 글등록  -->
<script>
	var write= $("#modal-register");
	var title = write.find("input[name='title']");
	var content = write.find("textarea[name='content']");
	var url = write.find("input[name='url']")
	var category= write.find("input[name='category']");
	//var catefory= write.find("")
	
	//console.log("글등록===============");
	//console.log(title, content,category);
	
	//console.log("===================");
	$(document).ready(function(){

		$("#register").on("click", function(e){
	
			var videoadd = {title: title.val(), content: content.val(),category: category.val(), url: url.val() };
			
			videoService.add(videoadd, function(result){
				
				console.log("reult: " + result);
				
				if(result !== null){
					
					$("#modal-register").find('form')[0].reset()
					$("#modal-register").modal("hide");
					location.replace('list');
					//console.log("성공성공")
				}
			}); 
	}); 
		////////// 영상 확인버튼 처리//////////////////
		$(".checkVideo").on("click", function(e){
			
			var str= ' <hr><hr><div class="form-group"> '
					+' <iframe id="videoLoadingSrc" width="300" height="200" src=""'
					+' title="YouTube video player" frameborder="0"allow="accelerometer; autoplay; clipboard-write; '
					+' encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> '
					+' </div> ';
			
			if(url.val() !== ""){
				$(".videoLoading").html(str);
			}
		
			var checkUrl= $("#modal-register").find("input[name='url']").val();
		
		
		
			$("#videoLoadingSrc").attr("src", checkUrl);
		
			});
	
});
</script>
<script>
////////수정 Modal + Get + Update
	
	///////////GET///////////////////////
	////////////////////////////////////
	//   modal - > $(".modal-modify") //
	////////////////////////////////////
	var modal = $("#modal-modify");
	
	var modalInputCategory = modal.find("input[name='category']");
	var modalInputContent = modal.find("input[name='content']");
	var modalInputRegDate = modal.find("input[name='regDate']");
	var modalInputVno = modal.find("input[name = 'vno']");
	var modalInputTitle = modal.find("input[name='title']");
	var modalInputUrl = modal.find("input[name='url']");
	var modalInputHits = modal.find("input[name='hits']");
	//console.log("영상수정===============");
	//console.log(modalInputTitle, modalInputContnet, modalInputUrl);
	//console.log(modalInputRef);
	//console.log("===================");
	
	$(".modyBtn").on("click", function(e){
	
		$("#modal-modify").modal("show");
	
		var vno = $(this).data("vno");
		//var vno = $(".modyBtn").data("vno");
		
		//console.log(".modyBtn vno : " + vno)
		
		modal.data("vno", vno);
		
		//var vno2 = modal.data("vno");
		
		//console.log("Modal data vno : "+ vno2)
		
		videoService.get(vno, function(mModify){ //get 으로 받아온 값은 mModify 에 들어있음.
				
			//console.log("mModify : "+ mModify);	
			
			modalInputTitle.val(mModify.title);
			modalInputContent.val(mModify.content);
			modalInputUrl.val(mModify.url);
			
			modalInputRegDate.val(videoService.displayTime(mModify.regDate));
			//$("#img_form_url").attr("src", imgurl); -> src 변경방법
			
			$("#mModifySrc").attr("src", mModify.url);
			//console.log("mModify.url : "+mModify.url);
			
			modalInputHits.val(mModify.hits);
			modalInputCategory.val(mModify.category);
			modalInputVno.val(mModify.vno);
			
			//console.log("modal.data : "+modal.data("vno"));
			//console.log("mModify.hits: "+mModify.hits);
			
			// Modal창 x button hide()
			//modal.find("button[id !='modalCloseBtn']").hide();
			
			//$("#modal-modify").modal("show");
			
			
///////////////////////////수정 update 부분//////////////////////////////////////
			
			$("#modify").on("click", function(e){
				
				var mModifyU = {
						vno: vno,
						title: modalInputTitle.val(),
						url: modalInputUrl.val(),
						content: modalInputContent.val()
				};
						
				//console.log("mModifyU : "+mModifyU);

				videoService.update(mModifyU, function(result){
					
					console.log(result);
					$("#modal-modify").modal("hide");
					location.replace('list');
					
				});
			
			});//수정  update
			
			////modal삭제/////
			//console.log("delete vno1 : "+ vno );
			
			$(".delete").on("click", function(e){
				
				boardService.remove(vno, function(result){
					
					console.log(result);
					$("#modal-modify").modal("hide");
					location.replace('list'); 
					
				});
			});//삭제

		});
	});
</script>
<script>
////삭제/////

$(document).ready(function(){
	
	$(".delete").on("click", function(e){
		
		var vno = $(this).data("vno");
		
		//console.log("delete vno2 : "+ vno );
	
		videoService.remove(vno, function(result){
		
			console.log(result);
			location.replace('list'); 
		});
	});//삭제
});
</script>

<%@include file="../includes/footer.jsp" %>
        