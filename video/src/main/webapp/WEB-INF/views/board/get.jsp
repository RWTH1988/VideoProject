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

<!-- (seit.572) 사진 큰화면 보기 -->
<div class="bigPictureWrapper">
	<div class="bigPicture">
	</div>
</div>
   
<div class="row">
	<div class="col-lg-12">
    	<div class="panel panel-default">
	    	<div class="panel-heading" style="background: skyblue; color: #fff;">
            <h4>${board.title }</h4>
            </div>
            <!-- /.panel-heading -->
           	<div class="panel-body">
           		
           			<div class="form-group">
           				<label>문의글 번호</label>
           				<input class="form-control" name="bno" value="${board.bno}" readonly="readonly"/>           				
           			</div>
           			<div class="form-group">
           				<label>제목</label>
           				<input class="form-control" name="title" value="${board.title}" readonly="readonly"/>           				
           			</div>
           			<div class="form-group">
           				<label>내용</label>
           				<textarea class="form-control" rows="3" name="content" readonly="readonly">${board.content}</textarea>
           			</div>
           			<div class="form-group">
           				<label>작성자</label>
           				<input class="form-control" name="writer" value="${board.writer}" readonly="readonly"/>           				
           			</div>
           			
		<!-- (S.717)로그인한 경우에만 수정 버튼 보이게 하기 -->
		<sec:authentication property="principal" var="pinfo"/>
				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq board.writer }">

						<button data-oper="modify" class="btn btn-default btn-primary"
							onclick="location.href='/board/modify?bno=${board.bno}'">수정</button>

					</c:if>
				</sec:authorize>
				<button data-oper="list" class="btn btn-info">목록</button>
           			<form id="operForm" action="/board/modify" method="get">
           				<input type="hidden" id="bno" name="bno" value="${board.bno }" />
           				<input type="hidden" name="pageNum" value="${cri.pageNum }" />
           				<input type="hidden" name="amount" value="${cri.amount }" />
           				<input type="hidden" name="type" value="${cri.type }" />
						<input type="hidden" name="keyword" value="${cri.keyword }" />
           			</form>
           	</div>
			<!-- end panel-body -->			
		</div>
        <!-- end panel -->
	</div>               
</div>
<!-- /.row -->

<!-- 첨부파일 보는 창 -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading" style="background: tomato; color:#fff">첨부파일</div>
			
			<div class="panel-body">
				<div class="uploadResult" style="background: skyblue;">
					<ul>
					
					</ul>
				</div>
			</div>		
		</div>
	</div>
</div>

<!-- 댓글 창  -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<!-- <div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>Reply
			</div> -->
			<div class="panel-heading" style="background: #5cb85c; color:#fff">
				<i class="fa fa-comments fa-fw"></i>댓글
			<!-- (S.718) 댓글쓰기 로그인 여부 처리 -->
				<sec:authorize access="isAuthenticated()">
				<button id="addReplyBtn" class="btn btn-danger btn-xs pull-right">
				댓글쓰기</button>
				</sec:authorize>
			</div>
		</div>
		
		<div class="panel-body">
			<ul class="chat">
				<li class="left clearfix" data-rno="12">
					<div>
						<div class="header">
							<strong class="primay-font"></strong>
							<small class="pull-right text-muted"></small>
						</div>
						<p></p>					
					</div>				
				</li>
			</ul>
		</div> <!-- "panel-body 끝! -->
		<div class="panel-footer">
		
		</div>	
	</div>			
</div>

<!-- 댓글 달기 Modal window! -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">댓글 창</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>내용</label>
					<input class="form-control" name="reply" value="New Reply!!!!!" />					
				</div>
				<div class="form-group">
					<label>작성자</label>
					<input class="form-control" name="replyer" value="replyer" readonly="readonly"/>
				</div>
				<div class="form-group">
					<label>작성일</label>
					<input class="form-control" name="replyDate" value="" />
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" id="modalModBtn" class="btn btn-warning">수정</button>
				<button type="button" id="modalRemoveBtn" class="btn btn-danger">삭제</button>
				<button type="button" id="modalRegisterBtn" class="btn btn-primary" data-dismiss="modal">등록</button>
				<button type="button" id="modalCloseBtn" class="btn btn-info" data-dismiss="modal">닫기</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script src="/resources/js/reply.js"></script>

<!--  댓글 JSON 테스트!! --> 
<script>
	console.log("===================");
	console.log("js Test");
	
	var bnoValue = '<c:out value="${board.bno}" />';
	
	/* replyService.add(
		{reply:"js test", replyer: "tester", bno: bnoValue},
		function(result){
			alert("reult: " + result);
		}
	);
	
	replyService.getList({bno:bnoValue, page:1}, function(list){
		
		for(var i = 0, len = list.length || 0; i<len; i++){
			console.log(list[i]);
		}
	});
	
	// 46번 댓글 삭제!
 	replyService.remove(46, function(count){
		
		console.log(count);
		
		if(count === "success"){
			alert("REMOVED");
		}
	}, function(err){
		alert("ERROR....");
	}); 
	
	replyService.update({
		rno : 22,
		bno : bnoValue,
		reply : "Modified Reply......"		
	}, function(result){
		alert("modified success");
	}); */
	
	replyService.get(10, function(data){
		console.log(data);
	});
	
</script>

<!-- 게시판 처리 -->
<script>
	$(document).ready(function(){
		
		var operForm = $("#operForm");
		$("button[data-oper='modify']").on("click",function(e){
			
			operForm.attr("action","/board/modify").submit();
			
		});
		
		$("button[data-oper='list']").on("click", function(e){
			
			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list");
			operForm.submit();
			
		});	
	});
		// console.log(replyService);
</script>		

<script>
//댓글 처리 부분!
// Seit. 415 댓글 목록보기 이벤트 처리  / 수정된 부분 : Seit. 418
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
	
		showList(1);
		
		function showList(page){
			
			console.log("show list : "+page);
			
			replyService.getList({bno: bnoValue, page: page || 1}, function(replyCnt, list){
//				댓글 페이징 처리 seit.438
				console.log("replyCnt : "+replyCnt);
				console.log("list : "+list);				
				
				if(page == -1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
//				댓글 페이징 처리 전
				var str="";
				if(list == null || list.length == 0){
//					replyUL.html("");					
					return;
				}
				for(var i =0, len = list.length || 0; i<len; i++){
					str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
					str += "<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
					str += "<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
					str += "<p>"+list[i].reply+"</p></div></li>";
				}
				
				replyUL.html(str);
				showReplyPage(replyCnt);
			}); // end function
		}// ent show list
		
// Seit. 421~422 새로운 댓글 추가 이벤트 처리
		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
//		(S.727) 댓글 기능 스프링 시큐리티 추가
		var replyer = null;
		
		<sec:authorize access="isAuthenticated()">
		
		replyer = '<sec:authentication property="principal.username"/>';
		
		</sec:authorize>
		
		var csrfHeaderName ="${_csrf.headerName}";
		var csrfTokenValue ="${_csrf.token}";
		
		$("#addReplyBtn").on("click", function(e){
			
			modal.find("input").val("");
			modal.find("input[name='replyer']").val(replyer);
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id !='modalCloseBtn']").hide();
			
			modalRegisterBtn.show();
			
			$(".modal").modal("show");
		});
//		(S.728) Ajax 스프링 시큐리티 헤더설정
		$(document).ajaxSend(function(e, xhr, options){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
		
		modalRegisterBtn.on("click", function(e){
			
			var reply = {
					reply: modalInputReply.val(),
					replyer: modalInputReplyer.val(),
					bno: bnoValue
			};
			replyService.add(reply, function(result){
				
				alert(result);
				
				modal.find("input").val("");
				modal.modal("hide");
				
				showList(-1); // 우선적으로 전체 댓글의 숫자를 파악하게 하기 위한 초기화
//				showList(1);
			});
		});
// Seit. 425~426 댓글 이벤트 처리(하나의 댓글 내용보기)
		$(".chat").on("click", "li", function(e){
			
			var rno = $(this).data("rno");
			
			replyService.get(rno, function(reply){
				
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
				.attr("readonly","readonly");
				modal.data("rno", reply.rno);
				
				modal.find("button[id !='modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				$(".modal").modal("show");
			});
			console.log(rno);
		});
		
//		Seit.426 모달창에서 댓글 수정
		modalModBtn.on("click", function(e){
			
			var originalReplyer = modalInputReplyer.val();
			
			var reply = {rno : modal.data("rno"), 
						reply : modalInputReply.val(),
						replyer: modalInputReplyer.val()};
			
			if(!replyer){
				alert("로그인후 수정이 가능합니다.");
				modal.modal("hide");
				return;
			}			
			
			console.log("실제 작성자 : "+ originalReplyer);
			
			if(replyer != originalReplyer){
				alert("자신이 작성한 댓글만 수정 가능 합니다.");
				modal.modal("hide");
				return;
			}
			
			replyService.update(reply, function(result){
				
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});			
		});
//		Seit.427 모달창에서 댓글 삭제
		modalRemoveBtn.on("click", function(e){
			
			var rno = modal.data("rno");
//		Seit.730 스프링 시큐리티 추가 			
			console.log("RNO : "+rno);
			console.log("REPLYER : "+replyer);
			
			if(!replyer){
				alert("로그인 후 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			var originalReplyer = modalInputReplyer.val();
			
			console.log("실제 작성자 : "+ originalReplyer);
			
			if(replyer != originalReplyer){
				
				alert("자신이 작성한 댓글만 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			replyService.remove(rno, originalReplyer, function(result){
			
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});
//		Seit.440 댓글 페이지 번호 출력
		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");
		
		function showReplyPage(replyCnt){
			
			var endNum = Math.ceil(pageNum / 10.0)*10;
			var startNum = endNum - 9;
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt/10.0);	 		
			}
			if(endNum * 10 < replyCnt){
				next = true;
			}
			
			var str = "<ul class='pagination pull-right'>";
			
			if(prev){
				str += "<li class='page-item'>";
				str += "<a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
			}
			
			for(var i = startNum; i<=endNum; i++){
				
				var active = pageNum == i ? "active" : "";
				
				str += "<li class='page-item "+active+"'>";
				str += "<a class='page-link' href='"+i+"'>"+i+"</a></li>";
			}
			
			if(next){
				str += "<li class='page-item'><a class='page-link' herf='"+(endNum+1)+"'>Next</a></li>";
			}
			
			str += "</ul></div>";
			
			console.log(str);
			replyPageFooter.html(str);
		}
//		Seit.441 댓글 페이지 이동		
		replyPageFooter.on("click", "li a", function(e){
			
			e.preventDefault();
			console.log("page click");
			
			var targetPageNum = $(this).attr("href");
			console.log("targetPageNum : "+targetPageNum);
			
			pageNum = targetPageNum;
			
			showList(pageNum);
		});
	
</script>
<script>
// (seit.571) 게시물 조회 화면 처리 mit 첨부파일
$(document).ready(function(){
	(function(){
		
		var bno = '<c:out value="${board.bno}"/>';
		
		$.getJSON("/board/getAttachList", {bno:bno}, function(arr){
			
			console.log("getJSON: "+arr);
			console.log(arr);
// (siet.574) 첨부파일 보여주기 처리
			var str = "";
			
			$(arr).each(function(i, attach){
				
				//이미지 타입
				if(attach.fileType){
					var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
					console.log("fileCallPath:"+fileCallPath);
					
					
					str += "<li data-path='"+attach.uploadPath+"'data-uuid='"+attach.uuid+"'data-filename='"+attach.fileName+"'data-type='"+attach.fileType+"'><div>"
						+ "<img src='/display?fileName="+fileCallPath+"'>"
						+ "</div></li>";
//					console.log("filename: "+attach.fileName);
//					console.log(str);
					
				}else{					
					str +="<li data-path='"+attach.uploadPath+"'data-uuid='"+attach.uuid+"'data-filename='"+attach.fileName+"'data-type='"+attach.fileType+"'><div>"						
						+ "<span>"+attach.fileName+"</span><br/>"
						+ "<img src='/resources/img/attach.png'>"
						+ "</div></li>";
//					console.log("filename: "+attach.fileName);
//					console.log(str);
				}
			});
			$(".uploadResult ul").html(str);
			
		}); // getJSON 끝
		
//		(Seit.575~576) 첨부파일 다운로드 등 액션 처리	
		$(".uploadResult").on("click", "li", function(e){
			
			console.log("view Image");
			
			var liObj = $(this);
			console.log(liObj);
//			console.log("fileName: "+liObj.data("filename"));
			
			var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
			console.log("path:"+ path);
/* 
 encodeURIComponent의 역할 = web상에서 사용할 수 있는 문자열로 경로를 재설정(encoding)해준다. 
   Encode전: 2021\11\16\2F33af339b-78ea-4e0e-9484-312134a029\lion.png
   Encode후: 2021%5C11%5C16%2F33af339b-78ea-4e0e-9484-312134a029be_lion.png 
*/			
			if(liObj.data("type")){
				showImage(path.replace(new RegExp(/\\/g),"/"));
//				\\ = \, \를 /로 변경.
			}else{
				//download
				self.location = "/download?fileName="+path
			}		
			
		});
		
		function showImage(fileCallPath){
			
			//alert(fileCallPath);
			
			$(".bigPictureWrapper").css("display", "flex").show();
			
			$(".bigPicture")
			.html("<img src='/display?fileName="+fileCallPath+"'>")
			.animate({width: '100%', height: '100%'}, 1000);
		}
		
		$(".bigPictureWrapper").on("click", function(e){
			$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
			setTimeout(function(){
				$(".bigPictureWrapper").hide();
			}, 1000);	
		});
		
	})(); // 즉시 실행 함수 끝
	
});

</script>


<%@include file="../includes/footer.jsp" %>        