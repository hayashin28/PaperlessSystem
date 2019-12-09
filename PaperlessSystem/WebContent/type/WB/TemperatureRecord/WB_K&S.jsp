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
			$('#select4')[0].addEventListener('change', function(){CheckboxHandler('select4')}, false);
			$('#select5')[0].addEventListener('change', function(){CheckboxHandler('select5')}, false);
			/* バーコード読取り時に反応するイベントリスナー */
			$('#Setubi')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Setubi')}, false);
			$('#Worker')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Worker')}, false);
			/* フォーカスロスト時に反応するイベントリスナー */
			$('#Setubi')[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Setubi')}, false);
			$('#Worker')[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Worker')}, false);
			/* 測定器Noの先頭にHを付けるイベント */
			$('#Item06').change(function(e) {
				//先頭のHのみ重複しないよう制御
				var val=$(this).val().replace(/H/, '');
				//TextBoxが空でれば何もしない
				if (val.length===0) return false;
				//入力値の先頭にHを付ける
				$(this).val('H'+val);
			});
			/* 初期表示処理 */
			CheckboxHandler('select5');
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
		$(window).load(function() {
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
				words = '';
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
		var CheckboxHandler = function(id) {
			$("#tbl").show();
			$("#Item02, #Item03, #Item04, #Item05, #Item06, #Item08, #Item09, #Item10").prop('disabled', false);
			$(":input[name='Item07']").prop('disabled',false);
			if(id==='select1' && $("#select1").prop('checked')) {
				$(":input[name='Item02']").prop('disabled',false);
				$("#select2, #select3, #select4, #select5").prop('checked', false);
			}
			else {
				$(":input[name='Item02']").prop('checked',false);
				$(":input[name='Item02']").prop('disabled',true);

				if (id==='select2' ||id==='select3' || id==='select4') {
					$("#select1, #select5").prop('checked', false);
				}  else  {
					$("#tbl").hide();
					$(":input[name='Item07']").prop('checked',false);
					$(":input[name='Item07']").prop('disabled',true);
					$("#select1, #select2, #select3, #select4").prop('checked', false);
					$("#Item02, #Item03, #Item04, #Item05, #Item06, #Item08, #Item09, #Item10").val('');
					$("#Item02, #Item03, #Item04, #Item05, #Item06, #Item08, #Item09, #Item10").prop('disabled', true);
				}
			}
		}
	</script>

	<script type="text/javascript">
		/* 保存前のバリデーション処理を行う */
		var ValidationHandler = function() {
			/* 変化点の選択漏れ確認 */
			if(!($('#select1').prop('checked') || $('#select2').prop('checked') || $('#select3').prop('checked') || $('#select4').prop('checked') || $('#select5').prop('checked'))) {
				$("#alert_chkbox").show();
				return false;
			} else {
				$("#alert_chkbox").hide();
			}
			/* 個別バリデーション処理 */
			// 計画停止は個別バリデーションの対象外
			if ($("#select5").prop('checked')) { submit(); return; }
			if (!$.isNumeric($("#Item08").val())) {
				bootbox.alert("実測温度/アフターヒーターに数値を入力してください。");
				return false;
			}
			//メインヒータに関するValidate
			var msg='';
			var num = $("#Item08").val();
			var val = $("input[name='Item07']:checked").val();
			if (!val) {
				msg+='【温度仕様】メインヒータが選択されていません。<br/>';
			} else {
				//最初の一文字を取得する
				val = val.slice(0, 1);
				var  bool = false;
				switch(val){
			      case '①' : if (!(140<=num && num<=160)) bool = true; break;
			      case '②' : if (!(155<=num && num<=165)) bool = true; break;
			      case '③' : if (!(160<=num && num<=180)) bool = true; break;
			      case '④' : if (!(190<=num && num<=210)) bool = true; break;
			      case '⑤' : if (!(220<=num && num<=240)) bool = true; break;
			      case '⑥' : if (!(230<=num && num<=250)) bool = true; break;
			      case '⑦' : if (!(250<=num && num<=270)) bool = true; break;
			      default 	: break;
				}
				if (bool) msg += '【実測温度】指定された温度仕様の範囲外です。<br/>';
			}
			num = $("#Item09").val();
			if (!(100<=num && num<=160)) msg += '【アフターヒーター】温度が範囲外です。<br/>';
			if(0<msg.length) { $("#Item10").val('×'); msg += '【判定】判定結果が×です。<br/>'; }
			else { $("#Item10").val('○'); }

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
			/* サーブレットの呼出しを行う */
			$("#fm").submit();
		}
	</script>
	<!-- Script宣言部ここまで -->


	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Ｋ＆Ｓ　ワイヤボンダ作業温度実測記録</title>
	</head>

	<body>
		<div class="block">Ｋ＆Ｓ　ワイヤボンダ作業温度実測記録</div>
		<jsp:include page="/include/include_pagetop.jsp"/>
		<form id="fm" action="<%=request.getContextPath()%>/TenkenListServlet" method="post">
			<input type="hidden" name="sheetnm" value="Ｋ＆Ｓ　ワイヤボンダ作業温度実測記録">
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
							<jsp:include page="/include/include_alertbar.jsp">
								<jsp:param name="id"	 value="alert_chkbox" />
								<jsp:param name="msg"	 value="交換理由を選択して下さい。" />
							</jsp:include>
							<div class="boxContainer">
								<div class="btn btn-primary btn-lg">交換理由</div>
								<div class="btn_group_180" style="margin : 3.5px 0px 0px 0px">
									<input type="checkbox" name="Item01" id="select1" value="定期1回/週">
									<label for="select1">定期1回/週</label>
									<input type="checkbox" name="Item01" id="select2" value="品種交換">
									<label for="select2">品種交換</label>
									<input type="checkbox" name="Item01" id="select3" value="治工具交換">
									<label for="select3">治工具交換</label>
									<input type="checkbox" name="Item01" id="select4" value="他">
									<label for="select4">他</label>
									<input type="checkbox" name="Item01" id="select5" value="計画停止">
									<label for="select5">計画停止</label>
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td colspan=2>
							<table class="table table-hover" id="tbl" >
								<tr>
									<td>大項目</td><td colspan=2>項目</td><td>前回入力値</td><td>今回入力値</td>
								</tr>
								<tr>
									<td colspan=3>測定曜日</td>
									<td><input type="text" name="Item02" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
											<div class="btn_group_80" style="margin : 3.5px 0px 0px 0px">
												<input type="radio" name="Item02" id="radio月" value="月">
												<label for="radio月">月</label>
												<input type="radio" name="Item02" id="radio火" value="火">
												<label for="radio火">火</label>
												<input type="radio" name="Item02" id="radio水" value="水">
												<label for="radio水">水</label>
												<input type="radio" name="Item02" id="radio木" value="木">
												<label for="radio木">木</label>
												<input type="radio" name="Item02" id="radio金" value="金">
												<label for="radio金">金</label>
												<input type="radio" name="Item02" id="radio土" value="土">
												<label for="radio土">土</label>
												<input type="radio" name="Item02" id="radio日" value="日">
												<label for="radio日">日</label>
											</div>
									</td>
								</tr>

								<tr>
									<td rowspan=3>温度計指示値</td><td colspan=2>PRE</td>
									<td><input type="text" name="Item03" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey_required.jsp">
											<jsp:param name="btn_id"	value="btn03"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item03"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td colspan=2>BOND</td>
									<td><input type="text" name="Item04" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey_required.jsp">
											<jsp:param name="btn_id"	value="btn04"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item04"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td colspan=2>POST</td>
									<td><input type="text" name="Item05" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey_required.jsp">
											<jsp:param name="btn_id"	value="btn05"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item05"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td rowspan=5>ヒートステージ<br/>表面温度測定</td>
									<td colspan=2>測定器No.</td>
									<td><input type="text" name="Item06" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey_required.jsp">
											<jsp:param name="btn_id"	value="btn06"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item06"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td rowspan=3>メインヒータ</td>
								</tr>
								<tr>
									<td>温度仕様</td>
									<td><input type="text" name="Item07" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<div class="btn_group_180" style="margin : 3.5px 0px 0px 0px">
											<input type="radio" name="Item07" id="radio①" value="①140～160℃">
											<label for="radio①">①140～160℃</label>
											<input type="radio" name="Item07" id="radio②" value="②155～165℃">
											<label for="radio②">②155～165℃</label>
											<input type="radio" name="Item07" id="radio③" value="③160～180℃">
											<label for="radio③">③160～180℃</label>
											<input type="radio" name="Item07" id="radio④" value="④190～210℃">
											<label for="radio④">④190～210℃</label>
											<input type="radio" name="Item07" id="radio⑤" value="⑤220～240℃">
											<label for="radio⑤">⑤220～240℃</label>
											<input type="radio" name="Item07" id="radio⑥" value="⑥230～250℃">
											<label for="radio⑥">⑥230～250℃</label>
											<input type="radio" name="Item07" id="radio⑦" value="⑦250～270℃">
											<label for="radio⑦">⑦250～270℃</label>
										</div>
									</td>
								</tr>
								<tr>
									<td>実測温度</td>
									<td><input type="text" name="Item08" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey_required.jsp">
											<jsp:param name="btn_id"	value="btn08"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item08"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td colspan=2>アフターヒーター<br/>(100～160℃)</td>
									<td><input type="text" name="Item09" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
									<td>
										<jsp:include page="/include/include_tenkey_required.jsp">
											<jsp:param name="btn_id"	value="btn09"/>
											<jsp:param name="btn_text"	value="テンキー"/>
											<jsp:param name="txt_id"	value="Item09"/>
											<jsp:param name="width"		value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td colspan=4>判定</td>
									<td><input type="text" id="Item10" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="margin:10px 0px 0px 0px;background-color:#FFFFFF"></td>
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
