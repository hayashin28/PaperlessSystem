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
		<title>DCメニュー　<jsp:include page="/include/include_versioninfo.jsp"></jsp:include></title>
	</head>
	<body>
		<jsp:include page="/include/include_type.jsp"></jsp:include>
		<div id="tabs">
			<ul>
				<li><a href="#ErrorHistory"><font size="4">エラー来歴</font></a></li>
				<li><a href="#MounterExchangeHistory"><font size="4">マウンタ交換来歴</font></a></li>
				<li><a href="#DicerSelfCheck"><font size="4">ダイサセルフチェック</font></a></li>
				<li><a href="#DaisaCheckSheet"><font size="4">ダイサチェックシート</font></a></li>
				<li><a href="#CleaningOfMounter"><font size="4">マウンタ清掃チェックシート</font></a></li>
				<li><a href="#DicerCleaning"><font size="4">ダイサ清掃チェックシート</font></a></li>
				<li><a href="#JigCleaning"><font size="4">治具詰清掃チェックシート</font></a></li>
				<li><a href="#AppearanceInspectionMachineCleaning"><font size="4">外観検査機清掃チェックシート</font></a></li>
			</ul>

			<div id="ErrorHistory">
				<table class="table table-hover">
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./ErrorHistory/ATM-8100X.jsp">全自動マウンタATM-8100X</button></td>
					</tr>
					<tr>
					</tr>
				</table>
			</div>

			<div id="MounterExchangeHistory">
				<table class="table table-hover">
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./MounterExchangeHistory/ATM-8100X.jsp">治工具交換チェックシートATM-8100X</button></td>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./MounterExchangeHistory/TapeExchange.jsp">テープ交換チェックシート</button></td>
					</tr>
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./MounterExchangeHistory/DAF.jsp">ＤＡＦ・ＢＧテープ切替チェックシート</button></td>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./MounterExchangeHistory/WaferAdsorption.jsp">ｳｴﾊ吸着ﾃｰﾌﾞﾙ/ｱﾗｲﾅﾌﾞﾙ交換来歴ﾁｪｯｸｼｰﾄ</button></td>
					</tr>
					<tr>
					</tr>
				</table>
			</div>

			<div id="DicerSelfCheck">
				<table class="table table-hover">
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./DicerSelfCheck/BevelCut.jsp">べベルカット　セルフチェックシート</button></td>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./DicerSelfCheck/DENSO.jsp">ダイサセルフチェックシート（デンソー移管品／ＥＨＶ品）</button></td>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./DicerSelfCheck/Dicer.jsp">ダイサセルフチェックシート</button></td>
					</tr>
				</table>
			</div>
			<div id="DaisaCheckSheet">
				<table class="table table-hover">
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./DaisaCheckSheet/DFD600.jsp">ダイサ（ＤＦＤ６００シリーズ）インチ切替チェックシート</button></td>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./DaisaCheckSheet/DFD6000.jsp">ダイサ（ＤＦＤ６０００シリーズ）インチ切替チェックシート</button></td>
					</tr>
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./DaisaCheckSheet/PRECUTBOARD.jsp">ＰＲＥＣＵＴ　ＢＯＡＲＤチェックシート</button></td>
					</tr>
				</table>
			</div>
			<div id="CleaningOfMounter">
				<table class="table table-hover">
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./CleaningOfMounter/MA3000II.jsp">ウエハマウンタ清掃チェックシート ＭＡ３０００Ⅱ</button></td>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./CleaningOfMounter/ATM-8100X.jsp">ウエハマウンタ清掃チェックシート ＡＴＭ－８１００Ｘ</button></td>
					</tr>
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./CleaningOfMounter/DFM2800.jsp">ウエハマウンタ清掃チェックシート ＤＦＭ２８００</button></td>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./CleaningOfMounter/FM-903S.jsp">半自動マウンタ清掃チェックシート ＦＭ－９０３Ｓ</button></td>
					</tr>
				</table>
			</div>
			<div id="DicerCleaning">
				<table class="table table-hover">
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./DicerCleaning/DFD-650.jsp">ダイサー清掃チェックシート（ＤＦＤ－６５０／６５１）</button></td>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./DicerCleaning/DFD-6350.jsp">ダイサー清掃チェックシート（ＤＦＤ－６３５０／６３４０／６３６１）</button></td>
					</tr>
				</table>
			</div>
			<div id="JigCleaning">
				<table class="table table-hover">
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./JigCleaning/DFD-250I.jsp">全自動治具詰清掃チェックシート（ＤＰＳ－２５０）①</button></td>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./JigCleaning/DFD-250II.jsp">全自動治具詰清掃チェックシート（ＤＰＳ－２５０）②</button></td>
					</tr>
				</table>
			</div>
			<div id="AppearanceInspectionMachineCleaning">
				<table class="table table-hover">
					<tr>
						<td><button type="button" onClick="location.href=value;" class="btn btn-primary btn-lg btn-block" value="./AppearanceInspectionMachineCleaning/LI900W.jsp">自動外観検査機清掃チェックシート（ＬＩ９００Ｗ）</button></td>
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