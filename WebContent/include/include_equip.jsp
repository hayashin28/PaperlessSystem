<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<div class="boxContainer">
		<div><span class="btn btn-primary btn-lg" style="width:100px; margin:8px 0px 0px 0px;">装置名</span></div>
		<div><input type="text" id="Series" class="input RoundedCorners ShadowInsetTop" readonly="readOnly" style="width:150px; margin:10px 10px 10px 0px; background-color:#FFFFFF"></div>
		<div>
			<jsp:include page="/include/include_inputtextex_required.jsp">
				<jsp:param name="btn"	 value="Setubi" />
				<jsp:param name="disp"	 value="装置ID." />
				<jsp:param name="txt"	 value="Setubi" />
				<jsp:param name="width"	 value="100"/>
			</jsp:include>
		</div>
	</div>
</html>
