<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
    
<%@include file="../includes/header.jsp" %>
<div class="row">
	<div class="col-lg-12">
	<h1 class="page-header">회원 리스트</h1>
	<%-- <input value="${member.userid }">
	<input value='<sec:authentication property="principal.username" />' /> --%>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
          
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading" style="background:#6494C6; color:#fff;"><b>
			회원 리스트	
			</b>	
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
			<table class="table table-striped table-bordered table-hover">
				<thead>
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>생년월일</th>
					<th>Email</th>
					<th>가입일</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${list }" var="member">
					<tr>									
						<td>
						<sec:authorize access="hasRole('ROLE_ADMIN')">
						<a class="move" href="${member.userid}"><c:out value="${member.userid}" /></a>
						</sec:authorize>
						</td>						
						<td>${member.userName}</td>		
						<td>${member.userBirth }</td>
						<td>${member.userEmail }</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${member.regDate}"/></td>						
					</tr>
				</c:forEach>
				</tbody>                                                                
			</table>
	<!-- 검색 처리 -->
			<div class="row">
				<div class="col-lg-12">
				
				<form action="/admin/list" id="searchForm" method="get">
					<select name="type">
						<option value=""
						<c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>전체</option>
						<option value="I"
						<c:out value="${pageMaker.cri.type eq 'I'?'selected':'' }"/>>아이디</option>
						<option value="N"
						<c:out value="${pageMaker.cri.type eq 'N'?'selected':'' }"/>>이름</option>
						<option value="B"
						<c:out value="${pageMaker.cri.type eq 'B'?'selected':'' }"/>>생일</option>												
					</select>
					<input type="text" name="keyword" value="${pageMaker.cri.keyword }"/>					
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }" />
					<input type="hidden" name="amount" value="${pageMaker.cri.amount }"/>
					<button class="btn btn-info">검색</button>
				</form>
	<!-- 페이지 처리 -->
				<form id="actionForm" action="/admin/list" method="get">
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
					
<!--           모달창 설정                            -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel"></h4>
						</div>
						<div class="modal-body">회원 정보가 수정되었습니다.</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
							<!-- <button type="button" class="btn btn-primary">Save changes</button> -->
						</div>						
					</div>
					<!-- /modal-content -->
				</div>
				<!-- /modal-dialog -->                            
			</div>
			<!-- /modal -->
			</div>                        
			<!-- end panel-body -->
		</div>
		<!-- end panel -->
	</div>                
</div>
<!-- /.row -->
            
<!-- Modal창을 보여주기 위한 일회성 데이터  -->
<script type="text/javascript">
$(document).ready(function(){
	var result = '<c:out value="${result}"/>';
	
	checkModal(result);
	
	history.replaceState({},null,null);
	
	function checkModal(result){
		if(result ==='' || history.state){
			return;
		}
		if(parseInt(result)>0){
			$(".modal-body").html("게시글"+parseInt(result)+"번이 등록 되었습니다.");			
		}
		$("#myModal").modal("show");
	}	
	
	var actionForm = $("#actionForm");
	
	$(".paginate_button a").on("click", function(e){
		e.preventDefault();
		console.log("click");
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	$(".move").on("click", function(e){
		e.preventDefault();
		actionForm.append("<input type='hidden' name='userid' value='"+
							$(this).attr("href")+"'>");
		actionForm.attr("action","/admin/modify");
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
</script>
<%@include file="../includes/footer.jsp" %>
        