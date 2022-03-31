<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp" %> 

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">회원 정보</h3>
                    <h4 class="page-header">회원 탈퇴</h4>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <!-- 게시판 레이아웃 시작 -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                       		<form id="operForm" role="form" action="/member/delete" method="post">  
                       		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
	                       	 	<div class="form-group">
	                            	<label>아이디</label>
	                                	<input class="form-control" name='userid' value='<c:out value="${profile.userid }"/>' readonly="readonly">
	                            </div>
	                            <div class="form-group">
	                            	<label>비밀번호</label><br>
	                            	<span style="color: blue;">* 회원 탈퇴를 위해 비밀번호를 입력해주세요.</span><br>
	                                	<input class="form-control" name='userpw' type="password" value='<c:out value=""/>' placeholder="">
	                            </div>
	                            <div class="form-group">
	                            	<c:if test="${msg == false}">
	                            	<span style="color: red;">* 비밀번호가 일치하지 않습니다.</span>
	                            	</c:if>
	                            </div>
                       		</form>  
                       		
                       		<sec:authentication property="principal" var="pinfo"/>
                       		<sec:authorize access="isAuthenticated()">
                            	<c:if test="${pinfo.username eq profile.userid }">
                                    <button type="submit" data-oper="delete" class="btn btn-danger" >회원 탈퇴</button>
                            </c:if>
                            </sec:authorize>  		
						
						</div>
                            <!-- /.table-responsive -->
                     </div>
                        <!-- /.panel-body -->
                 </div>
                    <!-- /.panel -->
             </div>
                <!-- /.col-lg-12 -->
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
    	<!-- /#wrapper -->
   
<script type="text/javascript">
$(document).ready(function(){
	
	var operForm = $("form");
	
	$("button").on("click",function(e){
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		// 회원 탈퇴 버튼 클릭 시 
		if(operation === "delete"){
			operForm.attr("action", "/member/logout").submit();
			operForm.attr("action", "/member/delete").submit();
			sessionStorage.clear(); 
		}
	});
	
	// 회원 탈퇴 처리 결과를 보여주는 모달창 - 회원 탈퇴 실패 
	var result = "<c:out value='${result }' />";
	
	checkModal(result);
	history.replaceState({},null,null); 
	
	function checkModal(result){
		
		if (result === "" || history.state){
			return;
		}
		
		if (result == "deleteUserFail") {
			$(".modal-body").html("회원 탈퇴 처리가 되지 않았습니다. 비밀번호를 재확인하시어 다시 시도해주세요.");
		}
		
		$("#myModal").modal("show");
	}
	
});

</script>


 <%@include file="../includes/footer.jsp" %>