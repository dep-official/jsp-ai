<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Force recompile --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="templates" tagdir="/WEB-INF/tags/pages/event-detail/templates" %>

<%-- 
    Event Detail Page Router 
    - DB에서 가져온 event.templateType에 따라 적절한 템플릿을 렌더링합니다.
    - 현재는 임시로 ProductSetB를 기본값으로 사용합니다.
--%>

<c:choose>
    <c:when test="${event.templateType == 'PRODUCT_SET_B'}">
         <%-- ProductSetB 템플릿 사용 --%>
        <templates:ProductSetB 
            event="${event}" 
            products="${products}" 
            eventProducts="${eventProducts}"
            recommendedProducts="${recommendedProducts}"
            brands="${brands}"
            noticeItems="${noticeItems}" />
    </c:when>
    <c:when test="${event.templateType == 'PRODUCT_SET_A'}">
         <%-- ProductSetA 템플릿 사용 --%>
        <templates:ProductSetA 
            event="${event}" 
            products="${products}" 
            eventProducts="${eventProducts}"
            recommendedProducts="${recommendedProducts}"
            brands="${brands}"
            noticeItems="${noticeItems}" />
    </c:when>
    <c:otherwise>
        <%-- 기본 템플릿 사용 --%>
        <templates:Default
            event="${event}" 
            products="${products}" 
            eventProducts="${eventProducts}"
            recommendedProducts="${recommendedProducts}"
            brands="${brands}"
            noticeItems="${noticeItems}" />
    </c:otherwise>
</c:choose>

