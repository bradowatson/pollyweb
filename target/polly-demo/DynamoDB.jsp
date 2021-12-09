<%@page import="com.watson.dynamodb.DBHelper"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.Item"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.ItemCollection"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.ScanOutcome"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
if(request.getParameter("language") != null) {
	ItemCollection<ScanOutcome> items = DBHelper.getResults();
	Iterator<Item> iter = items.iterator();
	StringBuilder output = new StringBuilder();
	output.append("{\"results\":[");
	while (iter.hasNext()) {
	    Item item = iter.next();
	    System.out.println(item.toString());
	    if(item.getString("Type").equalsIgnoreCase("Macro") && item.getString("Language").equalsIgnoreCase("English")) {
			output.append(item.toJSON());
			if(iter.hasNext()) {
				output.append(",");
			}
	    } else if(request.getParameter("language").equalsIgnoreCase("Spanish")) {
		    if(item.getString("Type").equalsIgnoreCase("Macro") && item.getString("Language").equalsIgnoreCase("Spanish")) {
				output.append(item.toJSON());
				if(iter.hasNext()) {
					output.append(",");
				}
		    }
	    }
	}
	if(output.toString().endsWith(",")) {
		output.substring(0, (output.length() - 1));
	}
	output.append("]}");
	out.println(output.toString());
}
   
%>