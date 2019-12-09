<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="common.DbCommonFunctions"%>
<%@page import="java.sql.Timestamp"%>
<!DOCTYPE html>
<html>

	<jsp:include page="/include/include_scriptframework.jsp"/>

	<% String tanname = System.getProperty("user.name");%>
	<% request.setCharacterEncoding("UTF-8"); %>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>モールド金型交換条件確認結果票</title>
	</head>

	<body>
		<div class="block">モールド金型交換条件確認結果票</div>
		<jsp:include page="/include/include_pagetop.jsp"/>
		<form id="fm" action="<%=request.getContextPath()%>/TenkenListServlet" method="post">
			<input type="hidden" name="sheetnm" value="モールド金型交換条件確認結果票">
			<input type="hidden" name="tanname" value="<%=tanname%>">
			<input type="hidden" name="Setubi"  value="">
			<input type="hidden" name="params" id="params" value="">

			<div class="bs-example table-responsive">
				<table class="table table-hover">
					<tr>
						<td colspan=4>
							<div class="boxContainer">
								<div class="right"><jsp:include page="/include/include_button.jsp"/></div>
							</div>
						<td>
					</tr>
					<tr>
						<td colspan=4>
							<div class="boxContainer">
								<div><span class="btn btn-primary btn-lg" style="width:100px; margin:20px 0px 0px 0px;">交換日時</span></div>
								<div><input type="text" id="Date" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:150px; margin:20px 10px 10px 0px; background-color:#FFFFFF"></div>
								<div><jsp:include page="/include/include_equip.jsp"/></div>
							</div>
						<td>
					</tr>
					<tr>
						<td colspan=4><b>前回の金型</b></td>
					</tr>
					<tr>
						<td rowspan=4>
							<div class="boxContainer">
								<div><span class="btn btn-primary btn-lg" style="width:100px; margin:12px 0px 0px 0px;">PKG名</span></div>
								<div><input type="text" name="PKG" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:200px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
							</div>
						</td>
						<td>ﾓｼﾞｭｰﾙNo.1</td>
						<td>
							<div class="boxContainer">
								<div><span class="btn btn-primary btn-lg" style="width:100px; margin:12px 0px 0px 0px;">金型No</span></div>
								<div><input type="text" name="Gold01" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
							</div>
						</td>
						<td>
							<div class="boxContainer">
								<div><span class="btn btn-primary btn-lg" style="width:100px; margin:12px 0px 0px 0px;">ﾌﾞﾛｯｸNo.</span></div>
								<div><input type="text" name="Block01" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
							</div>
						</td>
					</tr>
					<tr>
						<td>ﾓｼﾞｭｰﾙNo.2</td>
						<td>
							<div class="boxContainer">
								<div><span class="btn btn-primary btn-lg" style="width:100px; margin:12px 0px 0px 0px;">金型No</span></div>
								<div><input type="text" name="Gold02" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
							</div>
						</td>
						<td>
							<div class="boxContainer">
								<div><span class="btn btn-primary btn-lg" style="width:100px; margin:12px 0px 0px 0px;">ﾌﾞﾛｯｸNo.</span></div>
								<div><input type="text" name="Block02" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
							</div>
						</td>
					</tr>
					<tr>
						<td>ﾓｼﾞｭｰﾙNo.3</td>
						<td>
							<div class="boxContainer">
								<div><span class="btn btn-primary btn-lg" style="width:100px; margin:12px 0px 0px 0px;">金型No</span></div>
								<div><input type="text" name="Gold03" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
							</div>
						</td>
						<td>
							<div class="boxContainer">
								<div><span class="btn btn-primary btn-lg" style="width:100px; margin:12px 0px 0px 0px;">ﾌﾞﾛｯｸNo.</span></div>
								<div><input type="text" name="Block03" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
							</div>
						</td>
					</tr>
					<tr>
						<td>ﾓｼﾞｭｰﾙNo.4</td>
						<td>
							<div class="boxContainer">
								<div><span class="btn btn-primary btn-lg" style="width:100px; margin:12px 0px 0px 0px;">金型No</span></div>
								<div><input type="text" name="Gold04" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
							</div>
						</td>
						<td>
							<div class="boxContainer">
								<div><span class="btn btn-primary btn-lg" style="width:100px; margin:12px 0px 0px 0px;">ﾌﾞﾛｯｸNo.</span></div>
								<div><input type="text" name="Block04" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
							</div>
						</td>
					</tr>

					<tr>
						<td colspan=4><b>今回の金型</b></td>
					</tr>
					<tr>
						<td>
							<jsp:include page="/include/include_inputtextex_required.jsp">
								<jsp:param name="btn"	 value="PKG" />
								<jsp:param name="disp"	 value="PKG名" />
								<jsp:param name="txt"	 value="PKG" />
								<jsp:param name="width"	 value="100"/>
							</jsp:include>
						</td>
						<td>ﾓｼﾞｭｰﾙNo.1</td>
						<td>
							<jsp:include page="/include/include_tenkey_required.jsp">
								<jsp:param name="btn_id"	value="Gold01"/>
								<jsp:param name="btn_text"	value="金型No."/>
								<jsp:param name="txt_id"	value="Gold01"/>
								<jsp:param name="width"		value="50"/>
							</jsp:include>
						</td>
						<td>
							<jsp:include page="/include/include_tenkey_required.jsp">
								<jsp:param name="btn_id"	value="Block01"/>
								<jsp:param name="btn_text"	value="ﾌﾞﾛｯｸNo."/>
								<jsp:param name="txt_id"	value="Block01"/>
								<jsp:param name="width"		value="50"/>
							</jsp:include>
						</td>
					</tr>
					<tr>
						<td rowspan=3>
							<jsp:include page="/include/include_inputtextex_required.jsp">
								<jsp:param name="btn"	 value="Resin" />
								<jsp:param name="disp"	 value="摘要レジン名" />
								<jsp:param name="txt"	 value="Resin" />
								<jsp:param name="width"	 value="100"/>
							</jsp:include>
						</td>
						<td>ﾓｼﾞｭｰﾙNo.2</td>
						<td>
							<jsp:include page="/include/include_tenkey_required.jsp">
								<jsp:param name="btn_id"	value="Gold02"/>
								<jsp:param name="btn_text"	value="金型No."/>
								<jsp:param name="txt_id"	value="Gold02"/>
								<jsp:param name="width"		value="50"/>
							</jsp:include>
						</td>
						<td>
							<jsp:include page="/include/include_tenkey_required.jsp">
								<jsp:param name="btn_id"	value="Block02"/>
								<jsp:param name="btn_text"	value="ﾌﾞﾛｯｸNo."/>
								<jsp:param name="txt_id"	value="Block02"/>
								<jsp:param name="width"		value="50"/>
							</jsp:include>
						</td>
					</tr>
					<tr>
						<td>ﾓｼﾞｭｰﾙNo.3</td>
						<td>
							<jsp:include page="/include/include_tenkey_required.jsp">
								<jsp:param name="btn_id"	value="Gold03"/>
								<jsp:param name="btn_text"	value="金型No."/>
								<jsp:param name="txt_id"	value="Gold03"/>
								<jsp:param name="width"		value="50"/>
							</jsp:include>
						</td>
						<td>
							<jsp:include page="/include/include_tenkey_required.jsp">
								<jsp:param name="btn_id"	value="Block03"/>
								<jsp:param name="btn_text"	value="ﾌﾞﾛｯｸNo."/>
								<jsp:param name="txt_id"	value="Block03"/>
								<jsp:param name="width"		value="50"/>
							</jsp:include>
						</td>
					</tr>
					<tr>
						<td>ﾓｼﾞｭｰﾙNo.4</td>
						<td>
							<jsp:include page="/include/include_tenkey_required.jsp">
								<jsp:param name="btn_id"	value="Gold04"/>
								<jsp:param name="btn_text"	value="金型No."/>
								<jsp:param name="txt_id"	value="Gold04"/>
								<jsp:param name="width"		value="50"/>
							</jsp:include>
						</td>
						<td>
							<jsp:include page="/include/include_tenkey_required.jsp">
								<jsp:param name="btn_id"	value="Block04"/>
								<jsp:param name="btn_text"	value="ﾌﾞﾛｯｸNo."/>
								<jsp:param name="txt_id"	value="Block04"/>
								<jsp:param name="width"		value="50"/>
							</jsp:include>
						</td>
					</tr>

					<tr>
						<td colspan=5><b>1.金型セットアップ確認</b></td>
					</tr>
					<tr>
						<td colspan=5>
							<table border="1">
								<tr>
									<td>項目</td><td>内容</td><td>判定基準</td><td>判定</td>
								</tr>
								<tr id="plunger">
									<td>ﾌﾟﾗﾝｼﾞｬ高さ</td><td>ｸﾘｰﾅｰ時の高さを目視確認する。</td><td>定位置である</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on01"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off01"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="Plunger"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="cleaner">
									<td>ｸﾘｰﾅ高さ</td><td>ﾘｯﾌﾟと上型、下型のｸﾘｱﾗﾝｽを確認する。</td><td>上下共に1.0～2.0ｍｍのｸﾘｱﾗﾝｽがあること</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on02"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off02"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="Cleaner"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="tswitch">
									<td>型締めｽｲｯﾁ</td><td>ｸﾗﾝﾌﾟ型締め状態にしてﾗﾝﾌﾟを目視確認する。</td><td>ﾗﾝﾌﾟが点灯する。</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on03"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off03"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="Tswitch"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="chase">
									<td>ﾁｪｲｽ位置</td><td>ﾁｪｲｽ外観を目視確認する。</td><td>刻印により所定の位置にｾｯﾄされている。</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on04"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off04"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="Chase"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="lfset">
									<td>L/Fｾｯﾄ状態</td><td>金型へのL/Fﾁｬｰｼﾞ動作を目視確認する。</td><td>Ｌ／Ｆへのストレスが無い。</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on05"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off05"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="LFset"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="cstop">
									<td>ﾁｪｲｽｽﾄｯﾊﾟ</td><td>ｽﾄｯﾊﾟのｾｯﾄ状態を目視確認する。</td><td>確実に入れてある。</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on06"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off06"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="Cstop"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="ball">
									<td>ﾁｪｲｽｽﾄｯﾊﾟ</td><td>ﾎﾞｰﾙﾌﾟﾗﾝｼﾞｬの状態を目視確認する。</td><td>閉め込んである。</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on07"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off07"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="Ball"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="goldct">
									<td>搬送と金型の位置合わせ</td><td>金型上で搬送ｻﾌﾞポットと金型ﾎﾟｯﾄに位置合わせ治具を差し込む。</td><td>治具がｽﾑｰｽﾞに入る。</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on08"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off08"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="GoldCt"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="typecheck">
									<td rowspan=2>型合わせ確認</td><td>下型が位置決め状態を確認する。</td><td>定位置にある。</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on09"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off09"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="TypeCheck"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="udcheck">
									<td>上下型の型合わせを確認する。</td><td>ｳｴｯｼﾞがｽﾑｰｽﾞに入る。</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on10"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off10"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="UDCheck"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="heater">
									<td>ﾋｰﾀ</td><td>ﾋｰﾀ線被服及びｺﾝｾﾝﾄを目視確認する。</td><td>破れ、破損等が無い。</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on11"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off11"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="Heater"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="pot">
									<td>ﾎﾟｯﾄ・ﾌﾟﾗﾝｼﾞｬ</td><td>手動でﾌﾟﾗﾝｼﾞｬ動作を目視確認する。</td><td>ﾌﾟﾗﾝｼﾞｬのﾉｯｷﾝｸﾞ等が無い。</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on12"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off12"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="Pot"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="charge">
									<td>未充填ｾﾝｻ</td><td>確認用ﾀﾞﾐｰﾓｰﾙﾄﾞ品で実装する。</td><td>未充填ｴﾗｰ発令する。</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on13"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off13"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="Charge"/>
										</jsp:include>
									</td>
								</tr>
							</table>
						</td>
					</tr>

					<tr>
						<td><b>2.モールド作業条件確認</b></td>
						<td colspan=3>
							<div class="boxContainer">
								<div>
									<jsp:include page="/include/include_tenkey_required.jsp">
										<jsp:param name="btn_id"	value="SWNo"/>
										<jsp:param name="btn_text"	value="ｽﾄｯﾌﾟｳｫｯﾁ管理No."/>
										<jsp:param name="txt_id"	value="SWno"/>
										<jsp:param name="width"		value="50"/>
									</jsp:include>
								</div>
								<div>
									<jsp:include page="/include/include_tenkey_required.jsp">
										<jsp:param name="btn_id"	value="HeatNo"/>
										<jsp:param name="btn_text"	value="表面温度計管理No."/>
										<jsp:param name="txt_id"	value="HeatNo"/>
										<jsp:param name="width"		value="50"/>
									</jsp:include>
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td colspan=4>
							<table border="1">
								<tr>
									<td rowspan=2>項目</td><td rowspan=2>判定基準</td><td colspan=4>結果</td><td>判定</td>
								</tr>
								<tr>
									<td>ﾓｼﾞｭｰﾙ1</td><td>ﾓｼﾞｭｰﾙ2</td><td>ﾓｼﾞｭｰﾙ3</td><td>ﾓｼﾞｭｰﾙ4</td>
									<td>
									</td>
								</tr>
								<tr id=kgclampj>
									<td>ｸﾗﾝﾌﾟ圧力</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="KgClampJ"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="KgClampJ"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>±</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="KgClampG"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="KgClampG"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kg/cm2</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="KgClamp01"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="KgClamp01"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kg/cm2</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="KgClamp02"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="KgClamp02"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kg/cm2</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="KgClamp03"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="KgClamp03"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kg/cm2</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="KgClamp04"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="KgClamp04"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kg/cm2</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div><input type="text" name="KgClampRs" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
										</div>
									</td>
								</tr>

								<tr id="tonclampj">
									<td>ｸﾗﾝﾌﾟ圧力</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="TonClampJ"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="TonClampJ"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>±</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="TonClampG"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="TonClampG"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>ton</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="TonClamp01"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="TonClamp01"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>ton</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="TonClamp02"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="TonClamp02"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>ton</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="TonClamp03"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="TonClamp03"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>ton</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="TonClamp04"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="TonClamp04"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>ton</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div><input type="text" name="TonClampRs" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
										</div>
									</td>
								</tr>
								<tr id="knclampj">
									<td>ｸﾗﾝﾌﾟ圧力</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="kNClampJ"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="kNClampJ"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>±</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="kNClampG"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="kNClampG"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kN</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="kNClamp01"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="kNClamp01"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kN</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="kNClamp02"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="kNClamp02"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kN</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="kNClamp03"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="kNClamp03"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kN</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="kNClamp04"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="kNClamp04"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kN</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div><input type="text" name="kNClampRs" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
										</div>
									</td>
								</tr>
								<tr id="kgplungerj">
									<td>ﾌﾟﾗﾝｼﾞｬ圧力</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="KgPlungerJ"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="KgPlungerJ"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>±</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="KgPlungerG"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="KgPlungerG"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kg/cm2</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="KgPlunger01"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="KgPlunger01"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kg/cm2</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="KgPlunger02"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="KgPlunger02"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kg/cm2</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="KgPlunger03"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="KgPlunger03"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kg/cm2</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="KgPlunger04"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="KgPlunger04"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kg/cm2</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div><input type="text" name="KgPlungerRs" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
										</div>
									</td>
								</tr>
								<tr id="knplungerj">
									<td>ﾌﾟﾗﾝｼﾞｬ圧力</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="kNPlungerJ"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="kNPlungerJ"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>±</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="kNPlungerG"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="kNPlungerG"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kN</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="kNPlunger01"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="kNPlunger01"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kN</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="kNPlunger02"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="kNPlunger02"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kN</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="kNPlunger03"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="kNPlunger03"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kN</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="kNPlunger04"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="kNPlunger04"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>kN</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div><input type="text" name="kNPlungerRs" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
										</div>
									</td>
								</tr>
								<tr id="transj">
									<td>移送時間</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="TransJ"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="TransJ"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>±</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="TransG"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="TransG"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>sec</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="Trans01"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="Trans01"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>sec</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="Trans02"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="Trans02"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>sec</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="Trans03"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="Trans03"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>sec</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="Trans04"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="Trans04"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>sec</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div><input type="text" name="TransRs" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
										</div>
									</td>
								</tr>
								<tr id="goldheatj">
									<td>金型温度</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="GoldHeatJ"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="GoldHeatJ"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>±</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="GoldHeatG"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="GoldHeatG"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>℃</div>
										</div>
									</td>
									<td colspan=2>
										<div class="boxContainer">
											<div>MAX</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="GoldHeat01"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="GoldHeat01"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>℃</div>
										</div>
									</td>
									<td colspan=2>
										<div class="boxContainer">
											<div>MIN</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="GoldHeat02"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="GoldHeat02"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>℃</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div><input type="text" name="GoldHeatRs" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
										</div>
									</td>
								</tr>
								<tr id="moldtimej">
									<td>ﾓｰﾙﾄﾞ時間</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="MoldTimeJ"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="MoldTimeJ"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>±</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="MoldTimeG"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="MoldTimeG"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>sec</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="MoldTime01"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="MoldTime01"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>sec</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="MoldTime02"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="MoldTime02"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>sec</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="MoldTime03"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="MoldTime03"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>sec</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="MoldTime04"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="MoldTime04"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>sec</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div><input type="text" name="MoldTimeRs" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
										</div>
									</td>
								</tr>
								<tr id="depressjg">
									<td>減圧</td>
									<td>
										<div class="boxContainer">
											<div>－</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="DePressJG"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="DePressJG"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>mmHg</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="DePress01"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="DePress01"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>mmHg</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="DePress02"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="DePress02"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>mmHg</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="DePress03"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="DePress03"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>mmHg</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="DePress04"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="DePress04"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>mmHg</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div><input type="text" name="DePressRs" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>

					<tr>
						<td colspan=4><b>3.品質確認</b></td>
					</tr>
					<tr>
						<td colspan=4>
							<table border="1">
								<tr>
									<td rowspan=2>項目</td><td rowspan=2>数量</td><td rowspan=2>内容</td><td rowspan=2>判定基準</td><td colspan=4>結果</td><td>判定</td>
								</tr>
								<tr>
									<td>ﾓｼﾞｭｰﾙ1</td><td>ﾓｼﾞｭｰﾙ2</td><td>ﾓｼﾞｭｰﾙ3</td><td>ﾓｼﾞｭｰﾙ4</td>
									<td>
									</td>
								</tr>
								<tr id="outer">
									<td>外観ﾁｪｯｸ</td><td>1ｼｮｯﾄ</td><td>PKGｷｽﾞ・汚れ不足を目視確認する</td><td>図面(3P600293Q00554,3Q00175Y-01-00156)規格内。</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="Outer01"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="Outer01"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>IC</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="Outer02"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="Outer02"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>IC</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="Outer03"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="Outer03"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>IC</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="Outer04"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="Outer04"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>IC</div>
										</div>
									</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on30"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off30"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="OuterRs"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="xray">
									<td>X線透視　注1)</td><td>1ｼｮｯﾄ<br/>600回</td><td>ﾜｲﾔ・ｲﾝﾅｰﾘｰﾄﾞ状態及び内部気泡を確認する</td><td>製造仕様書(Y-01-00029)規格内。</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="Xray01"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="Xray01"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>IC</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="Xray02"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="Xray02"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>IC</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="Xray03"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="Xray03"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>IC</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="Xray04"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="Xray04"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>IC</div>
										</div>
									</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on31"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off31"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="XrayRs"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="displace">
									<td>PKGｽﾞﾚ</td><td>1ｼｮｯﾄ</td><td>上型PKGｽﾞﾚ量を測定する。</td>
									<td>
										<div>製造仕様書(Y-01-00397)規格内。</div>
										<div class="boxContainer">
											<div>MAX</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="DisPlaceJG"/>
													<jsp:param name="btn_text"	value="規格"/>
													<jsp:param name="txt_id"	value="DisPlaceJG"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>μm</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>MAX</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="DisPlace01"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="DisPlace01"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>μm</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>MAX</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="DisPlace02"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="DisPlace02"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>μm</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>MAX</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="DisPlace03"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="DisPlace03"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>μm</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>MAX</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="DisPlace04"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="DisPlace04"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>μm</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div><input type="text" name="DisPlaceRs" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
										</div>
									</td>
								</tr>
								<tr id="lfmark">
									<td>L/F圧痕</td><td>1ｼｮｯﾄ</td><td>L/Fを空ｸﾗﾝﾌﾟし確認する。</td><td>面圧圧痕が均等についている。</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="LFMark01"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="LFMark01"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>IC</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="LFMark02"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="LFMark02"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>IC</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="LFMark03"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="LFMark03"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>IC</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="LFMark04"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="LFMark04"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
											<div>IC</div>
										</div>
									</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on33"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off33"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="LFMarkRs"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="resinflash">
									<td>ﾚｼﾞﾝﾌﾗｯｼｭﾚﾍﾞﾙ</td><td>1ｼｮｯﾄ</td><td>ﾀﾞﾑﾊﾞｰ周辺のﾚjﾝﾊﾞﾘを確認する。</td><td>製造仕様書(Y-01-00504)規格内。</td>
									<td>
										<div class="boxContainer">
											<div>MAXレベル</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="ResinFlash01"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="ResinFlash01"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>MAXレベル</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="ResinFlash02"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="ResinFlash02"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>MAXレベル</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="ResinFlash03"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="ResinFlash03"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
										</div>
									</td>
									<td>
										<div class="boxContainer">
											<div>MAXレベル</div>
											<div>
												<jsp:include page="/include/include_tenkey_required.jsp">
													<jsp:param name="btn_id"	value="ResinFlash04"/>
													<jsp:param name="btn_text"	value="テンキー"/>
													<jsp:param name="txt_id"	value="ResinFlash04"/>
													<jsp:param name="width"		value="50"/>
												</jsp:include>
											</div>
										</div>
									</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on34"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off34"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="ResinFlashRs"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td colspan=9><b>注１）Ｘ線透視　ＱＦＰ１４２０－１２８ｐｉｎ（ＲＣＩ）品はベーク前に６００個の確認を行い、その結果で量産の判断を行う。</b></td>
								</tr>
							</table>
						</td>
					</tr>

					<tr>
						<td colspan=4><b>4.その他確認事項</b></td>
					</tr>
					<tr>
						<td colspan=4>
							<table border="1">
								<tr>
									<td>項目</td><td>内容</td><td>判定</td>
								</tr>
								<tr id="typeselect">
									<td>品種選択</td><td>交換した品種パラメータを呼び出す。</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on40"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off40"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="TypeSelect"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="golddisplay">
									<td>金型表示板</td><td>装置の金型表示板を交換した金型名に変更する。</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on41"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off41"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="GoldDisplay"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="goldno">
									<td>金型Ｎｏ．表示</td><td>型確認シートの型Ｎｏ．が合っているかを確認する。</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on42"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off42"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="GoldNo"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="dummylf">
									<td>ダミーＬ／Ｆラック</td><td>適応ダミーＬ／Ｆをセットする。</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on43"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off43"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="DummyLF"/>
										</jsp:include>
									</td>
								</tr>
								<tr id="4s">
									<td>４Ｓ</td><td>周囲の整理・整頓・清掃を実施する。</td>
									<td>
										<jsp:include page="/include/include_trueorfalsewitch.jsp">
											<jsp:param name="on"	 value="on44"/>
											<jsp:param name="valon"	 value="○"/>
											<jsp:param name="off"	 value="off44"/>
											<jsp:param name="valoff" value="×"/>
											<jsp:param name="select" value="4S"/>
										</jsp:include>
									</td>
								</tr>
							</table>
						</td>
					</tr>

					<tr>
						<td colspan=4><b>5.Ｉｎｓｉｔｅセットアップ変更</b></td>
					</tr>
					<tr>
						<td colspan=4>
							<table border="1">
								<tr>
									<td>項目</td><td>内容</td>
								</tr>

								<tr>
									<td>ＰＫＧ名</td>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="InsPkg" />
											<jsp:param name="disp"	 value="クリア"/>
											<jsp:param name="txt"	 value="InsPkg" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								<tr>
									<td>金型ＩＤ</td>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="InsGold" />
											<jsp:param name="disp"	 value="クリア"/>
											<jsp:param name="txt"	 value="InsGold" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>ﾚｼﾞﾝ型式</td>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="InsResin" />
											<jsp:param name="disp"	 value="クリア"/>
											<jsp:param name="txt"	 value="InsResin" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>担当者名</td>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="InsName" />
											<jsp:param name="disp"	 value="クリア"/>
											<jsp:param name="txt"	 value="InsName" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
								<tr>
									<td>確認者名(ﾘｰﾀﾞ･保全員以上）</td>
									<td>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="InsChk" />
											<jsp:param name="disp"	 value="クリア"/>
											<jsp:param name="txt"	 value="InsChk" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan=4>
							<div><b>総合判定</b></div>
							<jsp:include page="/include/include_twoswitch.jsp">
								<jsp:param name="on"	 value="on"/>
								<jsp:param name="valon"	 value="合格"/>
								<jsp:param name="off"	 value="off"/>
								<jsp:param name="valoff" value="不合格"/>
								<jsp:param name="select" value="Total"/>
							</jsp:include>
						</td>
					</tr>
				</table>
			</div>
		</form>

		<jsp:include page="/include/include_lasttenkendata.jsp"/>
		<jsp:include page="/include/include_barcodehandler.jsp"/>
		<jsp:include page="/include/include_datehandler.jsp"/>

		<!-- Script宣言部 -->
		<script type="text/javascript">
			$(document).ready(function() {
				/**
				 * イベントリスナーの登録
				 */

				 /* バリデーション処理 */
				$('#submitBtn')[0].addEventListener('click', function(){ValidationHandler()}, false);
				/* バーコード読取り時に反応するイベントリスナー */
				$('#Setubi')[0].addEventListener('keypress', function(e){
					var promise=BarcodeHandler(e, 'Series','Setubi', functionkbn.getSeries);
					promise.done(function(){
						SeriesHandler();
					})
					promise.fail(function() {
						$('#Series').val("");
						setCookie('Series', null);
					});
				}, false);
				$('#Setubi')[0].addEventListener('keypress', function(e){DateHandler(datekbn.datetime)}, false);


				/* フォーカスロスト時に反応するイベントリスナー */
				$('#Setubi')[0].addEventListener('focusout', function(e){
					var promise=FocuslostHandler(e, 'Series','Setubi', functionkbn.getSeries);
					promise.done(function(){
						SeriesHandler();
					})
					promise.fail(function() {
						$('#Series').val("");
						setCookie('Series', null);
					});
				}, false);
				$('#Setubi')[0].addEventListener('focusout', function(e){DateHandler(datekbn.datetime)}, false);

				$('#KgClamp01')[0].addEventListener('focusout', function(){MoldJudge("KgClamp")}, false);
				$('#KgClamp02')[0].addEventListener('focusout', function(){MoldJudge("KgClamp")}, false);
				$('#KgClamp03')[0].addEventListener('focusout', function(){MoldJudge("KgClamp")}, false);
				$('#KgClamp04')[0].addEventListener('focusout', function(){MoldJudge("KgClamp")}, false);
				$('#TonClamp01')[0].addEventListener('focusout', function(){MoldJudge("TonClamp")}, false);
				$('#TonClamp02')[0].addEventListener('focusout', function(){MoldJudge("TonClamp")}, false);
				$('#TonClamp03')[0].addEventListener('focusout', function(){MoldJudge("TonClamp")}, false);
				$('#TonClamp04')[0].addEventListener('focusout', function(){MoldJudge("TonClamp")}, false);
				$('#kNClamp01')[0].addEventListener('focusout', function(){MoldJudge("kNClamp")}, false);
				$('#kNClamp02')[0].addEventListener('focusout', function(){MoldJudge("kNClamp")}, false);
				$('#kNClamp03')[0].addEventListener('focusout', function(){MoldJudge("kNClamp")}, false);
				$('#kNClamp04')[0].addEventListener('focusout', function(){MoldJudge("kNClamp")}, false);
				$('#KgPlunger01')[0].addEventListener('focusout', function(){MoldJudge("KgPlunger")}, false);
				$('#KgPlunger02')[0].addEventListener('focusout', function(){MoldJudge("KgPlunger")}, false);
				$('#KgPlunger03')[0].addEventListener('focusout', function(){MoldJudge("KgPlunger")}, false);
				$('#KgPlunger04')[0].addEventListener('focusout', function(){MoldJudge("KgPlunger")}, false);
				$('#kNPlunger01')[0].addEventListener('focusout', function(){MoldJudge("kNPlunger")}, false);
				$('#kNPlunger02')[0].addEventListener('focusout', function(){MoldJudge("kNPlunger")}, false);
				$('#kNPlunger03')[0].addEventListener('focusout', function(){MoldJudge("kNPlunger")}, false);
				$('#kNPlunger04')[0].addEventListener('focusout', function(){MoldJudge("kNPlunger")}, false);
				$('#Trans01')[0].addEventListener('focusout', function(){MoldJudge("kNPlunger")}, false);
				$('#Trans02')[0].addEventListener('focusout', function(){MoldJudge("kNPlunger")}, false);
				$('#Trans03')[0].addEventListener('focusout', function(){MoldJudge("kNPlunger")}, false);
				$('#Trans04')[0].addEventListener('focusout', function(){MoldJudge("kNPlunger")}, false);
				$('#GoldHeat01')[0].addEventListener('focusout', function(){MoldJudge("GoldHeat")}, false);
				$('#GoldHeat02')[0].addEventListener('focusout', function(){MoldJudge("GoldHeat")}, false);
				$('#MoldTime01')[0].addEventListener('focusout', function(){MoldJudge("MoldTime")}, false);
				$('#MoldTime02')[0].addEventListener('focusout', function(){MoldJudge("MoldTime")}, false);
				$('#MoldTime03')[0].addEventListener('focusout', function(){MoldJudge("MoldTime")}, false);
				$('#MoldTime04')[0].addEventListener('focusout', function(){MoldJudge("MoldTime")}, false);
				$('#DePress01')[0].addEventListener('focusout', function(){MoldJudge("DePress")}, false);
				$('#DePress02')[0].addEventListener('focusout', function(){MoldJudge("DePress")}, false);
				$('#DePress03')[0].addEventListener('focusout', function(){MoldJudge("DePress")}, false);
				$('#DePress04')[0].addEventListener('focusout', function(){MoldJudge("DePress")}, false);

				$('#DisPlace01')[0].addEventListener('focusout', function(){MoldJudge("DisPlace")}, false);
				$('#DisPlace02')[0].addEventListener('focusout', function(){MoldJudge("DisPlace")}, false);
				$('#DisPlace03')[0].addEventListener('focusout', function(){MoldJudge("DisPlace")}, false);
				$('#DisPlace04')[0].addEventListener('focusout', function(){MoldJudge("DisPlace")}, false);

				/*  */
				$('#Gold01')[0].addEventListener('change', function(e){InputModuleEnabledHandler()}, false);
				$('#Gold02')[0].addEventListener('change', function(e){InputModuleEnabledHandler()}, false);
				$('#Gold03')[0].addEventListener('change', function(e){InputModuleEnabledHandler()}, false);
				$('#Gold04')[0].addEventListener('change', function(e){InputModuleEnabledHandler()}, false);

				$('#KgClampJ')[0].addEventListener('change', function(){MoldReset("KgClamp")}, false);
				$('#KgClampG')[0].addEventListener('change', function(){MoldReset("KgClamp")}, false);
				$('#TonClampJ')[0].addEventListener('change', function(){MoldReset("TonClamp")}, false);
				$('#TonClampG')[0].addEventListener('change', function(){MoldReset("TonClamp")}, false);
				$('#kNClampJ')[0].addEventListener('change', function(){MoldReset("kNClamp")}, false);
				$('#kNClampG')[0].addEventListener('change', function(){MoldReset("kNClamp")}, false);
				$('#KgPlungerJ')[0].addEventListener('change', function(){MoldReset("KgPlunger")}, false);
				$('#KgPlungerG')[0].addEventListener('change', function(){MoldReset("KgPlunger")}, false);
				$('#kNPlungerJ')[0].addEventListener('change', function(){MoldReset("kNPlunger")}, false);
				$('#kNPlungerG')[0].addEventListener('change', function(){MoldReset("kNPlunger")}, false);
				$('#TransJ')[0].addEventListener('change', function(){MoldReset("Trans")}, false);
				$('#TransG')[0].addEventListener('change', function(){MoldReset("Trans")}, false);
				$('#GoldHeatJ')[0].addEventListener('change', function(){MoldReset("GoldHeat")}, false);
				$('#GoldHeatG')[0].addEventListener('change', function(){MoldReset("GoldHeat")}, false);
				$('#MoldTimeJ')[0].addEventListener('change', function(){MoldReset("MoldTime")}, false);
				$('#MoldTimeG')[0].addEventListener('change', function(){MoldReset("MoldTime")}, false);
				$('#DePressJG')[0].addEventListener('change', function(){MoldReset("DePress")}, false);

				initialize();

				/* ｽﾄｯﾌﾟｳｫｯﾁ管理No.の先頭にSを付けるイベント */
				$('#SWno').change(function(e) {
					//先頭のSのみ重複しないよう制御
					var val=$(this).val().replace(/S/, '');
					//TextBoxが空であれば何もしない
					if (val.length===0) return false;
					//入力値の先頭にWBを付ける
					$(this).val('S'+val);
				});
				/* 表面温度計管理No.の先頭にSを付けるイベント */
				$('#HeatNo').change(function(e) {
					//先頭のSのみ重複しないよう制御
					var val=$(this).val().replace(/H/, '');
					//TextBoxが空であれば何もしない
					if (val.length===0) return false;
					//入力値の先頭にWBを付ける
					$(this).val('H'+val);
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
		var MoldJudge = function(set) {
			var jud	  = $('#' + set + 'J').val();
			var ge    = $('#' + set + 'G').val();
			var jg    = $('#' + set + 'JG').val();
			var plus  = parseInt(jud,10) + parseInt(ge,10);
			var minus = parseInt(jud,10) - parseInt(ge,10);
			var Rs    = ('input[name="' + set + 'Rs"]');
			var check = true;

			if(!isNaN(jud) && !isNaN(ge) && isNaN(jg)){
				if(jud !== '' && ge !== ''){
					for (var i=1; i<=4; i++){
						var count = parseInt($('#' + set + '0' + i).val(),10);
						if((minus > count || count > plus) && !isNaN(count)){
							check = false;
						}
					}
					if(check==true){
						$(Rs).val('○');
					}else{
						$(Rs).val('×');
						bootbox.alert("範囲外です");
					}
				}
			}else if(!isNaN(jg)){
				if(jg !== ''){
					for (var i=1; i<=4; i++){
						var count = parseInt($('#' + set + '0' + i).val(),10);
						if(count !== parseInt(jg,10) && !isNaN(count)){
							check = false;
						}
					}
					if(check==true){
						$(Rs).val('○');
					}else{
						$(Rs).val('×');
						bootbox.alert("範囲外です");
					}
				}
			}
		}
		</script>

		<script type="text/javascript">
		var MoldReset = function(set) {
			for (var i=1; i<=4; i++) $('#' + set + '0' + i).val('');
			$('input[name="' + set + 'Rs"]').val('');
		}
		</script>

		<script type="text/javascript">
			var initialize = function() {
				/*  */
				$('#Gold01,#Gold02,#Gold03,#Gold04,#Block01,#Block02,#Block03,#Block04').prop("disabled", true);
				/*  */
				$('#plunger,#cleaner,#tswitch,#chase,#lfset,#cstop,#ball,#goldct,#typecheck,#udcheck,#heater,#pot,#charge').hide();
				//$('#plunger,#cleaner,#tswitch,#chase,#lfset,#cstop,#ball,#goldct,#typecheck,#udcheck,#heater,#pot,#charge').prop("disabled", true);
				$('#kgclampj,#tonclampj,#knclampj,#kgplungerj,#knplungerj,#transj,#goldheatj,#moldtimej,#depressjg').hide();
				$('#outer,#xray,#displace,#lfmark,#resinflash').hide();
				$('#typeselect,#golddisplay,#goldno,#dummylf,#4s').hide();
				/*  */
				InputModuleDisabledHandler();
			}
		</script>

		<script type="text/javascript">
			var InputModuleEnabledHandler = function() {
				InputModuleDisabledHandler();
				if ($('#Gold01').val().replace(/[\n\s　]/g, "").length!==0) {$("#KgClamp01,#TonClamp01,#kNClamp01,#KgPlunger01,#kNPlunger01,#Trans01,#GoldHeat01,#MoldTime01,#DePress01,#Outer01,#Xray01,#DisPlace01,#LFMark01,#ResinFlash01").prop("disabled", false);}
				if ($('#Gold02').val().replace(/[\n\s　]/g, "").length!==0) {$("#KgClamp02,#TonClamp02,#kNClamp02,#KgPlunger02,#kNPlunger02,#Trans02,#GoldHeat02,#MoldTime02,#DePress02,#Outer02,#Xray02,#DisPlace02,#LFMark02,#ResinFlash02").prop("disabled", false);}
				if ($('#Gold03').val().replace(/[\n\s　]/g, "").length!==0) {$("#KgClamp03,#TonClamp03,#kNClamp03,#KgPlunger03,#kNPlunger03,#Trans03,#GoldHeat03,#MoldTime03,#DePress03,#Outer03,#Xray03,#DisPlace03,#LFMark03,#ResinFlash03").prop("disabled", false);}
				if ($('#Gold04').val().replace(/[\n\s　]/g, "").length!==0) {$("#KgClamp04,#TonClamp04,#kNClamp04,#KgPlunger04,#kNPlunger04,#Trans04,#GoldHeat04,#MoldTime04,#DePress04,#Outer04,#Xray04,#DisPlace04,#LFMark04,#ResinFlash04").prop("disabled", false);}
			}
		</script>

		<script type="text/javascript">
			var InputModuleDisabledHandler = function() {
				 $("#KgClamp01,#TonClamp01,#kNClamp01,#KgPlunger01,#kNPlunger01,#Trans01,#GoldHeat01,#MoldTime01,#DePress01,#Outer01,#Xray01,#DisPlace01,#LFMark01,#ResinFlash01").prop("disabled", true);
				 $("#KgClamp02,#TonClamp02,#kNClamp02,#KgPlunger02,#kNPlunger02,#Trans02,#GoldHeat02,#MoldTime02,#DePress02,#Outer02,#Xray02,#DisPlace02,#LFMark02,#ResinFlash02").prop("disabled", true);
				 $("#KgClamp03,#TonClamp03,#kNClamp03,#KgPlunger03,#kNPlunger03,#Trans03,#GoldHeat03,#MoldTime03,#DePress03,#Outer03,#Xray03,#DisPlace03,#LFMark03,#ResinFlash03").prop("disabled", true);
				 $("#KgClamp04,#TonClamp04,#kNClamp04,#KgPlunger04,#kNPlunger04,#Trans04,#GoldHeat04,#MoldTime04,#DePress04,#Outer04,#Xray04,#DisPlace04,#LFMark04,#ResinFlash04").prop("disabled", true);
			}
		</script>

		<script type="text/javascript">
			const PF100 =['plunger','cleaner','tswitch','lfset','goldct','typecheck','udcheck','heater','pot','charge','kgclampj','kgplungerj','transj','goldheatj','moldtimej','depressjg','outer','xray','displace','lfmark','resinflash','typeselect','golddisplay','goldno','4s'];
			const F500	=['plunger','chase','lfset','cstop','ball','typecheck','udcheck','heater','pot','tonclampj','kgplungerj','transj','goldheatj','moldtimej','depressjg','outer','xray','displace','lfmark','resinflash','typeselect','golddisplay','goldno,dummylf','4s'];
			const FX	=['plunger','chase','lfset','cstop','typecheck','udcheck','heater','pot','knclampj','knplungerj','transj','goldheatj','moldtimej','outer','xray','displace','lfmark','resinflash','typeselect','golddisplay','goldno','dummylf','4s'];
			const FS	=['plunger','chase','lfset','cstop','typecheck','udcheck','heater','pot','knclampj','knplungerj','transj','goldheatj','moldtimej','outer','xray','displace','lfmark','resinflash','typeselect','golddisplay','goldno','dummylf','4s'];
			const GLINE =['plunger','chase','lfset','cstop','typecheck','udcheck','heater','pot','knclampj','knplungerj','transj','goldheatj','moldtimej','outer','xray','displace','lfmark','resinflash','typeselect','golddisplay','goldno','dummylf','4s'];
			const PMC	=['plunger','chase','lfset','cstop','typecheck','udcheck','heater','pot','knclampj','knplungerj','transj','goldheatj','moldtimej','outer','xray','displace','lfmark','resinflash','typeselect','golddisplay','goldno','dummylf','4s'];
			const YPC	=['plunger','chase','lfset','cstop','typecheck','udcheck','heater','pot','knclampj','knplungerj','transj','goldheatj','moldtimej','outer','xray','displace','lfmark','resinflash','typeselect','golddisplay','goldno','4s'];
			const YPM	=['plunger','chase','lfset','cstop','typecheck','udcheck','heater','pot','knclampj','knplungerj','transj','goldheatj','moldtimej','outer','xray','displace','lfmark','resinflash','typeselect','golddisplay','goldno','dummylf','4s'];
			const YPS	=['plunger','chase','lfset','cstop','typecheck','udcheck','heater','pot','knclampj','knplungerj','transj','goldheatj','moldtimej','outer','xray','displace','lfmark','resinflash','typeselect','golddisplay','goldno','4s'];

			var SeriesHandler = function() {

				initialize();

				var val = $('#Series').val();
				if (val==='100PF')		 {$.each(PF100, function(i, val){SelectorControl(val, true)});}
				else if (val==='500F')	 {$.each(F500,  function(i, val){SelectorControl(val, true)});}
				else if (val==='FX')	 {$.each(FX,    function(i, val){SelectorControl(val, true)});}
				else if (val==='FS')	 {$.each(FS,    function(i, val){SelectorControl(val, true)});}
				else if (val==='G-LINE') {$.each(GLINE, function(i, val){SelectorControl(val, true)});}
				else if (val==='PMC')	 {$.each(PMC,   function(i, val){SelectorControl(val, true)});}
				else if (val==='Y-PC')	 {$.each(YPC,   function(i, val){SelectorControl(val, true)});}
				else if (val==='YPM')	 {$.each(YPM,   function(i, val){SelectorControl(val, true)});}
				else if (val==='YPS')	 {$.each(YPS,   function(i, val){SelectorControl(val, true)});}
			}
		</script>

		<script type="text/javascript">
			/* 保存前のバリデーション処理を行う */
			var ValidationHandler = function() {
				var param='';
				var msg='';
				param=(!$('#KgClamp01').is(':disabled')?$('#KgClamp01').val():(!$('#KgClamp02').is(':disabled')?$('#KgClamp02').val():(!$('#KgClamp03').is(':disabled')?$('#KgClamp03').val():(!$('#KgClamp04').is(':disabled')?$('#KgClamp04').val():''))))
				//alert(isRange());

				/*if($('#plunger').prop('disabled')===false && $('#Plunger').val()==='×') {
					msg+='【結果】判定結果に × が選択されています。<br/>';
					$('#InsChk').val($('#plunger').prop('disabled'));
					$('#PKG').val($('#plunger').prop('disabled'));
				}*/

				if(!($('#Total').val()==='合格')){
					msg+='【総合判定】総合判定が不合格です。<br/>';
					$('#PKG').val($('#plunger').prop('disabled'));
				}


				if(0<msg.length) {
					bootbox.alert(msg);
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

	</body>
	<!-- cssフレームワーク  -->
	<jsp:include page="/include/include_bootstrap.jsp"/>
</html>