/* JS 모듈 */

console.log("Good Module.............")

var goodService = (function(){
		
	
	// 동영상 좋아요 
	function update(good, callback, error){
		
		console.log("VNO: "+ good.vno);
		
		$.ajax({
			type : 'put',
			url : '/total/good/' + good.vno,
			data : JSON.stringify(good),
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
	
	
	// 동영상 싫어요
	function update1(noway, callback, error){
		
		console.log("VNO: "+ noway.vno);
		
		$.ajax({
			type : 'put',
			url : '/total/noway/' + noway.vno,
			data : JSON.stringify(noway),
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
	
	return {
			
		update: update,
		update1:update1
	};
})();
	