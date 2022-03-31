<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SJBoard 아이디 찾기</title>

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
                        <h3 class="panel-title">SJBoard 아이디 찾기</h3>
                    </div>
                    <div class="panel-body">
                        <form id="findIdForm" role="form" method='post' action="/member/findId">
                            <fieldset>
                            	<div class="form-group">
                            		아이디를 찾기 위해 가입 시 입력하셨던 이메일 주소를 입력해주세요.
                            	</div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="이메일주소(필수)" id="email" name="email" type="email" value="">
                                </div>
                                <div class="showResult">
	                                <c:if test="${success == 1}">
	                                	<label style="color: blue;">찾으시는 아이디는 ${userid } 입니다.</label>
	                                	<button type="submit" id="loginBtn" class="btn btn-lg btn-warning btn-block" style="margin-bottom: 5px;">로그인 하기</button>
	                                </c:if>
	                                <c:if test="${fail == 0}">
	                                	<label style="color: red;">해당 이메일 주소로 가입된 아이디가 존재하지 않습니다.</label>
	                                </c:if>
	                           	</div>
	                           	<div>
	                                <button type="submit" id="findIdBtn" class="btn btn-lg btn-success btn-block">아이디 찾기</button>
	                                <button type="button" id="homeBtn" class="btn btn-lg btn-info btn-block">홈으로</button>
                                </div>
                            </fieldset>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        </form>
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
  		
  		// 아이디 찾기 버튼 클릭 시 
  		$("#findIdBtn").on("click", function(){
  	  		$("#findIdForm").submit(); 
  		});
  		
  		// 홈으로 버튼 클릭 시 
  	  	$("#homeBtn").on("click",function(){
  	  		location.href = "/";
  	  	});
  		
  		// 아이디 찾은 후 로그인 하기 버튼 클릭 시 
  		$(".showResult").on("click", "#loginBtn",function(){
  			$("#findIdForm").attr("method", "get").attr("action", "/member/login").submit();
  		});
  	});
  	
  	</script>
    
</body>

</html>
