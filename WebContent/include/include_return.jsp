<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<div id="r" align="right">
		<button type="button" onClick="location.href=value;" class="button large" value="<%=request.getContextPath()%>"><span>戻る</span></button>
	</div>

	<script>
		window.onload = function() {
			if (getContextPath()===location.pathname) {
				document.getElementById("r").style.display="none";
			} else {
				document.getElementById("r").style.display="block";
			}
		}
	</script>
</html>