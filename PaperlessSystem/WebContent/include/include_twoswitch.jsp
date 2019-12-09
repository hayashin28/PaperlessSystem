<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
	String on      = "btn_" + request.getParameter("on");
	String valon   = 		  request.getParameter("valon");
	String off	   = "btn_" + request.getParameter("off");
	String valoff  = 		  request.getParameter("valoff");
	String select  = 		  request.getParameter("select");
%>

	<script type="text/javascript">
		/*
		 * ラジオボタンのチェックが変更されたタイミングで
		 * 呼び出されるイベントハンドラ―を登録
		 */
		$(function() {
			 $("[name='<%=select%>']").click(function() {
				 $("#"+"<%=select%>").val($("input[name='<%=select%>']:checked").val());
			 });
			 $("#"+"<%=select%>").val($("input[name='<%=select%>']:checked").val());
		});
	</script>

	<div class="btn_group_100 label">
		<input type="radio" name="<%=select%>" id="<%=on%>" value="<%=valon%>" >
		<label for="<%=on%>" class="switch-on"><%=valon%></label>
		<input type="radio" name="<%=select%>" id="<%=off%>" value="<%=valoff%>"  checked>
		<label for="<%=off%>" class="switch-off"><%=valoff%></label>
	</div>
	<input type="hidden" id="<%=select%>" value="">
</html>
