<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">게시판</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <!-- 게시판 레이아웃 시작 -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                              <!-- 글쓰기 버튼 -->     
                            	<button id='regBtn' type="button" class="btn pull-right fa fa-pencil" style="border-color:#ccc;"> 글쓰기</button>
                                <button id='newListBtn' type="button" class="btn pull-right fa fa-list" style="border-color:#ccc;"> 최신 목록</button>
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
	                                        <th>#</th>
	                                        <th>제목</th>
	                                        <th>작성자</th>
	                                        <th>등록일</th>
	                                        <th>수정일</th>
	                                        <th>조회수</th>
	                                        <th>추천수</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach items="${list}" var="board">
                                    		<tr>
                                    			<td><c:out value= "${board.bno}"/></td>
                                    			<td><a class="move" style="color:black;" href='<c:out value= "${board.bno}"/>'><c:out value= "${board.title}"/>
                                    			<b>[<c:out value="${board.replyCnt}"/>]</b></a></td>
                                    			<td><c:out value= "${board.writer}"/></td>
                                    			<td><fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate }"/></td>
                                    			<td><fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate }"/></td>
                                    			<td><c:out value= "${board.viewHit}"/></td>
                                    			<td><c:out value= "${board.likeHit}"/></td>
                                    			
                                    		</tr>
                                    	</c:forEach>
                                    </tbody>
                                 </table>
                                 
                            <!-- 검색창 출력  -->
                            <div class='row'>
	                            <form id='searchForm' action="/sjboard/list" method='get'>
		                            <div class="col-lg-2 form-group">
		                               <select name='type' class="form-control">
		                                  <option value="" <c:out value="${pageMaker.cri.type==null? 'selected' : '' }"/>>--</option>
		                                  <option value="T" <c:out value="${pageMaker.cri.type eq 'T'? 'selected' : '' }"/>>제목</option>
		                              	  <option value="C" <c:out value="${pageMaker.cri.type eq 'C'? 'selected' : '' }"/>>내용</option>
		                              	  <option value="W" <c:out value="${pageMaker.cri.type eq 'W'? 'selected' : '' }"/>>작성자</option>
		                              	  <option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'? 'selected' : '' }"/>>제목or내용</option>
		                              	  <option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'? 'selected' : '' }"/>>제목or작성자</option>
		                              	  <option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW'? 'selected' : '' }"/>>제목or내용or작성자</option>
		                               </select>
		                            </div>
		                            <div class="col-lg-2 form-group input-group">
	                                  <input type="text" name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>' class="form-control">
	                                  <input type="hidden" name='pageNum' value='<c:out value="${pageMaker.cri.pageNum }"/>'>
	                                  <input type="hidden" name='amount' value='<c:out value="${pageMaker.cri.amount }"/>'>
	                                    <span class="input-group-btn">
	                                      <button class="btn btn-default" type="button"><i class="fa fa-search"></i></button>
	                                    </span>
	                                </div>
	                            </form>
                            </div>
                            
                            <!-- 페이징 처리 페이지 번호 출력 -->
							<div class='pull-right'>
							  <ul class="pagination">
							  	<c:if test="${pageMaker.prev }">
							  		<li class="page-item">
							      	<a class="page-link" href="${pageMaker.startPage-1 }" aria-label="Previous">
							        	<span aria-hidden="true">&laquo;</span>
							        	<span class="sr-only">Previous</span>
							      	</a>
							    	</li>
							  	</c:if>
							  	
							  	<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							  		<li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : '' }"><a class="page-link" href="${num }">${num}</a></li>
							  	</c:forEach>
							   
							   	<c:if test="${pageMaker.next }">
							  		<li class="page-item">
							      	<a class="page-link" href="${pageMaker.endPage+1 }" aria-label="Next">
							        	<span aria-hidden="true">&raquo;</span>
							        	<span class="sr-only">Next</span>
							      	</a>
							    	</li>
							  	</c:if>
							  </ul>
							</div>  
							
							<form id='actionForm' action="/sjboard/list" method="get">
								<input type="hidden" name='pageNum' value='${pageMaker.cri.pageNum }'>
								<input type="hidden" name='amount' value='${pageMaker.cri.amount }'>
								<input type="hidden" name='type' value='${pageMaker.cri.type }'>
								<input type="hidden" name='keyword' value='${pageMaker.cri.keyword }'>
							</form>
							
						    <!-- Modal -->
							<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
						                	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						                    <h4 class="modal-title" id="myModalLabel">처리 안내</h4>
						                </div>
						                <div class="modal-body">
											처리가 완료되었습니다. 
						                </div>
						               	<div class="modal-footer">
						                  <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						               	</div>
						            </div>
						         <!-- /.modal-content -->
						        </div>
						      <!-- /.modal-dialog -->
						    </div>
						   <!-- /.modal -->
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
   
<script type="text/javascript">
/* 처리 결과를 보여주는 모달창*/
/* 뒤로 가기 시 모달창이 다시 뜨는 문제를 해결하기 위해 window의 history 객체를 사용함. */
$(document).ready(function(){
	
	var result = '<c:out value = "${result}"/>';
	
	checkModal(result);
	history.replaceState({},null,null); 
	
	function checkModal(result){
		if (result ==='' || history.state) {return;} 
		if (parseInt(result)>0){$(".modal-body").html("게시글 " + parseInt(result)+ " 번이 등록되었습니다.");}
		$("#myModal").modal("show");
	}

	/* 글쓰기 버튼 클릭 시 register.jsp로 넘어감*/
	$("#regBtn").on("click", function(){
		
		self.location = "/sjboard/register"; });
	
	$("#newListBtn").on("click", function(){
		
		self.location = "/sjboard/list"; });
	
	/* 페이지 처리 */
	var actionForm = $("#actionForm");
	
	$(".page-item a").on("click", function(e){
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	  });
  
	/* 페이지 처리를 반영한 게시물 조회 처리 */
	$(".move").on("click", function(e){
		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
		actionForm.attr("action", "/sjboard/get");
		actionForm.submit();
	});
	
	/* 검색 처리 */
	var searchForm = $("#searchForm");
	
	$("#searchForm button").on("click", function(e){
		
		if(!searchForm.find("option:selected").val()){
			alert("검색 조건을 선택하세요.")
			return false;
		}  
		
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요.");
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		
		searchForm.submit();
	
	});

});

</script>

<%@include file="../includes/footer.jsp" %>