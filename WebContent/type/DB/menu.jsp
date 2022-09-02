<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<link rel="stylesheet" href='<%=request.getContextPath() + "/css/bootstrap.css"%>' 		type="text/css">
	<link rel="stylesheet" href='<%=request.getContextPath() + "/css/bootstrap-min.css"%>' 	type="text/css">
	<link rel="stylesheet" href='<%=request.getContextPath() + "/css/commons.css"%>' 		type="text/css">
	<script src='<%=request.getContextPath() + "/js/jquery-2.2.3.js"%>'></script>
	<script src='<%=request.getContextPath() + "/js/jquery.tabs.js"%>'></script>
	<script src='<%=request.getContextPath() + "/js/bootstrap.js"%>'></script>
	<script src='<%=request.getContextPath() + "/js/common-functions.js"%>'></script>

	<script>
		$(document).ready( function() {
			tabify('#tabs');
		});
	</script>


	<head>
		<title>DBメニュー　<jsp:include page="/include/include_versioninfo.jsp"></jsp:include></title>
	</head>
	<body>
		<jsp:include page="/include/include_type.jsp"></jsp:include>

		<div id="tabs">
			<ul>
				<li><a href="#ExchangeHistory"><font size="4">交換来歴</font></a></li>
			</ul>

			<div id="ExchangeHistory">
				<table class="table table-hover">
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./ExchangeHistory/DB.jsp">DB交換来歴表</button></td>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./ExchangeHistory/ARIOS.jsp">ARIOS交換来歴表</button></td>
					</tr>
					<tr>
					</tr>
				</table>
			</div>
		</div>

		<div id="footerArea" align="right">
			<h4>
				<jsp:include page="/include/include_versioninfo.jsp"></jsp:include><br/>
				<jsp:include page="/include/include_corporatinfo.jsp"></jsp:include>
			</h4>
		</div>
	<!-- cssフレームワーク  -->
	<jsp:include page="/include/include_bootstrap.jsp"/>
	</body>
</html>