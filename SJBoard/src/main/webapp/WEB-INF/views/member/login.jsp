<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SJBoard Login</title>

    <!-- Bootstrap Core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

</head>

<body>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">SJBoard 로그인</h3>
                    </div>
                    <div class="panel-body">
                        <form id="loginForm" role="form" method='post' action="/login">
                            <fieldset>
                            	<div class="form-group">
                            		<c:out value="${error }"/>
                            		<c:out value="${logout }"/>
                            	</div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="아이디" name="username" type="text" value="" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="비밀번호" name="password" type="password" value="">
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="remember-me">로그인 상태 유지 
                                    </label>
                                </div>
                                <div>
                                	<ul style="list-style: none; padding: 0px;">
	                                	<li style="display: inline-block;"><a href="/member/findId" style="color:black;">아이디 찾기</a></li>
	                                	<li style="display: inline-block;">|</li>
	                                	<li style="display: inline-block;"><a href="/member/findPwd" style="color:black;">비밀번호 찾기</a></li>
                                	</ul>
                                </div>
                                <button type="submit" id="loginButton" class="btn btn-lg btn-success btn-block">로그인</button>
                                <button type="button" id="homeBtn" class="btn btn-lg btn-info btn-block">홈으로</button>
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
  	
  	$(document).ready(function(){
  		
  		// 회원 가입 처리 결과를 보여주는 모달창 
		var result = "<c:out value='${result }' />";
		
		checkModal(result);
		history.replaceState({},null,null); 
		
		function checkModal(result){
			
			if (result === "" || history.state){
				return;
			}
			
			if (result == "success") {
				$(".modal-body").html("회원 가입이 완료되었습니다. 로그인해주세요.");
			}
			
			if (result == "UpdatePwSuccess") {
				$(".modal-body").html("비밀번호 수정이 완료되었습니다. 로그인해주세요.");
			}
			
			if (result == "UpdateUserInfoSuccess") {
				$(".modal-body").html("회원 정보 수정이 완료되었습니다. 다시 로그인해주세요.");
			}
			
			$("#myModal").modal("show");
		}
  	});
 
  	// 로그인 버튼 엔터키 누를 시 
  	$("#loginForm").keypress(function(e){
		if (e.keyCode === 13) {
			$('#loginButton').click();
		}
  	});
  	
  	// 홈으로 버튼 클릭 시 
  	$("#homeBtn").on("click", function(){
  		location.href = "/";
  	});
  	</script>
    
</body>

</html>
