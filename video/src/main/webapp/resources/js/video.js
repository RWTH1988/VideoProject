 

/* JS 모듈 */

console.log("Video Module.............")

var videoService = (function(){
	
	//동영상 게시판 글 추가
	function add(videoadd, callback, error){
		
		console.log("add video write...........");
		
		console.log("videoadd category: "+ videoadd.category);
		console.log("videoadd title: "+ videoadd.title);
		console.log("videoadd url: "+ videoadd.url);
		console.log("videoadd content: "+ videoadd.content);
		
		$.ajax({
			type : 'post',
			url : ' /total/video/new ',
			data : JSON.stringify(videoadd),
			contentType : 'application/json; charset=utf-8',
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error: function(xhr, status, error){
				if(error){
					error(er);
				}
			}
		})
	}
	
//	동영상 게시판 수정Modal 조회	
	function get(vno, callback, error){
		
		console.log("JS Ctrl : "+ vno)
		
		$.get("/total/video/"+vno+".json", function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	
	
//	동영상 게시판 수정
	function update(mModifyU, callback, error){
		
		console.log("VNO: "+ mModifyU.vno);
		
		$.ajax({
			type : 'put',
			url : '/total/video/' + mModifyU.vno,
			data : JSON.stringify(mModifyU),
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

	//동영상 게시판 삭제
	function remove(vno, callback, error){
		$.ajax({
			type: 'delete',
			url : '/total/video/'+vno,
			data: JSON.stringify({vno: vno}),
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
	return {
		
		add: add,
		get: get,
		update: update,
		remove: remove,
		displayTime : displayTime
	};
})();
	