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
                    <h3 class="page-header">회원 정보</h3>
                    <h4 class="page-header">회원 정보 수정</h4>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <!-- 게시판 레이아웃 시작 -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                       		<form id="operForm" role="form" action="/member/update" method="post">  
                       		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
	                       	 	<div class="form-group">
	                            	<label>아이디</label>
	                                	<input class="form-control" name='userid' value='<c:out value="${profile.userid }"/>' readonly="readonly">
	                            </div>
	                            <div class="form-group">
	                            	<label>비밀번호</label><br>
	                            	<span style="color: blue;">* 비밀번호 변경 시 8자 이상, 문자/숫자/기호 사용 가능</span><br>
	                            	<span style="color: blue;">* 비밀번호 변경을 원하지 않아도 기존 비밀번호를 입력해주셔야 회원 정보 수정이 가능합니다.</span>
	                                	<input class="form-control" name='userpw' type="password" value='<c:out value=""/>' placeholder="">
	                            </div>
	                            <div class="form-group">
	                            	<label>사용자 이름(별명)</label><br>
	                       			<span style="color: blue;">* 사용자 이름(별명) 변경 시 10자 이내, 영문/숫자/기호 사용 가능</span>
		                            <input class="form-control" id="userName" name='userName' value="<c:out value="${profile.userName }"/>" maxlength="10">
		                            <span class="userName_input_re_1" style="color: green; display: none;">사용 가능한 사용자이름(별명)입니다.</span>
		                            <span class="userName_input_re_2" style="color: red; display: none;">이미 존재하는 사용자이름(별명)입니다.</span>
	                            </div>
	                            <div class="form-group">
	                            	<label>이메일</label><br>
	                            	<span style="color: blue;">* 이메일 주소 변경 시 본인의 이메일 주소를 정확하게 입력해주세요.</span>
	                                	<input class="form-control" name='email' value='<c:out value="${profile.email }"/>'>
	                            </div>
	                            <div class="form-group">
	                            	<label>사용자 가입일 </label>
	                                	<input class="form-control" name='regdate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${profile.regdate}"/>' readonly="readonly">
	                            </div>
	                            <div class="form-group">
	                            	<label>최근 사용자 정보 수정일 </label>
	                                	<input class="form-control" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${profile.updateDate}"/>' readonly="readonly">
	                            </div>
	                            <div class="form-group">
	                            	<label>사용자 권한</label>
	                                	<c:if test='${profile.authList[0].auth == "ROLE_ADMIN" }'>
	                            			<input class="form-control" name='authList' value='관리자' readonly="readonly">
	                            		</c:if>
	                            		<c:if test='${profile.authList[0].auth == "ROLE_MEMBER" }'>
	                            			<input class="form-control" name='authList' value='일반회원' readonly="readonly">
	                            		</c:if>
	                            </div> 
                       		</form>  
                       		
                       		<sec:authentication property="principal" var="pinfo"/>
                       		<sec:authorize access="isAuthenticated()">
                            	<c:if test="${pinfo.username eq profile.userid }">
                                    <button type="submit" data-oper="update" class="btn btn-success">회원 정보 수정</button>
                                    <button type="submit" data-oper="delete" class="btn btn-danger">회원 탈퇴</button>
                            </c:if>
                            </sec:authorize>  		
						
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
    	<!-- /#wrapper -->
   
<script type="text/javascript">

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

//사용자 이름 중복 검사
$("#userName").on("propertychange change keyup paste input", function(){
	
	var userName = $("#userName").val(); // <input id='userName'>에 입력되는 사용자 이름 값 
	var data = {userName : userName}; // {컨트롤러에 넘길 데이터 이름 : 데이터(<input id='userName'>에 입력되는 아이디 값) }
	
	$.ajax({
		type: "post",
		url: "/member/userNameCheck",
		beforeSend: function(xhr){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);	
		},
		data: data,
		success: function(result){
			/* console.log("userName success?" + result); */
			if(result != "fail"){
				$(".userName_input_re_1").css("display", "inline-block");
				$(".userName_input_re_2").css("display", "none");
			} else {
				$(".userName_input_re_1").css("display", "none");
				$(".userName_input_re_2").css("display", "inline-block");
			}
		}
	}); // end ajax 
});

$(document).ready(function(){
	
	// 회원 정보 수정 처리 결과를 보여주는 모달창 
	var result = "<c:out value='${result }' />";
	
	checkModal(result);
	history.replaceState({},null,null); 
	
	function checkModal(result){
		
		if (result === "" || history.state){
			return;
		}
		
		if (result == "UpdateUserInfoFail") {
			$(".modal-body").html("회원 정보 수정이 처리 되지 않았습니다. 다시 시도해주세요.");
		}
		
		$("#myModal").modal("show");
	}
	
	var operForm = $("form");
	
	$("button").on("click",function(e){
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		// 회원 정보 수정 버튼 클릭 시 
		if(operation === "update" ) {
			
			// 비밀번호를 입력하지 않았을 때
			if($("input[name='userpw']").val()==""){
				alert("비밀번호를 입력해주세요.");
				$("input[name='userpw']").focus();
				return false;
			}
			// 비밀번호의 길이가 8자보다 짧을 경우 
			if($("input[name='userpw']").val().length < 8){
				alert("비밀번호는 8자 이상 입력해주세요.");
				$("input[name='userpw']").focus();
				return false;
			}
			
			// 사용자 이름을 입력하지 않았을 경우 
			if($("input[name='userName']").val()==""){
				alert("사용자 이름을 입력해주세요.");
				$("input[name='userName']").focus();
				return false;
			}
				
			// 사용자 이름이 10자 보다 길 경우 
			if($("input[name='userName']").val().length > 10){
				alert("사용자 이름은 10자 이내로 입력해주세요.");
				$("input[name='userName']").focus();
				return false;
			}
			
			// 이메일 주소를 입력하지 않았을 경우 
 			if($("input[name='email']").val()==""){
				alert("이메일 주소를 입력해주세요.");
				$("input[name='email']").focus();
				return false;
			}
			
			operForm.submit();
		}
		
		// 회원 탈퇴 버튼 클릭 시 
		if(operation === "delete"){
			
			operForm.attr("action", "/member/delete").attr("method", "get");
			operForm.submit();
		}
		
	});
	
});

</script>


 <%@include file="../includes/footer.jsp" %>