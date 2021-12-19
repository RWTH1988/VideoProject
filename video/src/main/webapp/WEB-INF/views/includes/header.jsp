<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Back To School</title>

    <!-- Bootstrap Core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
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
	background: orange;
	color: #fff;
}
.navbar{
	background: tomato;	
}
a.navbar-brand, .navbar-default{
	color: #fff;
}
</style>
</head>

<body>
    <div id="wrapper">
        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/" style="color:#fff;">Back To School</a>
            </div>
            <!-- /.navbar-header -->            
            <ul class="nav navbar-top-links navbar-right">            
            <c:if test="<sec:authentication property='principal.username' />">
            <span>[<sec:authentication property="principal.username" />]님 환영합니다.</span>
            </c:if>            
				<li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" style="color:#fff;">
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                    	<sec:authorize access="isAuthenticated()">                    
                        <li><a href="/member/get?userid=<sec:authentication property="principal.username" />"><i class="fa fa-user fa-fw"></i>내 정보</a>
                        </li>                        
                    	</sec:authorize>
                    	<sec:authorize access="hasRole('ROLE_ADMIN')">                    
                        <li><a href="/admin/list"><i class="fa fa-user fa-fw"></i>회원 정보 관리</a>
                        </li>                        
                    	</sec:authorize>
                        <li class="divider"></li>
<!-- (S.735)스프링 시큐리티 관련 수정과 로그아웃 링크 설정 -->
                    	<sec:authorize access="isAuthenticated()">
                        <li><a href="/member/logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    	</sec:authorize>                        
                    	<sec:authorize access="isAnonymous()">
                        <li><a href="/member/login"><i class="fa fa-sign-out fa-fw"></i> Login</a>
                        </li>
                    	</sec:authorize>                        
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        
                        <li id="sidemenu" >
                            <a href="/" style="color:#fff"><i class="fa fa-dashboard fa-fw"></i>MAIN</a>
                        </li>
                        <li id="sidemenu">
                            <a href="#" style="color:#fff"><i class="fa fa-table fa-fw"></i>BOARD<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li id="sidemenu">
                                    <a href="/board/list" style="color:#fff">Q & A</a>
                                </li>
                                <li id="sidemenu">
                                    <a href="/video/list" style="color:#fff">강의</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>                        
                        <li>
                            <a href="#" style="color:#fff"><i class="fa fa-files-o fa-fw"></i>About Us<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">                                
                                <li id="sidemenu">
                                    <a href="/us" style="color:#fff">팀 소개</a>
                                </li>
                                <li id="sidemenu">
                                    <a href="/findUs" style="color:#fff">찾아 오시는 길</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
					</ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>

        <div id="page-wrapper">
        
	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- <script src="/resources/vendor/jquery/jquery.min.js"></script> -->    
    