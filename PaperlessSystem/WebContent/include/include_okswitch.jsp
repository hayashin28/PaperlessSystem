<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
	String on	   = "btn_" + request.getParameter("on");
	String select  = request.getParameter("select");
%>

	<script type="text/javascript">
		/*
		 * ラジオボタンのチェックが変更されたタイミングで
		 * 呼び出されるイベントハンドラ―を登録
		 */
		$(function() {
			 $("[name='<%=select%>']").click(function() {
				 if($('input[name="<%=select%>"]').prop('checked')) {
					$("#"+"<%=select%>").val('');
				 } else {
					$("#"+"<%=select%>").val($("input[name='<%=select%>']:checked").val());
				 }
			 });
		});
	</script>


	<div class="btn_group_100 label">
		<input type="checkbox" name="<%=select%>" id="<%=on%>" value="○">
		<label for="<%=on%>" class="switch-on">○</label>
	</div>
	<input type="hidden" name="<%=select%>" id="<%=select%>" value="">
</html>
