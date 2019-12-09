<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<%
		String  btn	  = "btn_" + request.getParameter("btn");
		String  disp  = 		 request.getParameter("disp");
		String  txt	  = 		 request.getParameter("txt");
		Integer width = 200 * 	 Integer.parseInt(request.getParameter("width")) /100;
	%>

	<script type="text/javascript">
		$(function () {
			$("#" + "<%=btn%>").click(function() {
				$("#" + "<%=txt%>").val("");
				$("#" + "<%=txt%>").focus();
			});
		});
	</script>
	<div class="boxContainer">
		<div><button type="button" id="<%=btn%>" class="button large"><%=disp%></button></div>
		<div><input type="text" id="<%=txt%>" class="input RoundedCorners ShadowInsetTop validate[required]" style="width:<%=width%>px;"></div>
	</div>
</html>