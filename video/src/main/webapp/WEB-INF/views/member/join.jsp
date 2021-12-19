<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> --%>
<!DOCTYPE html>
<html lang="en">

<head>

<style>
th{
	background: skyblue;
	color: #fff;
}
.col-lg-12, 
.panel-heading,
.panel-body,
.row
{
	background: ivory;
}
/* body{
	background: tomato;
} */
#wrapper, .navbar-default,
#side-menu, #sidemenu{
	background: skyblue;
}
#sidemenu:hover{
	background: #fff;
	color: skyblue;
}
.navbar{
	background: tomato;	
}
a.navbar-brand, .navbar-default{
	color: #fff;
}
</style>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>회원가입 페이지</title>

    <!-- Bootstrap Core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    <!-- Custom button -->
    <link href="/resources/vendor/custom/button.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading" style="background:#6494C6; color:#eee">
                        <h3 class="panel-title" style="text-align:center; font-weight:bold;">회원가입</h3>
                    </div>
                    <div class="panel-body" >
                        <form role="form" method="post" action="/member/register">
                            <fieldset>
                                <div class="form-group">
                                	아이디
                                    <input class="form-control userID" placeholder="아이디" id="userID" 
                                    name="userid" type="text" autofocus>                                    
                                    <!-- <button class="idCheck" type="button" id="idCheck" value="N" >중복체크</button> -->                                                                        
                                </div>             
                                <div class="form-group">
                                	비밀번호
                                    <input class="form-control" placeholder="비밀번호" id="userpw" 
                                    name="userpw" type="password" value="">
                                </div>
                                <div class="form-group">
                                	이름
                                    <input class="form-control" placeholder="이름" id="userName" 
                                    name="userName" type="text" value="">
                                </div>                                
                                <div class="form-group">
                                	성별&nbsp;&nbsp;
                                    <input class="userGender" id="userMan" 
                                    name="userGender" type="radio" value="남">남&nbsp;
                                    <input class="userGender" id="userLady" 
                                    name="userGender" type="radio" value="여">여
                                </div>
                                <div class="form-group">
                                	생일
                                    <input class="form-control" placeholder="ex)20220101" id="userBirth" 
                                    name="userBirth" type="text" value="">
                                </div>
                                <div class="form-group">
                                	휴대전화
                                    <input class="form-control" placeholder="ex)01012345789" id="userTel" 
                                    name="userTel" type="text" value="">
                                </div>
                                <div class="form-group">
                                	이메일주소
                                    <input class="form-control" placeholder="ex)asdf@naver.com" id="userEmail" 
                                    name="userEmail" type="text" value="">
                                </div>
                                <div class="form-group">
                                	주소<input class="form-control" type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" style="background:#6494C6; color:#eee"><br>
                                    <!-- <input class="form-control" placeholder="username" id="username" 
                                    name="userName" type="text" value=""> -->
                                    <input class="form-control" type="text" id="sample4_postcode" placeholder="우편번호" name="postcode">									
									<input class="form-control" type="text" id="sample4_roadAddress" placeholder="도로명주소" name="roadAddr">
									<input class="form-control" type="text" id="sample4_jibunAddress" placeholder="지번주소" name="jibunAddr">
									<span id="guide" style="color:#999;display:none"></span>
									<input class="form-control" type="text" id="sample4_detailAddress" placeholder="상세주소" name="detailAddr">
									<input class="form-control" type="text" id="sample4_extraAddress" placeholder="참고항목">									
                                </div>                          
                                <!-- Change this to a button or input when using this as a form -->
                                <button type="submit" class="btn btn-primary" id="join" style="postion:ralative; width: 50%;" name="join">회원가입</button>
                                <a type="button" id="cancle" class="btn btn-danger pull-right" style="postion:ralative; width: 50%;">취소</a>
                            </fieldset>
                            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>    

    <!-- jQuery -->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="/resources/dist/js/sb-admin-2.js"></script>    
    
<!-- 우편번호 API -->
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
                /* if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                } */

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

<script>
/* 아이디 체크*/ 	
	
function fun_idCheck(){	
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrftokenValue = "${_csrf.token}";
	
	console.log("csrfHeaderName : "+csrfHeaderName);
	console.log("csrftokenValue : "+csrftokenValue);
	
	var userID = $("#userID").val();	
	console.log(userID);
	
		$.ajax({
			url:"/total/idCheck",
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrftokenValue);
			},
			type: "post",
			data: JSON.stringify({"userid": userID}),
			contentType: "application/json; charset=utf-8",			
			success: function(data){
				if(data==1){
					alert("중복된 아이디입니다.");
				}else if(data==0){
					$("#idCheck").attr("value","Y");
					alert("사용가능한 아이디 입니다.");
				}
			}
		});
	}
/* 아이디 테스트 */
$("#userID").on("propertychange change keyup paste input", function(){
	//console.log("keyup test");
	
	var userID = $("#userID").val()
	var data = {userid: userID}
	//console.log(userID);
	//console.log(data);
	
	
});
	
$(document).ready(function(){	
	
		
	$("#idCheck").on("click", function(){
		
		fun_idCheck();
	});
	
	$("#cancle").on("click", function(){
		location.href = "/member/login";
	})
	
	$("#join").on("click", function(){
		if($("#userID").val()==""){
			alert("아이디를 입력해주세요.");
			$("#userID").focus();
			return false;
		}
		if($("#userpw").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#userpw").focus();
			return false;
		}
		if($("#userName").val()==""){
			alert("이름을 입력해주세요.");
			$("#userName").focus();
			return false;
		}		
		
	})	
	
	
});		
	

</script>

</body>

</html>