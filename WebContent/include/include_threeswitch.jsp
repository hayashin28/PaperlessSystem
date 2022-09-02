<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
	String switch1	= "btn_" + request.getParameter("switch1");
	String switch2	= "btn_" + request.getParameter("switch2");
	String off		= "btn_" + request.getParameter("off");
	String val1		= 		   request.getParameter("val1");
	String val2		= 		   request.getParameter("val2");
	String select	= 		   request.getParameter("select");
%>
	<script type="text/javascript">
		/*
		 * ラジオボタンのチェックが変更されたタイミングで
		 * 呼び出されるイベントハンドラ―を登録
		 */
		$(function() {
			 $("[name='btn_<%=select%>']").click(function() {
				 $("#"+"<%=select%>").val($("input[name='btn_<%=select%>']:checked").val());
			 });
			 $("#"+"<%=select%>").val($("input[name='btn_<%=select%>']:checked").val());
		});
	</script>

	<div class="btn_group_100 label">
		<input type="radio" name="<%=select%>" id="<%=switch1%>" value="<%=val1%>" >
		<label for="<%=switch1%>" class="switch-on"><%=val1%></label>
		<input type="radio" name="<%=select%>" id="<%=switch2%>" value="<%=val2%>" >
		<label for="<%=switch2%>" class="switch-on"><%=val2%></label>
		<input type="radio" name="<%=select%>" id="<%=off%>" value="＼"checked>
		<label for="<%=off%>" class="switch-off">＼</label>
	</div>
	<input type="hidden" id="<%=select%>" value="">
</html>
