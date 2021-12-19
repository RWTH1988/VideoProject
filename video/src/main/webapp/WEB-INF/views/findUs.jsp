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
			<div class="form-group" style="vertical-align:middle;text-align:center;display:inline-block; float:left;height:50%; width: 50%;">
    			<div style="vertical-align:middle;padding-top:15%;">
    				<h1 class="fa-2x" >찾아오시는 길</h1><br/>
    				<h3 class="fa-lg">부산광역시 동래구 충렬대로 84 /</h3>
    				<h3 class="fa-lg">한국기술교육직업전문학교</h3>
    			</div>
    		</div>
			<div id="map" class="form-group" style="width:50%;height:50%; float:left;"></div>
		</div>
	</div>
</div>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5b8358512d80af71f23eefb12275b549"></script>	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5b8358512d80af71f23eefb12275b549&libraries=services,clusterer,drawing"></script>
	<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(35.2075107071415, 129.07024081153634), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(35.2075107071415, 129.07024081153634); 

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});

	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);

		
		
	</script>

<%@include file="includes/footer.jsp" %>