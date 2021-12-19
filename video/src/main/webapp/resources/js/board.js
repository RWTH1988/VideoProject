 

/* JS 모듈 */

console.log("Board Module.............")

var boardService = (function(){
	
	
	//게시판 글 추가
	function add(write, callback, eroor){
		
		console.log("add write...........");
		
		$.ajax({
			type : 'post',
			url : '/total/new',
			data : JSON.stringify(write),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
			
		})
	}
	
	//	게시판 수정Modal 조회	
	function get(bno, callback, error){
		
		console.log("JS Ctrl getB : "+ bno)
		
		$.get("/total/"+bno+".json", function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	
	//	 게시판 수정
	function update(mModifyBU, callback, error){
		
		console.log("BNO: "+ mModifyBU.bno);
		
		$.ajax({
			type : 'put',
			url : '/total/' + mModifyBU.bno,
			data : JSON.stringify(mModifyBU),
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

	// 게시판 삭제
	function remove(bno, callback, error){
		$.ajax({
			type: 'delete',
			url : '/total/'+bno,
			data: JSON.stringify({bno: bno}),
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
	