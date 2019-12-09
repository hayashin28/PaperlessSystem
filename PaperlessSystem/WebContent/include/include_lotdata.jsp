<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<div class="boxContainer">
		<div><span class="btn btn-primary btn-lg">年月</span></div>
		<div><input type="text" id="Date" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; background-color:#FFFFFF"></div>
		<div><span class="btn btn-primary btn-lg">シフト</span></div>
		<div><input type="text" id="shift" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:80px; background-color:#FFFFFF"></div>
		<div style="margin:-6px 0px 0px 0px">
			<jsp:include page="/include/include_inputtextex_required.jsp">
				<jsp:param name="btn"	 value="lot"/>
				<jsp:param name="disp"	 value="組立ロット"/>
				<jsp:param name="txt"	 value="Lot"/>
				<jsp:param name="width"	 value="100"/>
			</jsp:include>
		</div>
		<div style="margin:-6px 0px 0px 0px">
			<!-- 子ロット -->
			<jsp:include page="/include/include_inputtextex.jsp">
				<jsp:param name="btn"	 value="kolot"/>
				<jsp:param name="disp"	 value="ロット情報"/>
				<jsp:param name="txt"	 value="KoLot"/>
				<jsp:param name="width"	 value="100"/>
			</jsp:include>
		</div>
	</div>
</html>
