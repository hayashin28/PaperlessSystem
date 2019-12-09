<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
	String btn_id     = "btn_" + request.getParameter("btn_id");
	String btn_text   = 		 request.getParameter("btn_text");
	String txt_id     = 		 request.getParameter("txt_id");
	Integer width     = 200 * 	 Integer.parseInt(request.getParameter("width")) /100;
%>

	<script type="text/javascript">
		var param='';
		var DBSelectionBoxHandler = function(id, kbn) {
			$("#" + "<%=txt_id%>").val("");
			if (kbn !== 0) {
				if (param===$('#'+id).val()) { return false; }
				param=$('#'+id).val();
				var result=collCommonFunctionServlet(kbn, param);
				result.done(function(response) {
					$("#" + "<%=txt_id%>").show();
					$("#" + "<%=txt_id%>").keypad({
						separator : '|',
						layout : [ String(response),$.keypad.CLOSE ],
						keypadClass : "excuse-keypad",
						keypadOnly : true
					}).keypad('option', 'closeText', 'Enter');
				});
				result.fail(function() {
					bootbox.alert("データが存在しません。");
					$("#" + "<%=txt_id%>").hide();
					return false;
				});
			}
		}

		var DBSelectionBoxhide = function() {
			$("#" + "<%=txt_id%>").hide();
		}

		$(function () {
			$("#" + "<%=txt_id%>").change(function(e) {
				value=$("#" + "<%=txt_id%>").val().replace(value, "");
				$("#" + "<%=txt_id%>").val(value);
			});
		});
	</script>

	<div class="boxContainer">
		<div><button type="button" id="<%=btn_id%>" class="button large" style="margin:0px 0px 0px 00px"><%=btn_text%></button></div>
		<div><input type="text" id="<%=txt_id%>" class="input RoundedCorners ShadowInsetTop validate[required]" style="width:<%=width%>px; margin:0px 0px 0px 00px"></div>
	</div>
</html>