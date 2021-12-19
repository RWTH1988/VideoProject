console.log("Video Reply Module........");
// (S.398) JavaScript 모듈화
var videoReplyService = (function(){
	
//	return {name:"AAAA"};

	//	댓글 추가
	function add(vreply, callback, error){
		console.log("vreply........");
		
		$.ajax({
			type : 'post',
			url : '/videoReplies/new',
			data : JSON.stringify(vreply),
			contentType : 'application/json; charset=utf-8',
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error: function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
	}
//	Seit. 406 전체 댓글 목록보기 = JQuery의 getJSON()메서드 사용.
	function getList(param, callback, error){
		
		var vno = param.vno;
		var page = param.page || 1;
		
		$.getJSON("/videoReplies/pages/"+vno+"/"+page+".json",
				function(data){
					if(callback){
//						callback(data); // 댓글 목록만 가져오는 경우
						callback(data.replyCnt, data.list); // 총 댓글 숫자 + 댓글 목록
					}
				}).fail(function(xhr, status, err){
					if(error){
						error();
					}
				});
	}
//	Seit.408 댓글 삭제 // (S.731) data, contentType 추가
	function remove(vrno, callback, error){
		$.ajax({
			type: 'delete',
			url : '/videoReplies/'+vrno,
			data: JSON.stringify({vrno: vrno, replyer: vreplyer}),
			contentType: "application/json; charset=utf-8",
			success : function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}				
		});
	}
//	Seit.410 댓글 수정
	function update(vreply, callback, error){
		
		console.log("VRNO: "+ vreply.vrno);
		
		$.ajax({
			type : 'put',
			url : '/videoReplies/' + vreply.vrno,
			data : JSON.stringify(vreply),
			contentType : 'application/json; charset=utf-8',
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				error(er);
			}
		});
	}	
//	Seit.412 <댓글 조회 처리>	
	function get(vrno, callback, error){
		
		$.get("/videoReplies/"+vrno+".json", function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	
/* 	Seit.417 <시간 처리>
 	XML이나 JSON형태의 데이터는 순수하게 수수자로 표현되는 시간 값이 출력 된다. 즉, '하루 = 86400000' 로 표시.
 	날짜 포맷을 원하는 형태로 직접 설정해줘야 한다.
 	여기서는 아래와 같은 형태로 설정 해줌.
 	당일 작성한 글 = 시간으로 표시 / 하루 이상 지난 글 = 날짜로 표시
 	시간 = 09:10:43
 	날짜 = 2021/11/06
*/
	function displayTime(timeValue){
		
		var today = new Date();
		
		var gap = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue);
		var str="";
		
		if(gap < (1000*60*60*24)){
			
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [(hh>9 ? '':'0')+hh, ':', (mi>9 ? '':'0')+mi,':',(ss>9 ? '':'0')+ss].join('');
		}else{
			
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth()+1;  // 달은 0부터 시작
			var dd = dateObj.getDate();
			
			return [yy, '/', (mm > 9 ? '':'0')+mm, '/', (dd > 9 ? '':'0')+dd].join('');
		}
	};
	
	return{
		add:add,
		getList : getList,
		remove : remove,
		update : update,
		get : get,
		displayTime : displayTime
		};	
	
})();