<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="label" required="true" %>
<%@ attribute name="size" required="false" %>
<%@ attribute name="active" required="false" %>
<%@ attribute name="className" required="false" %>

<c:choose>
    <c:when test="${empty size}">
        <c:set var="textSize" value="primary" />
    </c:when>
    <c:otherwise>
        <c:set var="textSize" value="${size}" />
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${textSize == 'primary'}">
        <c:set var="widthClass" value="w-full" />
        <c:choose>
            <c:when test="${active}">
                <c:set var="textClass" value="text-[16px] font-medium leading-[1.5em] tracking-[-0.05em] text-[#1B1E23]" />
                <c:set var="stateClass" value="hover:text-[#1B1E23] active:text-[#1B1E23] focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2" />
            </c:when>
            <c:otherwise>
                <c:set var="textClass" value="text-[16px] font-medium leading-[1.5em] tracking-[-0.05em] text-[#ABB2BE]" />
                <c:set var="stateClass" value="hover:text-[#1B1E23] active:text-[#1B1E23] focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2 transition-colors duration-200 ease-smooth" />
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test="${textSize == 'secondary'}">
        <c:set var="widthClass" value="" />
        <c:choose>
            <c:when test="${active}">
                <c:set var="textClass" value="text-[14px] font-bold leading-[1.43em] tracking-[-0.05em] text-[#1B1E23]" />
                <c:set var="stateClass" value="hover:text-[#1B1E23] active:text-[#1B1E23] focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2" />
            </c:when>
            <c:otherwise>
                <c:set var="textClass" value="text-[14px] font-normal leading-[1.43em] tracking-[-0.05em] text-[#788497]" />
                <c:set var="stateClass" value="hover:text-[#1B1E23] active:text-[#1B1E23] focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2 transition-colors duration-200 ease-smooth" />
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <c:set var="widthClass" value="" />
        <c:choose>
            <c:when test="${active}">
                <c:set var="textClass" value="text-[16px] font-medium leading-[1.5em] tracking-[-0.05em] text-[#1B1E23]" />
                <c:set var="stateClass" value="hover:text-[#1B1E23] active:text-[#1B1E23] focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2" />
            </c:when>
            <c:otherwise>
                <c:set var="textClass" value="text-[16px] font-medium leading-[1.5em] tracking-[-0.05em] text-[#ABB2BE]" />
                <c:set var="stateClass" value="hover:text-[#1B1E23] active:text-[#1B1E23] focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2 transition-colors duration-200 ease-smooth" />
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>

<button
    type="button"
    class="${widthClass} ${textClass} ${stateClass} ${className} w-full h-full justify-content items-center">
    ${label}
</button>

