<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="title" required="true" %>
<%@ attribute name="subtitle" required="false" %>
<%@ attribute name="className" required="false" %>

<div class="flex flex-col items-center justify-center ${className}">
    <h2 class="text-[22px] font-bold leading-[1.45em] tracking-[-0.05em] text-[#1B1E23] text-center mb-[6px] m-0">
        <c:set var="normalizedTitle" value="${fn:replace(title, '<br/>', '|||BREAK|||')}" />
        <c:set var="normalizedTitle" value="${fn:replace(normalizedTitle, '<br>', '|||BREAK|||')}" />
        <c:set var="normalizedTitle" value="${fn:replace(normalizedTitle, '&#10;', '|||BREAK|||')}" />
        <c:set var="titleLines" value="${fn:split(normalizedTitle, '|||BREAK|||')}" />
        <c:forEach var="line" items="${titleLines}" varStatus="status">
            <c:out value="${line}" /><c:if test="${!status.last}"><br/></c:if>
        </c:forEach>
    </h2>
    
    <c:if test="${!empty subtitle}">
        <p class="text-[14px] font-normal leading-[1.43em] tracking-[-0.05em] text-[#5C6677] text-center mb-[12px]">
            ${subtitle}
        </p>
    </c:if>
</div>
