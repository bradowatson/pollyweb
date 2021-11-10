
<%@page import="com.watson.polly.request.PollyRequest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	if(request.getParameter("text") != null) {
		PollyRequest.processRequest(request.getParameter("text"), request.getParameter("name"));
	}
   
%>