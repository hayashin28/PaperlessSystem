<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
			/**
			 * イベントリスナーの登録
			 */
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
	<!-- Script宣言部ここまで -->


	<% String tanname = System.getProperty("user.name"); %>
	<% request.setCharacterEncoding("UTF-8"); %>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>全自動マウンタATM-8100X</title>
	</head>

	<body>

		<% request.setCharacterEncoding("UTF-8");%>
		<div class="block">全自動マウンタATM-8100X</div>
		<jsp:include page="/include/include_pagetop.jsp"/>
		<form id="fm" action="<%=request.getContextPath()%>/TenkenListServlet" method="post">
			<input type="hidden" name="sheetnm" value="全自動マウンタATM-8100X">
			<input type="hidden" name="tanname" value="<%=tanname%>">
			<input type="hidden" name="params" id="params" value="">

			<div class="bs-example table-responsive">
				<table class="table table-hover">
					<tr>
						<td colspan=2><jsp:include page="/include/include_setubidata.jsp"/></td>
					</tr>
					<tr>
						<td colspan=2><jsp:include page="/include/include_errordate.jsp"/></td>
					</tr>

					<tr>
						<td>
							<jsp:include page="/include/include_inputtextex_required.jsp">
								<jsp:param name="btn"	 value="btn01" />
								<jsp:param name="disp"	 value="エラー名" />
								<jsp:param name="txt"	 value="Item01" />
								<jsp:param name="width"	 value="100"/>
							</jsp:include>
						</td>
						<td>
							<jsp:include page="/include/include_tenkey_required.jsp">
								<jsp:param name="btn_id"	value="btn02" />
								<jsp:param name="btn_text"	value="当該品外観検査数" />
								<jsp:param name="txt_id"	value="Item02" />
								<jsp:param name="width"	 	value="100"/>
							</jsp:include>
						</td>
					</tr>

					<tr>
					</tr>

					<tr>
						<td>
							<jsp:include page="/include/include_tenkey_required.jsp">
								<jsp:param name="btn_id"	value="btn" />
								<jsp:param name="btn_text"	value="不良数" />
								<jsp:param name="txt_id"	value="Item" />
								<jsp:param name="width"		value="100"/>
							</jsp:include>
						</td>
					</tr>

					<tr>
						<td>
							<jsp:include page="/include/include_inputtextex_required.jsp">
								<jsp:param name="btn"	 value="btn" />
								<jsp:param name="disp"	 value="処置者" />
								<jsp:param name="txt"	 value="Item" />
								<jsp:param name="width"	 value="100"/>
							</jsp:include>
						</td>
					</tr>

					<tr>
						<td>
							<div class="boxContainer">
								<div><span class="btn btn-primary btn-lg">ＡＢＩＲＥＸ</span></div>
								<div>
									<jsp:include page="/include/include_twoswitch.jsp">
										<jsp:param name="on"	 value="on1"/>
										<jsp:param name="valon"	 value="有"/>
										<jsp:param name="off"	 value="off1"/>
										<jsp:param name="valoff" value="無"/>
										<jsp:param name="select" value="Item"/>
									</jsp:include>
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td>
							<div class="boxContainer">
								<div><span class="btn btn-primary btn-lg">ＴＩＡＲＡ</span></div>
								<div>
									<jsp:include page="/include/include_twoswitch.jsp">
										<jsp:param name="on"	 value="on2"/>
										<jsp:param name="valon"	 value="有"/>
										<jsp:param name="off"	 value="off2"/>
										<jsp:param name="valoff" value="無"/>
										<jsp:param name="select" value="Item"/>
									</jsp:include>
								</div>
							</div>
						</td>
					</tr>

				</table>
			</div>
		</form>
	</body>

	<!-- cssフレームワーク  -->
	<jsp:include page="/include/include_bootstrap.jsp"/>
</html>
