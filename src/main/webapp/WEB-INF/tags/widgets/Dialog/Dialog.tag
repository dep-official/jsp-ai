<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dialogHeader" tagdir="/WEB-INF/tags/widgets/Dialog/ui/DialogHeader" %>
<%@ taglib prefix="dialogContent" tagdir="/WEB-INF/tags/widgets/Dialog/ui/DialogContent" %>
<%@ taglib prefix="dialogActions" tagdir="/WEB-INF/tags/widgets/Dialog/ui/DialogActions" %>
<%@ taglib prefix="dialogScript" tagdir="/WEB-INF/tags/widgets/Dialog/lib" %>
<%@ attribute name="id" required="false" %>
<%@ attribute name="open" required="false" type="java.lang.Boolean" %>
<%@ attribute name="title" required="true" %>
<%@ attribute name="content" required="false" %>
<%@ attribute name="actions" required="false" %>
<%@ attribute name="showCloseButton" required="false" type="java.lang.Boolean" %>
<%@ attribute name="onClose" required="false" %>
<%@ attribute name="className" required="false" %>

<%
    // open 기본값
    Boolean isOpen = (Boolean) jspContext.getAttribute("open");
    if (isOpen == null) {
        isOpen = false;
    }
    jspContext.setAttribute("isOpen", isOpen);
%>

<!-- 다이얼로그 -->
<dialog
    <c:if test="${!empty id}">id="${id}"</c:if>
    role="dialog"
    aria-labelledby="dialog-title"
    aria-modal="true"
    class="w-full max-w-[335px] rounded-[8px] bg-white shadow-lg p-0 backdrop:bg-black/50 ${className}"
    <c:if test="${isOpen}">open</c:if>>
    
    <!-- 다이얼로그 헤더 -->
    <dialogHeader:DialogHeader 
        title="${title}"
        showCloseButton="${showCloseButton != false}"
        onClose="${onClose}" />
    
    <!-- 다이얼로그 내용 -->
    <dialogContent:DialogContent content="${content}" />
    
    <!-- 다이얼로그 액션 버튼 -->
    <c:if test="${!empty actions}">
        <dialogActions:DialogActions actions="${actions}" alignment="right" />
    </c:if>
</dialog>

<c:if test="${!empty id}">
    <dialogScript:DialogScript dialogId="${id}" />
</c:if>

