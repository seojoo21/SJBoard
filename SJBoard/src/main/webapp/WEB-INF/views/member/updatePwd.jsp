<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<% session.getAttribute("userid"); %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SJBoard 비밀번호 재설정</title>

    <!-- Bootstrap Core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<style>
#mailCheck_false {
	background-color: #ccc;
}

#mailCheck_true {
	background-color: white;
}

</style>

</head>

<body>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">SJBoard 비밀번호 재설정</h3>
                    </div>
                    <div class="panel-body">
                        <form id="findPwdForm" role="form" method="post" action="/member/updatePwd">
                            <fieldset>
                            	<div class="form-group">
                            		비밀번호를 재설정해주세요. 
                            	</div>
                            	<div class="form-group">
                                	<input class="form-control" id="userid" name="userid" type="text" value="<c:out value="${sessionScope.userid }"/>" maxlength="12" readonly="readonly">
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="비밀번호(필수)" id="userpw" name="userpw" type="password" value="">
                                </div>
	                           	<div>
                                	<button type="submit" id="updatePwdBtn" class="btn btn-lg btn-success btn-block">비밀번호 재설정</button>
                               	 	<button type="button" id="homeBtn" class="btn btn-lg btn-info btn-block">홈으로</button>
                               	</div> 	
                            </fieldset>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
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
                </div>
            </div>
        </div>
    </div>

<!-- jQuery -->
<script src="/resources/vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="/resources/dist/js/sb-admin-2.js"></script>
    
<script type="text/javascript">

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

$(document).ready(function(){
	
	var userpw = $("#email").val();
	
	//비밀번호 재설정 버튼 클릭 시 
	$("#updatePwdBtn").on("click", function(){
		
		// 비밀번호를 입력하지 않았을 경우 
		if($("#userpw").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#userpw").focus();
			return false;
		}
				
		// 비밀번호의 길이가 8자보다 짧을 경우 
		if($("#userpw").val().length < 8){
			alert("비밀번호는 8자 이상 입력해주세요.");
			$("#userpw").focus();
			return false;
		}
		
		$("#findPwdForm").submit(); 
	});
		
	// 홈으로 버튼 클릭 시 
	$("#homeBtn").on("click",function(){
		location.href = "/";
	});
	
	// 비밀 번호 찾기 처리 결과를 보여주는 모달창 
	var result = "<c:out value='${result }' />";
		
	checkModal(result);
	history.replaceState({},null,null); 
		
	function checkModal(result){
			if (result === "" || history.state){
				return;
			}
			if (result == "success") {
				$(".modal-body").html("인증되었습니다. 비밀번호를 재설정 해주세요.");
			}
			$("#myModal").modal("show");
		}
		
	});
 
</script>

</body>

</html>
