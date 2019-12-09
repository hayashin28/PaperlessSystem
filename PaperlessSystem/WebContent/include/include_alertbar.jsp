<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String id  = request.getParameter("id");
	String msg = request.getParameter("msg");
%>
<div class="alert alert-danger" role="alert" id="<%=id%>">
	<strong> 警告! </strong><%=msg%>
</div>
