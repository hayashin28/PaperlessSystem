<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="common.DbCommonFunctions"%>
<%@page import="java.sql.Timestamp"%>
<!DOCTYPE html>

<html>

	<jsp:include page="/include/include_scriptframework.jsp"/>

	<!-- Script宣言部 -->
	<script type="text/javascript">
		$(document).ready(function() {
			/* アラートを非表示にする */
			$("#alert_chkbox").hide();
			/* セッション内の設備No.を取得 */
			$("#Setubi").val("${setuB}");
			/* バーコード読取り時に反応するイベントリスナー */
			$('#Wlot')	[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Wlot')},   false);
			$('#Worker')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Worker')}, false);
			 /* チェックボックスによる活性/非活性処理 */
			$('#select1')[0].addEventListener('change', function(){CheckboxHandler('select1')}, false);
			$('#select2')[0].addEventListener('change', function(){CheckboxHandler('select2')}, false);
			 /* バリデーション処理 */
			$('#submitBtn')[0].addEventListener('click', function(){ValidationHandler()}, false);
			/* 初期化処理 */
			CheckboxHandler('select1');
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
		var BarcodeHandler = function(e, id) {
			if (e.keyCode === 229) return false;
			if (e.charCode===13) {
				words=$("#"+id).val();
				if (words.length===0) { return false; }
				$("#"+id).val(replaceCode(toHalfWidth(words)));
				words = '';
				<%Timestamp time = DbCommonFunctions.getServerTime();%>
				var date = moment("<%=time%>");
				$("#Date").val(date.format("MM月DD日"));
			}
		}
	</script>

	<script type="text/javascript">
		var CheckboxHandler = function(id) {
			if(id==='select1') 		  { tbl1(id);
			} else if(id==='select2') { tbl2(id);
			}
		}
	</script>

	<script type="text/javascript">
		function tbl1(id) {
			if($("#" + id).prop('checked')) {
				$('#tbl_z1').show();
				$('#Item01, #Item02, #Item03, #Item04, #Item05, #Item06, #Item07, #Item08').prop("disabled", false);
			} else {
				$('#tbl_z1').hide();
				$('#Item01, #Item02, #Item03, #Item04, #Item05, #Item06, #Item07, #Item08').prop("disabled", true);
			}
		}

		function tbl2(id) {
			if($("#" + id).prop('checked')) {
				$('#tbl_z2').show();
				$('#Item09, #Item10, #Item11, #Item12, #Item13, #Item14, #Item15, #Item16').prop("disabled", false);
			} else {
				$('#tbl_z2').hide();
				$('#Item09, #Item10, #Item11, #Item12, #Item13, #Item14, #Item15, #Item16').prop("disabled", true);
			}
		}
	</script>

	<script type="text/javascript">
		/* 保存前のバリデーション処理を行う */
		var ValidationHandler = function() {
			/* 確認の選択漏れ確認 */
			if(!($('#select1').prop('checked') || $('#select2').prop('checked'))){
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
			/* サーブレットの呼出しを行う */
			$("#fm").submit();
		}
	</script>
	<!-- Script宣言部ここまで -->

	<% String tanname = System.getProperty("user.name"); %>
	<% request.setCharacterEncoding("UTF-8"); %>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>ダイサセルフチェックシート（デンソー移管品／ＥＨＶ品）</title>
	</head>

	<body>
		<% request.setCharacterEncoding("UTF-8");%>
		<div class="block">ダイサセルフチェックシート（デンソー移管品／ＥＨＶ品）</div>

		<form id="fm" action="<%=request.getContextPath()%>/TenkenListServlet" method="post">
		<input type="hidden" name="sheetnm" value="ダイサセルフチェックシート（デンソー移管品／ＥＨＶ品）">
		<input type="hidden" name="tanname" value="<%=tanname%>">
		<input type="hidden" name="params" id="params" value="">

			<div class="bs-example table-responsive">
				<table class="table table-hover">
					<tr>
						<td colspan=6><jsp:include page="/include/include_setubidata.jsp"/></td>
					</tr>
					<tr>
						<td colspan=6><jsp:include page="/include/include_waferlotdata.jsp"/></td>
					</tr>

					<tr>
						<td>
							<jsp:include page="/include/include_alertbar.jsp">
								<jsp:param name="id"	value="alert_chkbox" />
								<jsp:param name="msg"	value="確認を選択して下さい。" />
							</jsp:include>
							<div class="boxContainer">
								<div><span class="btn btn-primary btn-lg">確認</span></div>
								<div class="btn_group_280">
									<input type="checkbox" name="select" id="select1" value="使用軸：Z1">
									<label for="select1">使用軸：Z1</label>
									<input type="checkbox" name="select" id="select2" value="使用軸：Z2">
									<label for="select2">使用軸：Z2</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<table id="tbl_z1">
								<tr>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn01" />
											<jsp:param name="disp"	 value="測定目的" />
											<jsp:param name="txt"	 value="Item01" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn02" />
											<jsp:param name="disp"	 value="ブレード型" />
											<jsp:param name="txt"	 value="Item02" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn03" />
											<jsp:param name="disp"	 value="ブレード幅03" />
											<jsp:param name="txt"	 value="Item03" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn04" />
											<jsp:param name="disp"	 value="測定時ライン数" />
											<jsp:param name="txt"	 value="Item04" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn05" />
											<jsp:param name="disp"	 value="カーブ幅" />
											<jsp:param name="txt"	 value="Item05" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn06" />
											<jsp:param name="disp"	 value="チッピング量" />
											<jsp:param name="txt"	 value="Item06" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
									<tr>
									<td>
										<div class="boxContainer">
										<div><span class="btn btn-primary btn-lg">カットズレ</span></div>
											<div>
												<jsp:include page="/include/include_twoswitch.jsp">
													<jsp:param name="on"	 value="OK07"/>
													<jsp:param name="valon"	 value="OK"/>
													<jsp:param name="off"	 value="NG07"/>
													<jsp:param name="valoff" value="NG"/>
													<jsp:param name="select" value="Item07"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class="boxContainer">
										<div><span class="btn btn-primary btn-lg">外観検査</span></div>
											<div>
												<jsp:include page="/include/include_twoswitch.jsp">
													<jsp:param name="on"	 value="OK08"/>
													<jsp:param name="valon"	 value="OK"/>
													<jsp:param name="off"	 value="NG08"/>
													<jsp:param name="valoff" value="NG"/>
													<jsp:param name="select" value="Item08"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</td>

						<td>
							<table id="tbl_z2">
								<tr>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn09" />
											<jsp:param name="disp"	 value="測定目的" />
											<jsp:param name="txt"	 value="Item09" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn10" />
											<jsp:param name="disp"	 value="ブレード型" />
											<jsp:param name="txt"	 value="Item10" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn11" />
											<jsp:param name="disp"	 value="ブレード幅" />
											<jsp:param name="txt"	 value="Item11" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn12" />
											<jsp:param name="disp"	 value="測定時ライン数" />
											<jsp:param name="txt"	 value="Item12" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn13" />
											<jsp:param name="disp"	 value="カーブ幅" />
											<jsp:param name="txt"	 value="Item13" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn14" />
											<jsp:param name="disp"	 value="チッピング量" />
											<jsp:param name="txt"	 value="Item14" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">カットズレ</span></div>
											<div>
												<jsp:include page="/include/include_twoswitch.jsp">
													<jsp:param name="on"	 value="OK15"/>
													<jsp:param name="valon"	 value="OK"/>
													<jsp:param name="off"	 value="NG15"/>
													<jsp:param name="valoff" value="NG"/>
													<jsp:param name="select" value="Item15"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">外観検査</span></div>
											<div>
												<jsp:include page="/include/include_twoswitch.jsp">
													<jsp:param name="on"	 value="OK16"/>
													<jsp:param name="valon"	 value="OK"/>
													<jsp:param name="off"	 value="NG16"/>
													<jsp:param name="valoff" value="NG"/>
													<jsp:param name="select" value="Item16"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>

					<tr>
						<td colspan=2 align="center">
							<div class="boxContainer">
								<div>
									<jsp:include page="/include/include_inputtextex_required.jsp">
										<jsp:param name="btn"	 value="btn_sokuteiki" />
										<jsp:param name="disp"	 value="測定器" />
										<jsp:param name="txt"	 value="Sokuteiki" />
										<jsp:param name="width"	 value="100"/>
									</jsp:include>
								</div>
								<div><span class="btn btn-primary btn-lg">判定結果</span></div>
								<div>
									<jsp:include page="/include/include_twoswitch.jsp">
										<jsp:param name="on"	 value="OK17"/>
										<jsp:param name="valon"	 value="OK"/>
										<jsp:param name="off"	 value="NG17"/>
										<jsp:param name="valoff" value="NG"/>
										<jsp:param name="select" value="Item17"/>
									</jsp:include>
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td colspan=2>
							<p>1．ﾌﾙｶｯﾄのｶｰﾌ幅はZ1軸のみとし、装置のｶｰﾌﾁｪｯｸ時の数値を記入する。6000ｼﾘｰｽﾞの装置はｼｮｰﾄｶｰﾌﾁｪｯｸ時のZ2軸のｶｰﾌ幅も記入する。</p>
							<p>2.ﾀﾞﾐｰｳｴﾊにてﾌﾟﾘｶｯﾄを実施した時も、ｾﾙﾌﾁｪｯｸシートに記入する事。</p>
							<p>3.ｶｯﾄｽﾞﾚ､外観検査、判定結果にて「OK」か「NG」を選択する。「OK」の時は連続着工開始。「NG」の時はTIARA:ABIREXを発行し上長に連絡する。</p>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</body>

	<!-- cssフレームワーク  -->
	<jsp:include page="/include/include_bootstrap.jsp"/>
</html>