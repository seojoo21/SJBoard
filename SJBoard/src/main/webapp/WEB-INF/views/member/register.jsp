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

    <title>SJBoard Sign Up</title>

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
                        <h3 class="panel-title">SJBoard 회원가입</h3>
                    </div>
                    <div class="panel-body">
                        <form id="signUpForm" role="form" method="post" action="/member/register">
                            <fieldset>
                            	<div class="form-group">
                                	<input class="form-control" placeholder="아이디(6~12자 이내, 영문/숫자 사용 가능)" id="userid" name="userid" type="text" value="" maxlength="12" autofocus>
                                	<span class="id_input_re_1" style="color: green; display: none;">사용 가능한 아이디입니다.</span>
                                	<span class="id_input_re_2" style="color: red; display: none;">이미 존재하는 아이디입니다.</span>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="비밀번호(8자 이상, 문자/숫자/기호 사용 가능)" id="userpw" name="userpw" type="password" value="">
                                </div>
                                <div class="form-group">
                                	<input type="text" class="form-control" placeholder="사용자이름(별명)(10자 이내, 영문/숫자/기호 사용 가능)" id="userName" name="userName" type="text" value="" maxlength="10">
	                                <span class="userName_input_re_1" style="color: green; display: none;">사용 가능한 사용자이름(별명)입니다.</span>
	                                <span class="userName_input_re_2" style="color: red; display: none;">이미 존재하는 사용자이름(별명)입니다.</span>
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
                                	<button type="submit" id="signUpBtn" class="btn btn-lg btn-success btn-block">회원가입</button>
                               	 	<button type="button" id="CancelBtn" class="btn btn-lg btn-info btn-block">회원가입 취소</button>
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

// 인증 번호 일치 검사
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

//아이디 중복 검사
$("#userid").on("propertychange change keyup paste input", function(){
	/* console.log("아이디 입력 keyup 테스트") */
	var userId = $("#userid").val(); // <input id='userid'>에 입력되는 아이디 값 
	var data = {userid : userId}; // {컨트롤러에 넘길 데이터 이름 : 데이터(<input id='userid'>에 입력되는 아이디 값) }
	
	$.ajax({
		type: "post",
		url: "/member/idCheck",
		beforeSend: function(xhr){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);	
		},
		data: data,
		success: function(result){
			/* console.log("userid success?" + result); */
			if(result != "fail"){
				$(".id_input_re_1").css("display", "inline-block");
				$(".id_input_re_2").css("display", "none");
			} else {
				$(".id_input_re_1").css("display", "none");
				$(".id_input_re_2").css("display", "inline-block");
			}
		}
	}); // end ajax 
}); // end function


//사용자 이름 중복 검사
$("#userName").on("propertychange change keyup paste input", function(){
	/* console.log("사용자 이름 입력 keyup 테스트 ") */
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


// 회원 가입 버튼 동작 관련 자바 스크립트 
 	$(document).ready(function(){
 		
 		// 회원 가입 처리 결과를 보여주는 모달창 
		var result = "<c:out value='${result }' />";
		
		checkModal(result);
		history.replaceState({},null,null); 
		
		function checkModal(result){
			if (result === "" || history.state){
				return;
			}
			if (result == "fail") {
				$(".modal-body").html("회원 가입이 완료되지 않았습니다.<br> 아이디 중복 여부, 사용자 이름 중복 여부, 인증 번호 입력 일치 여부 확인 후 다시 시도해주세요.");
			}
			$("#myModal").modal("show");

		}
 		
 		// 회원 가입 취소 시 
 		$("#CancelBtn").on("click", function(){
 			location.href = "/member/login";
 		});
 			
		// 회원 가입 시  
 		$("#signUpBtn").on("click", function(){
 				
 			// 아이디를 입력하지 않았을 경우  
 			if($("#userid").val()==""){
 				alert("아이디를 입력해주세요.");
 				$("#userid").focus();
 				return false;
 			}
 				
 			// 아이디의 길이가 6~12자 범위에 포함되지 않을 경우 
 			if($("#userid").val().length < 6 || $("#userid").val().length > 12) {
 				alert("아이디는 6~12자 이내로 입력해주세요.")
 				$("#userid").focus();
 				return false;
 			}
 				
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
 				
 			// 사용자 이름을 입력하지 않았을 경우 
 			if($("#userName").val()==""){
 				alert("사용자 이름을 입력해주세요.");
 				$("#userName").focus();
 				return false;
 			}
 				
 			// 사용자 이름이 10자 보다 길 경우 
 			if($("#userName").val().length > 10){
				alert("사용자 이름은 10자 이내로 입력해주세요.");
				$("#userName").focus();
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
			
			// 모두 이상 없을 경우 회원 가입 버튼 동작 
			$("#signUpForm").submit();
			/* alert("회원가입이 완료되었습니다. 로그인해주세요."); */
			
 		}); 
	}); 
 
</script>

</body>

</html>
