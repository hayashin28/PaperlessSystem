<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="common.DbCommonFunctions"%>
<%@page import="java.sql.Timestamp"%>
<!DOCTYPE html>


<html>

	<jsp:include page="/include/include_scriptframework.jsp"/>

	<!-- Script宣言部 -->
	<script type="text/javascript">
		$(document).ready(function() {
			/* アラートを非表示にする */
			$("#alert_chkbox").hide();
			/**
			 * イベントリスナーの登録
			 */
			/* バーコード読取り時に反応するイベントリスナー */
			$('#Wlot')	[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Wlot')},   false);
			$('#Worker')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Worker')}, false);
			 /* バリデーション処理 */
			$('#submitBtn')[0].addEventListener('click', function(){ValidationHandler()}, false);
		});
	</script>

	<script type="text/javascript">
		var words = '';
		var BarcodeHandler = function(e, id) {
			if (e.charCode===13) {
				if (words.length===0) { return false; }
				$("#"+id).val(replaceCode(toHalfWidth(words)));
				words = '';
				<%Timestamp time = DbCommonFunctions.getServerTime();%>
				var date = moment("<%=time%>");
				$("#Date").val(date.format("MM月DD日"));
			}
			if (e.charCode!=13) {
				var key = String.fromCharCode(e.charCode);
				words+=key;
			}
		}
	</script>

	<script type="text/javascript">
		$(window).load(function() {});
	</script>

	<script type="text/javascript">
		/**
		 * HTMLではForm内にテキスト一行入力系のフィールドが一つだった場合、
		 * そこでEnterキーを押すとSubmitされる仕様になっている。
		 * デフォルトでこの挙動を解除する。
		 */
		$(document).on("keypress", "input:not(.allow_submit)", function(event) {
			return event.which !== 13;
		});
	</script>

	<script type="text/javascript">
		/* 保存前のバリデーション処理を行う */
		var ValidationHandler = function() {
			submit();
		}
	</script>

	<script type="text/javascript">
		var submit = function() {
			/* バリデーションプラグインの登録  */
			$('#fm').validationEngine();
			/*  */
			$('#params').val(getSerializableData(document.getElementById("fm")));
			/* サーブレットの呼出しを行う */
			$("#fm").submit();
		}
	</script>
	<!-- Script宣言部ここまで -->


	<% String tanname = System.getProperty("user.name"); %>
	<% request.setCharacterEncoding("UTF-8"); %>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>治工具交換チェックシートATM-8100X</title>
	</head>

	<body>

		<% request.setCharacterEncoding("UTF-8");%>
		<div class="block">治工具交換チェックシートＡＴＭ－８１００Ｘ</div>
		<jsp:include page="/include/include_pagetop.jsp"/>
		<form id="fm" action="<%=request.getContextPath()%>/TenkenListServlet" method="post">
			<input type="hidden" name="sheetnm" value="治工具交換チェックシートＡＴＭ－８１００Ｘ">
			<input type="hidden" name="tanname" value="<%=tanname%>">
			<input type="hidden" name="params" id="params" value="">

			<div class="bs-example table-responsive">
				<table class="table table-hover">
					<tr>
						<td colspan=2>
							<div class="boxContainer">
								<div class="right"><jsp:include page="/include/include_button.jsp"/></div>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan=2><jsp:include page="/include/include_waferlotdata.jsp"/></td>
					</tr>

					<tr>
						<td>
							<table>
								<tr>
									<td rowspan=2>チャンバー<br/>テーブル</td>
									<td>
										<jsp:include page="/include/include_selectionbox_required.jsp">
											<jsp:param name="btn_id"	 value="btn01" />
											<jsp:param name="btn_text"	 value="交換テーブル" />
											<jsp:param name="txt_id"	 value="Item01" />
											<jsp:param name="select_txt" value="中空テーブル5インチ|中空テーブル6インチ|中空テーブル8インチ|表面吸着テーブル5インチ|表面吸着テーブル6インチ|表面吸着テーブル8インチ" />
											<jsp:param name="width"	 	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">テーブル確認</span></div>
											<div>
												<jsp:include page="/include/include_twoswitch.jsp">
													<jsp:param name="on"	 value="on02"/>
													<jsp:param name="valon"	 value="OK"/>
													<jsp:param name="off"	 value="off02"/>
													<jsp:param name="valoff" value="NG"/>
													<jsp:param name="select" value="Item02"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td rowspan=2>貼付<br/>テーブル</td>
									<td>
										<jsp:include page="/include/include_selectionbox_required.jsp">
											<jsp:param name="btn_id"	 value="btn03" />
											<jsp:param name="btn_text"	 value="交換テーブル" />
											<jsp:param name="txt_id"	 value="Item03" />
											<jsp:param name="select_txt" value="6インチ|8インチ" />
											<jsp:param name="width"	 	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">テーブル確認</span></div>
											<div>
												<jsp:include page="/include/include_twoswitch.jsp">
													<jsp:param name="on"	 value="on04"/>
													<jsp:param name="valon"	 value="OK"/>
													<jsp:param name="off"	 value="off04"/>
													<jsp:param name="valoff" value="NG"/>
													<jsp:param name="select" value="Item04"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td rowspan=2>同時貼<br/>テーブル</td>
									<td>
										<jsp:include page="/include/include_selectionbox_required.jsp">
											<jsp:param name="btn_id"	 value="btn05" />
											<jsp:param name="btn_text"	 value="交換テーブル" />
											<jsp:param name="txt_id"	 value="Item05" />
											<jsp:param name="select_txt" value="DAF貼付ﾃｰﾌﾞﾙ6ｲﾝﾁOF|DAF貼付ﾃｰﾌﾞﾙ8ｲﾝﾁOF|DAF貼付ﾃｰﾌﾞﾙ8ｲﾝﾁV" />
											<jsp:param name="width"	 	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">テーブル確認</span></div>
											<div>
												<jsp:include page="/include/include_twoswitch.jsp">
													<jsp:param name="on"	 value="on06"/>
													<jsp:param name="valon"	 value="OK"/>
													<jsp:param name="off"	 value="off06"/>
													<jsp:param name="valoff" value="NG"/>
													<jsp:param name="select" value="Item06"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</td>

						<td>
							<table>
								<tr>
									<td rowspan=2>ウエハ<br/>搬送アーム</td>
									<td>
										<jsp:include page="/include/include_selectionbox_required.jsp">
											<jsp:param name="btn_id"	 value="btn07" />
											<jsp:param name="btn_text"	 value="交換テーブル" />
											<jsp:param name="txt_id"	 value="Item07" />
											<jsp:param name="select_txt" value="ｵｰﾌﾟﾝﾊﾝﾄﾞ|ﾌﾟﾛﾄｽｱｰﾑ6ｲﾝﾁ|ﾌﾟﾛﾄｽｱｰﾑ8ｲﾝﾁ" />
											<jsp:param name="width"	 	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">テーブル確認</span></div>
											<div>
												<jsp:include page="/include/include_twoswitch.jsp">
													<jsp:param name="on"	 value="on08"/>
													<jsp:param name="valon"	 value="OK"/>
													<jsp:param name="off"	 value="off08"/>
													<jsp:param name="valoff" value="NG"/>
													<jsp:param name="select" value="Item08"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td rowspan=2>キャリア<br/>ステージ</td>
									<td>
										<jsp:include page="/include/include_selectionbox_required.jsp">
											<jsp:param name="btn_id"	 value="btn09" />
											<jsp:param name="btn_text"	 value="交換テーブル" />
											<jsp:param name="txt_id"	 value="Item09" />
											<jsp:param name="select_txt" value="オープン|プロトス" />
											<jsp:param name="width"	 	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">テーブル確認</span></div>
											<div>
												<jsp:include page="/include/include_twoswitch.jsp">
													<jsp:param name="on"	 value="on10"/>
													<jsp:param name="valon"	 value="OK"/>
													<jsp:param name="off"	 value="off10"/>
													<jsp:param name="valoff" value="NG"/>
													<jsp:param name="select" value="Item10"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td>セルフ<br/>チェック</td>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">テーブル確認</span></div>
											<div>
												<jsp:include page="/include/include_twoswitch.jsp">
													<jsp:param name="on"	 value="on11"/>
													<jsp:param name="valon"	 value="OK"/>
													<jsp:param name="off"	 value="off11"/>
													<jsp:param name="valoff" value="NG"/>
													<jsp:param name="select" value="Item11"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>

					<tr>
						<td colspan=2 align="left">
							<p>１．交換する治工具を選択する。</p>
							<p>２．交換する治工具のバリや破損が無いか確認し「ＯＫ」か「ＮＧ」を選択する。（ＮＧ時はＴＩＡＲＡを発行し上長連絡する。）</p>
							<p>３．交換が無い治工具は入力無し。</p>
							<p>４．セルフチェックは先頭ウエハで供給停止をし、貼付後ウエハで表面のワレ、気泡、異物、シミ、キズ、等が無い事を確認し。</p>
							<p>　　「ＯＫ」か「ＮＧ」を選択する。「ＯＫ」の時は連続着工開始。「ＮＧ」の時はＴＩＡＲＡ：ＡＢＩＲＥＸを発行し上長に連絡する。</p>
						</td>
					</tr>

				</table>
			</div>
		</form>
	</body>

	<!-- cssフレームワーク  -->
	<jsp:include page="/include/include_bootstrap.jsp"/>
</html>
