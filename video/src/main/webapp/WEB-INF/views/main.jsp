<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  

<%@include file="includes/header.jsp" %>
  
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
	<div>
		<label>${category0.category }</label>
	</div>
	<section class="regular slider" >
	<img width="300" height="200" src=/resources/img/main1.jpg/>
	<c:forEach items="${rank0 }" var="rank">
			<div><iframe width="300" height="200"
				 src="${rank.url}"
				  title="YouTube video player"
				   allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
				   allowfullscreen></iframe>
				<a class="move" href="${rank.vno}"><c:out value="${rank.title }" /></a>
			</div>
	</c:forEach>
	</section>
	<div>
		<label>${category1.category }</label>
	</div>
	<section class="regular slider">
	<img width="300" height="200" src=/resources/img/main2.jpg>
	<c:forEach items="${rank1 }" var="rank">
			<div style="align:center;display: inline-block;"><iframe width="300" height="200"
				 src="${rank.url}"
				  title="YouTube video player"
				   allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
				   allowfullscreen></iframe>
				<a class="move" href="${rank.vno}"><c:out value="${rank.title }" /></a>
			</div>
	</c:forEach>
	</section>
	<div>
		<label>${category2.category }</label>
	</div>
	<section class="regular slider" >
	<img width="300" height="200" src=/resources/img/main3.jpg>
	<c:forEach items="${rank2 }" var="rank">
			<div style="align:center;display: inline-block;"><iframe width="300" height="200"
				 src="${rank.url}"
				  title="YouTube video player"
				   allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
				   allowfullscreen></iframe>
				<a class="move" href="${rank.vno}"><c:out value="${rank.title }" /></a>
			</div>
	</c:forEach>
	</section>
	
	<form id="actionForm" action="/video/get" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }" />
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }" />
		<input type="hidden" name="type" value="${pageMaker.cri.type }" />
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }" />
	</form>
	
  <script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
  <script src="/resources/slick/slick.js" type="text/javascript" charset="utf-8"></script>
  <!--           모달창 설정                            -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true"></button>
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
  
  
  <script>
  // 회원정보 수정 완료 모달창 관련
  $(document).ready(function(){
	var result = '<c:out value="${result}"/>';
	
	checkModal(result);
	
	history.replaceState({},null,null);
	
	function checkModal(result){
		if(result ==='' || history.state){
			return;
		}
		if(parseInt(result)>0){
			$(".modal-body").html("회원정보 수정이 완료 되었습니다.");			
		}
		$("#myModal").modal("show");
	}
  });
  
  </script>
  <script type="text/javascript">
    
  $(document).on('ready', function() {
      
      $(".regular").slick({
        dots: true,
        infinite: true,
        
        autoplaySpeed: 2000,
        slidesToShow: 4,
        slidesToScroll: 1
      });
 
      $(".move").on("click", function(e){
    	  
    	  	e.preventDefault();
    	  	
    	  	var actionForm = $("#actionForm");  
    	  	
    			actionForm.append("<input type='hidden' name='vno' value='"+
    								$(this).attr("href")+"'>");
    			actionForm.attr("action","/video/get");
    			actionForm.submit();
    		});
  		  
  
  });
  	
  
  

</script>


<%@include file="includes/footer.jsp" %> 
