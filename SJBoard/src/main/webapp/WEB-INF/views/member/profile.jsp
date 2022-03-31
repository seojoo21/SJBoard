<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp" %>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">회원 정보</h3>
                    <h4 class="page-header">회원 정보 확인</h4>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <!-- 게시판 레이아웃 시작 -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                       		
                       		<form id="operForm" action="/member/update" method="get"> 
	                       	 	<div class="form-group">
	                            	<label>아이디</label>
	                                	<input class="form-control" name='userid' value='<c:out value="${profile.userid }"/>' readonly="readonly">
	                            </div>
	                            <div class="form-group">
	                            	<label>사용자 이름(별명)</label>
	                                	<input class="form-control" name='userName' value='<c:out value="${profile.userName }"/>' readonly="readonly">
	                            </div>
	                            <div class="form-group">
	                            	<label>이메일</label>
	                                	<input class="form-control" name='email' value='<c:out value="${profile.email }"/>' readonly="readonly">
	                            </div>
	                            <div class="form-group">
	                            	<label>사용자 가입일 </label>
	                                	<input class="form-control" name='regdate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${profile.regdate}"/>' readonly="readonly">
	                            </div>
	                            <div class="form-group">
	                            	<label>최근 사용자 정보 수정일 </label>
	                                	<input class="form-control" name='updateDate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${profile.updateDate}"/>' readonly="readonly">
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
                                    <button id="submitBtn"type="submit" class="btn btn-primary">회원 정보 수정</button>
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
        

    	</div>	
    	<!-- /#wrapper -->
   

<script type="text/javascript">

//회원 정보 수정 버튼 클릭 시 
$("#submitBtn").on("click", function(e){
		$("#operForm").attr("action", "/member/update").submit();
	});

</script>


 <%@include file="../includes/footer.jsp" %>