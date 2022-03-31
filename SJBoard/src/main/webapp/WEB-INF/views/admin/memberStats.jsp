<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp" %>

<style>
.div_left{
	width: 20%;
	float: left;
	height: 500px;
	box-sizing: border-box;
}

.div_right{
	width: 80%;
	float: right;
	height: 500px;
	box-sizing: border-box;
}

</style>
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">관리자 페이지</h3>
                </div>
            </div>
            
            <!-- div_left -->
            <div class="div_left">
	            <ul style="list-style: none; padding-left:0px;">
	            	<li class="divider"><a style="color: black;" href="/admin/main">메인</a></li>
		            <li class="divider"><a style="color: black;" href="/admin/memberList">회원 목록</a></li>
		            <li class="divider"><a style="color: black;" href="/admin/bnoStats">기간별 게시물 현황</a></li>
		            <li class="divider"><a style="color: black;" href="/admin/rnoStats">기간별 댓글 현황</a></li>
		            <li class="divider"><a style="color: black;" href="/admin/memberStats">기간별 회원 현황</a></li>
	            </ul>
            </div>
            <!-- div_left -->
            
            <!-- div_right -->
            <div class="row">
                <div class="col-lg-8">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> 기간별 회원수 현황  
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div id="morris-area-chart">
                            	<form id="bnoChartForm" action="/chart/member" method="get">
		                            <div style="display: inline-block;">
		                            	조회기간: <input type="text" id="fromDate" name="fromDate" value=""> ~ <input type="text" id="toDate" name="toDate" value="">
									</div>
									<div style="display: inline-block;">
										<button type="button" id="searchBtn">조회</button>
									</div>
										<div id="memberChart"></div>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">		
								</form>
                        	</div>
                        <!-- /.panel-body -->
                    	</div>
    				</div>
   				<!-- /.div-right -->
   				</div>
   			</div>
   		<!-- /. page-wrapper -->
   		</div>
<script type="text/javascript">

$(document).ready(function(){
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";

	//Ajax Spring Security Header
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	// datepicker 한글 설정 
	$.datepicker.setDefaults({
	    dateFormat: 'yy-mm',
	    prevText: '이전 달',
	    nextText: '다음 달',
	    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	    showMonthAfterYear: true,
	    yearSuffix: '년'
	  });
	
	// datepicker 실행 
	$(function() {
	    $("#fromDate, #toDate").datepicker({
	        dateFormat: 'yy-mm-dd' });
	}); //end datepicker
	
 	// 시작 날짜, 마지막 날짜 선택 후 조회 버튼 클릭 시 동작 
	$("#searchBtn").on("click", function(){
		
		var fromDate = $("#fromDate").val();
		var toDate = $("#toDate").val();
		
		//구글 차트 불러오기
		google.charts.load('current', {'packages':['line']});

		//주간 게시물 현황 차트를 불러온다. 
		google.charts.setOnLoadCallback(drawChart); 

		//주간 게시물 현황 차트를 그린다. 
		function drawChart() {

			  var jsonData = $.ajax({
				  url: "/chart/member?fromDate="+fromDate+"&toDate="+toDate,
				  dataType: "json",
				  async: false
			  }).responseText;
			  
			  var options = {
			    		chart: {
			    	          title: '기간별 회원 수 현황',
			    	    },
			    	    width: 800,
			    	    height: 300
			    	};
		      
		      var data = new google.visualization.DataTable(jsonData);

		      var chart = new google.charts.Line(document.getElementById('memberChart'));
		      chart.draw(data, google.charts.Line.convertOptions(options));
		      
		    }  
		
	}); //end function  
	
});

/* //구글 차트 불러오기
google.charts.load('current', {'packages':['line']});

//주간 게시물 현황 차트를 불러온다. 
google.charts.setOnLoadCallback(drawChart); 

//주간 게시물 현황 차트를 그린다. 
function drawChart() {

	  var jsonData = $.ajax({
		  url: "/chart/bno/",
		  dataType: "json",
		  async: false
	  }).responseText;
	  
	  console.log("jsonData : " + jsonData);
      
      var data = new google.visualization.DataTable(jsonData);

      var chart = new google.charts.Line(document.getElementById('bnoChart'));
      chart.draw(data, google.charts.Line.convertOptions(options));
      
      var options = {
    		chart: {
    	          title: '기간별 게시물 수 현황',
    	    },
    	    width: 800,
    	    height: 300
    	};
    }   */

/* //주간 게시물 현황 차트를 그린다. 
function drawChart() {

	  var jsonData = $.ajax({
		  url: "/chart/bno",
		  dataType: "json",
		  async: false
	  }).responseText;
	  
	  console.log("jsonData : " + jsonData);
      
      var data = new google.visualization.DataTable(jsonData);

      var chart = new google.charts.Line(document.getElementById('bnoChart'));
      chart.draw(data, google.charts.Line.convertOptions(options));
      
      var options = {
    		chart: {
    	          title: '기간별 게시물 수 현황',
    	    },
    	    width: 800,
    	    height: 300
    	};
    } */
</script>

 <%@include file="../includes/footer.jsp" %>