<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
	String  btn_id   = "btn_" + request.getParameter("btn_id");
	String  btn_text = 			request.getParameter("btn_text");
	String  txt_id   = 			request.getParameter("txt_id");
	Integer width    = 200 * 	Integer.parseInt(request.getParameter("width")) /100;
%>

	<script type="text/javascript">
		$(function () {
			$("#" + "<%=btn_id%>").click(function() {
				$("#" + "<%=txt_id%>").val("");
				$("#" + "<%=txt_id%>").focus();
			});

			$("#" + "<%=btn_id%>").blur(function() {
				$("#" + "<%=txt_id%>").keypad({
					layout: ['789','456','123','0.-','/'+$.keypad.BACK+$.keypad.CLEAR+$.keypad.CLOSE],
					keypadOnly: false
				}).keypad('option', 'closeText', 'Enter');
			});
		});
	</script>

	<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
	<div class="boxContainer">
		<div><button type="button" id="<%=btn_id%>" class="button large" style="margin:0px 0px 0px 00px"><%=btn_text%></button></div>
		<div><input type="text" id="<%=txt_id%>" class="input RoundedCorners ShadowInsetTop" style="width:<%=width%>px; margin:0px 0px 0px 0px"></div>
	</div>
</html>