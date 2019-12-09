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
			/* バーコード読取り時に反応するイベントリスナー */
			$('#Setubi')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Setubi')}, false);
			$('#Wlot')	[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Wlot')},   false);
			$('#Worker')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Worker')}, false);
			/* フォーカスロスト時に反応するイベントリスナー */
			$('#Setubi')[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Setubi')}, false);
			$('#Wlot')	[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Wlot')},   false);
			$('#Worker')[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Worker')}, false);
			/* チェックボックスによる活性/非活性処理 */
			$('#select1')[0].addEventListener('change', function(){CheckboxHandler('select1')}, false);
			$('#select2')[0].addEventListener('change', function(){CheckboxHandler('select2')}, false);
			$('#select3')[0].addEventListener('change', function(){CheckboxHandler('select3')}, false);
			/* バリデーション処理 */
			$('#submitBtn')[0].addEventListener('click', function(){ValidationHandler()}, false);
			/* 初期化処理 */
			CheckboxHandler('select1');
			CheckboxHandler('select2');
			CheckboxHandler('select3');
			$('#Item21').val(+0);

			$('#Item12, #Item13, #Item14, #Item15, #Item16, #Item17, #Item18, #Item19, #Item20').on('focusout', function() {
				var max = 0;
				max = (+max < +$('#Item12').val()) ? +$('#Item12').val() : +max;
				max = (+max < +$('#Item13').val()) ? +$('#Item13').val() : +max;
				max = (+max < +$('#Item14').val()) ? +$('#Item14').val() : +max;
				max = (+max < +$('#Item15').val()) ? +$('#Item15').val() : +max;
				max = (+max < +$('#Item16').val()) ? +$('#Item16').val() : +max;
				max = (+max < +$('#Item17').val()) ? +$('#Item17').val() : +max;
				max = (+max < +$('#Item18').val()) ? +$('#Item18').val() : +max;
				max = (+max < +$('#Item19').val()) ? +$('#Item19').val() : +max;
				max = (+max < +$('#Item20').val()) ? +$('#Item20').val() : +max;
				$('#Item21').val(+max);
			});

			/* 測定器Noの先頭にPを付けるイベント */
			$('#Sokuteiki').change(function(e) {
				//先頭のPのみ重複しないよう制御
				var val=$(this).val().replace(/P/, '');
				//TextBoxが空でれば何もしない
				if (val.length===0) return false;
				//入力値の先頭にPを付ける
				$(this).val('P'+val);
			});
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
				$("#shift").val(getShift(date));
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
		var CheckboxHandler = function(id) {
			if(id==='select1') 		  { tbl1(id);
			} else if(id==='select2') { tbl2(id);
			} else if(id==='select3') { tbl3(id);
			}
			tbl4();
		}
	</script>

	<script type="text/javascript">
		function tbl1(id) {
			if($("#" + id).prop('checked')) {
				$('#tbl1').show();
				$('#Item01, #Item02, #Item03, #Item04, #Item05, #Item06, #Item07, #Item08, #Item09, #Item10, #Item11, #Item12, #Item13, #Item14, #Item15, #Item16, #Item17, #Item18, #Item19, #Item20, #Item21').prop("disabled", false);
			} else {
				$('#tbl1').hide();
				$('#Item01, #Item02, #Item03, #Item04, #Item05, #Item06, #Item07, #Item08, #Item09, #Item10, #Item11, #Item12, #Item13, #Item14, #Item15, #Item16, #Item17, #Item18, #Item19, #Item20, #Item21').prop("disabled", true);
			}
		}

		function tbl2(id) {
			if($("#" + id).prop('checked')) {
				$('#tbl2').show();
				$('#Item22, #Item23, #Item24').prop("disabled", false);
			} else {
				$('#tbl2').hide();
				$('#Item22, #Item23, #Item24').prop("disabled", true);
			}
		}

		function tbl3(id) {
			if($("#" + id).prop('checked')) {
				$('#tbl3').show();
				$('#Item25, #Item26, #Item27, #Item28, #Item29, #Item30').prop("disabled", false);
			} else {
				$('#tbl3').hide();
				$('#Item25, #Item26, #Item27, #Item28, #Item29, #Item30').prop("disabled", true);
			}
		}

		function tbl4() {
			if($("#select1, #select2").prop('checked') || $("#select2").prop('checked')) {
				$('#tbl4').show();
				$('#Item31, #Item32').prop("disabled", false);
			} else {
				$('#tbl4').hide();
				$('#Item31, #Item32').prop("disabled", true);
			}
		}
	</script>

	<script type="text/javascript">
		/* 保存前のバリデーション処理を行う */
		var ValidationHandler = function() {
			/* 確認の選択漏れ確認 */
			if(!($('#select1').prop('checked') || $('#select2').prop('checked') || $('#select3').prop('checked'))){
				$("#alert_chkbox").show();
				return false;
			} else {
				$("#alert_chkbox").hide();
			}
			submit();
		}
	</script>

	<script type="text/javascript">
		var submit = function() {
			/* バリデーションプラグインの登録  */
			$('#fm').validationEngine();
			/*  */
			$('#params').val(getSerializableData(document.getElementById("fm")));
			$(':hidden[name="Setubi"]').val($('#Setubi').val());
			/* サーブレットの呼出しを行う */
			$("#fm").submit();
		}
	</script>
	<!-- Script宣言部ここまで -->


	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>べベルカット　セルフチェックシート</title>
	</head>

	<body>
		<% request.setCharacterEncoding("UTF-8");%>
		<div class="block">べベルカット　セルフチェックシート</div>
		<jsp:include page="/include/include_pagetop.jsp"/>
		<form id="fm" action="<%=request.getContextPath()%>/TenkenListServlet" method="post">
			<input type="hidden" name="sheetnm" value="べベルカット　セルフチェックシート">
			<input type="hidden" name="tanname" value="<%=tanname%>">
			<input type="hidden" name="Setubi"  value="">
			<input type="hidden" name="params" id="params" value="">

			<div class="bs-example table-responsive">
				<table class="table table-hover">
					<tr>
						<td><jsp:include page="/include/include_setubidata.jsp"/></td>
					</tr>
					<tr>
						<td><jsp:include page="/include/include_kakusanlotdata.jsp"/></td>
					</tr>
					<tr>
						<td>
							<a class="inline label label-info" style="font-size:large" href="#DicingCondition">ダイシング条件確認</a>
						</td>
					</tr>
					<tr>
						<td>
							<jsp:include page="/include/include_alertbar.jsp">
								<jsp:param name="id"	value="alert_chkbox" />
								<jsp:param name="msg"	value="確認を選択して下さい。" />
							</jsp:include>
							<div class="boxContainer">
								<div><span class="btn btn-primary btn-lg">確認</span></div>
								<div class="btn_group_180">
									<input type="checkbox" name="select" id="select1" value="使用軸：Z1">
									<label for="select1">使用軸：Z1</label>
									<input type="checkbox" name="select" id="select2" value="使用軸：Z2">
									<label for="select2">使用軸：Z2</label>
									<input type="checkbox" name="select" id="select3" value="チャックテーブル管理">
									<label for="select3">チャックテーブル管理</label>
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td>
							<table id="tbl1" border="1">
								<tr>
									<td colspan=3>
										<div class="boxContainer">
										<div><span class="btn btn-primary btn-lg" style="width:100px; margin:8px 0px 0px 0px;">使用軸Z1</span></div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn01"/>
													<jsp:param name="btn_text"	value="即定時ライン数"/>
													<jsp:param name="txt_id"	value="Item01"/>
													<jsp:param name="width"		value="100"/>
												</jsp:include>
											</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn02"/>
													<jsp:param name="btn_text"	value="カーフ幅（実測値）"/>
													<jsp:param name="txt_id"	value="Item02"/>
													<jsp:param name="width"		value="100"/>
												</jsp:include>
											</div>
											<div>
												<jsp:include page="/include/include_selectionbox_required.jsp">
													<jsp:param name="btn_id"	 value="btn03" />
													<jsp:param name="btn_text"	 value="測定目的" />
													<jsp:param name="txt_id"	 value="Item03" />
													<jsp:param name="select_txt" value="立上げ時|ブレード交換（定期）|ブレード交換（破損）|ブレード交換（品種）|新規データ作成時|条件変更時" />
													<jsp:param name="width"	 	 value="100"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td rowspan=2></td>
									<td colspan=2 style="text-align:center;">カーフ幅管理（チッピング含む）</td>
								</tr>

								<tr>
									<td>ウエハ段数1枚目</td><td>ウエハ段数11枚目</td>
								</tr>
								<tr>
									<td rowspan=3>カーフ幅</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_tenkey_required.jsp">
											<jsp:param name="btn_id"	value="btn04"/>
											<jsp:param name="btn_text"	value="1ライン目"/>
											<jsp:param name="txt_id"	value="Item04"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
									<td>
										<jsp:include page="/include/include_tenkey_required.jsp">
											<jsp:param name="btn_id"	value="btn05"/>
											<jsp:param name="btn_text"	value="1ライン目"/>
											<jsp:param name="txt_id"	value="Item05"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_tenkey_required.jsp">
											<jsp:param name="btn_id"	value="btn06"/>
											<jsp:param name="btn_text"	value="2ライン目"/>
											<jsp:param name="txt_id"	value="Item06"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
									<td>
										<jsp:include page="/include/include_tenkey_required.jsp">
											<jsp:param name="btn_id"	value="btn07"/>
											<jsp:param name="btn_text"	value="2ライン目"/>
											<jsp:param name="txt_id"	value="Item07"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td rowspan=3>ハイト量</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_tenkey_required.jsp">
											<jsp:param name="btn_id"	value="btn08"/>
											<jsp:param name="btn_text"	value="1ライン目"/>
											<jsp:param name="txt_id"	value="Item08"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
									<td>
										<jsp:include page="/include/include_tenkey_required.jsp">
											<jsp:param name="btn_id"	value="btn09"/>
											<jsp:param name="btn_text"	value="1ライン目"/>
											<jsp:param name="txt_id"	value="Item09"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_tenkey_required.jsp">
											<jsp:param name="btn_id"	value="btn10"/>
											<jsp:param name="btn_text"	value="2ライン目"/>
											<jsp:param name="txt_id"	value="Item10"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
									<td>
										<jsp:include page="/include/include_tenkey_required.jsp">
											<jsp:param name="btn_id"	value="btn11"/>
											<jsp:param name="btn_text"	value="2ライン目"/>
											<jsp:param name="txt_id"	value="Item11"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td colspan=3 style="text-align: center;">チッピング量測定</td>
								</tr>
								<tr>
									<td colspan=3 style="text-align: center;">ウエハ1枚目チッピング量（測定9point）</td>
								</tr>
								<tr>
									<td colspan=3>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn12" />
													<jsp:param name="btn_text"	value="point1" />
													<jsp:param name="txt_id"	value="Item12" />
													<jsp:param name="width"		value="100"/>
												</jsp:include>
											</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn13" />
													<jsp:param name="btn_text"	value="point2" />
													<jsp:param name="txt_id"	value="Item13" />
													<jsp:param name="width"	 	value="100"/>
												</jsp:include>
											</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn14" />
													<jsp:param name="btn_text"	value="point3" />
													<jsp:param name="txt_id"	value="Item14" />
													<jsp:param name="width"		value="100"/>
												</jsp:include>
											</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn15" />
													<jsp:param name="btn_text"	value="point4" />
													<jsp:param name="txt_id"	value="Item15" />
													<jsp:param name="width"	 	value="100"/>
												</jsp:include>
											</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn16" />
													<jsp:param name="btn_text"	value="point5" />
													<jsp:param name="txt_id"	value="Item16" />
													<jsp:param name="width"		value="100"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td colspan=3>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn17" />
													<jsp:param name="btn_text"	value="point6" />
													<jsp:param name="txt_id"	value="Item17" />
													<jsp:param name="width"	 	value="100"/>
												</jsp:include>
											</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn18" />
													<jsp:param name="btn_text"	value="point7" />
													<jsp:param name="txt_id"	value="Item18" />
													<jsp:param name="width"	 	value="100"/>
												</jsp:include>
											</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn19" />
													<jsp:param name="btn_text"	value="point8" />
													<jsp:param name="txt_id"	value="Item19" />
													<jsp:param name="width"	 	value="100"/>
												</jsp:include>
											</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn20" />
													<jsp:param name="btn_text"	value="point9" />
													<jsp:param name="txt_id"	value="Item20" />
													<jsp:param name="width"	 	value="100"/>
												</jsp:include>
											</div>
											<div><span class="btn btn-primary btn-lg" style="width:100px; margin:8px 0px 0px 0px;">MAX</span></div>
											<div><input type="text" id="Item21" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:10px 10px 10px 0px; background-color:#FFFFFF"></div>
										</div>
									</td>
								</tr>

							</table>
						</td>
					</tr>
					<tr>
						<td>
							<table id="tbl2" border="1">
								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg" style="width:100px; margin:8px 0px 0px 0px;">使用軸Z2</span></div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn22"/>
													<jsp:param name="btn_text"	value="即定時ライン数"/>
													<jsp:param name="txt_id"	value="Item22"/>
													<jsp:param name="width"		value="100"/>
												</jsp:include>
											</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn23"/>
													<jsp:param name="btn_text"	value="切込み量"/>
													<jsp:param name="txt_id"	value="Item23"/>
													<jsp:param name="width"		value="100"/>
												</jsp:include>
											</div>
											<div>
												<jsp:include page="/include/include_selectionbox_required.jsp">
													<jsp:param name="btn_id"	 value="btn24" />
													<jsp:param name="btn_text"	 value="測定目的" />
													<jsp:param name="txt_id"	 value="Item24" />
													<jsp:param name="select_txt" value="立上げ時|ブレード交換（定期）|ブレード交換（破損）|ブレード交換（品種）|新規データ作成時|条件変更時" />
													<jsp:param name="width"	 	 value="100"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>

					<tr>
						<td>
							<table id="tbl3" border="1">
								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg" style="margin:8px 0px 0px 0px;">チャックテーブル管理（テーブル平坦度測定）【変動値８μm以下】</span></div>
											<div>
												<jsp:include page="/include/include_selectionbox_required.jsp">
													<jsp:param name="btn_id"	 value="btn25" />
													<jsp:param name="btn_text"	 value="測定目的" />
													<jsp:param name="txt_id"	 value="Item25" />
													<jsp:param name="select_txt" value="月末測定（棚卸し日）|テーブル交換" />
													<jsp:param name="width"	 	 value="100"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td colspan=2>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn26"/>
													<jsp:param name="btn_text"	value="①"/>
													<jsp:param name="txt_id"	value="Item26"/>
													<jsp:param name="width"		value="100"/>
												</jsp:include>
											</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn27"/>
													<jsp:param name="btn_text"	value="②"/>
													<jsp:param name="txt_id"	value="Item27"/>
													<jsp:param name="width"		value="100"/>
												</jsp:include>
											</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn28" />
													<jsp:param name="btn_text"	value="③" />
													<jsp:param name="txt_id"	value="Item28" />
													<jsp:param name="width"		value="100"/>
												</jsp:include>
											</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn29"/>
													<jsp:param name="btn_text"	value="④"/>
													<jsp:param name="txt_id"	value="Item29"/>
													<jsp:param name="width"		value="100"/>
												</jsp:include>
											</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn30"/>
													<jsp:param name="btn_text"	value="⑤"/>
													<jsp:param name="txt_id"	value="Item30"/>
													<jsp:param name="width"		value="100"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>

					<tr>
						<td>
							<table id="tbl4">
								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">外観検査（4点×4pic）</span></div>
											<div>
												<jsp:include page="/include/include_twoswitch.jsp">
													<jsp:param name="on"	 value="OK31"/>
													<jsp:param name="valon"	 value="OK"/>
													<jsp:param name="off"	 value="NG31"/>
													<jsp:param name="valoff" value="NG"/>
													<jsp:param name="select" value="Item31"/>
												</jsp:include>
											</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">べベルカットテーパー有無 Z1軸</span></div>
											<div>
												<jsp:include page="/include/include_twoswitch.jsp">
													<jsp:param name="on"	 value="OK32"/>
													<jsp:param name="valon"	 value="OK"/>
													<jsp:param name="off"	 value="NG32"/>
													<jsp:param name="valoff" value="NG"/>
													<jsp:param name="select" value="Item32"/>
												</jsp:include>
											</div>
										</div>

									</td>
								</tr>
							</table>
						</td>

						<tr>
							<td>
								<div class="boxContainer">
									<div>
										<jsp:include page="/include/include_tenkey_required.jsp">
											<jsp:param name="btn_id"	value="btn_sokuteiki"/>
											<jsp:param name="btn_text"	value="測定器"/>
											<jsp:param name="txt_id"	value="Sokuteiki"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</div>
									<div><span class="btn btn-primary btn-lg">判定結果</span></div>
									<div>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="OK33"/>
											<jsp:param name="valon"	 value="OK"/>
											<jsp:param name="off"	 value="NG33"/>
											<jsp:param name="valoff" value="NG"/>
											<jsp:param name="select" value="Item33"/>
										</jsp:include>
									</div>
								</div>
							</td>
						</tr>

				</table>
			</div>
		</form>
	</body>

	<!--モーダルで表示させる要素-->
	<div style="display: none;">
		<section id="DicingCondition">
			<h3>(表-1) ダイシング条件</h3>
			<table border="1">
				<tr align="center">
					<td>使用軸</td>
					<td colspan=2>ブレード仕様</td>
					<td colspan=2>カーフ厚</td>
					<td>テープ切込み量</td>
					<td>ブレードライフ</td>
					<td>べベルカットの状態</td>
				</tr>
				<tr align="center">
					<td rowspan=3>Z1</td>
					<td rowspan=3>ZH-2050-D-T1</td>
					<td rowspan=3>20μm厚・先端角度90°</td>
				</tr>
				<tr align="center">
					<td>管理値</td>
					<td>90～100μm</td>
					<td>＼</td>
					<td rowspan=3>3500ライン以下</td>
					<td rowspan=3>デーパーがあること<br/>0μm以上</td>
				</tr>
				<tr align="center">
					<td>目標値</td>
					<td>100μm狙</td>
					<td>＼</td>
				</tr>
				<tr align="center">
					<td rowspan=3>Z2</td>
					<td rowspan=3>Z2050 27HEFH</td>
					<td rowspan=3>70μm厚</td>
				</tr>
				<tr align="center">
					<td>管理値</td>
					<td>＼</td>
					<td>5～25μm</td>
					<td rowspan=3>3500ライン以下</td>
					<td rowspan=3>＼</td>
				</tr>
				<tr align="center">
					<td>目標値</td>
					<td>＼</td>
					<td>20μm</td>
				</tr>
			</table>
		</section>
	</div>

	<!-- cssフレームワーク  -->
	<jsp:include page="/include/include_bootstrap.jsp"/>
</html>