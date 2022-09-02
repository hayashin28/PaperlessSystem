<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.lang.WordUtils"%>
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
			/* セッション内の設備No.を取得 */
			$("#Setubi").val("${setuB}");
			/**
			 * イベントリスナーの登録
			 */
			/* バーコード読取り時に反応するイベントリスナー */
			$('#Setubi')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Setubi')}, false);
			$('#Worker')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Worker')}, false);
			/* フォーカスロスト時に反応するイベントリスナー */
			$('#Setubi')[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Setubi')}, false);
			$('#Worker')[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Worker')}, false);
			 /* バリデーション処理 */
			$('#submitBtn')[0].addEventListener('click', function(){ValidationHandler()}, false);
		});
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
			/*  */
			$(':hidden[name="Setubi"]').val($('#Setubi').val());
			/* サーブレットの呼出しを行う */
			$("#fm").submit();
		}
	</script>
	<!-- Script宣言部ここまで -->


	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>ダイサー清掃チェックシート（ＤＦＤ－６３５０／６３４０／６３６１）</title>
	</head>

	<body>
		<% request.setCharacterEncoding("UTF-8");%>
		<div class="block">ダイサー清掃チェックシート（ＤＦＤ－６３５０／６３４０／６３６１）</div>
		<jsp:include page="/include/include_pagetop.jsp"/>
		<form id="fm" action="<%=request.getContextPath()%>/TenkenListServlet" method="post">
			<input type="hidden" name="sheetnm" value="ダイサー清掃チェックシート（ＤＦＤ－６３５０／６３４０／６３６１）">
			<input type="hidden" name="tanname" value="<%=tanname%>">
			<input type="hidden" name="Setubi"  value="">
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
						<td colspan=2><jsp:include page="/include/include_worker.jsp"/></td>
					</tr>

					<tr>
						<td colspan=2>
							<div class="boxContainer">
								<div>
									<jsp:include page="/include/include_selectionbox_required.jsp">
										<jsp:param name="btn_id"	 value="btn_shift"/>
										<jsp:param name="btn_text"	 value="清掃日 1回/日 シフト"/>
										<jsp:param name="txt_id"	 value="Shift"/>
										<jsp:param name="select_txt" value="早|遅|夜"/>
										<jsp:param name="width"	 	 value="100"/>
									</jsp:include>
								</div>
								<div>
									<jsp:include page="/include/include_selectionbox_required.jsp">
										<jsp:param name="btn_id"	 value="btn_week"/>
										<jsp:param name="btn_text"	 value="1回/週 曜日"/>
										<jsp:param name="txt_id"	 value="Week"/>
										<jsp:param name="select_txt" value="月|火|水|木|金|土|日"/>
										<jsp:param name="width"	 	 value="100"/>
									</jsp:include>
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td>
							<table>
								<tr>
									<td></td><td>清掃箇所</td><td>時間</td><td>頻度</td><td>清掃確認結果</td>
								</tr>
								<tr>
									<td>1</td><td>搬送部・搬送レール</td><td>30秒</td><td>1回/日</td>
									<td>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on1" />
											<jsp:param name="valon"	 value="○" />
											<jsp:param name="off" 	 value="off1" />
											<jsp:param name="valoff" value="×" />
											<jsp:param name="select" value="Item01"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>2</td><td>搬送部・搬送アーム</td><td>1分30秒</td><td>1回/日</td>
									<td>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on2" />
											<jsp:param name="valon"	 value="○" />
											<jsp:param name="off" 	 value="off2" />
											<jsp:param name="valoff" value="×" />
											<jsp:param name="select" value="Item02"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>3</td><td>スピンナ部・スピンナ周辺</td><td>1分</td><td>1回/日</td>
									<td>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on3" />
											<jsp:param name="valon"	 value="○" />
											<jsp:param name="off" 	 value="off3" />
											<jsp:param name="valoff" value="×" />
											<jsp:param name="select" value="Item03"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>4</td><td>ローダ部・ステージ上/※テフロンシート</td><td>30秒</td><td>1回/日</td>
									<td>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on4" />
											<jsp:param name="valon"	 value="○" />
											<jsp:param name="off" 	 value="off4" />
											<jsp:param name="valoff" value="×" />
											<jsp:param name="select" value="Item04"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>5</td><td>カッティング部・カッティング内/カバー</td><td>3分</td><td>1回/週</td>
									<td>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on5" />
											<jsp:param name="valon"	 value="○" />
											<jsp:param name="off" 	 value="off5" />
											<jsp:param name="valoff" value="×" />
											<jsp:param name="select" value="Item05"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>6</td><td>チャックテーブル側面・クランプ</td><td>3分</td><td>1回/週</td>
									<td>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on6" />
											<jsp:param name="valon"	 value="○" />
											<jsp:param name="off" 	 value="off6" />
											<jsp:param name="valoff" value="×" />
											<jsp:param name="select" value="Item06"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>7</td><td>スピンナ部・スピンナ内</td><td>3分</td><td>1回/週</td>
									<td>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on7" />
											<jsp:param name="valon"	 value="○" />
											<jsp:param name="off" 	 value="off7" />
											<jsp:param name="valoff" value="×" />
											<jsp:param name="select" value="Item07"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>8</td><td>装置外装・正面/側面/上部/下部/モニタ/計器</td><td>5分</td><td>1回/週</td>
									<td>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on8" />
											<jsp:param name="valon"	 value="○" />
											<jsp:param name="off" 	 value="off8" />
											<jsp:param name="valoff" value="×" />
											<jsp:param name="select" value="Item08"/>
										</jsp:include>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<p>※部</p>
							<p>干渉防止樹脂（ﾃﾌﾛﾝｼｰﾄ）を目視にて確認し、ｷｽﾞ、破損が確認された場合は、修正または交換が必要な場合「×」を記入し、装置保守部署に修正または交換依頼すること。</p>
							<p>判断基準は、作業指導票No.03Z-0039を確認のこと。</p>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</body>

	<!-- cssフレームワーク  -->
	<jsp:include page="/include/include_bootstrap.jsp"/>
</html>