<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SJBoard</title>
    
    <link rel="icon" href="/favicon.ico" type="image/x-icon">
    
    <!-- jQuery ajax  -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  
 	<!-- Metis Menu Plugin JavaScript -->
    <script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- DataTables JavaScript -->
    <script src="/resources/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="/resources/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="/resources/vendor/datatables-responsive/dataTables.responsive.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="/resources/dist/js/sb-admin-2.js"></script>
    
    <!-- Bootstrap Core JavaScript -->
    <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Bootstrap Core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css?after" rel="stylesheet">

    <!-- MetisMenu CSS  -->
    <link href="/resources/vendor/metisMenu/metisMenu.min.css?after" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css?after" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="/resources/vendor/datatables-responsive/dataTables.responsive.css?after" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/resources/dist/css/sb-admin-2.css?after" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css?after" rel="stylesheet" type="text/css">
    
    <!-- SummerNote -->
    <script src="/resources/summernote/js/summernote-lite.min.js"></script>
    <script src="/resources/summernote/lang/summernote-ko-KR.min.js"></script>
    <link href="/resources/summernote/css/summernote-lite-min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
	
	<!-- Google Chart -->
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	
	<!-- jQuery datepicker -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"/>
	
</head>

<body>
    <div id="wrapper">
        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <a class="navbar-brand" href="/" style="font-weight: bold;">SJ Board</a>
            </div>
            <!-- /.navbar-header -->
            <div>
            </div>
            <form>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
				<div class="pull-left" >
					<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal" var="user"/>
					[USER ID: ${user.username }
					| USER NAME : ${user.member.userName }] 환영합니다. 
					</sec:authorize>
				</div>
				
				<div>
		            <ul class="nav navbar-top-links navbar-right pull-right">
		                 <li class="divider"><a href="/" style="color:black;"><i class="fa fa-home"></i> 홈</a></li>
		                 <li class="divider"><a href="/sjboard/list" style="color:black;"><i class="fa fa-list"></i> 게시판</a></li> 
		                 
		                 <sec:authorize access="isAuthenticated()">
		                 <li class="divider"><a href="/member/profile" style="color:black;"><i class="fa fa-user"></i> 회원정보</a></li>
		                 </sec:authorize>
		                 
		                 <sec:authorize access="hasRole('ROLE_ADMIN')">
						 <li class="divider"><a href="/admin/main" style="color:black;"><i class="fa fa-gears"></i> 관리자 페이지</a></li>
						 </sec:authorize>
		                 
		                 <sec:authorize access="isAuthenticated()">
		                 <li class="divider"><a href="/member/logout" style="color:black;"><i class="fa fa-sign-out"></i> 로그아웃</a></li>
		                 </sec:authorize>
		                 
		                 <sec:authorize access="isAnonymous()">
		                 <li class="divider"><a href="/member/login" style="color:black;"><i class="fa fa-user"></i> 로그인</a></li>
		                 </sec:authorize>
		                  
		                 <li class="divider"><a href="/member/register" style="color:black;"><i class="fa fa-sign-in"></i> 회원가입</a></li>       
		            </ul>
		         </div>
	            <!-- /.navbar-top-links -->
	            
           	</form>
        </nav>