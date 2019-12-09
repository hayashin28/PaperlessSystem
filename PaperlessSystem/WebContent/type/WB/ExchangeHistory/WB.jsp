<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.lang.WordUtils"%>
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
			/* バーコード読取り時に反応するイベントリスナー */
			$('#Setubi')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Setubi')}, false);
			$('#Lot')   [0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Lot')},    false);
			$('#Worker')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Worker')}, false);
			/* フォーカスロスト時に反応するイベントリスナー */
			$('#Setubi')[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Setubi')}, false);
			$('#Lot')   [0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Lot')},    false);
			$('#Worker')[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Worker')}, false);
			/* 初期化処理 */
			/* 全てのオブジェクトを無効化する */
			for (var i=1; i<=14; i++)	$("#btn_off" + i).prop("disabled", true);
			CheckboxHandler('select1');
			CheckboxHandler('select2');
			CheckboxHandler('select3');
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
				var date = moment("<%=DbCommonFunctions.getServerTime()%>");
				$("#Date").val(date.format("MM月DD日"));
				if(id==='Lot') {
					var result=collCommonFunctionServlet(functionkbn.getPBLayoutDiagram, words);
					result.done(function(response) {
						$("#Item03").val(response);
					});
					result.fail(function() {
						bootbox.alert("組立ロットNo.が存在しません。");
						return false;
					});
				}
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
			if(id==='Lot') {
				var result=collCommonFunctionServlet(functionkbn.getPBLayoutDiagram, words);
				result.done(function(response) {
					$("#Item03").val(response);
				});
				result.fail(function() {
					bootbox.alert("組立ロットNo.が存在しません。");
					return false;
				});
			}
		}
	</script>

	<script type="text/javascript">
		/* 保存前のバリデーション処理を行う */
		var ValidationHandler = function() {
			/* 変化点の選択漏れ確認 */
			if(!($('#select1').prop('checked') || $('#select2').prop('checked') || $('#select3').prop('checked'))){
				$("#alert_chkbox").show();
				return false;
			} else {
				$("#alert_chkbox").hide();
			}

			/* 個別バリデーション処理 */
			var msg='';
			if (!$("#Item02").val()) {
				msg+='【ズレ確認】チェックがされていません。<br/>';
			}
			if(($("#select1").is(':checked')|| $("#select2").is(':checked')) && !$("#btn_on3").is(':checked')) {
				msg+='【治工具交換】異物確認がチェックされていません。<br/>';
			}
			if(($("#select1").is(':checked')|| $("#select2").is(':checked')) && !$("#btn_on4").is(':checked')) {
				msg+='【治工具交換】隙間確認がチェックされていません。<br/>';
			}
			if(($("#select1").is(':checked')|| $("#select3").is(':checked')) && $("#btn_off11").is(':checked')) {
				msg+='【キャピラリ交換】新品または洗浄品が選択されていません。<br/>';
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
			$(':hidden[name="Lot"]').val($('#Lot').val());
			/* サーブレットの呼出しを行う */
			$("#fm").submit();
		}
	</script>

	<script type="text/javascript">
		var CheckboxHandler = function(id) {
			if(id==='select1')		   { Item02(id); Item03(id); Item04(id); Item05(id); Item06(id); Item07(id); Item08(id); Item09(id); Item10(id); Item11(id); Item12(id); Item13(id); Item14(id); Item15(id); Item16(id);
			} else if (id==='select2') { Item11(id); Item12(id);
			} else if (id==='select3') { Item13(id); Item14(id); Item15(id); Item16(id); }
		}
	</script>

	<script type="text/javascript">

		function Item02(id) {
			if($("#" + id).prop('checked')) {
				$("#td02").css("background-color", "#FFFFFF");
			} else {
				$("#td02").css("background-color", "#D3D3D3");
			}
		}

		function Item03(id) {
			if($("#" + id).prop('checked')) {
				$("#btn_off1").prop("checked", false);
				$("#td03").css("background-color", "#FFFFFF");
			} else {
				$("#btn_off1").prop("checked", true);
				$("#td03").css("background-color", "#D3D3D3");
			}
		}

		function Item04(id) {
			if($("#" + id).prop('checked')) {
				$("#btn04, #Item04").prop("disabled", false);
				$("#btn_off2").prop("checked",false);
				$("#td04").css("background-color", "#FFFFFF");
			} else {
				$("#btn04, #Item04").prop("disabled", true);
				$("#btn_off2").prop("checked",true);
				$("#td04").css("background-color", "#D3D3D3");
			}
		}

		function Item05(id) {
			if($("#" + id).prop('checked')) {
				$("#btn05, #Item05").prop("disabled", false);
				$("#btn_off3").prop("checked",false);
				$("#td05").css("background-color", "#FFFFFF");
			} else {
				$("#btn05, #Item05").prop("disabled", true);
				$("#btn_off3").prop("checked",true);
				$("#td05").css("background-color", "#D3D3D3");
			}
		}

		function Item06(id) {
			if($("#" + id).prop('checked')) {
				$("#btn06, #Item06").prop("disabled", false);
				$("#btn_off4").prop("checked",false);
				$("#td06").css("background-color", "#FFFFFF");
			} else {
				$("#btn06, #Item06").prop("disabled", true);
				$("#btn_off4").prop("checked",true);
				$("#td06").css("background-color", "#D3D3D3");
			}
		}

		function Item07(id) {
			if($("#" + id).prop('checked')) {
				$("#btn07, #Item07").prop("disabled", false);
				$("#btn_off5").prop("checked",false);
				$("#td07").css("background-color", "#FFFFFF");
			} else {
				$("#btn07, #Item07").prop("disabled", true);
				$("#btn_off5").prop("checked",true);
				$("#td07").css("background-color", "#D3D3D3");
			}
		}

		function Item08(id) {
			if($("#" + id).prop('checked')) {
				$("#btn08, #Item08").prop("disabled", false);
				$("#btn_off6").prop("checked",false);
				$("#td08").css("background-color", "#FFFFFF");
			} else {
				$("#btn08, #Item08").prop("disabled", true);
				$("#btn_off6").prop("checked",true);
				$("#td08").css("background-color", "#D3D3D3");
			}
		}

		function Item09(id) {
			if($("#" + id).prop('checked')) {
				$("#btn09, #Item09").prop("disabled", false);
				$("#btn_off7").prop("checked",false);
				$("#td09").css("background-color", "#FFFFFF");
			} else {
				$("#btn09, #Item09").prop("disabled",  true);
				$("#btn_off7").prop("checked",true);
				$("#td09").css("background-color", "#D3D3D3");
			}
		}

		function Item10(id) {
			if($("#" + id).prop('checked')) {
				$("#btn_ac, #btn_dc, #btn_off").prop("disabled", false);
				$("#td10").css("background-color", "#FFFFFF");
			} else {
				$("#btn_ac, #btn_dc").prop("disabled", true);
				$("#btn_off").prop("checked",  true);
				$("#td10").css("background-color", "#D3D3D3");
			}
		}

		function Item11(id) {
			if($("#" + id).prop('checked')) {
				$("#btn_on3").prop("disabled", false);
				$("#btn_off8").prop("checked", false);
				$("#td11").css("background-color", "#FFFFFF");
			} else {
				if (!($('#select1').prop('checked') || $('#select2').prop('checked'))) {
					$("#btn_on3").prop("disabled", true);
					$("#btn_on3").prop("checked",  false);
					$("#btn_off8").prop("checked", true);
					$("#td11").css("background-color", "#D3D3D3");
				}
			}
		}

		function Item12(id) {
			if($("#" + id).prop('checked')) {
				$("#btn_on4").prop("disabled", false);
				$("#btn_off9").prop("checked", false);
				$("#td12").css("background-color", "#FFFFFF");
			} else {
				if (!($('#select1').prop('checked') || $('#select2').prop('checked'))) {
					$("#btn_on4").prop("disabled", true);
					$("#btn_on4").prop("checked",  false);
					$("#btn_off9").prop("checked", true);
					$("#td12").css("background-color", "#D3D3D3");
				}
			}
		}

		function Item13(id) {
			if($("#" + id).prop('checked')) {
				$("#btn13, #Item13").prop("disabled",false);
				$("#btn_off10").prop("checked", false);
				$("#td13").css("background-color", "#FFFFFF");
			} else {
				if (!($('#select1').prop('checked') || $('#select3').prop('checked'))) {
					$("#btn13, #Item13").prop("disabled",  	true);
					$("#btn_off10").prop("checked", true);
					$("#td13").css("background-color", "#D3D3D3");
				}
			}
		}

		function Item14(id) {
			if($("#" + id).prop('checked')) {
				$("#btn_◎, #btn_○, #btn_off11").prop("disabled",	false);
				$("#td14").css("background-color", "#FFFFFF");
			} else {
				if (!($('#select1').prop('checked') || $('#select3').prop('checked'))) {
					$("#btn_◎, #btn_○").prop("disabled",   true);
					$("#btn_off11").prop("checked", true);
					$("#td14").css("background-color", "#D3D3D3");
				}
			}
		}

		function Item15(id) {
			if($("#" + id).prop('checked')) {
				$("#btn15, #Item15").prop("disabled",	false);
				$("#btn_off12").prop("checked", false);
				$("#td15").css("background-color", "#FFFFFF");
			} else {
				if (!($('#select1').prop('checked') || $('#select3').prop('checked'))) {
					$("#btn15, #Item15").prop("disabled",	true);
					$("#btn_off12").prop("checked", true);
					$("#td15").css("background-color", "#D3D3D3");
				}
			}
		}

		function Item16(id) {
			if($("#" + id).prop('checked')) {
				$("#btn16, #Item16").prop("disabled", 	false);
				$("#btn_off13").prop("checked", false);
				$("#td16").css("background-color", "#FFFFFF");
			} else {
				if (!($('#select1').prop('checked') || $('#select3').prop('checked'))) {
					$("#btn16, #Item16").prop("disabled", 	true);
					$("#btn_off13").prop("checked",	true);
					$("#td16").css("background-color", "#D3D3D3");
				}
			}
		}

	</script>
	<!-- Script宣言部ここまで -->


	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Ｗ／Ｂ装置　交換来歴</title>
	</head>

	<body>
		<div class="block">Ｗ／Ｂ装置　交換来歴</div>
		<jsp:include page="/include/include_pagetop.jsp"/>
		<form id="fm" action="<%=request.getContextPath()%>/TenkenListServlet" method="post">
			<input type="hidden" name="sheetnm" value="Ｗ／Ｂ装置　交換来歴">
			<input type="hidden" name="tanname" value="<%=tanname%>">
			<input type="hidden" name="Setubi"  value="">
			<input type="hidden" name="Lot"		value="">
			<input type="hidden" name="params" id="params" value="">

			<div class="bs-example table-responsive">
				<table class="table table-hover">

					<tr>
						<td>
							<div class="boxContainer">
								<div>
									<jsp:include page="/include/include_inputtextex_required.jsp">
										<jsp:param name="btn"	 value="btn_lot" />
										<jsp:param name="disp"	 value="ロットNo." />
										<jsp:param name="txt"	 value="Lot" />
										<jsp:param name="width"	 value="100"/>
									</jsp:include>
								</div>
								<div class="right">
									<jsp:include page="/include/include_button.jsp"/>
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td colspan=2><jsp:include page="/include/include_worker.jsp"/></td>
					</tr>

					<tr>
						<td colspan=2>
							<jsp:include page="/include/include_alertbar.jsp">
								<jsp:param name="id"	 value="alert_chkbox" />
								<jsp:param name="msg"	 value="交換理由を選択して下さい。" />
							</jsp:include>
							<div class="boxContainer">
								<div class="btn btn-primary btn-lg">交換理由</div>
								<div class="btn_group_180" style="margin : 3.5px 0px 0px 0px">
									<input type="checkbox" name="Item01" id="select1" value="品種交換">
									<label for="select1">品種交換</label>
									<input type="checkbox" name="Item01" id="select2" value="治工具交換">
									<label for="select2">治工具交換</label>
									<input type="checkbox" name="Item01" id="select3" value="キャピラリ交換">
									<label for="select3">キャピラリ交換</label>
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td colspan=2>
							<table class="table table-bordered">

								<tr>
									<td>大項目</td><td>項目</td><td>選択項目</td><td colspan=2>結果</td>
								</tr>

								<tr>
									<td rowspan=9>品種交換</td>
								</tr>

								<tr>
									<td>PBレイアウトNo.</td><td>自動入力</td>
									<td id="td03">
										<input type="text" id="Item03" name="Item03" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:80%; background-color:#FFFFFF">
									</td>
									<td>
										<jsp:include page="/include/include_ngswitch.jsp">
											<jsp:param name="off"	 value="off1"/>
											<jsp:param name="select" value="Item03"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td>フレーム押さえNo.</td>
									<td rowspan=4>フレーム押さえNoの記録はテンキー入力とし、<br/>取り付けた上段（装置奥）から順に枝番を左から入力</td>
									<td id="td04">
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn04" />
											<jsp:param name="btn_text"	value="フレーム押さえNo." />
											<jsp:param name="txt_id"	value="Item04" />
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
									<td>
										<jsp:include page="/include/include_ngswitch.jsp">
											<jsp:param name="off"	 value="off2"/>
											<jsp:param name="select" value="Item04"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td rowspan=3>フレーム押さえ枝番No.</td>
									<td id="td05">
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn05"/>
											<jsp:param name="btn_text"	value="フレーム押さえ枝番No.1"/>
											<jsp:param name="txt_id"	value="Item05"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
									<td>
										<jsp:include page="/include/include_ngswitch.jsp">
											<jsp:param name="off"	 value="off3"/>
											<jsp:param name="select" value="Item05"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td id="td06">
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn06"/>
											<jsp:param name="btn_text"	value="フレーム押さえ枝番No.2"/>
											<jsp:param name="txt_id"	value="Item06"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
									<td>
										<jsp:include page="/include/include_ngswitch.jsp">
											<jsp:param name="off"	 value="off4"/>
											<jsp:param name="select" value="Item06"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td id="td07">
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn07"/>
											<jsp:param name="btn_text"	value="フレーム押さえ枝番No.3"/>
											<jsp:param name="txt_id"	value="Item07"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
									<td>
										<jsp:include page="/include/include_ngswitch.jsp">
											<jsp:param name="off"	 value="off5"/>
											<jsp:param name="select" value="Item07"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td>ヒート駒No.</td><td>テンキー入力</td>
									<td id="td08">
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn08" />
											<jsp:param name="btn_text"	value="ヒート駒No." />
											<jsp:param name="txt_id"	value="Item08" />
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
									<td>
										<jsp:include page="/include/include_ngswitch.jsp">
											<jsp:param name="off"	 value="off6"/>
											<jsp:param name="select" value="Item08"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td>金線仕様</td><td>キーボード入力</td>
									<td id="td09">
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn09" />
											<jsp:param name="disp"	 value="金線仕様" />
											<jsp:param name="txt"	 value="Item09" />
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
									<td>
										<jsp:include page="/include/include_ngswitch.jsp">
											<jsp:param name="off"	 value="off7"/>
											<jsp:param name="select" value="Item09"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td>不圧着検出</td>
									<td>パッド側、リード側共に不圧着検出を<br/>ON側に設定の時"AC"又は"DC"を選択。<br/>「不圧着検出」をNOに設定しない時は、<br/>＼を選択する事。</td>
									<td id="td10">
										<jsp:include page="/include/include_threeswitch.jsp">
											<jsp:param name="switch1"	 value="ac"/>
											<jsp:param name="switch2"	 value="dc"/>
											<jsp:param name="off"		 value="off"/>
											<jsp:param name="val1"		 value="AC"/>
											<jsp:param name="val2"	 	 value="DC"/>
											<jsp:param name="select"	 value="Item10"/>
										</jsp:include>
									</td>
									<td></td>
								</tr>

								<tr>
									<td rowspan=3>治工具交換</td>
								</tr>
								<tr>
									<td>押さえヒート駒<br/>異物確認</td>
									<td>押さえ取り付け前に裏面のバリ及びヒート駒<br/>異物を目視で確認し ○ を選択。</td>
									<td id="td11">
										<jsp:include page="/include/include_okswitch.jsp">
											<jsp:param name="on"	 value="on3"/>
											<jsp:param name="select" value="Item11"/>
										</jsp:include>
									</td>
									<td>
										<jsp:include page="/include/include_ngswitch.jsp">
											<jsp:param name="off"	 value="off8"/>
											<jsp:param name="select" value="Item11"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>押さえヒート駒<br/>隙間確認</td>
									<td>治工具取り付け後押さえとヒート駒間の隙間が<br/>無き事を確認し ○ を選択。</td>
									<td id="td12">
										<jsp:include page="/include/include_okswitch.jsp">
											<jsp:param name="on"	 value="on4"/>
											<jsp:param name="select" value="Item12"/>
										</jsp:include>
									</td>
									<td>
										<jsp:include page="/include/include_ngswitch.jsp">
											<jsp:param name="off"	 value="off9"/>
											<jsp:param name="select" value="Item12"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td rowspan=5>キャピラリ交換</td>
								</tr>
								<tr>
									<td>キャピラリ仕様</td>
									<td>バーコード入力</td>
									<td id="td13">
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn13" />
											<jsp:param name="disp"	 value="キャピラリ仕様" />
											<jsp:param name="txt"	 value="Item13" />
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
									<td>
										<jsp:include page="/include/include_ngswitch.jsp">
											<jsp:param name="off"	 value="off10"/>
											<jsp:param name="select" value="Item13"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td>新品<br/>洗浄品</td>
									<td>新品キャピラリは ◎<br/>洗浄キャピラリは ○ を選択。</td>
									<td id="td14">
										<jsp:include page="/include/include_threeswitch.jsp">
											<jsp:param name="switch1"	value="◎"/>
											<jsp:param name="val1"	 	value="◎"/>
											<jsp:param name="switch2"	value="○"/>
											<jsp:param name="val2" 		value="○"/>
											<jsp:param name="off"	 	value="off11"/>
											<jsp:param name="select" 	value="Item14"/>
										</jsp:include>
									</td>
									<td></td>
								</tr>
								<tr>
									<td>トルクレンチNo.</td>
									<td>ポップアップから選択。</td>
									<td id="td15">
										<jsp:include page="/include/include_selectionbox_required.jsp">
											<jsp:param name="btn_id"	 value="btn15"/>
											<jsp:param name="btn_text"	 value="トルクレンチNo."/>
											<jsp:param name="txt_id"	 value="Item15"/>
											<jsp:param name="select_txt" value="XT72N|T73N|T75N|T76N|T77N|T79N|／"/>
											<jsp:param name="width"	 	 value="100"/>
										</jsp:include>
									</td>
									<td>
										<jsp:include page="/include/include_ngswitch.jsp">
											<jsp:param name="off"	 value="off12"/>
											<jsp:param name="select" value="Item15"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>チューニングレベル量</td>
									<td>テンキー入力。</td>
									<td id="td16">
										<jsp:include page="/include/include_tenkey.jsp">
											<jsp:param name="btn_id"	value="btn16"/>
											<jsp:param name="btn_text"	value="チューニングレベル量"/>
											<jsp:param name="txt_id"	value="Item16"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									<td>
										<jsp:include page="/include/include_ngswitch.jsp">
											<jsp:param name="off"	 value="off13"/>
											<jsp:param name="select" value="Item16"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td>全項目</td><td>ズレ確認</td><td>再稼動時にボール位置を確認し ○ を選択</td>
									<td colspan=2>
										<jsp:include page="/include/include_okswitch.jsp">
											<jsp:param name="on"	 value="on1"/>
											<jsp:param name="select" value="Item02"/>
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