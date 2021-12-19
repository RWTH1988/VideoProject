<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp" %>
<div class="row">
	<div class="col-lg-12">
    	<h1 class="page-header">내 정보</h1>
   	</div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
   
<div class="row">
	<div class="col-lg-12">
    	<div class="panel panel-default">
	    	<div class="panel-heading" style="background:#6494C6; color:#eee">
                      [${member.userName }]님 정보
            </div>
            <!-- /.panel-heading -->
           	<div class="panel-body">
           	<form action="/member/modify" method="post" >	
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
				<sec:authorize access="isAuthenticated()">
				<c:if test="${pinfo.username eq member.userid }">
				<%-- <input type="text" value="${pinfo.username}">
				<input type="text" value="${member.userid}"> --%>
           		<button data-oper="modify" class="btn btn-warning">수정</button>          		       				
           		<button data-oper="remove" class="btn btn-danger">삭제</button>
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
           		</c:if>
       			</sec:authorize>
          	</form>		           			
           	</div>
			<!-- end panel-body -->			
		</div>
        <!-- end panel -->
	</div>               
</div>
<!-- /.row -->

<script src="/resources/js/reply.js"></script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
// 회원탈퇴
$(document).ready(function(){
	
	var formObj = $("form");
	
	$('button').on('click', function(e){
		
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation==='remove'){
			formObj.attr("action", "/member/remove");			
		}
		formObj.submit();
	});
});

</script>
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