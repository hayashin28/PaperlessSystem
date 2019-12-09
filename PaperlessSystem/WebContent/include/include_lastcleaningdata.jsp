<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<script type="text/javascript">
		$(function() {
		//
			if (!(!("${setuB}"))) {
				/* セッション内の設備No.を取得 */
				$('#Setubi').val("${setuB}")
				findLastCleaningData("${setuB}", $(':hidden[name="sheetnm"]').val());
			}

			$('#Setubi').on("keypress", function(e){
				if (e.charCode===13) {
					var words = $('#Setubi').val();
					if (words.length===0) { return false; }
					findLastCleaningData(words, $(':hidden[name="sheetnm"]').val());
				}
			});
		});
	</script>

	<script type="text/javascript">
		var findLastCleaningData = function(setubi, param) {
			var result = collCommonFunctionServlet(functionkbn.getLastCleaningData, setubi + ',' + param);
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
					$('#' + tag).val(val);
				});
			});
			result.fail(function() {});
		}
	</script>
</html>