console.log("Reply Module:");


var replyService = (function(){
   
    // 1. 댓글 등록 처리 
   function add(reply, callback, error){
        console.log("add reply:");
   	
   	    $.ajax({
   		    type : 'post',
   		    url : '/replies/new', 
   		    data : JSON.stringify(reply),
            contentType : "application/json; charset=utf-8",
            success : function(result, status, xhr){
                if(callback) {
                    callback(result);
                    alert("댓글이 등록되었습니다.");
                }
            },
            error : function(xhr, status, er) {
                if(error){
                    error(er);
                }
            }
   	    });
    }
    
    // 2. 댓글 목록 처리 (페이지 처리 전 )
    // function getList(param, callback, error){
    //     let bno = param.bno;
    //     let page = param.page || 1;

    //     $.getJSON("/replies/pages/" + bno + "/" + page + ".json",
    //             function(data){
    //                 if(callback){
    //                     callback(data);
    //                 }
    //             }).fail(function(xhr, status, err){
    //         if(error){
    //                 error();
    //          }
    //     });
    // }

      // 2. 댓글 목록 처리 (페이지 처리 후 )
      function getList(param, callback, error) {

        var bno = param.bno;
        var page = param.page || 1; 

        $.getJSON("/replies/pages/" + bno + "/" + page + ".json", 
            function(data) {
                if(callback){
                    callback(data.replyCnt, data.list);
                }
            }).fail(function(xhr, status, err) {
        if(error){
                error();
            }      
        });
    }

    // 3. 댓글 삭제 처리
    function remove(rno, userid, callback, error) {
    	
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,
			data : JSON.stringify({rno: rno, userid: userid}),
			contentType : "application/json; charset=utf-8",
			success : function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
					alert("댓글이 삭제되었습니다.");
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}

    // 4. 댓글 수정 처리 
    function update(reply, callback, error) {
        $.ajax({
            type : 'put',
            url : '/replies/' + reply.rno,
            data : JSON.stringify(reply),
            contentType : "application/json; charset=utf-8",
            success: function(result, status, xhr) {
                if (callback) {
                    callback(result);
                    alert("댓글이 수정되었습니다.");
                }
            }, 
            error : function(xhr, status, er) {
                if (error) {
                    error(er);
                }
            }
        });
    }

    // 5. 댓글 조회 처리 
    function get(rno, callback, error) {
        $.get("/replies/" + rno + ".json", function(result){

            if(callback) {
                callback(result);
            }
        }).fail(function(xhr, status, err) {
            if(error) {
                error();
            }
        });
    }

    // 6. 댓글 작성 시간 처리 
    function displayTime(timeValue){
        var today = new Date();

        var gap = today.getTime() - timeValue;

        var dateObj = new Date(timeValue);
        var str = "";

        if (gap < 1000 * 60 * 60 * 24) {
            var hh = dateObj.getHours();
            var mi = dateObj.getMinutes();
            var ss = dateObj.getSeconds();

            return [(hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss].join('');
        } else {
            var yy = dateObj.getFullYear();
            var mm = dateObj.getMonth() + 1; 
            var dd = dateObj.getDate();

            return[ yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '': '0') + dd].join('');
        }
    };

   return {
        add:add,
        getList:getList,
        remove:remove,
        update:update,
        get:get,
        displayTime:displayTime
    };
})();