<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="label" required="true" %>
<%@ attribute name="variant" required="false" %>
<%@ attribute name="className" required="false" %>

<c:choose>
    <c:when test="${empty variant}">
        <c:set var="badgeVariant" value="soldout" />
    </c:when>
    <c:otherwise>
        <c:set var="badgeVariant" value="${variant}" />
    </c:otherwise>
</c:choose>

<c:set var="groupClass" value="" />
<c:set var="transitionClass" value="" />

<c:choose>
    <c:when test="${badgeVariant == 'soldout'}">
        <c:set var="bgClass" value="bg-[#5C6677] opacity-80" />
        <c:set var="textClass" value="text-[12px] font-bold leading-[1.5em] tracking-[-0.05em] text-white" />
        <c:set var="borderRadius" value="rounded-[4px]" />
        <c:set var="paddingClass" value="px-3 py-1" />
        <c:set var="sizeClass" value="w-[67px] h-[27px]" />
    </c:when>
    <c:when test="${badgeVariant == 'restock'}">
        <c:set var="bgClass" value="bg-[rgba(27,30,35,0.06)] backdrop-blur-[5px] group-hover:bg-black" />
        <c:set var="textClass" value="text-[12px] font-normal leading-[1.5em] tracking-[-0.05em] text-[rgba(0,0,0,0.4)] group-hover:text-white" />
        <c:set var="transitionClass" value="transition-colors duration-200 ease-smooth" />
        <c:set var="paddingClass" value="px-3 py-1" />
        <c:set var="sizeClass" value="w-full h-[32px]" />
    </c:when>
    <c:otherwise>
        <c:set var="bgClass" value="bg-[#5C6677] opacity-80" />
        <c:set var="textClass" value="text-[12px] font-bold leading-[1.5em] tracking-[-0.05em] text-white" />
        <c:set var="borderRadius" value="rounded-[4px]" />
        <c:set var="paddingClass" value="px-3 py-1" />
        <c:set var="sizeClass" value="w-[67px] h-[27px]" />
    </c:otherwise>
</c:choose>

<span class="inline-flex items-center justify-center ${sizeClass} ${paddingClass} ${borderRadius} ${bgClass} ${textClass} ${transitionClass} ${className}">
    ${label}
</span>

