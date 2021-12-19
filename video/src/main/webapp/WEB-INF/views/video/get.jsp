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
    	<h1 class="page-header">강의보기</h1>
   	</div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
    	<div class="panel panel-default">
	    	<div class="panel-heading" align="center" style="background: skyblue; color: #fff;">
           <h4><b>${video.title}</b></h4>
            </div>
            <!-- /.panel-heading -->
           	<div class="panel-body">
           	<!-- width="1064" height="768" -->
           			<div class="form-group" align="center">
           				<iframe style="positon:relative; width:100%; height:80%;"src="${video.url}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
           			</div>
           			<div class="form-group" align="right">
	           			<button class="good" style="display: inline-block; color: #fff; background:blue;border-radius:0.5em;">좋아요</button>${video.good }&nbsp&nbsp
	           			<button class="noway" style="display: inline-block; color: #fff; background:red;border-radius:0.5em;">싫어요</button>${video.noway }
           				
           			</div>
           			<div class="form-group">
           				<label>제목</label> 
           				<input class="form-control" name="title" value="${video.title}" readonly="readonly"/>           				
           			</div>
           			<div class="form-group">
           				<label>영상 설명</label>
           				<input class="form-control" name="content" value="${video.content}" readonly="readonly"></input>
           			</div>
           			<button data-oper="list" class="btn btn-info">목록</button>
           			<form id="operForm" action="/video/modify" method="get">
           				<input type="hidden" id="vno" name="vno" value="${video.vno }" />
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
				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">
				댓글쓰기</button>
				</sec:authorize>
			</div>
		</div>
		
		<div class="panel-body">
			<ul class="chat">
				<li class="left clearfix" data-vrno="12">
					<div>
						<div class="header">
							<strong class="primay-font">no user</strong>
							<small class="pull-right text-muted">2021-11-08</small>
						</div>
						<p>no data!</p>					
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
					<input class="form-control" name="vreply" value="New Reply!!!!!" />					
				</div>
				<div class="form-group">
					<label>작성자</label>
					<input class="form-control" name="vreplyer" value="vreplyer" readonly="readonly" />
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
				<button type="button" id="modalCloseBtn" class="btn btn-success" data-dismiss="modal">취소</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script src="/resources/js/videoreply.js"></script>

<!--  동영상  js --> 
<script src="/resources/js/good.js"></script>

<!--  동영상 좋아요 JSON 테스트!! --> 
<script>
	console.log("===================");
	console.log("js Test");
	
	var vnoValue = '<c:out value="${video.vno}"/>';
	var goodValue = '<c:out value="${video.good}"/>';
	
	/* goodService.update({
		vno : vnoValue ,
		good : goodValue+1
			
	}, function(result){
		alert("success");
	});  */
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
	
	/* replyService.get(10, function(data){
		console.log(data);
	});*/
	
</script>

<!-- 게시판 처리 -->
<script>
	$(document).ready(function(){
		
		var operForm = $("#operForm");
		$("button[data-oper='modify']").on("click",function(e){
			
			operForm.attr("action","/board/modify").submit();
			
		});
		
		$("button[data-oper='list']").on("click", function(e){
			
			operForm.find("#vno").remove();
			operForm.attr("action", "/video/list");
			operForm.submit();
			
		});	
	});
		// console.log(replyService);
</script>		

<script>
//댓글 처리 부분!
// Seit. 415 댓글 목록보기 이벤트 처리  / 수정된 부분 : Seit. 418
	var vnoValue = '<c:out value="${video.vno}"/>';
	var replyUL = $(".chat");
	
		showList(1);
		
		function showList(page){
			
			console.log("show list : "+page);
			
			videoReplyService.getList({vno: vnoValue, page: page || 1}, function(replyCnt, list){
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
					str += "<li class='left clearfix' data-vrno='"+list[i].vrno+"'>";
					str += "<div><div class='header'><strong class='primary-font'>"+list[i].vreplyer+"</strong>";
					str += "<small class='pull-right text-muted'>"+videoReplyService.displayTime(list[i].replyDate)+"</small></div>";
					str += "<p>"+list[i].vreply+"</p></div></li>";
				}
				
				replyUL.html(str);
				showReplyPage(replyCnt);
			}); // end function
		}// ent show list
		
// Seit. 421~422 새로운 댓글 추가 이벤트 처리
		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='vreply']");
		var modalInputReplyer = modal.find("input[name='vreplyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
//		(S.727) 댓글 기능 스프링 시큐리티 추가
		var vreplyer = null;
		
		<sec:authorize access="isAuthenticated()">
		
		vreplyer = '<sec:authentication property="principal.username"/>';
		
		</sec:authorize>
		
		var csrfHeaderName ="${_csrf.headerName}";
		var csrfTokenValue ="${_csrf.token}";
		
		$("#addReplyBtn").on("click", function(e){
			
			modal.find("input").val("");
			modal.find("input[name='vreplyer']").val(vreplyer);
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
			
			var vreply = {
					vreply: modalInputReply.val(),
					vreplyer: modalInputReplyer.val(),
					vno: vnoValue
			};
			videoReplyService.add(vreply, function(result){
				
				alert(result);
				
				modal.find("input").val("");
				modal.modal("hide");
				
				showList(-1); // 우선적으로 전체 댓글의 숫자를 파악하게 하기 위한 초기화
//				showList(1);
			});
		});
// Seit. 425~426 댓글 이벤트 처리(하나의 댓글 내용보기)
		$(".chat").on("click", "li", function(e){
			
			var vrno = $(this).data("vrno"); // vrno = <li data-(변수이름)="abc"> .data("vrno":입력할 값)
			
			console.log("vrno : "+vrno);
			
			videoReplyService.get(vrno, function(reply){
				
				modalInputReply.val(reply.vreply);
				modalInputReplyer.val(reply.vreplyer);
				modalInputReplyDate.val(videoReplyService.displayTime(reply.replyDate))
				.attr("readonly","readonly");
				modal.data("vrno", reply.vrno);
				
				
				
				modal.find("button[id !='modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				$(".modal").modal("show");
			});
			/* console.log(vrno); */
		});
		
//		Seit.426 모달창에서 댓글 수정
		modalModBtn.on("click", function(e){
//			(S.733) 로그인 후, 본인만 댓글 삭제가 가능 하도록 설정.
			var originalReplyer = modalInputReplyer.val();						
						
			console.log("Modify REPLYER: "+vreplyer);
			console.log("Modify ORIGINAL REPLYER: "+originalReplyer); // 댓글 주인
			
			var vreply = {
					vrno: modal.data("vrno"),
					vreply: modalInputReply.val(),
					vreplyer: originalReplyer					
			};
			
			if(!vreplyer){
				alert("로그인후 수정이 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			if(vreplyer != originalReplyer){
				alert("본인이 작성한 댓글만 수정이 가능합니다.");
				modal.modal("hide");
				return;
			}			
//			var reply = {rno : modal.data("rno"), reply : modalInputReply.val()};
			
			videoReplyService.update(vreply, function(result){
				
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});			
		});
//		Seit.427 모달창에서 댓글 삭제
		modalRemoveBtn.on("click", function(e){
			
//		(S.730) 본인이 작성한 댓글만 삭제 할 수 있도록 설정			
			var vrno = modal.data("vrno");
			var originalReplyer = modalInputReplyer.val();
			
			console.log("VRNO: "+ vrno);
			console.log("REPLYER: "+vreplyer);
			console.log("ORIGINAL REPLYER: "+originalReplyer); // 댓글 주인
			
			if(!vreplyer){
				alert("로그인후 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			if(vreplyer != originalReplyer){
				alert("본인이 작성한 댓글만 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			videoReplyService.remove(vrno, function(result){
			
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
	
	
	var btnGood=$(".good");
	
	var vnoValue = '<c:out value="${video.vno}"/>';
	var goodValue = '<c:out value="${video.good}"/>';
	
	console.log("vno : " + vnoValue);
	
	console.log("good : " + goodValue);
	
	
	btnGood.on("click", function(e){
		
		/* e.preventDefault(); */
		
		console.log("vno : " + vnoValue);
		
		console.log("good : " + goodValue);
		
		var good={vno:vnoValue,good:(goodValue+1)};
		
		goodService.update(good,function(result){
			alert(result); 
			location.href="/video/list?pageNum=${cri.pageNum }&amount=${cri.amount }&type=${cri.type }&keyword=${cri.keyword }";
			
	}); 
	
	});
	
	var btnNoway=$(".noway");
	
	var vnoValue = '<c:out value="${video.vno}"/>';
	var nowayValue = '<c:out value="${video.noway}"/>';
		
	console.log("noway : " + nowayValue);
	
	
	btnNoway.on("click", function(e){
		
		/* e.preventDefault(); */
		
		console.log("vno : " + vnoValue);
		
		console.log("noway : " + nowayValue);
		
		var good={vno:vnoValue,noway:(nowayValue+1)};
		
		goodService.update1(good,function(result){
			alert(result); 
			location.href="/video/list?pageNum=${cri.pageNum }&amount=${cri.amount }&type=${cri.type }&keyword=${cri.keyword }";
			
	}); 
	
	});
	
	

}); // 즉시 실행 함수 끝
</script>


<%@include file="../includes/footer.jsp" %>        