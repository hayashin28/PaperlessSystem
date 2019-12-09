<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="common.DbCommonFunctions"%>
<%@page import="java.sql.Timestamp"%>
<!DOCTYPE html>
<html>

	<jsp:include page="/include/include_scriptframework.jsp"/>

	<script type="text/javascript">
		document.getElementsByName('savekbn')[0].value=savekbn.TmpSaved;
	</script>

	<% String tanname = System.getProperty("user.name");%>
	<% request.setCharacterEncoding("UTF-8"); %>

	<head>
		<jsp:include page="/include/include_loader.jsp"/>

		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>品種切替評価チェックシート</title>
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

			<div class="block">品種切替評価チェックシート</div>
			<form id="fm" action="<%=request.getContextPath()%>/TenkenListServlet" method="post">
				<input type="hidden" name="sheetnm" value="品種切替評価チェックシート">
				<input type="hidden" name="tanname" value="<%=tanname%>">
				<input type="hidden" name="Setubi"  value="">
				<input type="hidden" name="Lot"		value="">
				<input type="hidden" name="savekbn">
				<input type="hidden" name="params" id="params" value="">

				<div class="bs-example table-responsive">
					<table class="table table-hover">
						<tr>
							<td colspan=2>
								<div class="boxContainer">
									<div>
										<button type="button" id="tmpSubmitBtn" class="button blue large" style="margin:10px 20px 0px 0px;"><span>一時保存</span></button>
									</div>
									<div><jsp:include page="/include/include_button.jsp"/></div>
								</div>
							<td>
						</tr>
						<tr>
							<td>
								<div class="boxContainer">
									<div><span class="btn btn-primary btn-lg" style="width:100px; margin:20px 0px 0px 0px;">実施日時</span></div>
									<div><input type="text" id="Date" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:150px; margin:20px 10px 10px 0px; background-color:#FFFFFF"></div>
									<div><jsp:include page="/include/include_equip.jsp"/></div>
								</div>
							<td>
						</tr>
						<tr>
							<td>
								<div class="boxContainer">
									<div>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="PKG" />
											<jsp:param name="disp"	 value="PKG名" />
											<jsp:param name="txt"	 value="PKG" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</div>
									<div>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="Gold" />
											<jsp:param name="disp"	 value="金型No." />
											<jsp:param name="txt"	 value="Gold" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td><b>1.適用</b></td>
						</tr>
						<tr>
							<td>
								<div class="btn_group_280" style="margin : 0x 0px 0px 0px">
									<input type="checkbox" name="Tekiyo" id="select1" value="品種切替">
									<label for="select1">品種切替</label>
									<input type="checkbox" name="Tekiyo" id="select2" value="エラー解除">
									<label for="select2">改造等によるﾕﾆｯﾄ取り外し</label>
									<input type="checkbox" name="Tekiyo" id="select3" value="ダミーで発生">
									<label for="select3">その他</label>
								</div>
							</td>
						</tr>
						<tr class="Tekiyo" id="tspkg">
							<td>
								<div class="boxContainer">
									<div><span class="btn btn-primary btn-lg" style="width:180px; margin:10px 0px 0px 0px;">品切前ＰＫＧ名</span></div>
									<div><input type="text" id="TSBefore" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:200px; margin:12px 10px 10px 0px; background-color:#FFFFFF"></div>
									<div>
										<jsp:include page="/include/include_inputtextex_required.jsp">
											<jsp:param name="btn"	 value="TSAfter" />
											<jsp:param name="disp"	 value="品切後ＰＫＧ名" />
											<jsp:param name="txt"	 value="TSAfter" />
											<jsp:param name="width"	 value="100"/>
										</jsp:include>
									</div>
								</div>
							</td>
						</tr>
						<tr class="Tekiyo" id="unitout">
							<td>
								<div>
									<jsp:include page="/include/include_selectionbox_required.jsp">
										<jsp:param name="btn_id"	 value="UnitOut"/>
										<jsp:param name="btn_text"	 value="改造などによるユニット取り外し"/>
										<jsp:param name="txt_id"	 value="UnitOut"/>
										<jsp:param name="select_txt" value="F001"/>
										<jsp:param name="width"	 	 value="100"/>
									</jsp:include>
								</div>
							</td>
						</tr>
						<tr class="Tekiyo" id="other">
							<td>
								<div>
									<jsp:include page="/include/include_inputtextex_required.jsp">
										<jsp:param name="btn"	 value="Other" />
										<jsp:param name="disp"	 value="その他" />
										<jsp:param name="txt"	 value="Other" />
										<jsp:param name="width"	 value="100"/>
									</jsp:include>
								</div>
							</td>
						</tr>

						<tr id="clist1">
							<td><b>2.チェックリスト</b></td>
						</tr>
						<tr id="clist2">
							<td>
								<div class="btn_group_80" style="margin : 0x 0px 0px 0px">
									<input type="checkbox" name="CList" id="select4" class="CList" value="L/D">
									<label for="select4">L/D</label>
									<input type="checkbox" name="CList" id="select5" class="CList" value="F/L">
									<label for="select5">F/L</label>
									<input type="checkbox" name="CList" id="select6" class="CList" value="F/I">
									<label for="select6">F/I</label>
									<input type="checkbox" name="CList" id="select7" class="CList" value="TC">
									<label for="select7">TC</label>
									<input type="checkbox" name="CList" id="select8" class="CList" value="T/L">
									<label for="select8">T/L</label>
									<input type="checkbox" name="CList" id="select9"  class="CList" value="プレス">
									<label for="select9">プレス</label>
									<input type="checkbox" name="CList" id="select10" class="CList"  value="C/L">
									<label for="select10">C/L</label>
									<input type="checkbox" name="CList" id="select11" class="CList"  value="FO">
									<label for="select11">FO</label>
									<input type="checkbox" name="CList" id="select12" class="CList"  value="G/B">
									<label for="select12">G/B</label>
									<input type="checkbox" name="CList" id="select13" class="CList"  value="U/L">
									<label for="select13">U/L</label>
								</div>
							</td>
						</tr>

						<tr id="table1">
							<td>
								<table border="1">
									<tr id="title1">
										<td>＼</td><td>確認項目</td><td>確認内容</td><td>判定基準</td><td>Ｎ数</td><td>確認結果</td><td>判定</td>
									</tr>

									<tr class="ld1" id="ldlf">
										<td rowspan=4>L/D</td><td>L/Fﾌﾟｯｼｬ動作</td><td>ﾌﾟｯｼｬ押し出し後のL/F変形確認</td><td>L/F変形無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="LDLF" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="LDLF" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on01"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off01"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="LDLFRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ld1" id="ldrailh">
										<td>整列ﾚｰﾙ高さ</td><td>L/Fと整列ﾚｰﾙ位置（高さ）確認</td><td>整列ﾚｰﾙへの乗り上げ無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="LDRailH" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="LDRailH" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on02"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off02"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="LDRailHRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ld1" id="ldrailw">
										<td>整列ﾚｰﾙ幅</td><td>L/Fと整列ﾚｰﾙ位置（幅）確認</td><td>L/Fが整列ﾚｰﾙ幅のｾﾝﾀを通過する事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="LDRailW" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="LDRailW" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on03"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off03"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="LDRailWRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ld1" id="ldloarder">
										<td>ﾛｰﾀﾞｶｾｯﾄ動作</td><td>ﾛｰﾀﾞｶｾｯﾄのこすれ確認</td><td>こすれ無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="LDLoarder" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="LDLoarder" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on04"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off04"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="LDLoarderRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fl1" id="flrailw">
										<td rowspan=3>F/L</td><td>整列ﾚｰﾙ幅</td><td>治具にて幅ﾁｪｯｸ</td><td>治具がｽﾑｰｽﾞに通る事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FLRailW" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FLRailW" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on05"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off05"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FLRailWRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fl1" id="flbelt">
										<td>搬送ﾍﾞﾙﾄ位置</td><td>L/Fと搬送ﾍﾞﾙﾄの位置確認</td><td>搬送ﾍﾞﾙﾄがL/F外枠にある事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FLBelt" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FLBelt" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on06"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off06"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FLBeltRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fl1" id="flact">
										<td>搬送動作</td><td>搬送ﾍﾞﾙﾄの送り動作確認</td><td>振動無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FLAct" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FLAct" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on07"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off07"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FLActRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fi1" id="fiagpos">
										<td rowspan=5>F/I</td><td>整列位置ｽﾞﾚ</td><td>整列とL/F位置をﾁｪｯｸ</td><td>L/F変形無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FIAgPos" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FIAgPos" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on08"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off08"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FIAgPosRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fi1" id="figopos">
										<td>金型位置ｽﾞﾚ</td><td>ﾕﾆｯﾄ位置を治具でﾁｪｯｸ</td><td>治具が確実に入る事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FIGoPos" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FIGoPos" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on09"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off09"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FIGoPosRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fi1" id="fiset">
										<td>L/Fｾｯﾄ</td><td>金型へのL/Fｾｯﾄ状態確認</td><td>L/F変形・押し付け無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FISet" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FISet" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on10"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off10"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FISetRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fi1" id="fiads">
										<td>L/F吸着</td><td>L/F吸着状態確認</td><td>ﾊﾟｲﾛｯﾄﾋﾟﾝとの干渉無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FIAds" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FIAds" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on11"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off11"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FIAdsRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fi1" id="ficollet">
										<td>吸着ｺﾚｯﾄ動作</td><td>吸着ｺﾚｯﾄ上下動作確認</td><td>ｶﾞﾀ･動作不良無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FICollet" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FICollet" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on12"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off12"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FIColletRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="tc1" id="tcshoot">
										<td rowspan=2>TC</td><td rowspan=2>TB受渡し位置</td><td>ｼｭｰﾄ部でのTB受渡し位置確認</td><td>ﾁｬｯｸ中心で受け渡す事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="TCShoot" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="TCShoot" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on13"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off13"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="TCShootRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="tc1" id="tcchuck">
										<td>T/Lﾁｬｯｸ部でのTB受渡し位置確認</td><td>ﾁｬｯｸ中心で受け渡す事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="TCChuck" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="TCChuck" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on14"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off14"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="TCChuckRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="tl1" id="tlsubpot">
										<td rowspan=2>T/L</td><td>ｻﾌﾞﾎﾟｯﾄ投入位置</td><td>金型へのTB投入状態確認</td><td>TBの引っかかり無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="TLSubPot" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="TLSubPot" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on15"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off15"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="TLSubPotRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="tl1" id="tlstuffing">
										<td>ｽﾀｯﾌｨﾝｸﾞｽﾄﾛｰｸ</td><td>ｽﾀｯﾌｨﾝｸﾞ動作時のｴﾗｰ発生状態確認</td><td>2個投入でｴﾗｰ検出する事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="TLStuffing" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="TLStuffing" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on16"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off16"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="TLStuffingRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="pr1" id="prplunger">
										<td rowspan=2>ﾌﾟﾚｽ</td><td>ﾌﾟﾗﾝｼﾞｬ位置</td><td>ｸﾘｰﾅ動作時のﾌﾟﾗﾝｼﾞｬ位置を確認</td><td>ﾎﾟｯﾄ端面との段差無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="PRPlunger" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="PRPlunger" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on17"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off17"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="PRPlungerRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="pr1" id="preject">
										<td>ｴｼﾞｪｸﾀﾋﾟﾝ動作</td><td>ｴｼﾞｪｸﾀﾋﾟﾝの動作状態を確認</td><td>突き出し・戻り不良無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="PREject" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="PREject" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on18"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off18"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="PREjectRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="cl1" id="clcl1">
										<td rowspan=2>C/L</td><td rowspan=2>ｸﾘｰﾅ位置</td><td rowspan=2>ｸﾘｰﾅ動作時のﾍｯﾄﾞ位置を確認</td><td>金型ｳｪｯｼﾞとﾍｯﾄﾞとの干渉無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="CLCL1" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="CLCL1" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on19"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off19"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="CLCL1Rs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="cl1" id="clcl2">
										<td>ﾘｯﾌﾟと上型、下型のｸﾘｱﾗﾝｽ1.0～2.0mm</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="CLCL2" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="CLCL2" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on20"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off20"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="CLCL2Rs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fo1" id="fopos">
										<td rowspan=2>F/O</td><td>ﾊﾟｯｹｰｼﾞ吸着位置</td><td>ﾊﾟｯｹｰｼﾞ吸着位置(X･Y)確認</td><td>ﾊﾟｯｹｰｼﾞ･ｶﾙの中心を吸着している事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FOPos" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FOPos" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on21"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off21"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FOPosRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fo1" id="fostate">
										<td>ﾊﾟｯｹｰｼﾞ吸着状態</td><td>ﾊﾟｯｹｰｼﾞ吸着状態確認</td><td>完全に吸着している事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FOState" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FOState" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on22"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off22"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FOStateRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="gb1" id="gbboard">
										<td rowspan=2>G/B</td><td>ｹﾞｰﾄﾌﾞﾚｲｸ板位置</td><td>製品とｹﾞｰﾄﾌﾞﾚｲｸ板の位置確認</td><td>L/Fに干渉無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="GBBoard" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="GBBoard" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on23"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off23"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="GBBoardRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="gb1" id="gbpress">
										<td>搬送体押え位置</td><td>搬送体の押えｼﾘﾝﾀﾞ位置確認</td><td>浮き無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="GBPress" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="GBPress" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on24"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off24"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="GBPressRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ul1" id="ulpos">
										<td rowspan=2>U/L</td><td>ｱﾝﾛｰﾃﾞｨﾝｸﾞ位置</td><td>ｱﾝﾛｰﾀﾞﾗｯｸへの収納状態確認</td><td>ｱﾝﾛｰﾀﾞﾗｯｸへの製品引っかかり無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="ULPos" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="ULPos" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on25"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off25"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="ULPosRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ul1" id="ulset">
										<td>ｱﾝﾛｰﾀﾞﾗｯｸｾｯﾄ状態</td><td>ｱﾝﾛｰﾀﾞﾗｯｸｾｯﾄ状態確認</td><td>ｶﾞﾀﾂｷ無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="ULSet" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="ULSet" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on26"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off26"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="ULSetRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ar1" id="artb">
										<td rowspan=5>異常検出</td><td>TB検出</td><td>TB検出ｽﾄﾛｰｸ確認</td><td>検出ﾐｽ無き事</td><td>1回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="ARTB" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="ARTB" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on27"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off27"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="ARTBRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ar1" id="arway">
										<td rowspan=3>整列L/F検出</td><td>方向逆</td><td>ｱﾗｰﾑ発生する事</td><td>1回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="ARWay" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="ARWay" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on28"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off28"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="ARWayRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ar1" id="arside">
										<td>表裏逆</td><td>ｱﾗｰﾑ発生する事</td><td>1回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="ARSide" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="ARSide" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on29"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off29"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="ARSideRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ar1" id="arless">
										<td>L/F無し</td><td>ｱﾗｰﾑ発生する事</td><td>1回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="ARLess" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="ARLess" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on30"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off30"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="ARLessRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ar1" id="armold">
										<td>ﾓｰﾙﾄﾞ不足検出</td><td>ﾓｰﾙﾄﾞ後製品の不足検出確認</td><td>ﾓｰﾙﾄﾞ不足時､ｱﾗｰﾑ発生する事</td><td>1回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="ARMold" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="ARMold" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on31"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off31"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="ARMoldRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ac1" id="acauto">
										<td>動作</td><td>自動ｻｲｸﾙ動作</td><td>自動ｻｲｸﾙでﾀﾞﾐｰﾗﾝﾆﾝｸﾞ確認</td><td>ﾄﾗﾌﾞﾙ無き事</td><td>30shot</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="ACAuto" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="ACAuto" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on32"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off32"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="ACAutoRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="qu1" id="qupkg">
										<td rowspan=3>品質</td><td rowspan=3>品質確認</td><td>ﾊﾟｯｹｰｼﾞ外観</td><td>外観不良無き事</td><td>1shot</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="QUPkg" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="QUPkg" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on33"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off33"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="QUPkgRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="qu1" id="qugate">
										<td>ｹﾞｰﾄ残り</td><td>ｹﾞｰﾄ残り発生無き事</td><td>1shot</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="QUGate" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="QUGate" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on34"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off34"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="QUGateRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="qu1" id="quxray">
										<td>X線ﾁｪｯｸ</td><td>ﾜｲﾔ変形･ｼｮｰﾄ･気泡無き事</td><td>1shot</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="QUXray" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="QUXray" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on35"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off35"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="QUXrayRs"/>
											</jsp:include>
										</td>
									</tr>
								</table>
							</td>
						</tr>



						<tr id="table2">
							<td>
								<table border="1">
									<tr id="title2">
										<td>＼</td><td>確認項目</td><td>確認内容</td><td>判定基準</td><td>Ｎ数</td><td>確認結果</td><td>判定</td>
									</tr>
									<tr class="ld2" id="ld2move">
										<td rowspan=4>L/D</td><td>ﾗｯｸ移動</td><td>ﾗｯｸ移動状態確認</td><td>振動、引っかかり、倒れ無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="LD2Move" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="LD2Move" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on001"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off001"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="LD2MoveRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ld2" id="ld2lifter">
										<td>ﾗｯｸﾘﾌﾀ移載</td><td>ﾘﾌﾀ移載状態確認</td><td>振動、引っかかり、倒れ無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="LD2Lifter" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="LD2Lifter" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on002"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off002"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="LD2LifterRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ld2" id="ld2keep">
										<td>ﾗｯｸ保持</td><td>ﾗｯｸ押え動作状態確認</td><td>ｶﾞﾀ・振動の無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="LD2Keep" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="LD2Keep" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on003"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off003"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="LD2KeepRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ld2" id="ld2level">
										<td>L/Fﾌﾟｯｼｬ位置</td><td>ﾌﾟｯｼｬとL/Fのﾚﾍﾞﾙ確認</td><td>ﾌﾟｯｼｬ厚み内での片寄り無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="LD2Level" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="LD2Level" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on004"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off004"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="LD2LevelRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fl2" id="fl2railtrans">
										<td>F/L</td><td>整列L/F位置</td><td>ﾚｰﾙへのL/F搬送状態</td><td>ﾚｰﾙとのｺｽﾚ､L/F乗り上げ無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FL2RailTrans" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FL2RailTrans" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on005"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off005"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FL2RailTransRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fl2" id="fl2railstate">
										<td>F/L</td><td>整列ﾚｰﾙ</td><td>整列ﾚｰﾙの状態確認</td><td>位置ｽﾞﾚ､ﾉｯｷﾝｸﾞ無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FL2RailState" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FL2RailState" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on006"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off006"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FL2RailStateRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fl2" id="fl2belt">
										<td>F/L</td><td>ﾍﾞﾙﾄ位置</td><td>L/Fとﾍﾞﾙﾄの位置確認</td><td>搬送ﾍﾞﾙﾄがｲﾝﾅｰﾘｰﾄﾞにかからない事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FL2Belt" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FL2Belt" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on007"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off007"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FL2BeltRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fl2" id="fl2send">
										<td>F/L</td><td>整列動作</td><td>ﾍﾞﾙﾄの送り動作状態確認</td><td>振動、変形無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FL2Send" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FL2Send" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on008"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off008"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FL2SendRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fl2" id="fl2gripper">
										<td>F/L</td><td>L/Fｸﾞﾘｯﾊﾟ</td><td>ｸﾞﾘｯﾊﾟ引き込み時のL/F確認</td><td>L/Fへのｽﾄﾚｽ無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FL2Gripper" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FL2Gripper" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on009"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off009"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FL2GripperRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fl2" id="fl2shiftrail">
										<td>F/L</td><td rowspan=2>ｼﾌﾀﾚｰﾙ位置</td><td>L/Fとｼﾌﾀﾚｰﾙ確認</td><td>ﾚｰﾙとのｺｽﾚ､L/F乗り上げ無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FL2ShiftRail" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FL2ShiftRail" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on010"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off010"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FL2ShiftRailRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fl2" id="fl2shiftstate">
										<td>F/L</td><td>ｼﾌﾀﾚｰﾙ位置状態確認</td><td>位置ｽﾞﾚ､ﾉｯｷﾝｸﾞ無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FL2ShiftState" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FL2ShiftState" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on011"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off011"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FL2ShiftStateRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fl2" id="fl2weight">
										<td>F/L</td><td>ｼﾌﾀﾚｰﾙ幅</td><td>ﾚｰﾙ幅確認</td><td>位置ｽﾞﾚ､ﾉｯｷﾝｸﾞ無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FL2Weight" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FL2Weight" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on012"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off012"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FL2WeightRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fi2" id="fi2chuking">
										<td>F/I</td><td>搬送受渡し</td><td>整列からのL/Fﾁｬｯｷﾝｸﾞ確認</td><td>L/Fへのｽﾄﾚｽ無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FI2Chuking" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FI2Chuking" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on013"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off013"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FI2ChukingRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fi2" id="fi2space">
										<td>F/I</td><td>搬送ﾁｬｯｸ爪</td><td>L/Fとﾁｬｯｸのすきま確認</td><td>L/Fへのｽﾄﾚｽ無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FI2Space" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FI2Space" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on014"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off014"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FI2SpaceRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fi2" id="fi2ads">
										<td>F/I</td><td>搬送吸着</td><td>L/Fの吸着状態確認</td><td>吸着ｴﾗｰ発生しない事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FI2Ads" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FI2Ads" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on015"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off015"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FI2AdsRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fi2" id="fi2set">
										<td>F/I</td><td rowspan=2>金型L/Fｾｯﾄ</td><td>金型へのL/Fｾｯﾄ状態確認</td><td>L/Fへのｽﾄﾚｽ無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FI2Set" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FI2Set" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on016"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off016"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FI2SetRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fi2" id="fi2drop">
										<td>F/I</td><td>金型へのL/F落下距離</td><td>落下距離2.5mm以上無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FI2Drop" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FI2Drop" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on017"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off017"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FI2DropRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fi2" id="fi2tb">
										<td>F/I</td><td>金型TBｾｯﾄ</td><td>金型へのTBｾｯﾄ状態確認</td><td>ﾎﾟｯﾄとの干渉無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FI2TB" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FI2TB" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on018"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off018"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FI2TBRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="tc2" id="tc2feeder">
										<td>TC</td><td>ﾊﾟｰﾂﾌｨｰﾀﾞ内TB</td><td>ﾊﾟｰﾂﾌｨｰﾀﾞﾄﾗｯｸ･ｼｭｰﾄ内TB移動状態確認</td><td>引っかかり、横詰り無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="TC2Feeder" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="TC2Feeder" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on019"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off019"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="TC2FeederRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="tc2" id="tc2cut">
										<td>TC</td><td>ｼｭｰﾄ受渡し</td><td>ｼｭｰﾄからのTB切り出し状態確認</td><td>TB落下、ｾｯﾄ位置ｽﾞﾚ無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="TC2Cut" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="TC2Cut" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on020"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off020"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="TC2CutRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="tc2" id="tc2stocker">
										<td>TC</td><td>TBｽﾄｯｶ挿入</td><td>TBｽﾄｯｶへのTB挿入状態確認</td><td>引っかかり無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="TC2Stocker" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="TC2Stocker" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on021"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off021"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="TC2StockerRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="tc2" id="tc2holder">
										<td>TC</td><td>TBﾎﾙﾀﾞ挿入</td><td>TBﾎﾙﾀﾞへのTB挿入状態確認</td><td>引っかかり無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="TC2Holder" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="TC2Holder" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on022"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off022"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="TC2HolderRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="tc2" id="tc2shifter">
										<td>TC</td><td>TBｼﾌﾀ挿入</td><td>TBｼﾌﾀへのTB挿入状態確認</td><td>引っかかり無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="TC2Shifter" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="TC2Shifter" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on023"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off023"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="TC2ShifterRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="tc2" id="tc2shoot">
										<td>TC</td><td>TBｼｭｰﾄ挿入</td><td>TBｼｭｰﾄへのTB挿入状態確認</td><td>引っかかり無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="TC2Shoot" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="TC2Shoot" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on024"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off024"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="TC2ShootRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="tc2" id="tc2ins">
										<td>TC</td><td>TB受け渡し</td><td>TB挿入状態確認</td><td>引っかかり無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="TC2Ins" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="TC2Ins" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on025"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off025"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="TC2InsRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="pr2" id="pr2plunger">
										<td rowspan=2>ﾌﾟﾚｽ</td><td>ﾌﾟﾗﾝｼﾞｬ位置</td><td>ｸﾘｰﾅ動作時のﾌﾟﾗﾝｼﾞｬ位置を確認</td><td>ﾎﾟｯﾄ端面との段差無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="PR2Plunger" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="PR2Plunger" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on026"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off026"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="PR2PlungerRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="pr2" id="pr2eject">
										<td>ｴｼﾞｪｸﾀﾋﾟﾝ動作</td><td>ｴｼﾞｪｸﾀﾋﾟﾝの動作状態を確認</td><td>突き出し・戻り不良無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="PR2Eject" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="PR2Eject" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on027"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off027"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="PR2EjectRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="cl2" id="cl2cl">
										<td>C/L</td><td>ｸﾘｰﾅ位置</td><td>ｸﾘｰﾅ動作時のﾍｯﾄﾞ位置を確認</td><td>金型ｳｪｯｼﾞとﾍｯﾄﾞとの干渉無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="CL2CL" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="CL2CL" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on028"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off028"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="CL2CLRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fo2" id="fo2gold">
										<td rowspan=3>F/O</td><td>金型からの取出し</td><td>金型からのL/Fﾁｬｯｷﾝｸﾞ確認</td><td>L/F変形無き事、金型との干渉無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FO2Gold" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FO2Gold" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on029"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off029"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FO2GoldRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fo2" id="fo2chuking">
										<td>L/Fﾁｬｯｷﾝｸﾞ</td><td>L/Fﾁｬｯｷﾝｸﾞ確認</td><td>L/F変形無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FO2Chuking" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FO2Chuking" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on030"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off030"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FO2ChukingRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="fo2" id="fo2recive">
										<td>L/F受渡し</td><td>搬送体～ｼｭｰﾄへの受渡し確認</td><td>L/F変形無き事、ﾗﾝﾅ受けとの干渉無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="FO2Recive" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="FO2Recive" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on031"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off031"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="FO2ReciveRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="gb2" id="gb2runner">
										<td>G/B</td><td>ｶﾙ･ﾗﾝﾅ押さえ</td><td>押さえ下降状態確認</td><td>L/F変形、ｶﾙ･PKGの割れ無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="GB2Runner" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="GB2Runner" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on032"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off032"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="GB2RunnerRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="gb2" id="gb2push">
										<td>G/B</td><td>突き落とし</td><td>突き落とし状態確認</td><td>確実にゲートブレイクされてある事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="GB2Push" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="GB2Push" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on033"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off033"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="GB2PushRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="gb2" id="gb2rise">
										<td>G/B</td><td>ﾊﾞﾀﾌﾗｲ動作</td><td>ﾊﾞﾀﾌﾗｲ上昇位置・速度確認</td><td>4列とも一定でバラツキ無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="GB2Rise" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="GB2Rise" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on034"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off034"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="GB2RiseRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="gb2" id="gb2speed">
										<td>G/B</td><td>ﾊﾞﾀﾌﾗｲ動作</td><td>突き落し位置・速度確認</td><td>一定・均等である事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="GB2Speed" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="GB2Speed" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on035"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off035"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="GB2SpeedRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="gb2" id="gb2charge">
										<td>G/B</td><td>未充填検出機能</td><td>未充填検出状態を確認</td><td>ﾀﾞﾑ内未充填検出する事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="GB2Charge" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="GB2Charge" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on036"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off036"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="GB2ChargeRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ul2" id="ul2shoot">
										<td>U/L</td><td>収納受渡し</td><td>G/BｼｭｰﾄからのL/Fﾁｬｯｷﾝｸﾞ</td><td>L/F変形無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="UL2Shoot" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="UL2Shoot" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on037"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off037"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="UL2ShootRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ul2" id="ul2carrier">
										<td>U/L</td><td>収納受渡し</td><td>ｷｬﾘｱからのL/Fﾁｬｯｷﾝｸﾞ</td><td>L/F変形無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="UL2Carrier" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="UL2Carrier" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on038"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off038"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="UL2CarrierRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ul2" id="ul2chucking">
										<td>U/L</td><td>収納ﾁｬｯｸ幅</td><td>L/Fﾁｬｯｷﾝｸﾞ状態</td><td>L/F変形無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="UL2Chucking" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="UL2Chucking" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on039"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off039"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="UL2ChuckingRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ul2" id="ul2push">
										<td>U/L</td><td>収納ﾌﾟｯｼｬ</td><td>L/F収納ﾌﾟｯｼｬ状態</td><td>L/F変形無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="UL2Push" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="UL2Push" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on040"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off040"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="UL2PushRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ul2" id="ul2rail">
										<td>U/L</td><td>収納ﾚｰﾙ</td><td>ｱﾝﾛｰﾀﾞﾗｯｸｾｯﾄ状態確認</td><td>位置ｽﾞﾚ､ﾉｯｷﾝｸﾞ無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="UL2Rail" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="UL2Rail" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on041"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off041"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="UL2RailRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ul2" id="ul2rack">
										<td>U/L</td><td>ﾗｯｸ収納状態</td><td>ﾗｯｸへのL/F収納状態</td><td>ﾗｯｸ･ﾗｯｸｶﾞｲﾄﾞとの引っかかり無き事</td><td>５回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="UL2Rack" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="UL2Rack" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on042"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off042"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="UL2RackRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ar2" id="ar2tb">
										<td rowspan=5>異常検出</td><td>TB長さ検出</td><td>TB検出ｽﾄﾛｰｸ確認</td><td>検出ﾐｽ無き事</td><td>1回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="AR2TB" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="AR2TB" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on043"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off043"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="AR2TBRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ar2" id="ar2way">
										<td rowspan=3>整列L/F検出</td><td>方向逆</td><td>ｱﾗｰﾑ発生する事</td><td>1回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="AR2Way" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="AR2Way" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on044"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off044"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="AR2WayRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ar2" id="ar2side">
										<td>表裏逆</td><td>ｱﾗｰﾑ発生する事</td><td>1回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="AR2Side" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="AR2Side" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on045"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off045"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="AR2SideRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ar2" id="ar2less">
										<td>L/F無し</td><td>ｱﾗｰﾑ発生する事</td><td>1回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="AR2Less" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="AR2Less" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on046"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off046"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="AR2LessRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ar2" id="ar2double">
										<td>金型L/F2枚重ね</td><td>L/F2枚重ね型締め確認</td><td>ｱﾗｰﾑ発生する事</td><td>1回</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="AR2Double" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="AR2Double" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on047"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off047"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="AR2DoubleRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="ac2" id="ac2auto">
										<td>動作</td><td>自動ｻｲｸﾙ動作</td><td>自動ｻｲｸﾙでﾀﾞﾐｰﾗﾝﾆﾝｸﾞ確認</td><td>ﾄﾗﾌﾞﾙ無き事</td><td>30shot</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="AC2Auto" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="AC2Auto" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on048"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off048"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="AC2AutoRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="qu2" id="qu2pkg">
										<td rowspan=3>品質</td><td rowspan=3>品質確認</td><td>ﾊﾟｯｹｰｼﾞ外観</td><td>外観不良無き事</td><td>1shot</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="QU2Pkg" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="QU2Pkg" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on049"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off049"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="QU2PkgRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="qu2" id="qu2gate">
										<td>ｹﾞｰﾄ残り</td><td>ｹﾞｰﾄ残り発生無き事</td><td>1shot</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="QU2Gate" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="QU2Gate" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on050"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off050"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="QU2GateRs"/>
											</jsp:include>
										</td>
									</tr>
									<tr class="qu2" id="qu2xray">
										<td>X線ﾁｪｯｸ</td><td>ﾜｲﾔ変形･ｼｮｰﾄ･気泡無き事</td><td>1shot</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="QU2Xray" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="QU2Xray" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on051"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off051"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="QU2XrayRs"/>
											</jsp:include>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<jsp:include page="/include/include_inputtextex_required.jsp">
									<jsp:param name="btn"	 value="Check" />
									<jsp:param name="disp"	 value="チェック担当者名" />
									<jsp:param name="txt"	 value="Check" />
									<jsp:param name="width"	 value="100"/>
								</jsp:include>
							</td>
						</tr>
						<tr>
							<td>
								<div>上記結果により、本装置の稼働を</div>
								<jsp:include page="/include/include_trueorfalsewitch.jsp">
									<jsp:param name="on"	 value="KA"/>
									<jsp:param name="valon"	 value="可"/>
									<jsp:param name="off"	 value="FUKA"/>
									<jsp:param name="valoff" value="不可"/>
									<jsp:param name="select" value="Running"/>
								</jsp:include>
								<div>とする。</div>
							</td>
						</tr>
						<tr>
							<td><b>3.品質確認結果</b></td>
						</tr>

						<tr>
							<td>
								<table border="1">
									<tr>
										<td>ロット数</td><td>製品名</td><td>ロットNo.</td><td>確認者</td><td>結果</td><td>不良内容</td><td>判定</td>
									</tr>
									<tr>
										<td>1ロット目</td>
										<td>
											<div class="boxContainer">
												<div><input type="text" name="Product01" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
											</div>
										</td>
										<td>
											<jsp:include page="/include/include_inputtextex_required.jsp">
												<jsp:param name="btn"	 value="Lot01" />
												<jsp:param name="disp"	 value="クリア" />
												<jsp:param name="txt"	 value="Lot01" />
												<jsp:param name="width"	 value="100"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_inputtextex_required.jsp">
												<jsp:param name="btn"	 value="Checker01" />
												<jsp:param name="disp"	 value="クリア" />
												<jsp:param name="txt"	 value="Checker01" />
												<jsp:param name="width"	 value="100"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="Result01" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="Result01" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_selectionbox_required.jsp">
												<jsp:param name="btn_id"	 value="Fail01"/>
												<jsp:param name="btn_text"	 value="不良内容"/>
												<jsp:param name="txt_id"	 value="Fail01"/>
												<jsp:param name="select_txt" value="F001|F002|F003|F004|F005|F006|F007|F008|F009|F010|F011|F012|F013|F014|F015|F016|F017|F018"/>
												<jsp:param name="width"	 	 value="100"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on41"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off41"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="Lot01Rs"/>
											</jsp:include>
										</td>
									</tr>
									<tr>
										<td>3ロット目</td>
										<td>
											<div class="boxContainer">
												<div><input type="text" name="Product03" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
											</div>
										</td>
										<td>
											<jsp:include page="/include/include_inputtextex_required.jsp">
												<jsp:param name="btn"	 value="Lot03" />
												<jsp:param name="disp"	 value="クリア" />
												<jsp:param name="txt"	 value="Lot03" />
												<jsp:param name="width"	 value="100"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_inputtextex_required.jsp">
												<jsp:param name="btn"	 value="Checker03" />
												<jsp:param name="disp"	 value="クリア" />
												<jsp:param name="txt"	 value="Checker03" />
												<jsp:param name="width"	 value="100"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="Result03" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="Result03" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_selectionbox_required.jsp">
												<jsp:param name="btn_id"	 value="Fail03"/>
												<jsp:param name="btn_text"	 value="不良内容"/>
												<jsp:param name="txt_id"	 value="Fail03"/>
												<jsp:param name="select_txt" value="F001|F002|F003|F004|F005|F006|F007|F008|F009|F010|F011|F012|F013|F014|F015|F016|F017|F018"/>
												<jsp:param name="width"	 	 value="100"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on43"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off43"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="Lot03Rs"/>
											</jsp:include>
										</td>
									</tr>
									<tr>
										<td>5ロット目</td>
										<td>
											<div class="boxContainer">
												<div><input type="text" name="Product05" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:15px 10px 10px 0px; background-color:#FFFFFF"></div>
											</div>
										</td>
										<td>
											<jsp:include page="/include/include_inputtextex_required.jsp">
												<jsp:param name="btn"	 value="Lot05" />
												<jsp:param name="disp"	 value="クリア" />
												<jsp:param name="txt"	 value="Lot05" />
												<jsp:param name="width"	 value="100"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_inputtextex_required.jsp">
												<jsp:param name="btn"	 value="Checker05" />
												<jsp:param name="disp"	 value="クリア" />
												<jsp:param name="txt"	 value="Checker05" />
												<jsp:param name="width"	 value="100"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_tenkey_required.jsp">
												<jsp:param name="btn_id"	value="Result05" />
												<jsp:param name="btn_text"	value="テンキー" />
												<jsp:param name="txt_id"	value="Result05" />
												<jsp:param name="width"		value="50"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_selectionbox_required.jsp">
												<jsp:param name="btn_id"	 value="Fail05"/>
												<jsp:param name="btn_text"	 value="不良内容"/>
												<jsp:param name="txt_id"	 value="Fail05"/>
												<jsp:param name="select_txt" value="F001|F002|F003|F004|F005|F006|F007|F008|F009|F010|F011|F012|F013|F014|F015|F016|F017|F018"/>
												<jsp:param name="width"	 	 value="100"/>
											</jsp:include>
										</td>
										<td>
											<jsp:include page="/include/include_trueorfalsewitch.jsp">
												<jsp:param name="on"	 value="on45"/>
												<jsp:param name="valon"	 value="○"/>
												<jsp:param name="off"	 value="off45"/>
												<jsp:param name="valoff" value="×"/>
												<jsp:param name="select" value="Lot05Rs"/>
											</jsp:include>
										</td>
									</tr>
								</table>
								<p>※１　※１ロット目は全数、３，５ロット目は１／２ロット確認の事</p>
							</td>
						</tr>
						<tr>
							<td><b>4.総合判定</b></td>
						</tr>
						<tr>
							<td>
								<jsp:include page="/include/include_trueorfalsewitch.jsp">
									<jsp:param name="on"	 value="GO"/>
									<jsp:param name="valon"	 value="合格"/>
									<jsp:param name="off"	 value="FUGO"/>
									<jsp:param name="valoff" value="不合格"/>
									<jsp:param name="select" value="Total"/>
								</jsp:include>
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

				/* 一時保存処理 */
				$('#tmpSubmitBtn')[0].addEventListener('click', function(){TmpSubmitHandler()}, false);
				/* バリデーション処理 */
				$('#submitBtn')[0].addEventListener('click', function(){ValidationHandler()}, false);
				/* バーコード読取り時に反応するイベントリスナー */
				$('#Setubi')[0].addEventListener('keypress', function(e){
					var promise=BarcodeHandler(e, 'Series', 'Setubi', functionkbn.getSeries);
					promise.done(function(){
//						TableReset();
						SeriesHandler();
					});
					promise.fail(function() {
//						TableReset();
					});
				}, false);

				$('#PKG')	    [0].addEventListener('keypress', function(e){BarcodeHandler(e, 'PKG',	 	functionkbn.nothing)},		 false);
				$('#TSAfter')   [0].addEventListener('keypress', function(e){BarcodeHandler(e, 'TSAfter',	functionkbn.nothing)},		 false);
				$('#Check')	    [0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Check',		functionkbn.nothing)},		 false);
				$('#Checker01') [0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Checker01', functionkbn.nothing)},		 false);
				$('#Checker03') [0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Checker03', functionkbn.nothing)},		 false);
				$('#Checker05') [0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Checker05', functionkbn.nothing)},		 false);
				$('#Lot01')	    [0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Lot01',		functionkbn.getItemName)},	 false);
				$('#Lot03')	    [0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Lot03',		functionkbn.getItemName)},	 false);
				$('#Lot05')	    [0].addEventListener('keypress', function(e){BarcodeHandler(e, 'Lot05', 	functionkbn.getItemName)},	 false);
				$('#Setubi')	[0].addEventListener('keypress', function(e){DateHandler(datekbn.datetime)}, false);
				$('#PKG')	    [0].addEventListener('keypress', function(e){DateHandler(datekbn.datetime)}, false);

				/* フォーカスロスト時に反応するイベントリスナー */
				$('#Setubi')[0].addEventListener('focusout', function(e){
					var promise=FocuslostHandler(e, 'Series', 'Setubi', functionkbn.getSeries);
					promise.done(function(){
//						TableReset();
//						SeriesHandler();
					});
					promise.fail(function() {
						$('#Series').val(null);
						setCookie('Series', null);
//						TableReset();
					});
				}, false);

				$('#PKG')		[0].addEventListener('focusout', function(e){BarcodeHandler(e, 'PKG',		functionkbn.nothing)},		false);
				$('#Checker01') [0].addEventListener('focusout', function(e){BarcodeHandler(e, 'Checker01', functionkbn.nothing)},	 	false);
				$('#Checker03') [0].addEventListener('focusout', function(e){BarcodeHandler(e, 'Checker03', functionkbn.nothing)},	 	false);
				$('#Checker05') [0].addEventListener('focusout', function(e){BarcodeHandler(e, 'Checker05', functionkbn.nothing)},	 	false);
				$('#TSAfter')	[0].addEventListener('focusout', function(e){BarcodeHandler(e, 'TSAfter',	functionkbn.nothing)},		false);
				$('#Check')	 	[0].addEventListener('focusout', function(e){BarcodeHandler(e, 'Check', 	functionkbn.nothing)},		false);
				$('#Lot01')	    [0].addEventListener('focusout', function(e){BarcodeHandler(e, 'Lot01',		functionkbn.getItemName)},	false);
				$('#Lot03')	    [0].addEventListener('focusout', function(e){BarcodeHandler(e, 'Lot03',		functionkbn.getItemName)},	false);
				$('#Lot05')	    [0].addEventListener('focusout', function(e){BarcodeHandler(e, 'Lot05',		functionkbn.getItemName)},	false);
				$('#Setubi')    [0].addEventListener('focusout', function(e){DateHandler(datekbn.datetime)}, false);
				$('#PKG')		[0].addEventListener('focusout', function(e){DateHandler(datekbn.datetime)}, false);


//				$('#Check')[0].addEventListener('focusout', function(){PassCheck()}, false);
				/*  */
				$('input[name="CList"]').change(function(e) {CheckboxHandler('CList')});




				TableReset();
/*
				$('#select1') [0].addEventListener('change', function(){CheckboxHandler('select1') }, false);
				$('#select2') [0].addEventListener('change', function(){CheckboxHandler('select2') }, false);
				$('#select3') [0].addEventListener('change', function(){CheckboxHandler('select3') }, false);
				$('#select4') [0].addEventListener('change', function(){CheckboxHandler('select4') }, false);
				$('#select5') [0].addEventListener('change', function(){CheckboxHandler('select5') }, false);
				$('#select6') [0].addEventListener('change', function(){CheckboxHandler('select6') }, false);
				$('#select7') [0].addEventListener('change', function(){CheckboxHandler('select7') }, false);
				$('#select8') [0].addEventListener('change', function(){CheckboxHandler('select8') }, false);
				$('#select9') [0].addEventListener('change', function(){CheckboxHandler('select9') }, false);
				$('#select10')[0].addEventListener('change', function(){CheckboxHandler('select10')}, false);
				$('#select11')[0].addEventListener('change', function(){CheckboxHandler('select11')}, false);
				$('#select12')[0].addEventListener('change', function(){CheckboxHandler('select12')}, false);
				$('#select13')[0].addEventListener('change', function(){CheckboxHandler('select13')}, false);
				$('#Check')   [0].addEventListener('change', function(){PassCheck()}, false);
				$('#Running') [0].addEventListener('change', function(){PassCheck()}, false);
				$('#Lot01')   [0].addEventListener('change', function(){PassCheck()}, false);
				$('#Lot03')   [0].addEventListener('change', function(){PassCheck()}, false);
				$('#Lot05')   [0].addEventListener('change', function(){PassCheck()}, false);
				$('#Lot01Rs') [0].addEventListener('change', function(){PassCheck()}, false);
				$('#Lot03Rs') [0].addEventListener('change', function(){PassCheck()}, false);
				$('#Lot05Rs') [0].addEventListener('change', function(){PassCheck()}, false);

				$('.Tekiyo').hide();
				$("#select8").prop("disabled", true);
				$(":input[name^='Total']").prop('disabled',true);
				$('#table1').hide();
				$('#table2').hide();
				$('#clist1,#clist2').hide();
				$('#title1,#ldlf,#ldrailh,#ldrailw,#ldloarder,#flrailw,#flbelt,#flact,#fiagpos,#figopos,#fiset,#fiads,#ficollet,#tcshoot,#tcchuck,#tlsubpot,#tlstuffing,#prplunger,#preject,#clcl1,#clcl2,#fopos,#fostate,#gbboard,#gbpress,#ulpos,#ulset,#artb,#arway,#arside,#arless,#armold,#acauto,#qupkg,#qugate,#quxray').hide();
				$('#title2,#ld2move,#ld2lifter,#ld2keep,#ld2level,#fl2railtrans,#fl2railstate,#fl2belt,#fl2send,#fl2gripper,#fl2shiftrail,#fl2shiftstate,#fl2weight,#fi2chuking,#fi2space,#fi2ads,#fi2set,#fi2drop,#fi2tb,#tc2feeder,#tc2cut,#tc2stocker,#tc2holder,#tc2shifter,#tc2shoot,#tc2ins,#pr2plunger,#pr2eject,#cl2cl,#fo2gold,#fo2chuking,#fo2recive,#gb2runner,#gb2push,#gb2rise,#gb2speed,#gb2charge,#ul2shoot,#ul2carrier,#ul2chucking,#ul2push,#ul2rail,#ul2rack,#ar2tb,#ar2way,#ar2side,#ar2less,#ar2double,#ac2auto,#qu2pkg,#qu2gate,#qu2xray').hide();
 */

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
			const PF100 =['clist1','clist2','table1','artb','arway','arside','arless','armold','acauto','qupkg','qugate','quxray'];
			const F500  =['clist1','clist2','table2','ar2tb','ar2way','ar2side','ar2less','ar2double','ac2auto','qu2pkg','qu2gate','qu2xray'];
			const FX    =['clist1','clist2','table2','ar2tb','ar2way','ar2side','ar2less','ar2double','ac2auto','qu2pkg','qu2gate','qu2xray'];
			const FS    =['clist1','clist2','table2','ar2tb','ar2way','ar2side','ar2less','ar2double','ac2auto','qu2pkg','qu2gate','qu2xray'];
			const GLINE =['clist1','clist2','table2','ar2tb','ar2way','ar2side','ar2less','ar2double','ac2auto','qu2pkg','qu2gate','qu2xray'];
			const YPC   =['clist1','clist2','table2','ar2tb','ar2way','ar2side','ar2less','ar2double','ac2auto','qu2pkg','qu2gate','qu2xray'];
			const YPM   =['clist1','clist2','table2','ar2tb','ar2way','ar2side','ar2less','ar2double','ac2auto','qu2pkg','qu2gate','qu2xray'];
			const YPS   =['clist1','clist2','table2','ar2tb','ar2way','ar2side','ar2less','ar2double','ac2auto','qu2pkg','qu2gate','qu2xray'];
			var SeriesHandler = function() {
				$('#clist1,#clist2').show();
				var val = $('#Series').val();
//				if (val==='100PF')		 {$.each(PF100, function(i, val){SelectorControl(val, true)});}
//				else if (val==='500F')	 {$.each(F500,  function(i, val){SelectorControl(val, true)});}
//				else if (val==='FX')	 {$.each(FX,    function(i, val){SelectorControl(val, true)});}
//				else if (val==='FS')	 {$.each(FS,    function(i, val){SelectorControl(val, true)});}
//				else if (val==='G-LINE') {$.each(GLINE, function(i, val){SelectorControl(val, true)});}
//				else if (val==='Y-PC')	 {$.each(YPC,   function(i, val){SelectorControl(val, true)});}
//				else if (val==='YPM')	 {$.each(YPM,   function(i, val){SelectorControl(val, true)});}
//				else if (val==='YPS')	 {$.each(YPS,   function(i, val){SelectorControl(val, true)});}
			}

			var TableReset = function() {
				$('#clist1,#clist2').hide();
				$.each(PF100, function(i, val){SelectorControl(val, false)});
				$.each(F500,  function(i, val){SelectorControl(val, false)});
				$.each(FX,    function(i, val){SelectorControl(val, false)});
				$.each(FS,    function(i, val){SelectorControl(val, false)});
				$.each(GLINE, function(i, val){SelectorControl(val, false)});
				$.each(YPC,   function(i, val){SelectorControl(val, false)});
				$.each(YPM,   function(i, val){SelectorControl(val, false)});
				$.each(YPS,   function(i, val){SelectorControl(val, false)});
			}


		</script>


		<script type="text/javascript">
			 var CheckboxHandler = function(name) {
				$('[name='+name+']:checked').each(function() {
					alert($(this).val());
				});
			}
		</script>

		<script type="text/javascript">
//
/*
			}
*/
		</script>

		<script type="text/javascript">


/*
				for (var i=4; i<=13; i++) $("#select" + i).prop("checked", false);
				$("#select8").prop("disabled", true);
				$('#table1').hide();
				$('#table2').hide();
				$('#clist1,#clist2').hide();
				$('#title1,#ldlf,#ldrailh,#ldrailw,#ldloarder,#flrailw,#flbelt,#flact,#fiagpos,#figopos,#fiset,#fiads,#ficollet,#tcshoot,#tcchuck,#tlsubpot,#tlstuffing,#prplunger,#preject,#clcl1,#clcl2,#fopos,#fostate,#gbboard,#gbpress,#ulpos,#ulset,#artb,#arway,#arside,#arless,#armold,#acauto,#qupkg,#qugate,#quxray').hide();
				$('#title1,#ldlf,#ldrailh,#ldrailw,#ldloarder,#flrailw,#flbelt,#flact,#fiagpos,#figopos,#fiset,#fiads,#ficollet,#tcshoot,#tcchuck,#tlsubpot,#tlstuffing,#prplunger,#preject,#clcl1,#clcl2,#fopos,#fostate,#gbboard,#gbpress,#ulpos,#ulset,#artb,#arway,#arside,#arless,#armold,#acauto,#qupkg,#qugate,#quxray').prop('disabled',true);
				$('#title2,#ld2move,#ld2lifter,#ld2keep,#ld2level,#fl2railtrans,#fl2railstate,#fl2belt,#fl2send,#fl2gripper,#fl2shiftrail,#fl2shiftstate,#fl2weight,#fi2chuking,#fi2space,#fi2ads,#fi2set,#fi2drop,#fi2tb,#tc2feeder,#tc2cut,#tc2stocker,#tc2holder,#tc2shifter,#tc2shoot,#tc2ins,#pr2plunger,#pr2eject,#cl2cl,#fo2gold,#fo2chuking,#fo2recive,#gb2runner,#gb2push,#gb2rise,#gb2speed,#gb2charge,#ul2shoot,#ul2carrier,#ul2chucking,#ul2push,#ul2rail,#ul2rack,#ar2tb,#ar2way,#ar2side,#ar2less,#ar2double,#ac2auto,#qu2pkg,#qu2gate,#qu2xray').hide();
				$('#title2,#ld2move,#ld2lifter,#ld2keep,#ld2level,#fl2railtrans,#fl2railstate,#fl2belt,#fl2send,#fl2gripper,#fl2shiftrail,#fl2shiftstate,#fl2weight,#fi2chuking,#fi2space,#fi2ads,#fi2set,#fi2drop,#fi2tb,#tc2feeder,#tc2cut,#tc2stocker,#tc2holder,#tc2shifter,#tc2shoot,#tc2ins,#pr2plunger,#pr2eject,#cl2cl,#fo2gold,#fo2chuking,#fo2recive,#gb2runner,#gb2push,#gb2rise,#gb2speed,#gb2charge,#ul2shoot,#ul2carrier,#ul2chucking,#ul2push,#ul2rail,#ul2rack,#ar2tb,#ar2way,#ar2side,#ar2less,#ar2double,#ac2auto,#qu2pkg,#qu2gate,#qu2xray').prop('disabled',true);

*/
			}
		</script>

		<script type="text/javascript">
			/* 一時保存処理 */
			var TmpSubmitHandler = function() {
				var sheetnm='品種切替評価チェックシート'
				fncTmpSubmit($('#Setubi').val(), sheetnm, getSerializableData(document.getElementById("fm")), "<%=tanname%>", savekbn.TmpSaved);
			}
		</script>

		<script type="text/javascript">
/*
		var PassCheck = function() {
			var val1 = $('#Lot01').val();
			var val2 = $('#Lot02').val();
			var val3 = $('#Lot03').val();

			if($('Check').val() <> '' && $('#Running').prop('checked')){
				if(val1 <> ''){
					if(val2==='' && val3===''){
						if($("#Lot01Rs").prop('checked')){
							$(":input[name^='Total']").prop('disabled',false);
						}
					}else if(val2==='' && val3 <> ''){
						if($("#Lot01Rs").prop('checked') && $("#Lot05Rs").prop('checked')){
							$(":input[name^='Total']").prop('disabled',false);
						}
					}else if(val2 <>'' && val3===''){
						if($("#Lot01Rs").prop('checked') && $("#Lot03Rs").prop('checked')){
							$(":input[name^='Total']").prop('disabled',false);
						}
					}else if(val2 <>'' && val3 <>''){
						if($("#Lot01Rs").prop('checked') && $("#Lot03Rs").prop('checked') && $("#Lot05Rs").prop('checked')){
							$(":input[name^='Total']").prop('disabled',false);
						}
					}else{
						$(":input[name^='Total']").prop('disabled',true);
						$(":input[name^='Total']").prop('checked',false);
					}
				}else if(val1===''){
					if(val2==='' && val3 <> ''){
						if($("#Lot05Rs").prop('checked')){
							$(":input[name^='Total']").prop('disabled',false);
						}
					}else if(val2 <>'' && val3===''){
						if($("#Lot03Rs").prop('checked')){
							$(":input[name^='Total']").prop('disabled',false);
						}
					}else if(val2 <>'' && val3 <>''){
						if($("#Lot03Rs").prop('checked') && $("#Lot05Rs").prop('checked')){
							$(":input[name^='Total']").prop('disabled',false);
						}
					}else{
						$(":input[name^='Total']").prop('disabled',false);
						$(":input[name^='Total']").prop('checked',false);
					}
				}
			}
		}
*/
	</script>

		<script type="text/javascript">
/*
			var val = $('#Series').val();

			if(id==='select1' && $("#select1").prop('checked')){
				$('#tspkg').prop('disabled',false);
				$('#tspkg').show();
			}else if(id==='select1' && $("#select1").prop('checked',false)){
				$('#tspkg').prop('disabled',true);
				$('#tspkg').hide();
			}
			if(id==='select2' && $("#select2").prop('checked')){
				$('#unitout').prop('disabled',false);
				$('#unitout').show();
			}else if(id==='select2' && $("#select2").prop('checked',false)){
				$('#unitout').prop('disabled',true);
				$('#unitout').hide();
			}
			if(id==='select3' && $("#select3").prop('checked')){
				$('#other').prop('disabled',false);
				$('#other').show();
			}else if(id==='select3' && $("#select3").prop('checked',false)){
				$('#other').hide();
				$('#other').prop('disabled',true);
			}


			if($("#table1").is(':visible')){
				if(id==='select4' && $("#select4").prop('checked')){
					$('.ld1').prop('disabled',false);
					$('.ld1').show();
				}else if(id==='select4' && $("#select4").prop('checked',false)){
					$('.ld1').prop('disabled',true);
					$('.ld1').hide();
				}
			}else if($("#table2").is(':visible')){
				if(id==='select4' && $("#select4").prop('checked')){
					$('.ld2').prop('disabled',false);
					$('.ld2').show();
				}else if(id==='select4' && $("#select4").prop('checked',false)){
					$('.ld2').prop('disabled',true);
					$('.ld2').hide();
				}
			}

			if($("#table1").is(':visible')){
				if(id==='select5' && $("#select5").prop('checked')){
					$('.fl1').prop('disabled',false);
					$('.fl1').show();
				}else if(id==='select5' && $("#select5").prop('checked',false)){
					$('.fl1').prop('disabled',true);
					$('.fl1').hide();
				}
			}else if($("#table2").is(':visible')){
				if(id==='select5' && $("#select5").prop('checked')){
					$('#fl2railtrans,#fl2railstate,#fl2belt,#fl2send').prop('disabled',false);
					$('#fl2railtrans,#fl2railstate,#fl2belt,#fl2send').show();
				}else if(id==='select5' && $("#select5").prop('checked') && val==='YPM'){
					$('#fl2gripper,#fl2shiftrail,#fl2shiftstate,#fl2weight').prop('disabled',false);
					$('#fl2gripper,#fl2shiftrail,#fl2shiftstate,#fl2weight').show();
				}else if(id==='select5' && $("#select5").prop('checked',false)){
					$('.fl2').prop('disabled',true);
					$('.fl2').hide();
				}
			}

			if($("#table1").is(':visible')){
				if(id==='select6' && $("#select6").prop('checked')){
					$('.fi1').prop('disabled',false);
					$('.fi1').show();
				}else if(id==='select6' && $("#select6").prop('checked',false)){
					$('.fi1').prop('disabled',true);
					$('.fi1').hide();
				}
			}else if($("#table2").is(':visible')){
				if(id==='select6' && $("#select6").prop('checked')){
					$('#fi2chuking,#fi2space,#fi2set,#fi2drop,#fi2tb').prop('disabled',false);
					$('#fi2chuking,#fi2space,#fi2set,#fi2drop,#fi2tb').show();
				}else if(id==='select6' && $("#select6").prop('checked') && (val==='FX' || val==='FS' || val==='GLINE')){
					$('.fi2').prop('disabled',false);
					$('.fi2').show();
				}else if(id==='select6' && $("#select6").prop('checked',false)){
					$('.fi2').prop('disabled',true);
					$('.fi2').hide();
				}
			}

			if($("#table1").is(':visible')){
				if(id==='select7' && $("#select7").prop('checked')){
					$('.tc1').prop('disabled',false);
					$('.tc1').show();
				}else if(id==='select7' && $("#select7").prop('checked',false)){
					$('.tc1').prop('disabled',true);
					$('.tc1').hide();
				}
			}else if($("#table2").is(':visible')){
				if(id==='select7' && $("#select7").prop('checked')){
					$('#tc2feeder,#tc2cut,#tc2stocker,#tc2holder,#tc2ins').prop('disabled',false);
					$('#tc2feeder,#tc2cut,#tc2stocker,#tc2holder,#tc2ins').show();
				}else if(id==='select7' && $("#select7").prop('checked') && val==='YPM'){
					$('#tc2feeder,#tc2cut,#tc2stocker,#tc2shifter,#tc2shoot,#tc2ins').prop('disabled',false);
					$('#tc2feeder,#tc2cut,#tc2stocker,#tc2shifter,#tc2shoot,#tc2ins').show();
				}else if(id==='select7' && $("#select7").prop('checked',false)){
					$('.tc2').prop('disabled',true);
					$('.tc2').hide();
				}
			}

			if($("#table1").is(':visible')){
				if(id==='select8' && $("#select8").prop('checked')){
					$('.tl1').prop('disabled',false);
					$('.tl1').show();
				}else if(id==='select8' && $("#select8").prop('checked',false)){
					$('.tl1').prop('disabled',true);
					$('.tl1').hide();
				}
			}

			if($("#table1").is(':visible')){
				if(id==='select9' && $("#select9").prop('checked')){
					$('.pr1').prop('disabled',false);
					$('.pr1').show();
				}else if(id==='select9' && $("#select9").prop('checked',false)){
					$('.pr1').prop('disabled',true);
					$('.pr1').hide();
				}
			}else if($("#table2").is(':visible')){
				if(id==='select9' && $("#select9").prop('checked')){
					$('.pr2').prop('disabled',false);
					$('.pr2').show();
				}else if(id==='select9' && $("#select9").prop('checked',false)){
					$('.pr2').prop('disabled',true);
					$('.pr2').hide();
				}
			}

			if($("#table1").is(':visible')){
				if(id==='select10' && $("#select10").prop('checked')){
					$('.cl1').prop('disabled',false);
					$('.cl1').show();
				}else if(id==='select10' && $("#select10").prop('checked',false)){
					$('.cl1').prop('disabled',true);
					$('.cl1').hide();
				}
			}else if($("#table2").is(':visible')){
				if(id==='select10' && $("#select10").prop('checked')){
					$('.cl2').prop('disabled',false);
					$('.cl2').show();
				}else if(id==='select10' && $("#select10").prop('checked',false)){
					$('.cl2').prop('disabled',true);
					$('.cl2').hide();
				}
			}

			if($("#table1").is(':visible')){
				if(id==='select11' && $("#select11").prop('checked')){
					$('.fo1').prop('disabled',false);
					$('.fo1').show();
				}else if(id==='select11' && $("#select11").prop('checked',false)){
					$('.fo1').prop('disabled',true);
					$('.fo1').hide();
				}
			}else if($("#table2").is(':visible')){
				if(id==='select11' && $("#select11").prop('checked')){
					$('.fo2').prop('disabled',false);
					$('.fo2').show();
				}else if(id==='select11' && $("#select11").prop('checked',false)){
					$('.fo2').prop('disabled',true);
					$('.fo2').hide();
				}
			}

			if($("#table1").is(':visible')){
				if(id==='select12' && $("#select12").prop('checked' )){
					$('.gb1').prop('disabled',false);
					$('.gb1').show();
				}else if(id==='select12' && $("#select12").prop('checked',false)){
					$('.gb1').prop('disabled',true);
					$('.gb1').hide();
				}
			}else if($("#table2").is(':visible')){
				if(id==='select12' && $("#select12").prop('checked')){
					$('#gb2runner,#gb2push,#gb2rise,#gb2charge').prop('disabled',false);
					$('#gb2runner,#gb2push,#gb2rise,#gb2charge').show();
				}else if(id==='select12' && $("#select12").prop('checked') && val==='YPM'){
					$('#gb2runner,#gb2push,#gb2speed,#gb2charge').prop('disabled',false);
					$('#gb2runner,#gb2push,#gb2speed,#gb2charge').show();
				}else if(id==='select12' && $("#select12").prop('checked',false)){
					$('.gb2').prop('disabled',true);
					$('.gb2').hide();
				}
			}

			if($("#table1").is(':visible')){
				if(id==='select13' && $("#select13").prop('checked' )){
					$('.ul1').prop('disabled',false);
					$('.ul1').show();
				}else if(id==='select13' && $("#select13").prop('checked',false)){
					$('.ul1').prop('disabled',true);
					$('.ul1').hide();
				}
			}else if($("#table2").is(':visible')){
				if(id==='select13' && $("#select13").prop('checked')){
					$('#ul2shoot,#ul2chucking,#ul2rack').prop('disabled',false);
					$('#ul2shoot,#ul2chucking,#ul2rack').show();
				}else if(id==='select13' && $("#select13").prop('checked') && val==='YPM'){
					$('#ul2carrier,#ul2chucking,#ul2push,#ul2rail,#ul2rack').prop('disabled',false);
					$('#ul2carrier,#ul2chucking,#ul2push,#ul2rail,#ul2rack').show();
				}else if(id==='select13' && $("#select13").prop('checked',false)){
					$('.ul2').prop('disabled',true);
					$('.ul2').hide();
				}
			}
		}
 */
		</script>


		<script type="text/javascript">
			/* 保存前のバリデーション処理を行う */
			var ValidationHandler = function() {
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

	</body>

	<!-- cssフレームワーク  -->
	<jsp:include page="/include/include_bootstrap.jsp"/>
</html>