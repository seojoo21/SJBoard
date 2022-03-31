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
                    <h3 class="page-header">게시판</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <!-- 게시판 레이아웃 시작 -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                       		     <form role="form" id="newContent" action="/sjboard/register" method="post">
                       		     	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
                                        <div class="form-group">
                                            <label>제목</label>
                                            <input class="form-control" id="title" name="title" value="" placeholder="제목을 입력하세요.(필수)">
                                        </div>
                                        <div class="form-group">
                                            <label>작성자</label>
                                            <input class="form-control" name="writer" value='<sec:authentication property="principal.member.userName"/>' readonly="readonly">
                                        </div>
                                         <div class="form-group">
                                         	<!-- 작성자ID -->
                                            <input class="form-control" type="hidden" name="userid" value='<sec:authentication property="principal.username"/>' readonly="readonly">
                                        </div>
                                       	<div class="form-group">
                                            <label>내용</label>
		                                    <textarea class="form-control" id="summernote" name="content" style="resize: none;"></textarea>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>파일첨부</label>
                                            <input type="file" name="uploadFile" multiple>
                                        </div>
                                        
                                        <div class="uploadResult">
											<ul>
											
											</ul>
										</div>
                                        
                                        <div style="margin-top: 10px;">
                                        <button type="button" id="submitBtn" class="btn btn-primary" >게시물 등록</button>
                                        <button type="reset" class="btn btn-warning">초기화</button>
                                        </div>
                                 </form>
                                 
                            <!-- /.table-responsive -->
                         </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

<script type="text/javascript">
        
$(document).ready(function(e){
	
	//게시물 등록 버튼 클릭 시 
	$("#submitBtn").on("click", function(){
		if($("#title").val() == "" ) {
			alert("제목을 입력해주세요.")
			$("#title").focus();
			return false;
		}
		if($("#summernote").val() == "" ) {
			alert("내용을 입력해주세요.")
			$("#summernote").focus();
			return false;
		}
		$("#newContent").submit();
	});
	
	// summernote 
	$("#summernote").summernote({
		height: 0,
		minHeight: null,
		maxHeight: null,
		focus: true,
		lang: "ko-KR",
		placeholder: "서로에게 상처주지 않는 바른말 고운말을 사용합시다.",
		toolbar: [
			    // [groupName, [list of button]]
			    ['fontname', ['fontname']],
			    ['fontsize', ['fontsize']],
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    ['color', ['forecolor','color']],
			    ['table', ['table']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			    ['insert',['picture','link','video']],
			    ['view', ['fullscreen', 'help']]
			  ],
			fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
	}); 
	
	var formObj = $("form[role='form']");
	
	// 첨부파일 목록을 가져온다. 
	$("button[type='submit']").on("click", function(e){
		e.preventDefault();
		console.log("submit clicked");
		var str="";
		
		$(".uploadResult ul li").each(function(i, obj){
			var jobj = $(obj);
			console.dir(jobj);
			
			str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" +  jobj.data("filename")+ "'>";
			str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" +  jobj.data("uuid")+ "'>";
			str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" +  jobj.data("path")+ "'>";
			str += "<input type='hidden' name='attachList[" + i + "].fileType' value='" +  jobj.data("type")+ "'>";
		});
		
		formObj.append(str).submit();
	});
	
	// 파일 확장자 exe.sh.zip.alz 업로드 금지 
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	
	// 파일 당 최대 용량 5MB로 지정 
	var maxSize = 5242880;
	
	// 파일 확장자와 용량 확인  
	function checkExtension(fileName, fileSize){
		if (fileSize > maxSize) {
			alert("파일 당 용량은 최대 5MB까지만 가능합니다.")
			return false;
		}
		if (regex.test(fileName)) {
			alert("해당 종류의 파일은 첨부할 수 없습니다.(.exe, .sh, .zip, .alz 첨부 불가)")
			return false;
		}
		return true;
	}
	
	// 사용자가 첨부파일을 골라서 올리면 파일 업로드 작업을 한다. 
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$("input[type='file']").change(function(e){
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		
		for(var i=0; i<files.length; i++) {
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		
	// 업로드된 결과를 화면에 섬네일 등을 만들어서 처리한다.
	function showUploadResult(uploadResultArr){
		if(!uploadResultArr || uploadResultArr.length == 0){ return; }
		var uploadUL = $(".uploadResult ul");
		var str = "";
		
		$(uploadResultArr).each(function(i, obj){
			// 이미지 파일인 경우 
			if(obj.image){
				
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName );
				
				str += "<li data-path='"+ obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName+ "' data-type='"+ obj.image+ "'><div>";
				str += "<span>" + obj.fileName + "</span>";
				str += "<button type='button' data-file=\'"+ fileCallPath+ "\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/display?fileName=" + fileCallPath + "'>";
				str += "</div></li>";
				
			// 일반 파일인 경우 
			}else {
				
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName );
				var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				
				str += "<li data-path='"+ obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName+ "' data-type='"+ obj.image+ "'><div>";
				str += "<span>" + obj.fileName + "</span>";
				str += "<button type='button' data-file=\'"+ fileCallPath+ "\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/resources/img/attach.png'></a>";
				str += "</div></li>";
			}
		});
		
		uploadUL.append(str);
		
	}
		
		//파일 업로드 작업 비동기 ajax 처리 
		$.ajax({
			url:'/uploadAjaxAction',
			processData: false,
			contentType: false, 
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data:formData, // 서버에 보내는 데이터 
			type: 'POST',
			dataType: 'json', // 서버에서 받아올 데이터 
			success: function(result){
				console.log(result);
				showUploadResult(result); // 파일 업로드 결과를 처리해주는 함수 
			}
			
		});
	});
	
	// 원하지 않는 첨부파일 삭제 
	$(".uploadResult"). on("click", "button", function(e){
		
		console.log("delete file");
		
		var targetFile = $(this).data("file");
		  var type = $(this).data("type");
		  var targetLi = $(this).closest("li");
		  
		  console.log(targetFile);
		  
		  $.ajax({
		    url: '/deleteFile',
		    data: {fileName: targetFile, type:type},
		    dataType:'text',
		    beforeSend: function(xhr){
		    	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		    },
		    type: 'POST',
		    success: function(result){
		         targetLi.remove();
		     }
		  }); //$.ajax
	});

	
});

</script>

 <%@include file="../includes/footer.jsp" %>