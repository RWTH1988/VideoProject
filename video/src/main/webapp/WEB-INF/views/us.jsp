<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
   <meta charset="utf-8">
   <title>Home</title>
</head>

<%@include file="includes/header.jsp" %>
<div class="row">
   <div class="col-lg-12">
       <div class="panel panel-default">
         <div class="panel-body">
            <div class="form-group" style="text-align:center;">
               <div style="float:left;width:50%;">
               <h1><a href="https://github.com/kingpark1"><img src="/resources/img/usIcon.png" width=100px height=100px  ></a>박재경</h1>
               	로그인, 회원가입 페이지, 시큐리티 활용
               </div>
               <div style="width:50%;float:right;">
               <h1><a href="https://github.com/RWTH1988"><img src="/resources/img/usIcon.png" width=100px height=100px  ></a>장연우</h1>
              	문의게시판, 댓글, 시큐리티 활용 , 관리자 페이지, CSS
               </div>
               <div style="float:left;width:50%;">
               <h1><a href="https://github.com/moosky1011"><img src="/resources/img/usIcon.png" width=100px height=100px  ></a>편무선</h1>
               	게시글 자세히보기, 조회수, 좋아요 싫어요 버튼, 관리자페이지
               </div>
               <div style="width:50%; float:right;">
               <h1><a href="https://github.com/Geum2020"><img src="/resources/img/usIcon.png" width=100px height=100px  ></a>한금주</h1>
               	메인, 영상게시판 (JSON방식 수정,삭제) 
               </div>
            </div>      
         </div>         
      </div>
   </div>
</div>
<%@include file="includes/footer.jsp" %>