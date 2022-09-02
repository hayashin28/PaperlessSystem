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
			/**
			 * イベントリスナーの登録
			 */
			/* バーコード読取り時に反応するイベントリスナー */
			$('#Wlot')	[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Wlot')},   false);
			$('#Worker')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Worker')}, false);
			$('#Item02')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Item02')}, false);	//テープロットNo.
			$('#Item05')[0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Item05')}, false);	//測定器管理No.
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
	<!-- Script宣言部ここまで -->


	<% String tanname = System.getProperty("user.name"); %>
	<% request.setCharacterEncoding("UTF-8"); %>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>ｳｴﾊ吸着ﾃｰﾌﾞﾙ/ｱﾗｲﾅﾌﾞﾙ交換来歴ﾁｪｯｸｼｰﾄ</title>
	</head>

	<body>

		<% request.setCharacterEncoding("UTF-8");%>
		<div class="block">ｳｴﾊ吸着ﾃｰﾌﾞﾙ/ｱﾗｲﾅﾌﾞﾙ交換来歴ﾁｪｯｸｼｰﾄ</div>
		<jsp:include page="/include/include_pagetop.jsp"/>
		<form id="fm" action="<%=request.getContextPath()%>/TenkenListServlet" method="post">
			<input type="hidden" name="sheetnm" value="ｳｴﾊ吸着ﾃｰﾌﾞﾙ/ｱﾗｲﾅﾌﾞﾙ交換来歴ﾁｪｯｸｼｰﾄ">
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
									<td rowspan=2>ウエハ<br/>吸着テーブル</td>
									<td>
										<jsp:include page="/include/include_selectionbox_required.jsp">
											<jsp:param name="btn_id"	 value="btn01" />
											<jsp:param name="btn_text"	 value="交換テーブル" />
											<jsp:param name="txt_id"	 value="Item01" />
											<jsp:param name="select_txt" value="6-OF-280|6-OF-400|8-OF-150|8-OF-280|8-OF-400|6-OF-280|8-V-非|8-OF-後" />
											<jsp:param name="width"	 	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">テーブル確認</span></div>
											<div>
												<jsp:include page="/include/include_twoswitch.jsp">
													<jsp:param name="on"	 value="on2"/>
													<jsp:param name="valon"	 value="OK"/>
													<jsp:param name="off"	 value="off2"/>
													<jsp:param name="valoff" value="NG"/>
													<jsp:param name="select" value="Item02"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td rowspan=3>アライナ<br/>テーブル</td>
									<td>
										<jsp:include page="/include/include_selectionbox_required.jsp">
											<jsp:param name="btn_id"	 value="btn03" />
											<jsp:param name="btn_text"	 value="交換テーブル" />
											<jsp:param name="txt_id"	 value="Item06" />
											<jsp:param name="select_txt" value="6インチ|8インチ" />
											<jsp:param name="width"	 	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">テーブル確認</span></div>
											<div>
												<jsp:include page="/include/include_twoswitch.jsp">
													<jsp:param name="on"	 value="on4"/>
													<jsp:param name="valon"	 value="OK"/>
													<jsp:param name="off"	 value="off4"/>
													<jsp:param name="valoff" value="NG"/>
													<jsp:param name="select" value="Item04"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</td>

						<td>
							<table>
								<tr>
									<td>
										<div class="boxContainer">
											<div><span class="btn btn-primary btn-lg">セルフチェック（先頭ウエハ）</span></div>
											<div>
												<jsp:include page="/include/include_twoswitch.jsp">
													<jsp:param name="on"	 value="on5"/>
													<jsp:param name="valon"	 value="OK"/>
													<jsp:param name="off"	 value="off5"/>
													<jsp:param name="valoff" value="NG"/>
													<jsp:param name="select" value="Item05"/>
												</jsp:include>
											</div>
										</div>
									</td>
								</tr>

							</table>
						</td>
					</tr>

					<tr>
						<td align="left">
							<p>１．テーブルを交換する時にバリや破損等の不具合が無いか確認し「ＯＫ」か「ＮＧ」を選択する。</p>
							<p>２．テーブル交換を実施した後、先頭ウエハでセルフチェックを行い、「ＯＫ」か「ＮＧ」を選択する。</p>
							<p>３．ＮＧ発生時、ＡＢＩＲＥＸを発行し、上長へ連絡する。</p>
						</td>
					</tr>

				</table>
			</div>
		</form>
	</body>

	<!-- cssフレームワーク  -->
	<jsp:include page="/include/include_bootstrap.jsp"/>
</html>
