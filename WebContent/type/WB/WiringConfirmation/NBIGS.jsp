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
			/* セッション内の設備No.を取得 */
			$("#Setubi").val("${setuB}");
			/**
			 * イベントリスナーの登録
			 */
			 /* バリデーション処理 */
			$('#submitBtn')[0].addEventListener('click', function(){ValidationHandler()}, false);
			/* バーコード読取り時に反応するイベントリスナー */
			$('#Setubi')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Setubi')}, false);
			$('#Lot')	[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Lot')},    false);
			$('#Worker')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Worker')}, false);
			$('#Third')	[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Third')}, false);
			/* フォーカスロスト時に反応するイベントリスナー */
			$('#Setubi')[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Setubi')}, false);
			$('#Lot')	[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Lot')},    false);
			$('#Worker')[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Worker')}, false);
			$('#Third')	[0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Third')}, false);


			/**/
			$('#btn_kbn_pc,#btn_kbn_other').click(function() { $('#KBN').val($(this).text()); });

			/* 測定器Noの先頭にBを付けるイベント */
			$('#Sokuteiki').change(function(e) {
				//先頭のBのみ重複しないよう制御
				var val=$(this).val().replace(/B/, '');
				//TextBoxが空でれば何もしない
				if (val.length===0) return false;
				//入力値の先頭にBを付ける
				$(this).val('B'+val);
			});
			/* 登録No.の処理 */
			$('#KS').change(function(e) {
				//先頭の値が重複しないよう制御
				var kors=$('#KorS').val();
				var val=$(this).val().replace(kors, '');
				//TextBoxが空でれば何もしない
				if (val.length===0) return false;
				//入力値の先頭に K- S- を付ける
				$(this).val(kors+val);
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
				CommonFunctionServlet(id, words);
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
			CommonFunctionServlet(id, words);
		}
	</script>

	<script type="text/javascript">
		/*  */
		var CommonFunctionServlet = function(id, kLot) {
			if (id !== 'Lot') { return false; }
			//
			var result=collCommonFunctionServlet(functionkbn.getItemName, kLot);
			result.done(function(response) {
				$("#Product").val(response);
			});
			result.fail(function() {
				$("#Product").val('');
				$("#PKG").val('');
				$("#PBL").val('');
				bootbox.alert("組立ロットNo.が存在しません。");
				return;
			});
			//
			result=collCommonFunctionServlet(functionkbn.getPKG, kLot);
			result.done(function(response) {
				$("#PKG").val(response);
			});
			result=collCommonFunctionServlet(functionkbn.getPBLayoutDiagram, kLot);
			result.done(function(response) {
				$("#PBL").val(response);
			});
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
			var val=$('#PBLayout2').val();
			$('#PBLayout2').val($('input[name="PBLayout1"]:checked').val() + '-' + val);
			/*  */
			$('#params').val(getSerializableData(document.getElementById("fm")));
			/*  */
			$('#PBLayout2').val(val);
			$(':hidden[name="Setubi"]').val($('#Setubi').val());
			$(':hidden[name="Lot"]').val($('#Lot').val());

			/* サーブレットの呼出しを行う */
			$("#fm").submit();
		}
	</script>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>N-BIGS配線確認チェックシート</title>
	</head>
	<body>
		<div class="block">N-BIGS配線確認チェックシート</div>
		<jsp:include page="/include/include_pagetop.jsp"/>
		<form id="fm" action="<%=request.getContextPath()%>/TenkenListServlet" method="post">
			<input type="hidden" name="sheetnm" value="N-BIGS配線確認チェックシート">
			<input type="hidden" name="tanname" value="<%=tanname%>">
			<input type="hidden" name="Setubi"  value="">
			<input type="hidden" name="Lot"		value="">
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
						<td colspan=2>
							<jsp:include page="/include/include_inputtextex_required.jsp">
								<jsp:param name="btn"	 value="btn_lot"/>
								<jsp:param name="disp"	 value="ロットNo."/>
								<jsp:param name="txt"	 value="Lot"/>
								<jsp:param name="width"	 value="100"/>
							</jsp:include>
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<div class="boxContainer">
								<div><jsp:include page="/include/include_worker.jsp"/></div>
								<div style="margin:14px 0px 0px 0px">
									<jsp:include page="/include/include_inputtextex_required.jsp">
										<jsp:param name="btn"	 value="btn_third"/>
										<jsp:param name="disp"	 value="第三者"/>
										<jsp:param name="txt"	 value="Third"/>
										<jsp:param name="width"	 value="100"/>
									</jsp:include>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<div class="boxContainer">
								<div><span class="btn btn-primary btn-lg">品名</span></div>
								<div><input type="text" id="Product" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="background-color:#FFFFFF"></div>
								<div><span class="btn btn-primary btn-lg">着工ＰＫＧ</span></div>
								<div><input type="text" id="PKG" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="background-color:#FFFFFF"></div>
							</div>
						</td>
					</tr>
					<tr>
					    <td>
							<div class="boxContainer">
								<div><span class="btn btn-primary btn-lg">作業項目</span></div>
							    <div>
									<jsp:include page="/include/include_threeswitch.jsp">
										<jsp:param name="switch1"	 value="呼出品"/>
										<jsp:param name="switch2"	 value="座標入力品"/>
										<jsp:param name="off"		 value="off_sagyo"/>
										<jsp:param name="val1"		 value="呼出品"/>
										<jsp:param name="val2"	 	 value="座標入力品"/>
										<jsp:param name="select"	 value="Sagyo"/>
									</jsp:include>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<div class="boxContainer">
								<div style="margin:14px 0px 0px 0px">
									<jsp:include page="/include/include_tenkey_required.jsp">
										<jsp:param name="btn_id"	 value="btn_kbn"/>
										<jsp:param name="btn_text"	 value="区分"/>
										<jsp:param name="txt_id"	 value="KBN"/>
										<jsp:param name="width"	 value="100"/>
									</jsp:include>
								</div>
								<div><span id="btn_kbn_pc"    class="btn btn-info btn-lg" style="margin:15px 0px 0px 0px">PC</span></div>
								<div><span id="btn_kbn_other" class="btn btn-info btn-lg" style="margin:15px 0px 0px 0px">その他</span></div>
								<div style="margin:10px 0px 0px 20px">
									<jsp:include page="/include/include_tenkey_required.jsp">
										<jsp:param name="btn_id"	value="btn_sokuteiki"/>
										<jsp:param name="btn_text"	value="測定器No."/>
										<jsp:param name="txt_id"	value="Sokuteiki"/>
										<jsp:param name="width"		value="100"/>
									</jsp:include>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<table border=1>
								<tr>
									<td align="center" colspan=5>1段目 ループ品</td>
								<tr/>
								<tr>
									<td>測定箇所</td><td>1</td><td>2</td><td>3</td><td>4</td>
								</tr>
								<tr>
									<td>1段目H</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td>
								</tr>
								<tr>
									<td colspan=5>マトリクス</td>
								<tr/>
								<tr>
									<td>最終段目H</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td>
								</tr>
								<tr>
									<td colspan=5>
										<p>=注意=</p>
										<p>シングル品と基板品は1ICの測定。</p>
										<p>マトリクス品の金属フレーム品は上段目（1段目）と最終段目の2IC目測定</p>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table border=1>
								<tr>
									<td align="center" colspan=5>2段目 （高・低）ループ品</td>
								</tr>
								<tr>
									<td>測定箇所</td><td>1</td><td>2</td><td>3</td><td>4</td>
								</tr>
								<tr>
									<td>高</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td>
								</tr>
								<tr>
									<td>低</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td>
								</tr>
								<tr>
									<td>ｈ</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td>
								</tr>
							</table>
						</td>
					</tr>

					<tr>
						<td>
							<table border="1">
								<tr>
									<td align="center" colspan=5>3段目 （高・中・低）ループ品</td>
								</tr>
								<tr>
									<td>測定箇所</td><td>1</td><td>2</td><td>3</td><td>4</td>
								</tr>
								<tr>
									<td>高</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td>
								</tr>
								<tr>
									<td>中</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td>
								</tr>
								<tr>
									<td>低</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td>
								</tr>
								<tr>
									<td>高中ｈ1</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td>
								</tr>
								<tr>
									<td>中低ｈ2</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td>
								</tr>
								<tr>
								<tr/>
							</table>
						</td>
						<td>
							<table border="1">
								<tr>
									<td align="center" colspan=5>特殊ループ品</td>
								</tr>
								<tr>
									<td>測定箇所</td><td>1</td><td>2</td><td>3</td><td>4</td>
								</tr>
								<tr>
									<td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td>
								</tr>
								<tr>
									<td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td>
								</tr>
								<tr>
									<td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td>
								</tr>
								<tr>
									<td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td>
								</tr>
								<tr>
									<td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td><td>　　　　　　　　　　</td>
								</tr>
							</table>
						</td>
					</tr>

					<tr>
						<td colspan=2>
							<p>　●現品及び装置状態確認</p>

							<table border="1">
								<tr>
									<td>項目</td><td colspan=2>確認内容</td><td colspan=2>確認結果</td><td>OK or NG</td>
								</tr>

								<tr>
									<td>PBレイアウト図No.</td>
									<td colspan=2>PB-Layout図と伝票の照合</td>
									<td colspan=2>
										<input type="text" id="PBL" name="PBL" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:80%; background-color:#FFFFFF">
									</td>
									<td>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="btn_01"/>
											<jsp:param name="valon"	 value="OK"/>
											<jsp:param name="off"	 value="off1"/>
											<jsp:param name="valoff" value="NG"/>
											<jsp:param name="select" value="Item01"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td>登録No.</td>
									<td>データ内と管理台帳の照合</td>
									<td>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="k_on"/>
											<jsp:param name="valon"	 value="K-"/>
											<jsp:param name="off"	 value="s_off"/>
											<jsp:param name="valoff" value="S-"/>
											<jsp:param name="select" value="KorS"/>
										</jsp:include>
									</td>
									<td colspan=2>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn_KS"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="KS"/>
													<jsp:param name="width"		value="100"/>
												</jsp:include>
											</div>
										</div>
									</td>
									<td>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="btn_02"/>
											<jsp:param name="valon"	 value="OK"/>
											<jsp:param name="off"	 value="off02"/>
											<jsp:param name="valoff" value="NG"/>
											<jsp:param name="select" value="Item02"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td rowspan=2>ダイ名位置</td>
									<td rowspan=2 colspan=2><img src='<%=request.getContextPath() + "/img/Daimei_ichi.png"%>'></td>
									<td colspan=2>
										<div class="boxContainer">
											<div class="btn_group_80" style="margin : 3.5px 0px 0px 0px">
												<input type="radio" name="PBLayout1" id="btn_radio1" value="1" checked>
												<label for="btn_radio1">1</label>
												<input type="radio" name="PBLayout1" id="btn_radio2" value="2">
												<label for="btn_radio2">2</label>
												<input type="radio" name="PBLayout1" id="btn_radio3" value="3">
												<label for="btn_radio3">3</label>
												<input type="radio" name="PBLayout1" id="btn_radio4" value="4">
												<label for="btn_radio4">4</label>
											</div>
										</div>
									</td>

									<td rowspan=2>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="btn_03"/>
											<jsp:param name="valon"	 value="OK"/>
											<jsp:param name="off"	 value="off03"/>
											<jsp:param name="valoff" value="NG"/>
											<jsp:param name="select" value="Item03"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td colspan=2>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="PBLayout_on"/>
											<jsp:param name="valon"	 value="縦"/>
											<jsp:param name="off"	 value="PBLayout_off"/>
											<jsp:param name="valoff" value="横"/>
											<jsp:param name="select" value="PBLayout2"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td>レール幅値</td>
									<td colspan=2>クリアランス調整後、装置モニタの数値を確認</td>
									<td colspan=2>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn_rail"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="rail"/>
													<jsp:param name="width"		value="100"/>
												</jsp:include>
											</div>
										</div>
									</td>

									<td>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="btn_04"/>
											<jsp:param name="valon"	 value="OK"/>
											<jsp:param name="off"	 value="off_04"/>
											<jsp:param name="valoff" value="NG"/>
											<jsp:param name="select" value="Item04"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
								</tr>

								<tr>
									<td>L/F刻印位置</td>
									<td colspan=2>実体顕微鏡ステージ上製品のＬ／Ｆ刻印が、正規に読める状態で刻印位置がどこにあるか確認する</td>
									<td colspan=2>
										<div class="boxContainer">
											<div class="btn_group_80" style="margin:3.5px 0px 0px 0px">
												<input type="radio" name="dir" id="radio上" value="上" checked>
												<label for="radio上">上</label>
												<input type="radio" name="dir" id="radio下" value="下">
												<label for="radio下">下</label>
												<input type="radio" name="dir" id="radio左" value="左">
												<label for="radio左">左</label>
												<input type="radio" name="dir" id="radio右" value="右">
												<label for="radio右">右</label>
											</div>
										</div>
									</td>
									<td>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="btn_05"/>
											<jsp:param name="valon"	 value="OK"/>
											<jsp:param name="off"	 value="off05"/>
											<jsp:param name="valoff" value="NG"/>
											<jsp:param name="select" value="Item05"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td>リード圧痕形状確認</td>
									<td colspan=2>リード側の圧痕形状が平均的に潰れているか、<br>キャピラリ先端の圧痕が丸く残っているか。<br>又規格内にあるか目視にて確認する（全段確認)</td>
									<td colspan=2>‐</td>
									<td>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="btn_06"/>
											<jsp:param name="valon"	 value="OK"/>
											<jsp:param name="off"	 value="off06"/>
											<jsp:param name="valoff" value="NG"/>
											<jsp:param name="select" value="Item06"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td>N-BIGS座標評価結果</td>
									<td colspan=2>N-BIGSパソコンでOK or NGを確認する。</td>
									<td colspan=2>‐</td>
									<td>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="btn_07"/>
											<jsp:param name="valon"	 value="OK"/>
											<jsp:param name="off"	 value="off07"/>
											<jsp:param name="valoff" value="NG"/>
											<jsp:param name="select" value="Item07"/>
										</jsp:include>
									</td>
								</tr>

								<tr>
									<td rowspan=4>トレーサビリティワイヤ（ラック流しの場合）</td>
									<td rowspan=4 colspan=2><img src='<%=request.getContextPath() + "/img/tracablity.png"%>'></td>
								</tr>
								<tr>
									<td colspan=2>
										<div class="boxContainer">
											<div>100の位</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn_place100"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="place100"/>
													<jsp:param name="width"		value="100"/>
												</jsp:include>
											</div>
										</div>
									</td>
									<td rowspan=3>
										<jsp:include page="/include/include_twoswitch.jsp">
											<jsp:param name="on"	 value="btn_08"/>
											<jsp:param name="valon"	 value="OK"/>
											<jsp:param name="off"	 value="off08"/>
											<jsp:param name="valoff" value="NG"/>
											<jsp:param name="select" value="Item08"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td colspan=2>
										<div class="boxContainer">
											<div>10の位</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn_place10"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="place10"/>
													<jsp:param name="width"		value="100"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td colspan=2>
										<div class="boxContainer">
											<div>1の位</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="btn_place1"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="place1"/>
													<jsp:param name="width"		value="100"/>
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