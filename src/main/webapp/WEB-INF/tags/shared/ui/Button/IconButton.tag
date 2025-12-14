<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="src" required="true" %>
<%@ attribute name="size" required="false" %>
<%@ attribute name="ariaLabel" required="false" %>
<%@ attribute name="className" required="false" %>

<c:choose>
    <c:when test="${size == 'sm'}">
        <c:set var="propSize" value="h-6 w-6" />
    </c:when>
    <c:when test="${size == 'lg'}">
        <c:set var="propSize" value="h-14 w-14" />
    </c:when>
    <c:otherwise>
        <c:set var="propSize" value="h-12 w-12" />
    </c:otherwise>
</c:choose>

<c:set var="propArialLabel" value="${ariaLabel ? ariaLabel : ''}" />

<button
    type="button"
    class="inline-flex items-center justify-center ${propSize} rounded-lg bg-transparent text-[#1B1E23] hover:bg-[#F4F5F7] active:bg-[#E9EBEF] focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed transition-colors duration-200 ease-smooth ${className ? className : ''}"
    aria-label="${propArialLabel}">
    <img src="${src}" alt="${propArialLabel}" class="w-6 h-6" />
</button>

