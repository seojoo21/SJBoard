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
                            <i class="fa fa-bar-chart-o fa-fw"></i> 전체 현황 (현재 시각 기준: <c:out value="${serverTime}"/>)
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div id="morris-area-chart">
                            	<b>전체 회원수</b>: <c:out value="${TotalUserNo}"/><br>
                            	<b>전체 게시물 수</b>: <c:out value="${TotalBnoNo}"/><br>
                           		<b>전체 댓글 수</b>: <c:out value="${TotalRnoNo}"/><br>
                            </div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
    			</div>
    			
    			<div class="row">
                <div class="col-lg-8">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> 주간 현황 (오늘 날짜 기준: <c:out value="${today }"/> )
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div id="morris-area-chart">
                            	<div id="weeklyBnoChart">
                            	</div>
                            	<div>
                            		<table class="table table-striped table-bordered table-hover">
                            			<thead>
                            				<tr>
                            					<td>분류</td>
	                            				<td>월요일</td>
	                            				<td>화요일</td>
	                            				<td>수요일</td>
	                            				<td>목요일</td>
	                            				<td>금요일</td>
	                            				<td>토요일</td>
	                            				<td>일요일</td>
                            				</tr>
                            			</thead>
                            			<tbody>
			                            	<c:forEach items="${lastWeekBnoList }" var="lastWeekBnoList">
				                            	<tr>
				                            		<td>지난주</td>
				                            		<td><c:out value="${lastWeekBnoList.monday }"/></td>
				                            		<td><c:out value="${lastWeekBnoList.tuesday }"/></td>
				                            		<td><c:out value="${lastWeekBnoList.wednesday }"/></td>
				                            		<td><c:out value="${lastWeekBnoList.thursday }"/></td>
				                            		<td><c:out value="${lastWeekBnoList.friday }"/></td>
				                            		<td><c:out value="${lastWeekBnoList.saturday }"/></td>
				                            		<td><c:out value="${lastWeekBnoList.sunday }"/></td>
				                            	</tr>
			                            	</c:forEach>
			                            	<c:forEach items="${thisWeekBnoList }" var="thisWeekBnoList">
			                            		<tr>
			                            			<td>이번주</td>
			                            			<td><c:out value="${thisWeekBnoList.monday }"/></td>
			                            			<td><c:out value="${thisWeekBnoList.tuesday }"/></td>
			                            			<td><c:out value="${thisWeekBnoList.wednesday }"/></td>
			                            			<td><c:out value="${thisWeekBnoList.thursday }"/></td>
			                            			<td><c:out value="${thisWeekBnoList.friday }"/></td>
			                            			<td><c:out value="${thisWeekBnoList.saturday }"/></td>
			                            			<td><c:out value="${thisWeekBnoList.sunday }"/></td>
			                            		</tr>
			                            	</c:forEach>
                            			</tbody>
                            		</table>
                            	
                            	<div id="weeklyRnoChart">
                            	</div>
                            	<div>
                            		<table class="table table-striped table-bordered table-hover">
                            			<thead>
                            				<tr>
                            					<td>분류</td>
	                            				<td>월요일</td>
	                            				<td>화요일</td>
	                            				<td>수요일</td>
	                            				<td>목요일</td>
	                            				<td>금요일</td>
	                            				<td>토요일</td>
	                            				<td>일요일</td>
                            				</tr>
                            			</thead>
                            			<tbody>
			                            	<c:forEach items="${lastWeekRnoList }" var="lastWeekRnoList">
				                            	<tr>
				                            		<td>지난주</td>
				                            		<td><c:out value="${lastWeekRnoList.monday }"/></td>
				                            		<td><c:out value="${lastWeekRnoList.tuesday }"/></td>
				                            		<td><c:out value="${lastWeekRnoList.wednesday }"/></td>
				                            		<td><c:out value="${lastWeekRnoList.thursday }"/></td>
				                            		<td><c:out value="${lastWeekRnoList.friday }"/></td>
				                            		<td><c:out value="${lastWeekRnoList.saturday }"/></td>
				                            		<td><c:out value="${lastWeekRnoList.sunday }"/></td>
				                            	</tr>
			                            	</c:forEach>
			                            	<c:forEach items="${thisWeekRnoList }" var="thisWeekRnoList">
			                            		<tr>
			                            			<td>이번주</td>
			                            			<td><c:out value="${thisWeekRnoList.monday }"/></td>
			                            			<td><c:out value="${thisWeekRnoList.tuesday }"/></td>
			                            			<td><c:out value="${thisWeekRnoList.wednesday }"/></td>
			                            			<td><c:out value="${thisWeekRnoList.thursday }"/></td>
			                            			<td><c:out value="${thisWeekRnoList.friday }"/></td>
			                            			<td><c:out value="${thisWeekRnoList.saturday }"/></td>
			                            			<td><c:out value="${thisWeekRnoList.sunday }"/></td>
			                            		</tr>
			                            	</c:forEach>
                            			</tbody>
                            		</table>
                            	</div>
                     		
                            	<div id="weeklyNewMemberChart">
                            	</div>
                            	<div>
                            		<table class="table table-striped table-bordered table-hover">
                            			<thead>
                            				<tr>
                            					<td>분류</td>
	                            				<td>월요일</td>
	                            				<td>화요일</td>
	                            				<td>수요일</td>
	                            				<td>목요일</td>
	                            				<td>금요일</td>
	                            				<td>토요일</td>
	                            				<td>일요일</td>
                            				</tr>
                            			</thead>
                            			<tbody>
			                            	<c:forEach items="${lastWeekNewMemberList }" var="lastWeekNewMemberList">
				                            	<tr>
				                            		<td>지난주</td>
				                            		<td><c:out value="${lastWeekNewMemberList.monday }"/></td>
				                            		<td><c:out value="${lastWeekNewMemberList.tuesday }"/></td>
				                            		<td><c:out value="${lastWeekNewMemberList.wednesday }"/></td>
				                            		<td><c:out value="${lastWeekNewMemberList.thursday }"/></td>
				                            		<td><c:out value="${lastWeekNewMemberList.friday }"/></td>
				                            		<td><c:out value="${lastWeekNewMemberList.saturday }"/></td>
				                            		<td><c:out value="${lastWeekNewMemberList.sunday }"/></td>
				                            	</tr>
			                            	</c:forEach>
			                            	<c:forEach items="${thisWeekNewMemberList }" var="thisWeekNewMemberList">
			                            		<tr>
			                            			<td>이번주</td>
			                            			<td><c:out value="${thisWeekNewMemberList.monday }"/></td>
			                            			<td><c:out value="${thisWeekNewMemberList.tuesday }"/></td>
			                            			<td><c:out value="${thisWeekNewMemberList.wednesday }"/></td>
			                            			<td><c:out value="${thisWeekNewMemberList.thursday }"/></td>
			                            			<td><c:out value="${thisWeekNewMemberList.friday }"/></td>
			                            			<td><c:out value="${thisWeekNewMemberList.saturday }"/></td>
			                            			<td><c:out value="${thisWeekNewMemberList.sunday }"/></td>
			                            		</tr>
			                            	</c:forEach>
                            			</tbody>
                            		</table>
                            	</div>
                            </div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
    			</div>
    		</div>	
    	</div>		
   		<!-- /.div-right -->
   	</div>
 </div>
<script type="text/javascript">

// 주간 게시물 현황 변수 
var bnoLast1= Number('<c:out value="${lastWeekBnoList[0].monday}"/>');
var bnoLast2= Number('<c:out value="${lastWeekBnoList[0].tuesday}"/>');
var bnoLast3= Number('<c:out value="${lastWeekBnoList[0].wednesday}"/>');
var bnoLast4= Number('<c:out value="${lastWeekBnoList[0].thursday}"/>');
var bnoLast5= Number('<c:out value="${lastWeekBnoList[0].friday}"/>');
var bnoLast6= Number('<c:out value="${lastWeekBnoList[0].saturday}"/>');
var bnoLast7= Number('<c:out value="${lastWeekBnoList[0].sunday}"/>');

var bnoThis1= Number('<c:out value="${thisWeekBnoList[0].monday}"/>');
var bnoThis2= Number('<c:out value="${thisWeekBnoList[0].tuesday}"/>');
var bnoThis3= Number('<c:out value="${thisWeekBnoList[0].wednesday}"/>');
var bnoThis4= Number('<c:out value="${thisWeekBnoList[0].thursday}"/>');
var bnoThis5= Number('<c:out value="${thisWeekBnoList[0].friday}"/>');
var bnoThis6= Number('<c:out value="${thisWeekBnoList[0].saturday}"/>');
var bnoThis7= Number('<c:out value="${thisWeekBnoList[0].sunday}"/>');

// 주간 댓글 현황 변수 
var rnoLast1= Number('<c:out value="${lastWeekRnoList[0].monday}"/>');
var rnoLast2= Number('<c:out value="${lastWeekRnoList[0].tuesday}"/>');
var rnoLast3= Number('<c:out value="${lastWeekRnoList[0].wednesday}"/>');
var rnoLast4= Number('<c:out value="${lastWeekRnoList[0].thursday}"/>');
var rnoLast5= Number('<c:out value="${lastWeekRnoList[0].friday}"/>');
var rnoLast6= Number('<c:out value="${lastWeekRnoList[0].saturday}"/>');
var rnoLast7= Number('<c:out value="${lastWeekRnoList[0].sunday}"/>');

var rnoThis1= Number('<c:out value="${thisWeekRnoList[0].monday}"/>');
var rnoThis2= Number('<c:out value="${thisWeekRnoList[0].tuesday}"/>');
var rnoThis3= Number('<c:out value="${thisWeekRnoList[0].wednesday}"/>');
var rnoThis4= Number('<c:out value="${thisWeekRnoList[0].thursday}"/>');
var rnoThis5= Number('<c:out value="${thisWeekRnoList[0].friday}"/>');
var rnoThis6= Number('<c:out value="${thisWeekRnoList[0].saturday}"/>');
var rnoThis7= Number('<c:out value="${thisWeekRnoList[0].sunday}"/>');

//주간 신규 회원 현황 변수 
var nmLast1= Number('<c:out value="${lastWeekNewMemberList[0].monday}"/>');
var nmLast2= Number('<c:out value="${lastWeekNewMemberRnoList[0].tuesday}"/>');
var nmLast3= Number('<c:out value="${lastWeekNewMemberList[0].wednesday}"/>');
var nmLast4= Number('<c:out value="${lastWeekNewMemberListt[0].thursday}"/>');
var nmLast5= Number('<c:out value="${lastWeekNewMemberList[0].friday}"/>');
var nmLast6= Number('<c:out value="${lastWeekNewMemberList[0].saturday}"/>');
var nmLast7= Number('<c:out value="${lastWeekNewMemberList[0].sunday}"/>');

var nmThis1= Number('<c:out value="${thisWeekNewMemberList[0].monday}"/>');
var nmThis2= Number('<c:out value="${thisWeekNewMemberList[0].tuesday}"/>');
var nmThis3= Number('<c:out value="${thisWeekNewMemberList[0].wednesday}"/>');
var nmThis4= Number('<c:out value="${thisWeekNewMemberList[0].thursday}"/>');
var nmThis5= Number('<c:out value="${thisWeekNewMemberList[0].friday}"/>');
var nmThis6= Number('<c:out value="${thisWeekNewMemberList[0].saturday}"/>');
var nmThis7= Number('<c:out value="${thisWeekNewMemberList[0].sunday}"/>');

// 구글 차트 불러오기 
google.charts.load('current', {'packages':['line']});
      
// 주간 게시물 현황 차트를 불러온다. 
google.charts.setOnLoadCallback(drawBnoChart); 
      
// 주간 댓글 현황 차트를 불러온다.
google.charts.setOnLoadCallback(drawRnoChart); 
      
// 주간 신규 회원 현황 차트를 불러온다.
google.charts.setOnLoadCallback(drawNewMemberChart); 

// 주간 게시물 현황 차트를 그린다. 
function drawBnoChart() {

	  var data = new google.visualization.DataTable();
      data.addColumn('string', '요일');
      data.addColumn('number', '지난주');
      data.addColumn('number', '이번주');

      data.addRows([
        ['월',  bnoLast1, bnoThis1],
        ['화',  bnoLast2, bnoThis2],
        ['수',  bnoLast3, bnoThis3],
        ['목',  bnoLast4, bnoThis4],
        ['금',  bnoLast5, bnoThis5],
        ['토',  bnoLast6, bnoThis6],
        ['일',  bnoLast7, bnoThis7],
      ]);

      var options = {
        chart: {
          title: '주간 신규 게시물 수',
        },
        width: 800,
        height: 300
      };

      var chart = new google.charts.Line(document.getElementById('weeklyBnoChart'));
      chart.draw(data, google.charts.Line.convertOptions(options));
    }

//주간 댓글 현황 차트를 그린다. 
function drawRnoChart() {

        var data = new google.visualization.DataTable();
        data.addColumn('string', '요일');
        data.addColumn('number', '지난주');
        data.addColumn('number', '이번주');

        data.addRows([
          ['월',  rnoLast1, rnoThis1],
          ['화',  rnoLast2, rnoThis2],
          ['수',  rnoLast3, rnoThis3],
          ['목',  rnoLast4, rnoThis4],
          ['금',  rnoLast5, rnoThis5],
          ['토',  rnoLast6, rnoThis6],
          ['일',  rnoLast7, rnoThis7],
        ]);

        var options = {
          chart: {
            title: '주간 신규 댓글 수',
          },
          width: 800,
          height: 300
        };

        var chart = new google.charts.Line(document.getElementById('weeklyRnoChart'));
        chart.draw(data, google.charts.Line.convertOptions(options));
      }
      
 //주간 신규 회원 현황 차트를 그린다. 
 function drawNewMemberChart() {

        var data = new google.visualization.DataTable();
        data.addColumn('string', '요일');
        data.addColumn('number', '지난주');
        data.addColumn('number', '이번주');

        data.addRows([
          ['월',  nmLast1, nmThis1],
          ['화',  nmLast2, nmThis2],
          ['수',  nmLast3, nmThis3],
          ['목',  nmLast4, nmThis4],
          ['금',  nmLast5, nmThis5],
          ['토',  nmLast6, nmThis6],
          ['일',  nmLast7, nmThis7],
        ]);

        var options = {
          chart: {
            title: '주간 신규 회원 수',
          },
          width: 800,
          height: 300
        };

        var chart = new google.charts.Line(document.getElementById('weeklyNewMemberChart'));
        chart.draw(data, google.charts.Line.convertOptions(options));
      }

</script>


 <%@include file="../includes/footer.jsp" %>