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
					| USER NAME : ${user.member.userName }] ???????????????. 
					</sec:authorize>
				</div>
             		
				<div>
		            <ul class="nav navbar-top-links navbar-right pull-right">
		                 <li class="divider"><a href="/" style="color:black;"><i class="fa fa-home"></i> ???</a></li>
		                 <li class="divider"><a href="/sjboard/list" style="color:black;"><i class="fa fa-list"></i> ?????????</a></li> 
		                 
		                 <sec:authorize access="isAuthenticated()">
		                 <li class="divider"><a href="/member/profile" style="color:black;"><i class="fa fa-user"></i> ????????????</a></li>
		                 </sec:authorize>
		                 
		                 <sec:authorize access="hasRole('ROLE_ADMIN')">
						 <li class="divider"><a href="/admin/main" style="color:black;"><i class="fa fa-gears"></i> ????????? ?????????</a></li>
						 </sec:authorize>
		                 
		                 <sec:authorize access="isAuthenticated()">
		                 <li class="divider"><a href="/member/logout" style="color:black;"><i class="fa fa-sign-out"></i> ????????????</a></li>
		                 </sec:authorize>
		                 
		                 <sec:authorize access="isAnonymous()">
		                 <li class="divider"><a href="/member/login" style="color:black;"><i class="fa fa-user"></i> ?????????</a></li>
		                 </sec:authorize>
		                  
		                 <li class="divider"><a href="/member/register" style="color:black;"><i class="fa fa-sign-in"></i> ????????????</a></li>       
		            </ul>
		         </div>
	            <!-- /.navbar-top-links -->
	            
           	</form>
        </nav>
        
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">???</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            ?????? ????????? 
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>??????</th>
                                            <th>?????????</th>
                                            <th>?????????</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach items="${recentList}" var="recentList">
                                       		<tr>
                                            <td><c:out value="${recentList.bno }"/></td>
                                            <td><a style="color:black;" href='/sjboard/get?bno=<c:out value="${recentList.bno }"/>'><c:out value="${recentList.title }"/></a></td>
                                            <td><c:out value="${recentList.writer }"/></td>
                                            <td><fmt:formatDate pattern="yyyy/MM/dd" value="${recentList.regdate }"/></td>
                                        	</tr>
                                       	</c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
                
                  <!-- /.row -->
            <div class="row">
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            ?????? ?????????
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>??????</th>
                                            <th>?????????</th>
                                            <th>?????????</th>
                                            <th>?????????</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${likeHitList}" var="likeHitList">
                                       		<tr>
                                            <td><c:out value="${likeHitList.bno }"/></td>
                                            <td><a style="color:black;" href='/sjboard/get?bno=<c:out value="${likeHitList.bno }"/>'><c:out value="${likeHitList.title }"/></a></td>
                                            <td><c:out value="${likeHitList.writer }"/></td>
                                            <td><c:out value="${likeHitList.likeHit }"/></td>
                                            <td><c:out value="${likeHitList.viewHit }"/></td>
                                        	</tr>
                                       	</c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
        </div>
        <!-- /#page-wrapper -->
                         
            <!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
						        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						        	<h4 class="modal-title" id="myModalLabel">?????? ??????</h4>
						    </div>
						    <div class="modal-body">
								????????? ?????????????????????. 
						    </div>
						    <div class="modal-footer">
						    	<button type="button" class="btn btn-default" data-dismiss="modal">??????</button>
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
  		
  		// ?????? ?????? ?????? ????????? ???????????? ????????? - ?????? ?????? ?????? 
		var result = "<c:out value='${result }' />";
		
		checkModal(result);
		history.replaceState({},null,null); 
		
		function checkModal(result){
			
			if (result === "" || history.state){
				return;
			}
			
			if (result == "deleteUserSuccess") {
				$(".modal-body").html("?????? ????????? ?????????????????????.");
				sessionStorage.clear(); 
			}
			
			$("#myModal").modal("show");
		}
  	});
</script>    
</body>

</html>