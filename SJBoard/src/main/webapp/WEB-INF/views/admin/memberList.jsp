<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp" %>

<style>
.div_left{
	width: 20%;
	float: left;
	box-sizing: border-box;
}

.div_right{
	width: 80%;
	float: right;
	box-sizing: border-box;
}

</style>
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">관리자 페이지</h3>
                </div>
            </div>
            
            <div class="div_left">
	            <ul style="list-style: none; padding-left:0px;">
	            	<li class="divider"><a style="color: black;" href="/admin/main">메인</a></li>
		            <li class="divider"><a style="color: black;" href="/admin/memberList">회원 목록</a></li>
		           	<li class="divider"><a style="color: black;" href="/admin/bnoStats">기간별 게시물 현황</a></li>
		            <li class="divider"><a style="color: black;" href="/admin/rnoStats">기간별 댓글 현황</a></li>
		            <li class="divider"><a style="color: black;" href="/admin/memberStats">기간별 회원 현황</a></li>
	            </ul>
            </div>
            
            <div class="div_right">
            	<div>
	            	<b>총 회원 수</b>: <c:out value="${TotalUserNo }"/>
	            </div>
            	<table class="table table-striped table-bordered table-hover">
	                <thead>
		                <tr>
		                	<td>No</td>
				            <th>회원 아이디</th>
				            <th>회원 사용자 이름</th>
				            <th>회원 가입일</th>
				            <th>회원 정보 수정일</th>
				            <th>이메일 주소</th>
				            <th>회원 권한</th>
				            <th>회원 권한 관리</th>
		                </tr>
	                </thead>
	                <tbody>
	  					<c:forEach items="${list }" var="list" varStatus="loop">
	  						<tr>
	  							<td><c:out value="${loop.count }"/></td>
			  					<td><c:out value="${list.userid }"/></td>
			  					<td><c:out value="${list.userName }"/></td>
			  					<td><fmt:formatDate pattern="yyyy/MM/dd" value="${list.regdate }"/></td>
			  					<td><fmt:formatDate pattern="yyyy/MM/dd" value="${list.updateDate }"/></td>
			  					<td><c:out value="${list.email }"/></td>
			  					<td>
				  					<c:if test='${list.authList[0].auth == "ROLE_ADMIN" }'>
		                            	<c:out value="관리자"/>
		                            </c:if>
		                            <c:if test='${list.authList[0].auth == "ROLE_MEMBER" }'>
		                            	<c:out value="일반회원"/>
		                            </c:if>
			  					</td>
			  					<td>
			  						<form id="updateForm" action="/admin/updateAuth" method="post">
			  						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }" >
				  						<div class="auth" style="display: inline-block;" data-userid='<c:out value="${list.userid }"/>'>
				  							<select>
				  								<option value="">----</option>
											  	<option value="ROLE_MEMBER">일반회원</option>
											 	<option value="ROLE_ADMIN">관리자</option>
											</select>
				  						</div>
						  				<div style="display: inline-block;">
							  				<button id="updateBtn" type="button" onclick="update(this)">변경</button>
										</div>
										<div style="display: inline-block;">
											<button id="updateBtn" type="button" onclick="remove(this)">강제 탈퇴</button>
										</div>
									</form> 
									<!-- 스크립트 잠깐 위로 이동 -->
									<script>
									
									// 회원 권한 변경 시 
									function update(obj){						
									    var $target =  $(obj).closest('form').find('.auth');
									    var userId = $target.data('userid');
									    var userAuth = $target.find("select > option:selected").val();
									    var data = {userid: userId, auth: userAuth};
									    console.log("click");
									    console.log("userId / auth : " + userId + "/" + userAuth );
									    
									    $.ajax({
									        type: "post",
									        url: "/admin/updateAuth",
									        data: data,
									        success: function(result){
									            if(result == "success") {
									                alert("회원 권한이 변경되었습니다.");
									                location.reload(); 
									            } else {
									                alert("처리되지 않았습니다. 다시 시도해주세요.");
									                location.reload(); 
									            }
									        } // end success
									    }); // end ajax
									};// end function update
									
									function remove(obj){
  										var $target = $(obj).closest('form').find('.auth');
  										var userId = $target.data('userid');
  										
  										console.log("click");
  										console.log("userid : " + userId);
  										
  										$.ajax({
  											type: "post",
  											url: "/admin/deleteMember",
  											data: {userid : userId},
  											success: function(result){
  												if(result == "success") {
									                alert("해당 회원의 강제 탈퇴 처리가 완료되었습니다.");
									                location.reload(); 
									            } else {
									                alert("처리되지 않았습니다. 다시 시도해주세요.");
									                location.reload(); 
									            }
  											} // end success
  										}); // end ajax
  									};// end function remove
									</script>
  								</td>
			  				</tr>
	  					</c:forEach> 
	                </tbody>
                </table>
                
                <!-- 페이징처리 -->
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
							
				<form id='pageForm' action="/admin/memberList" method="get">
					<input type="hidden" name='pageNum' value='${pageMaker.cri.pageNum }'>
					<input type="hidden" name='amount' value='${pageMaker.cri.amount }'>
				</form>
				<!-- 페이징처리 끝 -->
				
            </div>
    	</div>
   
<script type="text/javascript">

 $(document).ready(function(){
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	// 페이지 번호 클릭 시 
	var pageForm = $("#pageForm");
	
	$(".page-item a").on("click", function(e){
		e.preventDefault();
		pageForm.find("input[name='pageNum']").val($(this).attr("href"));
		pageForm.submit();
	  });
	
	
});//end document ready
 
</script>


 <%@include file="../includes/footer.jsp" %>