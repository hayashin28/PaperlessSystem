<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<div class="boxContainer">

		<div class="boxContainer" style="margin:5px 0px 0px 0px">

		<div><span class="btn btn-primary btn-lg">エラー発生日</span></div>
		<div><input type="text" id="errorDate" name="errorDate" class="input RoundedCorners ShadowInsetTop" disabled="disabled" style="width:100px; background-color:#FFFFFF"></div>
		</div>
		<jsp:include page="/include/include_inputtextex_required.jsp">
			<jsp:param name="btn"	 value="wlot" />
			<jsp:param name="disp"	 value="ウエハロットNo." />
			<jsp:param name="txt"	 value="wlot" />
			<jsp:param name="width"	 value="100"/>
		</jsp:include>
	</div>
</html>



