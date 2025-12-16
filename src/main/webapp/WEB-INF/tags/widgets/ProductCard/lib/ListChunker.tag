<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="list" required="true" type="java.util.List" %>
<%@ attribute name="chunkSize" required="true" type="java.lang.Integer" %>
<%@ variable name-given="chunkedList" variable-class="java.util.List" scope="AT_END" %>

<%
    java.util.List<java.util.List> chunks = new java.util.ArrayList<>();
    if (list != null && chunkSize > 0) {
        for (int i = 0; i < list.size(); i += chunkSize) {
            int end = Math.min(i + chunkSize, list.size());
            java.util.List chunk = new java.util.ArrayList<>();
            for (int j = i; j < end; j++) {
                chunk.add(list.get(j));
            }
            chunks.add(chunk);
        }
    }
    jspContext.setAttribute("chunkedList", chunks);
%>
