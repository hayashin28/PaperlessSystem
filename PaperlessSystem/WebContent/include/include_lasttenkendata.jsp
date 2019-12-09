<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<script type="text/javascript">
		$(function() {
			/* Cookieの有無を判定 */
			if ($.cookie("Setubi") !== null)) {
				LastTenkenData($.cookie("Setubi"), $(':hidden[name="sheetnm"]').val());
			}
			// セッションを廃止予定→∴削除予定
			else if (!(!("${setuB}"))) {
				/* セッション内の設備No.を取得 */
				$('#Setubi').val("${setuB}")
				LastTenkenData("${setuB}", $(':hidden[name="sheetnm"]').val());
			}

			$('#Setubi').on("keypress", function(e){
				if (e.charCode===13) {
					var words = $('#Setubi').val();
					if (words.length===0) { return false; }
					LastTenkenData(words, $(':hidden[name="sheetnm"]').val());
				}
			});
		});
	</script>

	<script type="text/javascript">
		var LastTenkenData = function(setubi, param) {
			var result = collCommonFunctionServlet(functionkbn.getLastTenkenData, setubi + ',' + param +  ','  + setubi + ',' + param + ',' + setubi + ',' + param);
			result.done(function(response) {
				 $.each(response, function(i, map) {
					var tag='';
					var val='';
					for(var key in map) {
						if(key==='tagnm') {
							tag=map[key];
						} else
						if(key==='dataval') {
							val=map[key];
						}
					}
					$(':text[name=' + tag + ']').val(val);
				});
			});
			result.fail(function() {});
		}
	</script>
</html>