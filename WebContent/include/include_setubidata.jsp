<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<div class="boxContainer">
		<div>
			<jsp:include page="/include/include_inputtextex_required.jsp">
				<jsp:param name="btn"	 value="setubi" />
				<jsp:param name="disp"	 value="装置No." />
				<jsp:param name="txt"	 value="Setubi" />
				<jsp:param name="width"	 value="100"/>
			</jsp:include>
		</div>
		<div class="right"><jsp:include page="/include/include_button.jsp"/></div>
	</div>
</html>