<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<div class="boxContainer">
		<div><span class="btn btn-primary btn-lg" style="width:100px; margin:8px 0px 0px 0px;">点検日</span></div>
		<div><input type="text" id="Date" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:100px; margin:10px 10px 10px 0px; background-color:#FFFFFF"></div>
		<div><span class="btn btn-primary btn-lg" style="width:100px; margin:8px 0px 0px 0px;">シフト</span></div>
		<div><input type="text" id="shift" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:80px; margin:10px 10px 10px 0px; background-color:#FFFFFF"></div>
		<div>
			<jsp:include page="/include/include_inputtextex_required.jsp">
				<jsp:param name="btn"	 value="wlot" />
				<jsp:param name="disp"	 value="拡散ロットNo." />
				<jsp:param name="txt"	 value="Wlot" />
				<jsp:param name="width"	 value="100"/>
			</jsp:include>
		</div>
		<div>
			<jsp:include page="/include/include_inputtextex_required.jsp">
				<jsp:param name="btn"	 value="worker" />
				<jsp:param name="disp"	 value="作業者" />
				<jsp:param name="txt"	 value="Worker" />
				<jsp:param name="width"	 value="100"/>
			</jsp:include>
		</div>
	</div>
</html>



