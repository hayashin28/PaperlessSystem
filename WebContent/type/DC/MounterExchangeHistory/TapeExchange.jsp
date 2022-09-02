<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
			/**
			 * イベントリスナーの登録
			 */
			 /* バリデーション処理 */
			$('#submitBtn')[0].addEventListener('click', function(){ValidationHandler()}, false);
			/* バーコード読取り時に反応するイベントリスナー */
			$('#Wlot')	[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Wlot')},   false);
			$('#Worker')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Worker')}, false);
			$('#Item02')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Item02')}, false);	//テープロットNo.
			$('#Item06')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Item06')}, false);	//測定器管理No.
			 /* バリデーション処理 */
			$('#submitBtn')[0].addEventListener('click', function(){ValidationHandler()}, false);
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
			/* サーブレットの呼出しを行う */
			$("#fm").submit();
		}
	</script>
	<!-- Script宣言部ここまで -->


	<% String tanname = System.getProperty("user.name"); %>
	<% request.setCharacterEncoding("UTF-8"); %>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>テープ交換チェックシート</title>
	</head>

	<body>

		<% request.setCharacterEncoding("UTF-8");%>
		<div class="block">テープ交換チェックシート</div>
		<jsp:include page="/include/include_pagetop.jsp"/>
		<form id="fm" action="<%=request.getContextPath()%>/TenkenListServlet" method="post">
			<input type="hidden" name="sheetnm" value="テープ交換チェックシート">
			<input type="hidden" name="tanname" value="<%=tanname%>">
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
						<td colspan=2><jsp:include page="/include/include_waferlotdata.jsp"/></td>
					</tr>

					<tr>
						<td>
							<table>
								<tr>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn01" />
											<jsp:param name="disp"	 value="テープの種類" />
											<jsp:param name="txt"	 value="Item01" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn02" />
											<jsp:param name="disp"	 value="テープロットNo." />
											<jsp:param name="txt"	 value="Item02" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn03" />
											<jsp:param name="disp"	 value="テープ使用期限" />
											<jsp:param name="txt"	 value="Item03" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn04" />
											<jsp:param name="disp"	 value="C治具サイズ" />
											<jsp:param name="txt"	 value="Item04" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_tenkey_required.jsp">
											<jsp:param name="btn_id"	value="btn05" />
											<jsp:param name="btn_text"	value="テーブル温度" />
											<jsp:param name="txt_id"	value="Item05" />
											<jsp:param name="width"	 	value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="btn06" />
											<jsp:param name="disp"	 value="測定器管理No." />
											<jsp:param name="txt"	 value="Item06" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>

							</table>

						</td>

						<td>
							<table>
								<tr>
									<td><img src='<%=request.getContextPath() + "/img/TapeExchange.png"%>'></td>
								</tr>
								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">テーブル確認</span></div>
											<div>
												<jsp:include page="/include/include_twoswitch.jsp">
													<jsp:param name="on"	 value="on07"/>
													<jsp:param name="valon"	 value="OK"/>
													<jsp:param name="off"	 value="off07"/>
													<jsp:param name="valoff" value="NG"/>
													<jsp:param name="select" value="Item07"/>
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
	<jsp:include page="/include/include_bootstrap.jsp"/></html>
