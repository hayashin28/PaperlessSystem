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
				<li><a href="#ConditionsProvenance"><font size="4">WB条件来歴票</font></a></li>
				<li><a href="#ExchangeHistory"><font size="4">交換来歴</font></a></li>
				<li><a href="#TemperatureRecord"><font size="4">温度記録</font></a></li>
				<li><a href="#CleaningCheckSheet"><font size="4">清掃チェックシート</font></a></li>
				<li><a href="#WiringConfirmation"><font size="4">配線確認</font></a></li>
			</ul>
			<div id="ConditionsProvenance">
				<table class="table table-hover">
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./ConditionsProvenance/WB_K&S.jsp">Ｗ／Ｂ条件履歴（Ｋ＆Ｓ系）</button></td>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./ConditionsProvenance/WB_UTC.jsp">Ｗ／Ｂ条件履歴（ＵＴＣ）</button></td>
					</tr>
				</table>
			</div>
			<div id="ExchangeHistory">
				<table class="table table-hover">
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./ExchangeHistory/WB.jsp">Ｗ／Ｂ装置　交換来歴</button></td>
					</tr>
				</table>
			</div>
			<div id="TemperatureRecord">
				<table class="table table-hover">
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./TemperatureRecord/WB_K&S.jsp">Ｋ＆Ｓ　ワイヤボンダ作業温度実測記録</button></td>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./TemperatureRecord/WB_UTC.jsp">ＵＴＣ　ワイヤボンダ作業温度実測記録</button></td>
					</tr>
				</table>
			</div>
			<div id="CleaningCheckSheet">
				<table class="table table-hover">
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./CleaningCheckSheet/WB_K&S.jsp">Ｋ＆Ｓ　ワイヤボンダ清掃チェックシート</button></td>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./CleaningCheckSheet/WB_UTC.jsp">ＵＴＣ　ワイヤボンダ清掃チェックシート</button></td>
					</tr>
				</table>
			</div>
			<div id="WiringConfirmation">
				<table class="table table-hover">
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./WiringConfirmation/NBIGSExempt.jsp">配線確認チェックシート（N-BIGS対象外品・N-BIGSのNG品配線確認）</button></td>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./WiringConfirmation/NBIGSMaxum.jsp">Maxum用　N-BIGS配線確認チェックシート</button></td>
					</tr>
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./WiringConfirmation/NBIGSMemoryItem.jsp">(メモリ品)N-BIGS配線確認チェックシート</button></td>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./WiringConfirmation/NBIGS.jsp">N-BIGS配線確認チェックシート</button></td>
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