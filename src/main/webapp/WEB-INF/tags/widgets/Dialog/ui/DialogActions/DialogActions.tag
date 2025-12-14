<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="actions" required="false" %>
<%@ attribute name="alignment" required="false" %>
<%@ attribute name="className" required="false" %>

<%
    // 정렬 기본값
    String alignValue = (String) jspContext.getAttribute("alignment");
    if (alignValue == null || alignValue.isEmpty()) {
        alignValue = "right"; // Material Design 기본값: 오른쪽 정렬
    }
    jspContext.setAttribute("alignValue", alignValue);
    
    // 정렬 클래스 결정
    String alignClass = "";
    if ("left".equals(alignValue)) {
        alignClass = "justify-start";
    } else if ("center".equals(alignValue)) {
        alignClass = "justify-center";
    } else {
        alignClass = "justify-end";
    }
    jspContext.setAttribute("alignClass", alignClass);
%>

<%@ variable name-given="actionList" variable-class="java.util.List" scope="AT_END" %>

<%
    // actions를 파싱하여 리스트 생성
    java.util.List<java.util.Map<String, Object>> actionList = new java.util.ArrayList<>();
    String actionsStr = (String) jspContext.getAttribute("actions");
    if (actionsStr != null && !actionsStr.isEmpty()) {
        String[] actions = actionsStr.split(",");
        for (String action : actions) {
            action = action.trim();
            java.util.Map<String, Object> actionMap = new java.util.HashMap<>();
            
            if ("confirm".equalsIgnoreCase(action) || "ok".equalsIgnoreCase(action)) {
                actionMap.put("variant", "filled");
                actionMap.put("label", "확인");
                actionMap.put("btnClass", "bg-[#1B1E23] text-white hover:bg-[#2B2F35] active:bg-[#16181D]");
            } else if ("cancel".equalsIgnoreCase(action)) {
                actionMap.put("variant", "text");
                actionMap.put("label", "취소");
                actionMap.put("btnClass", "bg-transparent text-[#1B1E23] border border-transparent hover:bg-[#F4F5F7] active:bg-[#E9EBEF]");
            } else {
                actionMap.put("variant", "text");
                actionMap.put("label", action);
                actionMap.put("btnClass", "bg-transparent text-[#1B1E23] border border-transparent hover:bg-[#F4F5F7] active:bg-[#E9EBEF]");
            }
            
            actionList.add(actionMap);
        }
    }
    jspContext.setAttribute("actionList", actionList);
%>

<!-- 다이얼로그 액션 버튼 영역 -->
<footer class="flex items-center gap-2 px-5 py-4 border-t border-[#DDE0E5] ${alignClass} ${className}">
    <c:choose>
        <c:when test="${!empty actionList}">
            <c:forEach var="action" items="${actionList}">
                <button
                    type="button"
                    onclick="this.closest('dialog').close()"
                    class="inline-flex items-center justify-center gap-1 rounded-[4px] font-bold leading-[1.5] tracking-[-0.05em] h-12 px-5 text-base ${action.btnClass} focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2 transition-colors duration-200 ease-smooth">
                    ${action.label}
                </button>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <!-- 슬롯 액션 버튼 -->
            <jsp:doBody />
        </c:otherwise>
    </c:choose>
</footer>

