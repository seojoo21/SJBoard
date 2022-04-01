<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp" %>


<!-- 첨부파일 관련 CSS 스타일  -->
<link href="/resources/dist/css/file-attachment.css" rel="stylesheet" type="text/css">

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">게시판</h3>
                    <h4 class="page-header">게시물 조회</h4>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <!-- 게시판 레이아웃 시작 -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                       		     
                       		     		<ul style="list-style: none; margin: 0px; padding: 0px;">
	                       		     		<li style="display: inline-block; ">
	                       		     		<div class="form-group">
	                                            <label>#</label>
	                                            <input class="form-control" name='bno' value='<c:out value="${board.bno}"/>' readonly="readonly">
	                                        </div>
	                                        </li>
	                                        
	                                        <li style="display: inline-block;" >
	                                        <div class="form-group">
	                                            <label>작성일</label>
	                                            <input class="form-control" name='regdate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate }"/>' readonly="readonly">
	                                        </div>
	                                        </li>
	                                        
	                                        <li style="display: inline-block;">
	                                        <div class="form-group">
	                                            <label>수정일</label>
	                                            <input class="form-control" name='updateDate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate }"/>' readonly="readonly">
	                                        </div>
	                                        
	                                        <li style="display: inline-block;">
	                                        <div class="form-group">
	                                            <label>조회수</label>
	                                            <input class="form-control" name='viewHit' value='<c:out value="${board.viewHit }"/>' readonly="readonly">
	                                        </div>
	                                        
	                                        <li style="display: inline-block;">
	                                        <div class="form-group">
	                                            <label>추천수</label>
	                                            <input class="form-control" name='recHit' value='<c:out value="${board.likeHit }"/>' readonly="readonly">
	                                        </div>
	                                        
	                                        </li>
                                        </ul>
                                        
                                        <div class="form-group">
                                            <label>제목</label>
                                            <input class="form-control" name='title' value='<c:out value="${board.title }"/>' readonly="readonly">
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>작성자</label>
                                            <input class="form-control" name='writer' value='<c:out value="${board.writer }"/>' readonly="readonly">
                                        </div>
                                        
                                       	<!-- 작성자ID -->
                                        <input class="form-control" type="hidden" name="userid" value='<c:out value="${board.userid }"/>' readonly="readonly">
                                        
                                       <div class="form-group">
                                            <label>내용</label>
                                            <div class="form-control" style="background-color: white; border: 1px solid #ccc; border-radius: 4px;">${board.content}</div>
                                        </div>
                                        
                                        <div class='bigPictureWrapper'>
                                        	<div class='bigPicture'>
                                        	</div>
                                        </div>
                                        
                                        <div class="uploadResult" style="margin-top: 10px;">
                                            <label>첨부파일</label>
                                            <ul>
                                            </ul>
                                        </div>
                                        
                                        <sec:authorize access="isAuthenticated()">
	                                    	<form id='likeForm' action="/updateLike" method="post" style="display: inline-block;">
	                                        	<input class="form-control" id='userid' name='userid' type='hidden' value='<sec:authentication property="principal.username"/>' readonly="readonly">
	                                    		<input class="form-control" id= 'bno' name='bno' type='hidden' value='<c:out value="${board.bno}"/>' readonly="readonly">
                                        	</form>
	                                    </sec:authorize>
                                    
                                        <sec:authorize access="isAuthenticated()">
	                                        <input type="button" class="btn btn-success" id="like" value="추천">
	                                    </sec:authorize>
                                        
                                        <sec:authentication property="principal" var="pinfo"/>
                                        <sec:authorize access="isAuthenticated()">
                                        	<c:if test="${pinfo.username eq board.userid}">
                                        		<button data-oper='modify' class="btn btn-primary">수정</button>
                                        	</c:if>
                                        </sec:authorize>
		                          		
		                          		<button data-oper='list' class="btn btn-info">목록으로</button>
		                          		
                          				<form id='operForm' action="/sjboard/modify" method="get">
		                          		  <input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
		                          		  <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
		                          		  <input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
		                          		  <input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
		                          		  <input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
		                          		</form>
		                          		
		                          		<!-- 댓글 목록 처리 -->
										<div class='row' style="margin-top: 20px;">
										  <div class="col-lg-12">
										    
										    <!-- /.panel -->
										    <div class="panel panel-default">
												<div class="panel-heading">
										        	<i class="fa fa-comments fa-fw"></i> 댓글
										      	</div> 
										      	
										      <!-- /.panel-heading -->
										      <div class="panel-body">
										        <ul class="chat">
										        
										        </ul>
										        <!-- ./ end ul -->
										      </div>
										      <!-- /.panel .chat-panel -->
										      
										<!-- 댓글 페이지 목록 처리 -->
                        				<div class="panel-body" id="replyPageFooter">
                        				
										</div>     
										
										<!-- 댓글 등록 처리  -->
										<sec:authorize access="isAuthenticated()">
										<div class="panel-footer">
											<div class="input-group">	
										    	<label>작성자</label>
						                        <input class="form-control input-sm" id="btn-input" name='replyer' value='<sec:authentication property="principal.member.userName"/>' readonly="readonly">
						                    	
						                    	<!-- 작성자ID -->
                                       			<input class="form-control" type="hidden" name="userid" value='<sec:authentication property="principal.username"/>' readonly="readonly">
						                    
						                    </div> 
							                <div class="input-group" style="margin-top: 10px;">
							                	<label>내용</label>
							                    <textarea id="btn-input" name="reply" class="form-control input-sm" rows='3' placeholder="댓글을 입력하세요."></textarea>
							                    <span class="input-group-btn">
								                    <button class="btn btn-warning btn-sm" id="btn-chat" style="width:50px; height:65px; margin-top:25px">
								                    등록</button>
							                    </span>
							               	</div>
                        				</div>
                        				</sec:authorize>
                        		
                        				<!-- 댓글 수정/삭제 처리용 모달 -->
			                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			                                <div class="modal-dialog">
			                                    <div class="modal-content">
			                                        <div class="modal-header">
			                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                                            <h4 class="modal-title" id="myModalLabel">댓글 수정/삭제</h4>
			                                        </div>
			                                        <div class="modal-body">
			                                        	<div class="panel-footer">
																 <div class="input-group">	
															    	<label>작성자</label>
											                        <input id="btn-input" name="replyer" type="text" class="form-control input-sm" readonly="readonly">
											                    </div> 
											                    
											                    <!-- 현재 로그인한 사용자 ID -->
                                       							<input class="form-control" type="hidden" name="loginUserId" value="" readonly="readonly">
                                       							
                                       							<!-- 원래 댓글을 작성했던 사람의 사용자 ID-->
                                       							<input class="form-control" type="hidden" name="userid" value="" readonly="readonly">
											                	
											                	<div class="input-group" style="margin-top: 10px;">
												                	<label>내용</label>
												                    <textarea id="btn-input" name="reply" class="form-control input-sm" rows='3' placeholder="댓글을 입력하세요."></textarea>
												                    <span class="input-group-btn">
													                    <button class="btn btn-primary btn-sm" id="modalModBtn" style="width:50px; height:65px; margin-top:25px">
													                    수정</button>
													                    <button class="btn btn-danger btn-sm" id="modalRemoveBtn" style="width:50px; height:65px; margin-top:25px">
													                    삭제</button>
													                    <button class="btn btn-default btn-sm" id="modalCloseBtn" style="width:50px; height:65px; margin-top:25px" data-dismiss="modal">
													                    닫기</button>
											                    	</span>
											               		</div>
					                        			</div>
			                                        </div>
			                                        <div class="modal-footer">
			                                        </div>
			                                    </div>
			                                    <!-- /.modal-content -->
			                                </div>
			                                <!-- /.modal-dialog -->
			                            </div>
			                            <!-- /.modal -->
                            
							                </div>
							            </div> 
							            
									</div>
								</div>
							<!-- ./ end row -->
							</div>
                            <!-- /.table-responsive -->
                         </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
    
<script type="text/javascript" src="/resources/js/reply.js"></script>  

<script type="text/javascript">

$(document).ready(function(){
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";	
	
	//Ajax Spring Security Header
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	// 추천 버튼 클릭시 실행되는 작업
	var likeForm = $("#likeForm");
	var likeBtn = $("#like");
	
	// 추천 이력이 있는지 확인한 값을 likeVal 에 저장
	var likeVal = ${like.likeNo}
	console.log(typeof likeVal);
	
	// likeVal이 1이면 이미 추천을 한 것이므로 추천 버튼 변경 
	if(likeVal === 1 ) {
		
		console.log("likeVal : " + likeVal);
		likeBtn.attr("value", "추천 1");
		
		// 추천 버튼 다시 클릭시 동작 
		likeBtn.on("click", function(e){
			
			var userId = $("#userid").val();
			var bno = $("#bno").val();
			var data = {bno: bno, userid: userId}
			
			$.ajax({
				type: "post",
				url: "/deleteLike",
				data: data,
				success: function(result){
					if (result == "success") {
						alert("게시물 추천이 취소되었습니다.");
						likeBtn.attr("class", "btn btn-success disabled");
						likeBtn.attr("value", "추천 0");
						likeBtn.attr("disabled", true); 
					} else {
						return;
					}
				}
			}); // end ajax
		}); // end function 
		
		
	} else if (likeVal === undefined){
		console.log("likeVal : " + likeVal);
		likeBtn.attr("value", "추천");
		
		// 추천 버튼 클릭시 동작 
		likeBtn.on("click", function(e){
			
			var userId = $("#userid").val();
			var bno = $("#bno").val();
			var data = {bno: bno, userid: userId}
			
			$.ajax({
				type: "post",
				url: "/updateLike",
				data: data,
				success: function(result){
					if (result == "success") {
						alert("게시물 추천이 완료되었습니다.");
						likeBtn.attr("class", "btn btn-success disabled");
						likeBtn.attr("value", "추천 1");
						likeBtn.attr("disabled", true); 
					} else {
						return;
					}
				}
			}); // end ajax
		}); // end function 
	}
	
	// 수정 및 목록으로 버튼 클릭시 실행되는 작업 
	var operForm = $("#operForm");
	
	// 수정 버튼 클릭시 수정 페이지로  
	$("button[data-oper='modify']").on("click", function(e){
		operForm.attr("action", "/sjboard/modify").submit();		
	});
	
	// 목록으로 버튼 클릭 시 목록으로 
	$("button[data-oper='list']").on("click", function(e){
		operForm.find("#bno").remove();
		operForm.attr("action", "/sjboard/list")
		operForm.submit();
	});
	
	// 댓글 목록을 가져오는 작업 
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
	
	showList(1);

	function showList(page){
		
		// console.log("show list" + page);
		
		replyService.getList({bno:bnoValue, page:page || 1}, function(replyCnt, list){
			
			/* console.log("replyCnt" + replyCnt);
			console.log("list" + list);
			console.log(list); */
			
			if(page == -1) {
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return;
			}
			
			var str = ""; 
			
			if(list==null || list.length ==0){
				replyUL.html("")
				return;
			}
			for(var i=0, len = list.length||0; i<len; i++) {
				str += "<li class='left clearfix' data-rno='" + list[i].rno+"'>";
				str += "<div><div class='header'><strong class='primary-font'>" + list[i].replyer + "</strong>";
				str += "<small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small></div>";
				str += "<p>" + list[i].reply + "</p></div></li>";
			}
		
		replyUL.html(str);
		
		showReplyPage(replyCnt);
		
		});
	}
	
	// 댓글 작성 관련 객체
	var replyObj = $(".panel-footer");
	var inputReplyer = replyObj.find("input[name='replyer']");
	var inputReply = replyObj.find("textarea[name='reply']");
	var replyRegisterBtn = $("#btn-chat");
	var inputLoginUserId = replyObj.find("input[name='userid']"); // 현재 로그인해서 댓글 작성할 수 있는 사용자 ID
	
	// 댓글 등록 처리 
	$("#btn-chat").on("click", function(e){
		
		var reply = {
				replyer : inputReplyer.val(),
				reply : inputReply.val(),
				bno : bnoValue,
				userid : inputLoginUserId.val()
				
		}
		
		replyService.add(reply, function(result){
			
			replyObj.find("input").val();
			replyObj.find("textarea").val("");
			
			// showList(1); 페이징 처리 전 댓글 최신 목록 
			showList(-1); // 페이징 처리 후 댓글 최신 목록 
		});
	});
	
	// 댓글 수정, 삭제 모달창 관련 객체
	var modal = $(".modal");
	var modalInputReplyer= modal.find("input[name='replyer']");
	var modalInputReply = modal.find("textarea[name='reply']");
	var modalInputLoginUserId = modal.find("input[name='loginUserId']"); // 현재 로그인해서 댓글 작성할 수 있는 사용자 ID
	var modalInputReplyerUserId = modal.find("input[name='userid']"); // 원래 댓글을 작성했던 사람의 사용자 ID
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	
	var loginReplyer = inputLoginUserId.val(); // 현재 로그인해서 댓글 작성할 수 있는 사용자 ID
	
	// 특정 댓글 클릭 이벤트 처리 (모달창)
	$(".chat").on("click", "li", function(e){
		
		var rno = $(this).data("rno");
		
		replyService.get(rno, function(reply){
			modalInputReplyer.val(reply.replyer);
			modalInputReply.val(reply.reply);
			modalInputLoginUserId.val(loginReplyer);	// 현재 로그인해서 댓글 작성할 수 있는 사용자 ID
			modalInputReplyerUserId.val(reply.userid); // 원래 댓글을 작성했던 사람의 사용자 ID
			
			modal.data("rno", reply.rno);
			modal.data("replyer", reply.replyer);
			modal.data("loginReplyer", loginReplyer);  // 현재 로그인해서 댓글 작성할 수 있는 사용자 ID
			modal.data("replyerUserId", reply.userid); // 원래 댓글을 작성했던 사람의 사용자 ID
		
			$(".modal").modal("show");
		});
	});
	
	// 댓글 수정 
	modalModBtn.on("click", function(e){
		
		var rno = modal.data("rno");	
		var originalReplyer = modal.data("replyer"); // 댓글 원작성자 
		var originalReplyerUserId = modal.data("replyerUserId"); // 댓글 원작성자의 사용자ID
		var loginReplyerUserId = modal.data("loginReplyer"); // 현재 로그인해서 댓글 작성할 수 있는 사용자 ID
	
/* 		console.log("Original Replyer ID: " + originalReplyerUserId); 
		console.log("Current Login Replyer ID: " + loginReplyerUserId); */
		
		var reply = {
				rno: rno, 
				reply: modalInputReply.val(),
				replyer: originalReplyer, 
				userid: originalReplyerUserId
			};
		
	 	if(!loginReplyerUserId){
			alert("로그인 후 수정이 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		if(originalReplyerUserId != loginReplyerUserId){
			alert("자신이 작성한 댓글만 수정 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		replyService.update(reply, function(result){
			modal.modal("hide");
			showList(pageNum); 
		});
	});
	
	// 댓글 삭제 
	modalRemoveBtn.on("click", function(e){
		
		var rno = modal.data("rno");	
		var originalReplyer = modal.data("replyer"); // 댓글 원작성자 
		var originalReplyerUserId = modal.data("replyerUserId"); // 댓글 원작성자의 사용자ID
		var loginReplyerUserId = modal.data("loginReplyer"); // 현재 로그인해서 댓글 작성할 수 있는 사용자 ID
		
/* 		console.log("RNO: " + rno);
		console.log("RNO TYPE: " + typeof rno);
		console.log("Original Replyer ID: " + originalReplyerUserId); 
		console.log("Current Login Replyer ID: " + loginReplyerUserId);  */
		
		if(!loginReplyerUserId){
			alert("로그인 후 삭제가 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		if(originalReplyerUserId != loginReplyerUserId) {
			alert("자신이 작성한 댓글만 삭제가 가능합니다.")
			modal.modal("hide");
			return;
		}
		
		replyService.remove(rno, loginReplyerUserId, function(result){
			modal.modal("hide");
			showList(pageNum);
		})
	});
	
	// 페이지 처리된 댓글 목록 가져오기 
	var pageNum = 1;
	var replyPageFooter = $("#replyPageFooter");
	
	function showReplyPage(replyCnt){
	      
	      var endNum = Math.ceil(pageNum / 10.0) * 10;  
	      var startNum = endNum - 9; 
	      
	      var prev = startNum != 1;
	      var next = false;
	      
	      if(endNum * 10 >= replyCnt){
	        endNum = Math.ceil(replyCnt/10.0);
	      }
	      
	      if(endNum * 10 < replyCnt){
	        next = true;
	      }
	      
	      var str = "<ul class='pagination pull-right'>";
	      
	      if(prev){
	    	  	str+="<li class='page-item'>";
				str+="<a class='page-link' href='" + (startNum-1) + "' aria-label='Previous'>";
				str+="<span aria-hidden='true'>&laquo;</span>";
				str+="<span class='sr-only'>Previous</span></a></li>";
	      }
	      
	      for(var i = startNum ; i <= endNum; i++){
	        
	        var active = pageNum == i? "active":"";
	        
	        str+= "<li class='page-item " + active + " '><a class='page-link' href='" + i + "'>" + i + "</a></li>";
	      }
	      
	      if(next){
	    	  	str+="<li class='page-item'>";
				str+="<a class='page-link' href='" + (endNum+1) + "' aria-label='Previous'>";
				str+="<span aria-hidden='true'>&raquo;</span>";
				str+="<span class='sr-only'>Previous</span></a></li>";
	      }
	      
	      str += "</ul></div>";
	      
	      console.log(str);
	      
	      replyPageFooter.html(str);
	    }
	
	// 댓글 페이지 클릭 시 페이지 이동 
	replyPageFooter.on("click", "li a", function(e){
		e.preventDefault();
		console.log("page click");
		
		var targetPageNum = $(this).attr("href");
		console.log("targetPageNum: " + targetPageNum);
		pageNum = targetPageNum;
		showList(pageNum);
	});
	
});

</script>

<!-- 첨부파일 관련 작업 스크립트 -->
<script type="text/javascript">

$(document).ready(function(){
	
	// 첨부파일 목록을 가져오는 작업.
	(function(){
		
		var bno = '<c:out value="${board.bno}"/>';
		$.getJSON(
				"/sjboard/getAttachList", 
				{bno: bno}, 
				function(arr){
					
					console.log(arr);
					
					var str="";
					
					$(arr).each(function(i, attach){
						
						// 이미지 파일인 경우 
						if(attach.fileType){
							
							var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName );
							
							str += "<li data-path='"+ attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName+ "' data-type='"+ attach.fileType+ "'><div>";
							str += "<span>" + attach.fileName + "</span><br>";
							str += "<img src='/display?fileName=" + fileCallPath + "'>";
							str += "</div></li>";
							
						// 일반 파일인 경우 
						}else {
							
							str += "<li data-path='"+ attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName+ "' data-type='"+ attach.fileType+ "'><div>";
							str += "<span>" + attach.fileName + "</span><br>";
							str += "<img src='/resources/img/attach.png'></a>";
							str += "</div></li>";
						}
						
					});
					
					$(".uploadResult ul").html(str);
					
				})
	})();
	
		
});

//첨부파일 클릭 시 이벤트 처리 

$(".uploadResult").on("click", "li", function(e){
	
	console.log("view image");
	
	var liObj = $(this);
	
	var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
	
	//data-type='true' = 이미지파일 (원본이미지를 보여준다.)
	if(liObj.data("type")){
		showImage(path.replace(new RegExp(/\\/g),"/"));
	}
	//data-type='false' = 일반파일 (다운로드한다.)
	else{ 
		if(confirm("다운로드 하시겠습니까?")){
			self.location = "/download?fileName=" + path;
		}
	}
});

// 이미지 파일의 원본 이미지를 보여주는 함수 
function showImage(fileCallPath){
	$(".bigPictureWrapper").css("display","flex").show();
	  
	$(".bigPicture")
	  .html("<img src='/display?fileName="+ fileCallPath+"'>")
	  .animate({width:'100%', height: '100%'});
}

//원본 이미지가 띄워진 전체 화면 클릭 시 사라지는 이벤트 
$(".bigPictureWrapper").on("click", function(e){
  $(".bigPicture").animate({width:'0%', height: '0%'});
  setTimeout(function() {
	  $(".bigPictureWrapper").hide();
  });

});

</script>

 <%@include file="../includes/footer.jsp" %>