<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="prefix" required="false" %>
<%@ variable name-given="generatedId" scope="AT_END" %>

<%
    String p = (prefix != null) ? prefix : "uid";
    String id = p + "_" + System.currentTimeMillis() + "_" + (int)(Math.random() * 1000);
    jspContext.setAttribute("generatedId", id);
%>
