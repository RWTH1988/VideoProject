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
    	<h1 class="page-header">회원 정보 수정</h1>
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
	    	<div class="panel-heading" style="background:#6494C6; ">
            <span style="color:#eee;"><b>[${member.userid }]님 정보</b></span>
            </div>
            <!-- /.panel-heading -->
           	<div class="panel-body">
           		<form role="form" action="/admin/modify" method="post">
<!-- pageNum, amount 값 hidden으로 추가  -->
           			<input type="hidden" name="pageNum" value="${cri.pageNum }" />
           			<input type="hidden" name="amount" value="${cri.amount }" />
           			<input type="hidden" name="type" value="${cri.type }" />
					<input type="hidden" name="keyword" value="${cri.keyword }" />
<!-- (S.719) Post처리부분 CSRF로 보안처리 -->
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
					
           			<div class="form-group">
           			<label>아이디</label>
           			<input class="form-control" name="userid" value="${member.userid}" readonly="readonly"/>           				
           		</div>
           		<div class="form-group">
           			<label>비밀번호</label>
           			<input class="form-control" name="userpw" type="password"  />
           		</div>
           		<div class="form-group">
           			<label>이름</label>
           			<input class="form-control" name="username" value="${member.userName}" readonly="readonly" />
           		</div>
           		<div class="form-group">
           			<label>생일</label>
           			<input class="form-control" name="userBirth" value="${member.userBirth}" type="text"/>           				
           		</div>
           		<div class="form-group">
           			<label>휴대전화</label>
           			<input class="form-control" name="userTel" value="${member.userTel}" type="text"/>           				
           		</div>
           		<div class="form-group">
           			<label>Email</label>
           			<input class="form-control" name="userEmail" value="${member.userEmail}" type="text" />           				
           		</div>
           		<div class="form-group">
           			<label>주소</label>
           			<input class="form-control" type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" style="background:#6494C6; color:#eee"><br>           				
           			<input class="form-control" type="text" id="sample4_postcode" name="postcode" value="${member.postcode }" >						
					<input class="form-control" type="text" id="sample4_roadAddress" name="roadAddr" value="${member.roadAddr }" >
					<input class="form-control" type="text" id="sample4_jibunAddress" name="jibunAddr" value="${member.jibunAddr }" >
					<input class="form-control" type="text" id="sample4_detailAddress" name="detailAddr" value="${member.detailAddr }" >
					<input class="form-control" type="text" id="sample4_extraAddress" >
					<span class="form-control" id="guide" style="color:#999;display:none"></span>
					<!-- <input class="form-control" type="text" id="sample4_detailAddress" name="detailAddr" placeholder="상세주소" readonly="readonly"> -->
				</div>
				<hr>           			
				<!-- (S.717)로그인한 경우에만 수정 버튼 보이게 하기 -->
				<sec:authentication property="principal" var="pinfo"/>
				<sec:authorize access="hasRole('ROLE_ADMIN')">			
				<%-- <input type="text" value="${pinfo.username}">
				<input type="text" value="${member.userid}"> --%>
           		<button data-oper="modify" class="btn btn-warning">수정</button>          		       				
           		<button data-oper="remove" class="btn btn-danger">삭제</button>
           		<button data-oper="list" class="btn btn-success">목록</button>
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />           		
       			</sec:authorize>
           		</form>
           	</div>
			<!-- end panel-body -->
		</div>
        <!-- end panel -->
	</div>               
</div>
<!-- /.row -->

<script>
//	(s.725) 시큐리티 설정
	var csrfHeaderName ="${_csrf.headerName}";
	var csrfTokenValue ="${_csrf.token}";		
</script>
<script>
// 회원탈퇴
$(document).ready(function(){
	
	var formObj = $("form");
	
	$('button').on('click', function(e){
		
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation==='remove'){
			formObj.attr("action", "/admin/remove");			
		}else if(operation === 'list'){
			formObj.attr("action","/admin/list").attr("method","get");
			//formObj.empty();			
/* 페이지 넘버와 게시물 개수는 복사(clone)한 뒤 나머지 모든 불필요한 파라메터 값을 삭제(empty) 후,
복사해둔 정보만 /admin/list 뒤에 합쳐서(append) 전송(submit) */
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			var typeTag = $("input[name='type']").clone();
			
			formObj.empty();
			formObj.append(pageNumTag).append(amountTag).append(keywordTag).append(typeTag);

		}
		formObj.submit();
	});
});

</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>


<%@include file="../includes/footer.jsp" %>