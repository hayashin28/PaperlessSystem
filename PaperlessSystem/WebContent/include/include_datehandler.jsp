<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.lang.WordUtils"%>
<%@page import="common.DbCommonFunctions"%>
<%@page import="java.sql.Timestamp"%>
<!DOCTYPE html>
<html>

	<script type="text/javascript">
		/* 日付処理 */
		var DateHandler = function(kbn) {
			var date = moment("<%=DbCommonFunctions.getServerTime()%>");
			if (datekbn.date===kbn)			 { $("#Date").val(date.format("MM月DD日")); }
			else if (datekbn.datetime===kbn) { $("#Date").val(date.format("MM/DD HH:mm")); }
		}
	</script>
</html>