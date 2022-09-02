<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
	String t      = "btn_" + request.getParameter("on");
	String valon  = 		 request.getParameter("valon");
	String f	  = "btn_" + request.getParameter("off");
	String valoff = 		 request.getParameter("valoff");
	String select = 		 request.getParameter("select");
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

	<div class="btn_group_80 label">
		<input type="radio" name="<%=select%>" id="<%=t%>" value="<%=valon%>" >
		<label for="<%=t%>" class="switch-on"><%=valon%></label>
		<input type="radio" name="<%=select%>" id="<%=f%>" value="<%=valoff%>"  checked>
		<label for="<%=f%>" class="switch-off"><%=valoff%></label>
	</div>
	<input type="hidden" id="<%=select%>" value="">
</html>
