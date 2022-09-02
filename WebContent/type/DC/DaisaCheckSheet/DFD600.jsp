<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="common.DbCommonFunctions"%>
<%@page import="java.sql.Timestamp"%>
<!DOCTYPE html>


<html>

	<jsp:include page="/include/include_scriptframework.jsp"/>

	<% String tanname = System.getProperty("user.name"); %>
	<% request.setCharacterEncoding("UTF-8"); %>

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
			/* フォーカスロスト時に反応するイベントリスナー */
			$('#Wlot')	[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Wlot')},   false);
			$('#Worker')[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Worker')}, false);
			 /* バリデーション処理 */
			$('#submitBtn')[0].addEventListener('click', function(){ValidationHandler()}, false);
		});
	</script>

	<script type="text/javascript">
		var words = '';
		/* Keypressによるイベント処理 */
		var BarcodeHandler = function(e, id) {
			if (e.keyCode === 229) return false;
			if (e.charCode===13) {
				words=$("#"+id).val();
				if (words.length===0) { return false; }
				$("#"+id).val(replaceCode(toHalfWidth(words)));
				var date = moment(<%DbCommonFunctions.getServerTime();%>);
				$("#Date").val(date.format("MM月DD日"));
			}
		}
		/* Focusoutによるイベント処理 */
		var FocuslostHandler = function(e, id) {
			if (words===$("#"+id).val()) { return false; }
			words=$("#"+id).val();
			if (words.length===0) { return false; }
			$("#"+id).val(replaceCode(toHalfWidth(words)));
			var date = moment(<%DbCommonFunctions.getServerTime();%>);
			$("#Date").val(date.format("MM月DD日"));
			$("#shift").val(getShift(date));
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


	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>ダイサ(DFD600シリーズ)インチ切替チェックシート</title>
	</head>

	<body>

		<% request.setCharacterEncoding("UTF-8");%>
		<div class="block">ダイサ（ＤＦＤ６００シリーズ）インチ切替チェックシート</div>
		<jsp:include page="/include/include_pagetop.jsp"/>
		<form id="fm" action="<%=request.getContextPath()%>/TenkenListServlet" method="post">
			<input type="hidden" name="sheetnm" value="ダイサ（ＤＦＤ６００シリーズ）インチ切替チェックシート">
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
									<td rowspan=2>ロータリー<br/>アーム</td>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn_01" />
											<jsp:param name="disp"	 value="ﾛｰﾀﾘｰｱｰﾑ幅吸着ﾊﾟｯﾄﾞ" />
											<jsp:param name="txt"	 value="Item01" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">確認</span></div>
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
									<td rowspan=2>直動<br/>アーム</td>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn_03" />
											<jsp:param name="disp"	 value="直動ｱｰﾑ幅吸着ﾊﾟｯﾄﾞ" />
											<jsp:param name="txt"	 value="Item03" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">確認</span></div>
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
									<td rowspan=2>チャック<br/>テーブル<br/>クランプ<br/>サイズ</td>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn_05" />
											<jsp:param name="disp"	 value="ﾁｬｯｸﾃｰﾌﾞﾙｸﾗﾝﾌﾟｻｲｽﾞ" />
											<jsp:param name="txt"	 value="Item05" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">確認</span></div>
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
									<td rowspan=2>スピンナー<br/>テーブル</td>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn_07" />
											<jsp:param name="disp"	 value="ｽﾋﾟﾝﾅｰﾃｰﾌﾞﾙ" />
											<jsp:param name="txt"	 value="Item07" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">確認</span></div>
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
									<td rowspan=2>フレームサイズ<br/>変更データ</td>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn_09" />
											<jsp:param name="disp"	 value="ﾁｬｯｸﾃｰﾌﾞﾙ" />
											<jsp:param name="txt"	 value="Item09" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_selectionbox_required.jsp">
											<jsp:param name="btn_id"	 value="btn_10"/>
											<jsp:param name="btn_text"	 value="フレーム番号"/>
											<jsp:param name="txt_id"	 value="Item10"/>
											<jsp:param name="select_txt" value="6インチHITACHI6|8インチHITACHI5"/>
											<jsp:param name="width"	 	 value="100"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td rowspan=2>ＵＶ</td>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn_11" />
											<jsp:param name="disp"	 value="ＵＶﾏｽｸ" />
											<jsp:param name="txt"	 value="Item11" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">確認</span></div>
											<div>
												<jsp:include page="/include/include_twoswitch.jsp">
													<jsp:param name="on"	 value="on12"/>
													<jsp:param name="valon"	 value="OK"/>
													<jsp:param name="off"	 value="off12"/>
													<jsp:param name="valoff" value="NG"/>
													<jsp:param name="select" value="Item12"/>
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
							<p>２．交換する治工具のバリや破損等の異常が無いか確認し「ＯＫ」「ＮＧ」を選択する。（ＮＧ時はＴＩＡＲＡを発行し上長連絡する。）</p>
							<p>３．交換が無い治工具は入力無し。</p>
						</td>
					</tr>

				</table>
			</div>
		</form>
	</body>

	<!-- cssフレームワーク  -->
	<jsp:include page="/include/include_bootstrap.jsp"/>
</html>
