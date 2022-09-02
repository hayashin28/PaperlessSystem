<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<script type="text/javascript">
		$(function() {
			/**
			 * Cookieの値を取得⇒展開処理
			 */
			$('#Setubi').val($.cookie('Setubi'));
			$('#Series').val($.cookie('Series'));
		});
	</script>

	<script type="text/javascript">
		var setCookie = function(key, val) {
			//Cookieの保存（30日間保持）
			$.cookie(key, val, {expires:30});
		}
	</script>

</html>