<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<jsp:include page="/include/include_cookie.jsp"/>

	<script type="text/javascript">
		var words = '';
		/* Keypressによるイベント処理 */
		var BarcodeHandler = function(e, dataid, id, kbn) {
			var val=id.split(',');
			if (words === $("#" + val[0]).val() || e.keyCode === 229 || e.charCode!==13) { return false; }
			words=replaceCode(toHalfWidth($("#"+val[0]).val()));
			$("#"+val[0]).val(words);
			var defer = $.Deferred();
			$.each(val, function(i, elm) {val[i]=$("#"+val[i]).val();});
			words = val.join(',');
			var promise=fncWords(words, dataid, id, kbn);
			promise.done(function(){
				defer.resolve(); 	// 承認
			})
			promise.fail(function() {
				defer.reject(); 	// 却下
			});
			return defer.promise(); // プロミスを作って返す
		}
		/* Focusoutによるイベント処理 */
		var FocuslostHandler = function(e, dataid, id, kbn) {
			var val=id.split(',');
			if (words === $("#" + val[0]).val()) { return false; }
			words=replaceCode(toHalfWidth($("#"+val[0]).val()));
			$("#"+val[0]).val(words);
			var defer = $.Deferred();
			$.each(val, function(i, elm) {val[i]=$("#"+val[i]).val();});
			words = val.join(',');
			var promise=fncWords(words, dataid, id, kbn);
			promise.done(function(){
				defer.resolve(); 	// 承認
			})
			promise.fail(function() {
				defer.reject(); 	// 却下
			});
			return defer.promise(); // プロミスを作って返す
		}
	</script>
</html>