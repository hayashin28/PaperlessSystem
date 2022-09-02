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
			/* セッションの曜日の値を設定 */
			if (!(!('${Week}'))) { $('input[name=Week]').val(['${Week}']); }
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
			/* 搬送レール部の先頭にWBを付けるイベント */
			$('#Item04, #Item08, #Item12, #Item16, #Item20, #Item24').change(function(e) {
				//先頭のWBのみ重複しないよう制御
				var val=$(this).val().replace(/W/, '').replace(/B/, '');
				//TextBoxが空でれば何もしない
				if (val.length===0) return false;
				//入力値の先頭にWBを付ける
				$(this).val('WB'+val);
			});
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
			/* 個別バリデーション処理 */
			var msg='';
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
		<title>UTC ワイヤボンダ清掃チェックシート</title>
	</head>

	<body>
		<div class="block">ＵＴＣ　ワイヤボンダ清掃チェックシート</div>
		<jsp:include page="/include/include_pagetop.jsp"/>
		<form id="fm" action="<%=request.getContextPath()%>/TenkenListServlet" method="post">
			<input type="hidden" name="sheetnm" value="ＵＴＣ　ワイヤボンダ清掃チェックシート">
			<input type="hidden" name="tanname" value="<%=tanname%>">
			<input type="hidden" name="Setubi"  value="">
			<input type="hidden" name="params" id="params" value="">

			<div class="bs-example table-responsive">

				<jsp:include page="/include/include_lastcleaningdatewb.jsp"/>

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
								<div class="btn btn-primary btn-lg">清掃曜日</div>
								<div class="btn_group_80" style="margin : 3.5px 0px 0px 0px">
									<input type="radio" name="Week" id="radio1" value="月" checked>
									<label for="radio1">月</label>
									<input type="radio" name="Week" id="radio2" value="火">
									<label for="radio2">火</label>
									<input type="radio" name="Week" id="radio3" value="水">
									<label for="radio3">水</label>
									<input type="radio" name="Week" id="radio4" value="木">
									<label for="radio4">木</label>
									<input type="radio" name="Week" id="radio5" value="金">
									<label for="radio5">金</label>
									<input type="radio" name="Week" id="radio6" value="土">
									<label for="radio6">土</label>
									<input type="radio" name="Week" id="radio7" value="日">
									<label for="radio7">日</label>
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td>
							<table border="1">

								<tr>
									<td>01</td><td rowspan=10>清掃頻度<br/>（週）</td><td>顕微鏡、ハンドル、照明アーム部</td><td rowspan=10>11</td><td rowspan=10>ｷｬﾋﾟﾗﾘ<br/>交換時</td><td rowspan=10>クランパ部</td><td rowspan=5>12</td><td rowspan=10>清掃頻度<br/>（月）</td><td rowspan=5>装置全体</td><td rowspan=10>14</td><td rowspan=10>清掃頻度<br/>（月）</td><td rowspan=10>搬送レール部</td>
								</tr>
								<tr>
									<td>02</td><td>I/Lﾏｶﾞｼﾞﾝ受け部＋I/Lﾏｶﾞｼﾞﾝｶﾞｲﾄﾞ部<br/>ﾌﾟｯｼｬｰ駆動部ｶﾊﾞｰ及び水平面　※</td>
								</tr>
								<tr>
									<td>03</td><td>I/Lﾏｶﾞｼﾞﾝ払出し部　※</td>
								</tr>
								<tr>
									<td>04</td><td>U/Lﾏｶﾞｼﾞﾝｶﾞｲﾄﾞ部(4本)及び水平面　※</td>
								</tr>
								<tr>
									<td>05</td><td>U/Lﾏｶﾞｼﾞﾝ払出し部　※</td>
								</tr>
								<tr>
									<td>06</td><td>ﾏｳｽﾊﾟｯﾄ、ｵﾍﾟﾚｰｼｮﾝﾊﾟﾈﾙ部</td><td rowspan=5>13</td><td rowspan=5>ヒータプレート部</td>
								</tr>
								<tr>
									<td>07</td><td>金線経路部</td>
								</tr>
								<tr>
									<td>08</td><td>金線屑回収</td>
								</tr>
								<tr>
									<td>09</td><td>脇机部</td>
								</tr>
								<tr>
									<td>10</td><td>金線受け皿部</td>
								</tr>
								<tr>
									<td>1週目</td>
									<td colspan=2>
										<jsp:include page="/include/include_threeswitch.jsp">
											<jsp:param name="switch1"	 value="switch1_01"/>
											<jsp:param name="switch2"	 value="switch2_01"/>
											<jsp:param name="off"		 value="off01"/>
											<jsp:param name="val1"		 value="○"/>
											<jsp:param name="val2"	 	 value="×"/>
											<jsp:param name="select"	 value="Item01"/>
										</jsp:include>
									</td>
									<td colspan=3>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on02"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off02"/>
											<jsp:param name="valoff" value="‐"/>
											<jsp:param name="select" value="Item02"/>
										</jsp:include>
									</td>
									<td colspan=3>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on03"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off03"/>
											<jsp:param name="valoff" value="‐"/>
											<jsp:param name="select" value="Item03"/>
										</jsp:include>
									</td>
									<td colspan=3>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn04"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item04"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>2週目</td>
									<td colspan=2>
										<jsp:include page="/include/include_threeswitch.jsp">
											<jsp:param name="switch1"	 value="switch1_05"/>
											<jsp:param name="switch2"	 value="switch2_05"/>
											<jsp:param name="off"		 value="off05"/>
											<jsp:param name="val1"		 value="○"/>
											<jsp:param name="val2"	 	 value="×"/>
											<jsp:param name="select"	 value="Item05"/>
										</jsp:include>
									</td>
									<td colspan=3>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on06"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off06"/>
											<jsp:param name="valoff" value="‐"/>
											<jsp:param name="select" value="Item06"/>
										</jsp:include>
									</td>
									<td colspan=3>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on07"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off07"/>
											<jsp:param name="valoff" value="‐"/>
											<jsp:param name="select" value="Item07"/>
										</jsp:include>
									</td>
									<td colspan=3>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn08"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item08"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>3週目</td>
									<td colspan=2>
										<jsp:include page="/include/include_threeswitch.jsp">
											<jsp:param name="switch1"	 value="switch1_09"/>
											<jsp:param name="switch2"	 value="switch2_09"/>
											<jsp:param name="off"		 value="off09"/>
											<jsp:param name="val1"		 value="○"/>
											<jsp:param name="val2"	 	 value="×"/>
											<jsp:param name="select"	 value="Item09"/>
										</jsp:include>
									</td>
									<td colspan=3>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on10"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off10"/>
											<jsp:param name="valoff" value="‐"/>
											<jsp:param name="select" value="Item10"/>
										</jsp:include>
									</td>
									<td colspan=3>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on11"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off11"/>
											<jsp:param name="valoff" value="‐"/>
											<jsp:param name="select" value="Item11"/>
										</jsp:include>
									</td>
									<td colspan=3>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn12"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item12"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>4週目</td>
									<td colspan=2>
										<jsp:include page="/include/include_threeswitch.jsp">
											<jsp:param name="switch1"	 value="switch1_13"/>
											<jsp:param name="switch2"	 value="switch2_13"/>
											<jsp:param name="off"		 value="off13"/>
											<jsp:param name="val1"		 value="○"/>
											<jsp:param name="val2"	 	 value="×"/>
											<jsp:param name="select"	 value="Item13"/>
										</jsp:include>
									</td>
									<td colspan=3>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on14"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off14"/>
											<jsp:param name="valoff" value="‐"/>
											<jsp:param name="select" value="Item14"/>
										</jsp:include>
									</td>
									<td colspan=3>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on15"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off15"/>
											<jsp:param name="valoff" value="‐"/>
											<jsp:param name="select" value="Item15"/>
										</jsp:include>
									</td>
									<td colspan=3>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn16"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item16"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>5週目</td>
									<td colspan=2>
										<jsp:include page="/include/include_threeswitch.jsp">
											<jsp:param name="switch1"	 value="switch1_17"/>
											<jsp:param name="switch2"	 value="switch2_17"/>
											<jsp:param name="off"		 value="off17"/>
											<jsp:param name="val1"		 value="○"/>
											<jsp:param name="val2"	 	 value="×"/>
											<jsp:param name="select"	 value="Item17"/>
										</jsp:include>
									</td>
									<td colspan=3>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on18"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off18"/>
											<jsp:param name="valoff" value="‐"/>
											<jsp:param name="select" value="Item18"/>
										</jsp:include>
									</td>
									<td colspan=3>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on19"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off19"/>
											<jsp:param name="valoff" value="‐"/>
											<jsp:param name="select" value="Item19"/>
										</jsp:include>
									</td>
									<td colspan=3>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn20"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item20"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>6週目</td>
									<td colspan=2>
										<jsp:include page="/include/include_threeswitch.jsp">
											<jsp:param name="switch1"	 value="switch1_21"/>
											<jsp:param name="switch2"	 value="switch2_21"/>
											<jsp:param name="off"		 value="off21"/>
											<jsp:param name="val1"		 value="○"/>
											<jsp:param name="val2"	 	 value="×"/>
											<jsp:param name="select"	 value="Item21"/>
										</jsp:include>
									</td>
									<td colspan=3>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on22"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off22"/>
											<jsp:param name="valoff" value="‐"/>
											<jsp:param name="select" value="Item22"/>
										</jsp:include>
									</td>
									<td colspan=3>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on23"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off23"/>
											<jsp:param name="valoff" value="‐"/>
											<jsp:param name="select" value="Item23"/>
										</jsp:include>
									</td>
									<td colspan=3>
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn24"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item24"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
							</table>
						</td>

					</tr>

					<tr>
						<td>
							<div class="boxContainer">
								<div><span class="btn btn-primary btn-lg" style="width:180px; margin:8px 0px 0px 0px;">前回の（月）清掃日</span></div>
								<div><input type="text" name="Cleaning" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:10px 10px 10px 0px; background-color:#FFFFFF"></div>
							</div>
						</td>
					</tr>

					<tr>
						<td>
							<p>干渉防止樹脂（テフロンシート）を目視にて確認し、キズ、破損が確認された場合は、修正または交換が必要な場合は「×」を記入し、</p>
							<p>装置保守部署に修正または交換依頼すること。</p>
							<p>判断基準は作業指導票No.032-0039を確認のこと。</p>
						</td>
					</tr>

				</table>
			</div>
		</form>

	</body>

	<!-- cssフレームワーク  -->
	<jsp:include page="/include/include_bootstrap.jsp"/>
</html>