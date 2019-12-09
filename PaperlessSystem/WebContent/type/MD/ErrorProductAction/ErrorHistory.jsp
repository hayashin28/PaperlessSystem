<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="common.Enum"%>
<%@page import="java.sql.Timestamp"%>
<!DOCTYPE html>
<html>

	<jsp:include page="/include/include_scriptframework.jsp"/>

	<% String tanname = System.getProperty("user.name");%>
	<% request.setCharacterEncoding("UTF-8"); %>

	<head>

		<jsp:include page="/include/include_loader.jsp"/>

		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>モールド装置エラー発生時の製品処置来歴</title>
	</head>
	<body>
		<div id="loader-bg">
			<div id="loader">
				<img src='<%=request.getContextPath() + "/img/loader.gif"%>' width="80" height="80"
					alt="Now Loading..." />
				<p>Now Loading...</p>
			</div>
		</div>
		<div id="wrap">

			<div class="block">モールド装置エラー発生時の製品処置来歴</div>
			<form id="fm" action="<%=request.getContextPath()%>/TenkenListServlet" method="post">
				<input type="hidden" name="sheetnm" value="モールド装置エラー発生時の製品処置来歴">
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
							<td>
						</tr>
						<tr>
							<td><jsp:include page="/include/include_equip.jsp"/></td>
						</tr>
						<tr>
							<td colspan=2>
								<p>※１　Ｑ１・全数検査品については当該ショットをアルミで包み一時保管の用紙に詳細を記載しＩＣタグへ添付。</p>
								<p>　　　 「一時保管添付」にチェックし、ベーク完で製品処置を行う。</p>
								<p>　　　 （チョコ停発生時の品質確認結果台帳に来歴を残す）</p>
								<p>※２　製品処置については、製造仕様書Y-01-00433参照（製造ポイント票）</p>
							</td>
						</tr>
						<tr>
							<td>
								<table border="1">
									<tr>
										<td colspan=2>発生日時</td>
										<td>
											<input type="text" id="Date" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:150px; margin:10px 10px 10px 0px; background-color:#FFFFFF">
										</td>
									</tr>
									<tr>
										<td colspan=2>チョコ停内容</td>
										<td>
											<jsp:include page="/include/include_inputtextex_required.jsp">
												<jsp:param name="btn"		value="Choco"/>
												<jsp:param name="disp"		value="チョコ停"/>
												<jsp:param name="txt"		value="Choco"/>
												<jsp:param name="width"		value="100"/>
											</jsp:include>
										</td>
									</tr>
									<tr>
										<td colspan=2></td>
										<td>
											<input type="text" id="Messege" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:250px; margin:10px 10px 10px 0px; background-color:#FFFFFF">
										</td>
									</tr>
									<tr>
										<td colspan=2>ロットＮｏ．</td>
										<td>
											<jsp:include page="/include/include_inputtextex_required.jsp">
												<jsp:param name="btn"	 value="lot" />
												<jsp:param name="disp"	 value="クリア" />
												<jsp:param name="txt"	 value="Lot" />
												<jsp:param name="width"	 value="100"/>
											</jsp:include>
										</td>
									</tr>
									<tr>
										<td colspan=2>グレード</td>
										<td>
											<input type="text" id="Sinrai" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:10px 10px 10px 0px; background-color:#FFFFFF">
										</td>
									</tr>
									<tr>
										<td rowspan=4>当該ショット品質記録</td>
									</tr>
									<tr>
										<td>外観検査</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="Gaikan"/>
												<jsp:param name="btn_text"	value="テンキー"/>
												<jsp:param name="txt_id"	value="Gaikan"/>
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
									</tr>
									<tr>
										<td>X線検査</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="Xsen"/>
												<jsp:param name="btn_text"	value="テンキー"/>
												<jsp:param name="txt_id"	value="Xsen"/>
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
									</tr>
									<tr>
										<td>（組立）外観検査</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="Kumitate"/>
												<jsp:param name="btn_text"	value="テンキー"/>
												<jsp:param name="txt_id"	value="Kumitate"/>
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
									</tr>
								</table>
							</td>

							<td>
								<table border="1">
									<tr>
										<td>対応内容</td>
										<td>
											<div class="btn_group_180" style="margin : 3.5px 0px 0px 0px">
												<input type="radio" name="Contents" id="radio1" value="TIARA発行" checked>
												<label for="radio1">ＴＩＡＲＡ発行</label>
												<input type="radio" name="Contents" id="radio2" value="エラー解除">
												<label for="radio2">エラー解除</label>
												<input type="radio" name="Contents" id="radio3" value="ダミーで発生">
												<label for="radio3">ダミーで発生</label>
											</div>
										</td>
									</tr>
									<tr>
										<td>処置者名</td>
										<td>
											<jsp:include page="/include/include_inputtextex_required.jsp">
												<jsp:param name="btn"	 value="Name" />
												<jsp:param name="disp"	 value="クリア" />
												<jsp:param name="txt"	 value="Name" />
												<jsp:param name="width"	 value="100"/>
											</jsp:include>
										</td>
									</tr>
									<tr>
										<td>一時保管貼付</td>
										<td>
											<jsp:include page="/include/include_twoswitch.jsp">
												<jsp:param name="on"	 value="on"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off"/>
												<jsp:param name="valoff" value="‐"/>
												<jsp:param name="select" value="Hokan"/>
											</jsp:include>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>

		<jsp:include page="/include/include_barcodehandler.jsp"/>
		<jsp:include page="/include/include_datehandler.jsp"/>
		<jsp:include page="/include/include_pagetop.jsp"/>

		<!-- Script宣言部 -->
		<script type="text/javascript">
			$(document).ready(function() {
				/**
				 * イベントリスナーの登録
				 */
				 /* バリデーション処理 */
				$('#submitBtn')[0].addEventListener('click', function(){ValidationHandler()}, false);
				/**
				 * バーコード読取り時に反応するイベントリスナー
				 */
				$('#Setubi')[0].addEventListener('keypress', function(e){
					var promise=BarcodeHandler(e, 'Series', 'Setubi', functionkbn.getSeries)
					promise.done(function() {});
					promise.fail(function() {});
				}, false);
				$('#Lot')   [0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Sinrai', 'Lot',  functionkbn.getSinrai)}, false);
				$('#Name')  [0].addEventListener('keypress', function(e){BarcodeHandler(e, null,     'Name', functionkbn.nothing)}, false);
				/**
				 * フォーカスロスト時に反応するイベントリスナー
				 */
				$('#Setubi')[0].addEventListener('focusout', function(e){
					var promise=FocuslostHandler(e, 'Series', 'Setubi', functionkbn.getSeries)
					promise.done(function() {});
					promise.fail(function() {});
				}, false);
				$('#Lot')   [0].addEventListener('focusout', function(e){FocuslostHandler(e, 'Sinrai', 'Lot',  functionkbn.getSinrai)}, false);
				$('#Name')  [0].addEventListener('focusout', function(e){FocuslostHandler(e, null,     'Name', functionkbn.nothing)}, false);
				$('#Choco') [0].addEventListener('change', function(e){
					var promise=FocuslostHandler(e, 'Messege','Choco,Setubi', functionkbn.getEquipErrorMsg)
					promise.done(function() {});
					promise.fail(function() {});
				}, false);
				/**
				 * 日付処理に関するイベントリスナー
				 */
				$('#Setubi')[0].addEventListener('keypress', function(e){DateHandler(datekbn.datetime)}, false);
				$('#Lot')   [0].addEventListener('keypress', function(e){DateHandler(datekbn.datetime)}, false);
				$('#Setubi')[0].addEventListener('focusout', function(e){DateHandler(datekbn.datetime)}, false);
				$('#Lot')   [0].addEventListener('focusout', function(e){DateHandler(datekbn.datetime)}, false);
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
				$(':hidden[name="Lot"]').val($('#Lot').val());
				/* サーブレットの呼出しを行う */
				$("#fm").submit();
			}
		</script>
		<!-- Script宣言部ここまで -->


	</body>
	<!-- cssフレームワーク  -->
	<jsp:include page="/include/include_bootstrap.jsp"/>
</html>