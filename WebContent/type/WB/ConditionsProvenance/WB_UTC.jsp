<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="common.DbCommonFunctions"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="dao.TenkenListDao"%>
<%@page import="java.util.Arrays"%>
<!DOCTYPE html>

<html>

	<jsp:include page="/include/include_scriptframework.jsp"/>

	<% String tanname = System.getProperty("user.name");%>
	<% request.setCharacterEncoding("UTF-8"); %>

	<!-- Script宣言部 -->
	<script type="text/javascript">
		$(document).ready(function() {
			/* アラートを非表示にする */
			$("#alert_chkbox").hide();
			/**
			 * イベントリスナーの登録
			 */
			 /* バリデーション処理 */
			$('#submitBtn')[0].addEventListener('click', function(){ValidationHandler()}, false);
			/* バーコード読取り時に反応するイベントリスナー */
			$('#Setubi')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Setubi')}, false);
			$('#Worker')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Worker')}, false);
			/* フォーカスロスト時に反応するイベントリスナー */
			$('#Setubi')[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Setubi')}, false);
			$('#Worker')[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Worker')}, false);
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
		var words = '';
		/* Keypressによるイベント処理 */
		var BarcodeHandler = function(e, id) {
			if (e.keyCode === 229) return false;
			if (e.charCode===13) {
				words=$("#"+id).val();
				if (words.length===0) { return false; }
				$("#"+id).val(replaceCode(toHalfWidth(words)));
				var date = moment("<%=DbCommonFunctions.getServerTime()%>");
				$("#Date").val(date.format("MM月DD日"));
			}
		}
		/* Focusoutによるイベント処理 */
		var FocuslostHandler = function(e, id) {
			if (words===$("#"+id).val()) { return false; }
			words=$("#"+id).val();
			if (words.length===0) { return false; }
			$("#"+id).val(replaceCode(toHalfWidth(words)));
			var date = moment("<%=DbCommonFunctions.getServerTime()%>");
			$("#Date").val(date.format("MM月DD日"));
		}
	</script>

	<script type="text/javascript">
		/* 保存前のバリデーション処理を行う */
		var ValidationHandler = function() {
			/* 変化点の選択漏れ確認 */
			if(!($('#select定').prop('checked') || $('#select品').prop('checked') || $('#selectキ').prop('checked') || $('#select他').prop('checked'))){
				$("#alert_chkbox").show();
				return false;
			} else {
				$("#alert_chkbox").hide();
			}

			/* 個別バリデーション処理 */
			var msg='';
			if($("#btn_○").is(':enabled') && $("#btn_×").is(':checked')) {
				msg+='【判定結果】判定結果に × が選択されています。<br/>';
			}
			if(0<msg.length) {
				var promise=confirmSave(msg);
				promise.done(function() {
					submit();
				});
				promise.fail(function() {
					return false;
				});
			} else {
				submit();
			}
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
		<title>Ｗ／Ｂ条件履歴(UTC)</title>
	</head>

	<body>
		<div class="block">Ｗ／Ｂ条件履歴（ＵＴＣ）</div>
		<jsp:include page="/include/include_pagetop.jsp"/>
		<form id="fm" action="<%=request.getContextPath()%>/TenkenListServlet" method="post">
			<input type="hidden" name="sheetnm" value="Ｗ／Ｂ条件履歴（ＵＴＣ）">
			<input type="hidden" name="tanname" value="<%=tanname%>">
			<input type="hidden" name="Setubi"  value="">
			<input type="hidden" name="params" id="params" value="">
			<div class="bs-example table-responsive">

			<jsp:include page="/include/include_lasttenkendata.jsp"/>

				<table class="table table-hover">
					<tr>
						<td>
							<div class="boxContainer">
								<div class="right"><jsp:include page="/include/include_button.jsp"/></div>
							</div>
						</td>
					</tr>

					<tr>
						<td><jsp:include page="/include/include_worker.jsp"/></td>
					</tr>

					<tr>
						<td colspan=2>
							<table class="table table-bordered">
								<tr>
									<jsp:include page="/include/include_alertbar.jsp">
										<jsp:param name="id"	 value="alert_chkbox" />
										<jsp:param name="msg"	 value="目的を選択して下さい。" />
									</jsp:include>
									<td colspan=2>区分</td><td colspan=2>点検項目</td><td>確認区分</td><td>最終指示値</td>
									<td>
										<div class="boxContainer">
											<div class="btn btn-primary btn-lg">目的</div>
											<div class="btn_group_100" style="margin : 3.5px 0px 0px 0px">
												<input type="checkbox" name="select" id="select定" value="定">
												<label for="select定">定</label>
												<input type="checkbox" name="select" id="select品" value="品">
												<label for="select品">品</label>
												<input type="checkbox" name="select" id="selectキ" value="キ">
												<label for="selectキ">キ</label>
												<input type="checkbox" name="select" id="select他" value="他">
												<label for="select他">他</label>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td colspan=2>Gr</td><td>No</td><td>&nbsp;</td><td>キャピ仕様</td>
									<td><input type="text" name="capillary" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_inputtextex.jsp">
											<jsp:param name="btn"	value="btn"/>
											<jsp:param name="disp"	value="クリア"/>
											<jsp:param name="txt"	value="capillary"/>
											<jsp:param name="width"	value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td rowspan=8>パッド<br/>Bond1</td>
									<td rowspan=2>①</td>
									<td>1</td><td colspan=2>US POWER</td>
									<td><input type="text" name="Item01" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn01"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item01"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>2</td><td colspan=2>FORCE</td>
									<td><input type="text" name="Item02" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn02"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item02"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td rowspan=2>②</td>
									<td>4</td><td colspan=2>US POWER</td>
									<td><input type="text" name="Item04" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn04"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item04"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>5</td><td colspan=2>FORCE</td>
									<td><input type="text" name="Item05" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn05"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item05"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td rowspan=2>③</td>
									<td>7</td><td colspan=2>US POWER</td>
									<td><input type="text" name="Item07" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn07"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item07"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>8</td><td colspan=2>FORCE</td>
									<td><input type="text" name="Item08" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn08"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item08"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td rowspan=2>④</td>
									<td>10</td><td colspan=2>US POWER</td>
									<td><input type="text" name="Item10" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn10"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item10"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>11</td><td colspan=2>FORCE</td>
									<td><input type="text" name="Item11" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn11"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item11"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td rowspan=6>バンプ<br/>Bond1</td>
									<td rowspan=2>①</td>
									<td>13</td><td colspan=2>US POWER</td>
									<td><input type="text" name="Item13" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn13"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item13"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>14</td><td colspan=2>FORCE</td>
									<td><input type="text" name="Item14" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn14"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item14"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td rowspan=2>②</td>
									<td>16</td><td colspan=2>US POWER</td>
									<td><input type="text" name="Item16" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn16"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item16"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>17</td><td colspan=2>FORCE</td>
									<td><input type="text" name="Item17" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn17"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item17"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td rowspan=2>③</td>
									<td>19</td><td colspan=2>US POWER</td>
									<td><input type="text" name="Item19" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn19"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item19"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>20</td><td colspan=2>FORCE</td>
									<td><input type="text" name="Item20" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn20"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item20"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td rowspan=6>リード<br/>Bond2</td>
									<td rowspan=2>①</td>
									<td>22</td><td colspan=2>US POWER</td>
									<td><input type="text" name="Item22" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn22"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item22"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>23</td><td colspan=2>FORCE</td>
									<td><input type="text" name="Item23" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn23"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item23"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td rowspan=2>②</td>
									<td>24</td><td colspan=2>US POWER</td>
									<td><input type="text" name="Item24" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn24"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item24"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>25</td><td colspan=2>FORCE</td>
									<td><input type="text" name="Item25" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn25"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item25"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td rowspan=2>③</td>
									<td>26</td><td colspan=2>US POWER</td>
									<td><input type="text" name="Item26" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn26"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item26"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>27</td><td colspan=2>FORCE</td>
									<td><input type="text" name="Item27" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn27"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item27"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td rowspan=12>ループ<br/>関連</td>
									<td rowspan=3>①</td>
									<td>28</td><td colspan=2>LOOP HEIGHT</td>
									<td><input type="text" name="Item28" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn28"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item28"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>29</td><td colspan=2>REV HEIGHT</td>
									<td><input type="text" name="Item29" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn29"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item29"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>30</td><td colspan=2>LOOP OFFSET</td>
									<td><input type="text" name="Item30" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn30"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item30"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td rowspan=3>②</td>
									<td>31</td><td colspan=2>LOOP HEIGHT</td>
									<td><input type="text" name="Item31" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn31"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item31"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>32</td><td colspan=2>REV HEIGHT</td>
									<td><input type="text" name="Item32" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn32"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item32"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>33</td><td colspan=2>LOOP OFFSET</td>
									<td><input type="text" name="Item33" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn33"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item33"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td rowspan=3>③</td>
									<td>34</td><td colspan=2>LOOP HEIGHT</td>
									<td><input type="text" name="Item34" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn34"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item34"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>35</td><td colspan=2>REV HEIGHT</td>
									<td><input type="text" name="Item35" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn35"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item35"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>36</td><td colspan=2>LOOP OFFSET</td>
									<td><input type="text" name="Item36" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn36"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item36"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td rowspan=3>④</td>
									<td>37</td><td colspan=2>LOOP HEIGHT</td>
									<td><input type="text" name="Item37" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn37"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item37"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>38</td><td colspan=2>REV HEIGHT</td>
									<td><input type="text" name="Item38" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn38"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item38"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>39</td><td colspan=2>LOOP OFFSET</td>
									<td><input type="text" name="Item39" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn39"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item39"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td rowspan=5>初期<br/>ボール</td>
								</tr>
								<tr>
									<td>①</td>
									<td>40</td><td colspan=2>TORCH POWER/TIME</td>
									<td><input type="text" name="Item40" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn40"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item40"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>②</td>
									<td>41</td><td colspan=2>TORCH POWER/TIME</td>
									<td><input type="text" name="Item41" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn41"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item41"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>③</td>
									<td>42</td><td colspan=2>TORCH POWER/TIME</td>
									<td><input type="text" name="Item42" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn42"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item42"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>④</td>
									<td>43</td><td colspan=2>TORCH POWER/TIME</td>
									<td><input type="text" name="Item43" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn43"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item43"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td rowspan=3>エア<br/>流量</td>
								</tr>
								<tr>
									<td>-</td>
									<td>51</td><td colspan=2>エア流量名</td>
									<td><input type="text" name="Item51" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn51"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item51"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td>-</td>
									<td>52</td><td colspan=2>目視確認値</td>
									<td><input type="text" name="Item52" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn52"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item52"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td>レール幅</td>
									<td>-</td>
									<td>53</td><td colspan=2>FRAME WIDTH</td>
									<td><input type="text" name="Item53" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn53"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item53"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td colspan=5>その他<br/>注1）</td>
									<td>-</td>
									<td>
										<jsp:include page="/include/include_inputtextex.jsp">
											<jsp:param name="btn"	value="btn54"/>
											<jsp:param name="disp"	value="クリア"/>
											<jsp:param name="txt"	value="Item54"/>
											<jsp:param name="width"	value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td colspan=6>判定結果</td>
									<td>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="○"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="×"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="Item55"/>
										</jsp:include>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</body>

	<!-- cssフレームワーク  -->
	<jsp:include page="/include/include_bootstrap.jsp"/>
</html>
