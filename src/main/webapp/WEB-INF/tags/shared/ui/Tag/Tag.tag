<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="label" required="true" %>
<%@ attribute name="variant" required="false" %>
<%@ attribute name="className" required="false" %>

<c:choose>
    <c:when test="${empty variant}">
        <c:set var="tagVariant" value="event" />
    </c:when>
    <c:otherwise>
        <c:set var="tagVariant" value="${variant}" />
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${tagVariant == 'event'}">
        <c:set var="bgClass" value="bg-[#5998D7]" />
        <c:set var="textClass" value="text-[12px] font-medium leading-[1.5em] tracking-[-0.05em] text-white" />
        <c:set var="borderRadius" value="rounded-[20px]" />
        <c:set var="paddingClass" value="px-3 py-0.75" />
        <c:set var="heightClass" value="h-6" />
        <c:set var="sizeClass" value="" />
        <c:set var="borderClass" value="" />
    </c:when>
    <c:when test="${tagVariant == 'gift'}">
        <c:set var="bgClass" value="bg-[#B1A59A]" />
        <c:set var="textClass" value="text-[12px] font-medium leading-[1.5em] tracking-[-0.05em] text-white" />
        <c:set var="borderRadius" value="rounded-tl-[8px] rounded-tr-[0px] rounded-br-[8px] rounded-bl-[0px]" />
        <c:set var="paddingClass" value="px-2 py-0.5" />
        <c:set var="heightClass" value="" />
        <c:set var="sizeClass" value="" />
        <c:set var="borderClass" value="" />
    </c:when>
    <c:when test="${tagVariant == 'flag'}">
        <c:set var="bgClass" value="bg-white" />
        <c:set var="textClass" value="text-[11px] font-medium leading-[1.55em] tracking-[-0.05em] text-[#5C6677]" />
        <c:set var="borderRadius" value="rounded-[4px]" />
        <c:set var="paddingClass" value="px-1.5 pt-[1px] pb-[2px]" />
        <c:set var="heightClass" value="" />
        <c:set var="sizeClass" value="" />
        <c:set var="borderClass" value="border border-[#CCD1D8]" />
    </c:when>
    <c:otherwise>
        <c:set var="bgClass" value="bg-[#5998D7]" />
        <c:set var="textClass" value="text-[12px] font-medium leading-[1.5em] tracking-[-0.05em] text-white" />
        <c:set var="borderRadius" value="rounded-[20px]" />
        <c:set var="paddingClass" value="px-3 py-0.75" />
        <c:set var="heightClass" value="h-6" />
        <c:set var="sizeClass" value="" />
        <c:set var="borderClass" value="" />
    </c:otherwise>
</c:choose>

<span class="inline-flex items-center justify-center ${sizeClass} ${heightClass} ${paddingClass} ${borderRadius} ${bgClass} ${borderClass} ${textClass} ${className}">
    ${label}
</span>

