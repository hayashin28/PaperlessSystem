<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<jsp:include page="./include/include_scriptframework.jsp"/>

	<head>
		<title>メインメニュー　<jsp:include page="./include/include_versioninfo.jsp"></jsp:include></title>
	</head>
	<body>
		<jsp:include page="./include/include_type.jsp"></jsp:include>
		<div id="footerArea" align="right">
			<h4>
				<jsp:include page="./include/include_versioninfo.jsp"></jsp:include><br/>
				<jsp:include page="./include/include_corporatinfo.jsp"></jsp:include>
			</h4>
		</div>
	<!-- cssフレームワーク  -->
	<jsp:include page="./include/include_bootstrap.jsp"/>
	</body>
</html>