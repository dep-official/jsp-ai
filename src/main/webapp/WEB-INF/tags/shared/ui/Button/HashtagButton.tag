<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="label" required="true" %>
<%@ attribute name="active" required="false" %>
<%@ attribute name="icon" required="false" %>
<%@ attribute name="className" required="false" %>
<%@ attribute name="dataBrandId" required="false" %>

<c:choose>
    <c:when test="${active}">
        <c:set var="bgClass" value="bg-[#1B1E23]" />
        <c:set var="textClass" value="text-[14px] font-medium leading-[1.43em] tracking-[-0.05em] text-white" />
        <c:set var="borderClass" value="" />
    </c:when>
    <c:otherwise>
        <c:set var="bgClass" value="bg-white" />
        <c:set var="textClass" value="text-[14px] font-normal leading-[1.43em] tracking-[-0.05em] text-[#5C6677]" />
        <c:set var="borderClass" value="border border-[#DDE0E5]" />
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${!empty icon}">
        <c:set var="paddingClass" value="pl-3 pr-2 py-1.5" />
        <c:set var="gapClass" value="gap-1" />
    </c:when>
    <c:otherwise>
        <c:set var="paddingClass" value="px-3 py-1.5" />
        <c:set var="gapClass" value="" />
    </c:otherwise>
</c:choose>

<button
    type="button"
    class="flex items-center ${gapClass} ${paddingClass} rounded-[20px] ${bgClass} ${borderClass} ${textClass} hover:opacity-80 transition-all duration-200 ease-smooth focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2 ${className}"
    <% if (jspContext.getAttribute("dataBrandId") != null && !jspContext.getAttribute("dataBrandId").toString().isEmpty()) { %>data-brand-id="<%= jspContext.getAttribute("dataBrandId") %>"<% } %>>
    <span>${label}</span>
    <c:if test="${!empty icon}">
        <img src="${icon}" alt="${label} 아이콘" class="w-4 h-4" />
    </c:if>
</button>

