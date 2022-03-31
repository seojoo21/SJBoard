<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SJBoard 비밀번호 찾기</title>

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
                        <h3 class="panel-title">SJBoard 비밀번호 찾기</h3>
                    </div>
                    <div class="panel-body">
                        <form id="findPwdForm" role="form" method="post" action="/member/findPwd">
                            <fieldset>
                            	<div class="form-group">
                            		비밀번호를 찾고자 하는 아이디와 가입 시 입력하셨던 이메일 주소를 입력해주세요.
                            	</div>
                            	<div class="form-group">
                                	<input class="form-control" placeholder="아이디(필수)" id="userid" name="userid" type="text" value="" maxlength="12" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="이메일주소(필수)" id="email" name="email" type="email" value="">
                                </div>
                                <div class="form-group input-group">
                                	<input type="text" class="form-control" placeholder="인증 번호를 입력해주세요." id="mailCheck_false" name="regNumKey" value="" disabled="disabled" maxlength="6">
                                    <span class="input-group-btn">
                                    <button class="btn btn-warning" type="button" id="mailCheckBtn" style="marin-top: 0px;">인증 번호 전송</button>
                                    </span>
                                </div>
                                <div>
	                                <span class="checkNum_input_re_1" style="color: green; display: none; ">인증 번호가 일치합니다.</span>
		                           	<span class="checkNum_input_re_2" style="color: red; display: none; ">인증 번호가 일치하지 않습니다.</span>
	                           	</div>
	                           	<div>
	                           		<div>
	                                	<ul style="list-style: none; padding: 0px;">
		                                	<li style="display: inline-block;">아이디가 기억나지 않는다면?</li>
		                                	<li style="display: inline-block; text-decoration: underline; text-underline-position:under;"><a href="/member/findId" style="color:black;">아이디 찾기</a></li>
	                                	</ul>
                                	</div>
                                	<button type="submit" id="findPwdBtn" class="btn btn-lg btn-success btn-block">비밀번호 찾기</button>
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
	
	// 비밀번호 찾기 버튼 클릭 시 
	$("#findPwdBtn").on("click", function(){
		
		// 아이디를 입력하지 않았을 경우  
		if($("#userid").val()==""){
			alert("아이디를 입력해주세요.");
			$("#userid").focus();
			return false;
		}
		
		// 이메일 주소를 입력하지 않았을 경우 
 		if($("#email").val()==""){
			alert("이메일 주소를 입력해주세요.");
			$("#email").focus();
			return false;
		}
		
		// 인증 번호를 입력하지 않았을 경우 
		if(checkBox.val()==""){
			alert("인증 번호를 입력해주세요.");
			checkBox.focus();
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
		if (result == "fail") {
			$(".modal-body").html("아이디와 인증 번호를 재확인해주세요.");
		}
		
		$("#myModal").modal("show");

	}
	
});

var checkBox = $("input[id='mailCheck_false']"); // 인증 번호 입력란 

// 인증 번호 전송 버튼 클릭 시 
$("#mailCheckBtn").on("click", function(){
	
	var email =  $("#email").val(); //사용자가 입력한 이메일 

	$.ajax({
		type: "get",
		url: "/member/mailCheck?email=" + email,
		success: function(data) {
			checkBox.attr("disabled", false);
			checkBox.attr("id", "mailCheck_true");
		}
	});
}); 

// 인증 번호 일치 시 
$("#mailCheck_false").on("propertychange change keyup paste input", function(){
	
	var checkBoxInputNum = checkBox.val();
	var data = {regCheckNum : checkBoxInputNum };
			
	$.ajax({
		type: "post",
		url: "/member/regCheckNum",
		beforeSend: function(xhr){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);	
		},
		data: data,
		success: function(result){
			if(result != "fail") {
				$(".checkNum_input_re_1").css("display", "inline-block");
				$(".checkNum_input_re_2").css("display", "none");
				
			} else {
				$(".checkNum_input_re_1").css("display", "none");
				$(".checkNum_input_re_2").css("display", "inline-block");
			}
		}
		
	}); // end ajax
	
}); 
 
</script>

</body>

</html>
