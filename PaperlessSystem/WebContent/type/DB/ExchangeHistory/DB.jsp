<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="common.DbCommonFunctions"%>
<%@page import="java.sql.Timestamp"%>
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
			/* セッション内の設備No.を取得 */
			$("#Setubi").val("${setuB}");
			/**
			 * イベントリスナーの登録
			 */
			 /* バリデーション処理 */
			$('#submitBtn')[0].addEventListener('click', function(){ValidationHandler()}, false);
			 /* チェックボックスによる活性/非活性処理 */
			$('#select1')[0].addEventListener('change', function(){CheckboxHandler('select1')}, false);
			$('#select2')[0].addEventListener('change', function(){CheckboxHandler('select2')}, false);
			$('#select3')[0].addEventListener('change', function(){CheckboxHandler('select3')}, false);
			$('#select4')[0].addEventListener('change', function(){CheckboxHandler('select4')}, false);
			$('#select5')[0].addEventListener('change', function(){CheckboxHandler('select5')}, false);
			/* バーコード読取り時に反応するイベントリスナー */
			$('#Setubi')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Setubi')}, false);
			$('#Lot')	[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Lot')},    false);
			/* フォーカスロスト時に反応するイベントリスナー */
			$('#Setubi')[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Setubi')}, false);
			$('#Lot')	[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Lot')},    false);
			/* 初期化処理 */
			CheckboxHandler('select2');
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
				if(id==='Lot') {
					var date = moment("<%=DbCommonFunctions.getServerTime()%>");
					$("#Date").val(date.format("MM月DD日"));
					$("#shift").val(getShift(date));
				}
			}
		}
		/* Focusoutによるイベント処理 */
		var FocuslostHandler = function(e, id) {
			if (words===$("#"+id).val()) { return false; }
			words=$("#"+id).val();
			if (words.length===0) { return false; }
			$("#"+id).val(replaceCode(toHalfWidth(words)));
			words = '';
			if(id==='Lot') {
				var date = moment("<%=DbCommonFunctions.getServerTime()%>");
				$("#Date").val(date.format("MM月DD日"));
				$("#shift").val(getShift(date));
			}
		}
	</script>

	<script type="text/javascript">
		/* 保存前のバリデーション処理を行う */
		var ValidationHandler = function() {
			/* 変化点の選択漏れ確認 */
			if(!($('#select1').prop('checked') || $('#select2').prop('checked') || $('#select3').prop('checked') || $('#select4').prop('checked') || $('#select5').prop('checked'))){
				$("#alert_chkbox").show();
				return false;
			} else {
				$("#alert_chkbox").hide();
			}

			/* 個別バリデーション処理 */
			var msg='';
			if($("#btn_on").is(':enabled') && $("#btn_off").is(':checked')) {
				msg+='【ステージ清掃】清掃実施が選択されていません。<br/>';
			}
			if($("#btn_on3").is(':enabled') && $("#btn_off3").is(':checked')) {
				msg+='【ウエハブロー確認】OKが選択されていません。<br/>';
			}
			if($("#btn_switch3").is(':enabled') && $("#btn_switch4").is(':enabled') && $("#btn_off6").is(':checked')) {
				msg+='【移送コレット】交換済または継続が選択されていません。<br/>';
			}
			if($("#btn_switch5").is(':enabled') && $("#btn_switch6").is(':enabled') && $("#btn_off7").is(':checked')) {
				msg+='【破損・汚れ CH】交換済または継続が選択されていません。<br/>';
			}
			if($("#btn_on4").is(':enabled') && $("#btn_off8").is(':checked')) {
				msg+='【先端汚れ】清掃が選択されていません。<br/>';
			}
			/*  */
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
			$(':hidden[name="Lot"]').val($('#Lot').val());
			/* サーブレットの呼出しを行う */
			$("#fm").submit();
		}
	</script>

	<script type="text/javascript">
		var CheckboxHandler = function(id) {
			if(id==='select1') 		  { Item02(id); Item03(id); Item04(id); Item05(id);
			} else if(id==='select2') { Item02(id); Item03(id); Item04(id); Item05(id); Item06(id); Item07(id); Item08(id); Item09(id); Item10(id); Item11(id); Item12(id); Item13(id);
			} else if(id==='select3') { Item02(id); Item03(id); Item04(id); Item06(id); Item07(id); Item08(id); Item13(id);
			} else if(id==='select4') { Item09(id); Item13(id);
			} else if(id==='select5') { Item13(id); }
		}
	</script>


	<script type="text/javascript">

		function Item02(id) {
			if($("#" + id).prop('checked')) {
				$("#btn_on").prop("disabled", false);
				$("#td02").css("background-color", "#FFFFFF");
			} else {
				if (!($('#select1').prop('checked') || $('#select2').prop('checked') || $('#select3').prop('checked'))) {
					$("#btn_on").prop("disabled", true);
					$("#btn_off").prop("checked", true);
					$("#td02").css("background-color", "#D3D3D3");
				}
			}
		}

		function Item03(id) {
			if($("#" + id).prop('checked')) {
				$("#btn_on1").prop("disabled",  false);
				$("#td03").css("background-color", "#FFFFFF");
			} else {
				if (!($('#select1').prop('checked') || $('#select2').prop('checked') || $('#select3').prop('checked'))) {
					$("#btn_on1").prop("disabled", true);
					$("#btn_off1").prop("checked", true);
					$("#td03").css("background-color", "#D3D3D3");
				}
			}
		}

		function Item04(id) {
			if($("#" + id).prop('checked')) {
				$("#btn_on2").prop("disabled", false);
				$("#td04").css("background-color", "#FFFFFF");
			} else {
				if (!($('#select1').prop('checked') || $('#select2').prop('checked') || $('#select3').prop('checked'))) {
					$("#btn_on2").prop("disabled", true);
					$("#btn_off2").prop("checked", true);
					$("#td04").css("background-color", "#D3D3D3");
				}
			}
		}

		function Item05(id) {
			if($("#" + id).prop('checked')) {
				$("#btn_on3").prop("disabled",  false);
				$("#td05").css("background-color", "#FFFFFF");
			} else {
				if (!($('#select1').prop('checked') || $('#select2').prop('checked'))) {
					$("#btn_on3").prop("disabled", true);
					$("#btn_off3").prop("checked", true);
					$("#td05").css("background-color", "#D3D3D3");
				}
			}
		}

		function Item06(id) {
			if($("#" + id).prop('checked')) {
					$("#btn_paste, #Item06").prop("disabled",  false);
					$("#td06").css("background-color", "#FFFFFF");
			} else {
				if (!($('#select2').prop('checked') || $('#select3').prop('checked'))) {
					$("#btn_paste, #Item06").prop("disabled",  true);
					$("#td06").css("background-color", "#D3D3D3");
				}
			}
		}

		function Item07(id) {
			if($("#" + id).prop('checked')) {
				$("#btn_switch1, #btn_switch2").prop("disabled", false);
				$("#td07").css("background-color", "#FFFFFF");
			} else {
				if (!($('#select2').prop('checked') || $('#select3').prop('checked'))) {
					$("#btn_switch1, #btn_switch2").prop("disabled", true);
					$("#btn_off4").prop("checked", true);
					$("#td07").css("background-color", "#D3D3D3");
				}
			}
		}

		function Item08(id) {
			if($("#" + id).prop('checked')) {
				$("#btn_coating, #Item08, #btn_off5").prop("disabled", false);
				$("#btn_off5").prop("checked", false);
				$("#td08").css("background-color", "#FFFFFF");
			} else {
				if (!($('#select2').prop('checked') || $('#select3').prop('checked'))) {
					$("#btn_coating, #Item08, #btn_off5, #btn_coating").prop("disabled", true);
					$("#btn_off5").prop("checked", true);
					$("#td08").css("background-color", "#D3D3D3");
				}
			}
		}

		function Item09(id) {
			if($("#" + id).prop('checked')) {
				$("#btn_switch3, #btn_switch4").prop("disabled", false);
				$("#td09").css("background-color", "#FFFFFF");
			} else {
				if (!($('#select2').prop('checked') || $('#select4').prop('checked'))) {
					$("#btn_switch3, #btn_switch4").prop("disabled", true);
					$("#btn_off6").prop("checked", true);
					$("#td09").css("background-color", "#D3D3D3");
				}
			}
		}

		function Item10(id) {
			if($("#" + id).prop('checked')) {
				$("#btn_switch5, #btn_switch6").prop("disabled", false);
				$("#td10").css("background-color", "#FFFFFF");
			} else {
				if (!($('#select2').prop('checked'))) {
					$("#btn_switch5, #btn_switch6").prop("disabled", true);
					$("#btn_off7").prop("checked", true);
					$("#td10").css("background-color", "#D3D3D3");
				}
			}
		}

		function Item11(id) {
			if($("#" + id).prop('checked')) {
				$("#btn_on4").prop("disabled", false);
				$("#td11").css("background-color", "#FFFFFF");
			} else {
				if (true) {
					$("#btn_on4").prop("disabled", true);
					$("#btn_off8").prop("checked", true);
					$("#td11").css("background-color", "#D3D3D3");
				}
			}
		}

		function Item12(id) {
			if($("#" + id).prop('checked')) {
				$("#btn_partnum, #Item12").prop("disabled", false);
				$("#btn_off9").prop("checked", false);
				$("#td12").css("background-color", "#FFFFFF");
			} else {
				if (true) {
					$("#btn_partnum, #Item12, #btn_off9").prop("disabled", true);
					$("#btn_off9").prop("checked", true);
					$("#td12").css("background-color", "#D3D3D3");
				}
			}
		}

		function Item13(id) {
			if($("#" + id).prop('checked')) {
				$("#btn_quality, #Item13").prop("disabled", false);
				$("#btn_off10").prop("checked", false);
				$("#td13").css("background-color", "#FFFFFF");
			} else {
				if (!($('#select2').prop('checked') || $('#select3').prop('checked') || $('#select4').prop('checked') || $('#select5').prop('checked'))) {
					$("#btn_quality, #Item13, #btn_off10").prop("disabled", true);
					$("#btn_off10").prop("checked", true);
					$("#td13").css("background-color", "#D3D3D3");
				}
			}
		}
	</script>
	<!-- Script宣言部ここまで -->


	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>DB交換来歴表</title>
	</head>

	<body>
		<% request.setCharacterEncoding("UTF-8");%>
		<jsp:include page="/include/include_pagetop.jsp"/>
		<div class="block">DB交換来歴表</div>

		<form id="fm" action="<%=request.getContextPath()%>/TenkenListServlet" method="post">
			<input type="hidden" name="sheetnm" value="ＤＢ交換来歴表">
			<input type="hidden" name="tanname" value="<%=tanname%>">
			<input type="hidden" name="Setubi"  value="">
			<input type="hidden" name="Lot"		value="">
			<input type="hidden" name="params" id="params" value="">

			<div class="bs-example table-responsive">
				<table class="table table-hover">
					<tr>
						<td><div><jsp:include page="/include/include_setubidata.jsp"/></div></td>
					</tr>
					<tr>
						<td><div><jsp:include page="/include/include_lotdata.jsp"/></div></td>
					</tr>

					<tr>
						<td colspan=6>
							<jsp:include page="/include/include_alertbar.jsp">
								<jsp:param name="id"	 value="alert_chkbox" />
								<jsp:param name="msg"	 value="変化点を選択して下さい。" />
							</jsp:include>
							<div class="boxContainer">
								<div class="btn btn-primary btn-lg">変化点</div>
								<div class="btn_group_180" style="margin : 3.5px 0px 0px 0px">
									<input type="checkbox" name="Item01" id="select1" value="1回/シフト">
									<label for="select1">1回/シフト</label>
									<input type="checkbox" name="Item01" id="select2" value="品種交換">
									<label for="select2">品種交換</label>
									<input type="checkbox" name="Item01" id="select3" value="ペースト交換">
									<label for="select3">ペースト交換</label>
									<input type="checkbox" name="Item01" id="select4" value="定期交換">
									<label for="select4">定期交換</label>
									<input type="checkbox" name="Item01" id="select5" value="調整時">
									<label for="select5">調整時</label>
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td>
							<table class="table table-bordered">

								<tr>
									<td colspan=2>項目</td><td>選択方法</td><td colspan=2>結果</td>
								</tr>

								<tr>
									<td colspan=2>ﾎﾞﾝﾃﾞｨﾝｸﾞ･ﾌﾟﾘﾌｫｰﾑ<br/>ステージ清掃</td>
									<td>清掃実施した場合：清掃実施</td>
									<td colspan=2 id="td02">
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on" />
											<jsp:param name="valon"	 value="清掃実施" />
											<jsp:param name="off" 	 value="off" />
											<jsp:param name="valoff" value="＼" />
											<jsp:param name="select" value="Item02"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td colspan=2>ペースト残量</td>
									<td>ペースト残量確認：OK<br/>DAF材使用時：＼
									<td colspan=2 id="td03">
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on" 	 value="on1"/>
											<jsp:param name="valon"  value="OK"/>
											<jsp:param name="off" 	 value="off1"/>
											<jsp:param name="valoff" value="＼"/>
											<jsp:param name="select" value="Item03"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td colspan=2>ペースト有効期限</td>
									<td>使用期限確認：OK<br/>DAF材使用時：＼
									<td colspan=2 id="td04">
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on2"/>
											<jsp:param name="valon"	 value="OK"/>
											<jsp:param name="off"	 value="off2"/>
											<jsp:param name="valoff" value="＼"/>
											<jsp:param name="select" value="Item04"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td colspan=2>ウエハブロー確認</td>
									<td>ウエハブローがピックアップ時に<br/>流れている場合：OK
									<td colspan=2 id="td05">
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on3"/>
											<jsp:param name="valon"	 value="OK"/>
											<jsp:param name="off"	 value="off3"/>
											<jsp:param name="valoff" value="＼"/>
											<jsp:param name="select" value="Item05"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td colspan=2>ペースト仕様</td>
									<td>ペースト仕様<br/>手入力
									<td colspan=2 id="td06">
										<jsp:include page="/include/include_selectionbox_required.jsp">
											<jsp:param name="btn_id"	 value="btn_paste"/>
											<jsp:param name="btn_text"	 value="ペースト仕様"/>
											<jsp:param name="txt_id"	 value="Item06"/>
											<jsp:param name="select_txt" value="RZ032C|RZ017C|RZ253C"/>
											<jsp:param name="width"	 	 value="100"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td colspan=2>使用ディスペンサ</td>
									<td>使用するディスペンサを選択<br/>DAF材使用時：＼
									<td colspan=2 id="td07">
										<jsp:include page="/include/include_threeswitch.jsp">
											<jsp:param name="switch1"	value="switch1"/>
											<jsp:param name="switch2"	value="switch2"/>
											<jsp:param name="val1"	 	value="メカ"/>
											<jsp:param name="val2"	 	value="エア"/>
											<jsp:param name="off"	 	value="off4"/>
											<jsp:param name="select" 	value="Item07"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td colspan=2>ペースト塗布重量<br/>メガディス使用時</td>
									<td>ペースト塗布重量：テンキー入力<br/>ディスペンサ使用時：＼
									<td id="td08">
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn_coating"/>
													<jsp:param name="btn_text"	value="ペースト塗布重量"/>
													<jsp:param name="txt_id"	value="Item08"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div style="margin : 10px 0px 0px 0px">
												<jsp:include page="/include/include_ngswitch.jsp">
													<jsp:param name="off"	 value="off5"/>
													<jsp:param name="select" value="Item08"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td colspan=2>移送コレット<br/>（1回／50,000ic）</td>
									<td>
										<p>①品種交換時、仕様変更の場合ﾗﾊﾞｰｺﾚｯﾄ交換し、<br/>"交換済み"を選択する。</p>
										<p>②品種交換時、同一仕様ﾗﾊﾞｰｺﾚｯﾄの場合、装置カウントが<br/>ライフ内である事を確認し"継続"を選択する。</p>
										<p>③定期交換時、装置設定ｶｳﾝﾄｱｯﾌﾟ毎にﾗﾊﾞｰｺﾚｯﾄ交換し、<br>"交換済み"を選択する。</p>
									</td>
									<td colspan=2 id="td09">
										<jsp:include page="/include/include_threeswitch.jsp">
											<jsp:param name="switch1"	value="switch3"/>
											<jsp:param name="switch2"	value="switch4"/>
											<jsp:param name="val1"	 	value="交換済"/>
											<jsp:param name="val2"	 	value="継続"/>
											<jsp:param name="off"	 	value="off6"/>
											<jsp:param name="select" 	value="Item09"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td rowspan=4>突上針</td>
								</tr>
								<tr>
									<td>破損・汚れ CH</td>
									<td>
										<p>破損・汚れあり：交換</p>
										<p>継続して使用可能：継続</p>
									</td>
									<td colspan=2 id="td10">
										<jsp:include page="/include/include_threeswitch.jsp">
											<jsp:param name="switch1"	value="switch5"/>
											<jsp:param name="switch2"	value="switch6"/>
											<jsp:param name="val1"	 	value="交換"/>
											<jsp:param name="val2"	 	value="継続"/>
											<jsp:param name="off"	 	value="off7"/>
											<jsp:param name="select" 	value="Item10"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td>先端汚れ</td>
									<td>ｴﾀﾉｰﾙ＋ｴｺﾉﾐｰﾜｲﾊﾟ清掃：清掃</td>
									<td colspan=2 id="td11">
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="on4"/>
											<jsp:param name="valon"	 value="清掃"/>
											<jsp:param name="off"	 value="off8"/>
											<jsp:param name="valoff" value="＼"/>
											<jsp:param name="select" value="Item11"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td>品番</td>
									<td>突上針の品番　手入力</td>
									<td id="td12">
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn_partnum"/>
													<jsp:param name="btn_text"	value="品番"/>
													<jsp:param name="txt_id"	value="Item12"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div style="margin : 10px 0px 0px 0px">
												<jsp:include page="/include/include_ngswitch.jsp">
													<jsp:param name="off"	 value="off9"/>
													<jsp:param name="select" value="Item12"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td colspan=2>品質確認結果</td>
									<td>品質確認結果　テンキー入力</td>
									<td id="td13">
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn_quality"/>
													<jsp:param name="btn_text"	value="品質確認結果"/>
													<jsp:param name="txt_id"	value="Item13"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div style="margin : 10px 0px 0px 0px">
												<jsp:include page="/include/include_ngswitch.jsp">
													<jsp:param name="off"	 value="off10"/>
													<jsp:param name="select" value="Item13"/>
												</jsp:include>
											</div>
										</div>
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