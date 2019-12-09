<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<jsp:include page="/include/include_scriptframework.jsp"/>

	<script>
		$(document).ready( function() {
			tabify('#tabs');
		});
	</script>


	<head>
		<title>WBメニュー　<jsp:include page="/include/include_versioninfo.jsp"></jsp:include></title>
	</head>
	<body>
		<jsp:include page="/include/include_type.jsp"></jsp:include>

		<div id="tabs">
			<ul>
				<li><a href="#ErrorProductAction"><font size="4">エラー製品処置</font></a></li>
				<li><a href="#MoldReplacement"><font size="4">金型交換条件確認</font></a></li>
				<li><a href="#EvaluationChecksheet"><font size="4">品切</font></a></li>
			</ul>
			<div id="ErrorProductAction">
				<table class="table table-hover">
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./ErrorProductAction/ErrorHistory.jsp">モールド装置エラー発生時の製品処置来歴</button></td>
					</tr>
				</table>
			</div>
			<div id="MoldReplacement">
				<table class="table table-hover">
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./MoldReplacement/DieExchange.jsp">モールド金型交換条件確認結果票</button></td>
					</tr>
				</table>
			</div>
			<div id="EvaluationChecksheet">
				<table class="table table-hover">
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./EvaluationChecksheet/TypeSwitching.jsp">品種切替評価チェックシート
						</button></td>
					</tr>
				</table>
			</div>
		</div>

		<div id="footerArea" align="right">
			<h4>
				<jsp:include page="/include/include_versioninfo.jsp"/><br/>
				<jsp:include page="/include/include_corporatinfo.jsp"/>
			</h4>
		</div>
	<!-- cssフレームワーク  -->
	<jsp:include page="/include/include_bootstrap.jsp"/>
	</body>
</html>