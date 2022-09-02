<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	</head>

	<body>
		<div class="flag">記帳ペーパーレス点検システム</div>
		<p>&nbsp;</p>
		<table>
			<tr>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<div class="label label-default" style="font-size: large">装置タイプ</div>
					<div id="mainselection">
						<select name="type" onChange="location.href=value;">
							<option value="" selected="selected"></option>
							<option value='<%=request.getContextPath()+"/type/DB/menu.jsp"%>'>DB</option>
							<option value='<%=request.getContextPath()+"/type/DC/menu.jsp"%>'>DC</option>
							<option value='<%=request.getContextPath()+"/type/WB/menu.jsp"%>'>WB</option>
							<option value='<%=request.getContextPath()+"/type/MD/menu.jsp"%>'>MD</option>
						</select>
					</div>
				</td>
				<td rowspan=2 align="left"><jsp:include page="/include/include_return.jsp"/></td>
			</tr>
		</table>
	</body>

</html>