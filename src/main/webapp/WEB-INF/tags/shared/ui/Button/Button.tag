<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="label" required="false" %>
<%@ attribute name="variant" required="false" %>
<%@ attribute name="size" required="false" %>
<%@ attribute name="icon" required="false" %>
<%@ attribute name="iconPosition" required="false" %>
<%@ attribute name="type" required="false" %>
<%@ attribute name="disabled" required="false" %>
<%@ attribute name="ariaLabel" required="false" %>
<%@ attribute name="onclick" required="false" %>
<%@ attribute name="fullWidth" required="false" type="java.lang.Boolean" %>
<%@ attribute name="gradientFrom" required="false" %>
<%@ attribute name="gradientTo" required="false" %>
<%@ attribute name="className" required="false" %>

<c:choose>
    <c:when test="${empty variant}">
        <c:set var="btnVariant" value="filled" />
    </c:when>
    <c:otherwise>
        <c:set var="btnVariant" value="${variant}" />
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${btnVariant == 'filled'}">
        <c:set var="variantClass" value="bg-[#1B1E23] text-white hover:bg-[#2B2F35] active:bg-[#16181D]" />
    </c:when>
    <c:when test="${btnVariant == 'outlined'}">
        <c:set var="variantClass" value="bg-transparent text-[#1B1E23] border border-[#DDE0E5] hover:border-[#C7CBD3] active:border-[#B4B9C4]" />
    </c:when>
    <c:when test="${btnVariant == 'text'}">
        <c:set var="variantClass" value="bg-transparent text-[#1B1E23] border border-transparent hover:bg-[#F4F5F7] active:bg-[#E9EBEF]" />
    </c:when>
    <c:when test="${btnVariant == 'elevated'}">
        <c:set var="variantClass" value="bg-white text-[#1B1E23] shadow-sm hover:shadow-md active:shadow-sm" />
    </c:when>
    <c:when test="${btnVariant == 'tonal'}">
        <c:set var="variantClass" value="bg-[#F4F5F7] text-[#1B1E23] hover:bg-[#E9EBEF] active:bg-[#DDE0E5]" />
    </c:when>
    <c:when test="${btnVariant == 'gradient'}">
        <c:set var="gradientFromColor" value="${!empty gradientFrom ? gradientFrom : '#EA2869'}" />
        <c:set var="gradientToColor" value="${!empty gradientTo ? gradientTo : '#5A3FF2'}" />
        <c:set var="variantClass" value="bg-gradient-to-r text-white hover:opacity-90" />
    </c:when>
    <c:otherwise>
        <c:set var="variantClass" value="bg-[#1B1E23] text-white hover:bg-[#2B2F35] active:bg-[#16181D]" />
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${empty size}">
        <c:set var="btnSize" value="medium" />
    </c:when>
    <c:otherwise>
        <c:set var="btnSize" value="${size}" />
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${btnSize == 'small'}">
        <c:set var="sizeClass" value="h-10 px-4 text-sm" />
    </c:when>
    <c:when test="${btnSize == 'large'}">
        <c:set var="sizeClass" value="h-12 px-6 text-base" />
    </c:when>
    <c:when test="${btnSize == 'medium'}">
        <c:set var="sizeClass" value="h-12 px-5 text-base" />
    </c:when>
    <c:otherwise>
        <c:set var="sizeClass" value="h-12 px-5 text-base" />
    </c:otherwise>
</c:choose>

<c:set var="propArialLabel" value="${ariaLabel ? ariaLabel : ''}" />
<c:set var="buttonType" value="${empty type ? 'button' : type}" />
<c:set var="iconPos" value="${empty iconPosition ? 'leading' : iconPosition}" />

<%
    // variant를 scriptlet에서 사용하기 위해 가져오기
    String variantStr = (String) jspContext.getAttribute("variant");
    if (variantStr == null) {
        variantStr = "";
    }
    
    // fullWidth 처리
    Boolean fullWidthValue = (Boolean) jspContext.getAttribute("fullWidth");
    if (fullWidthValue == null) {
        fullWidthValue = false;
    }
    String widthClass = fullWidthValue ? "w-full" : "";
    jspContext.setAttribute("widthClass", widthClass);
    
    // onclick 속성 처리
    String onclickValue = (String) jspContext.getAttribute("onclick");
    if (onclickValue == null) {
        onclickValue = "";
    }
    String onclickAttr = onclickValue.isEmpty() ? "" : "onclick=\"" + onclickValue + "\"";
    jspContext.setAttribute("onclickAttr", onclickAttr);
    
    // disabled 처리 (Boolean 또는 String "true"/"false" 처리)
    Object disabledObj = jspContext.getAttribute("disabled");
    Boolean disabledValue = false;
    if (disabledObj != null) {
        if (disabledObj instanceof Boolean) {
            disabledValue = (Boolean) disabledObj;
        } else if (disabledObj instanceof String) {
            disabledValue = Boolean.parseBoolean((String) disabledObj);
        }
    }
    String disabledAttr = disabledValue ? "disabled" : "";
    jspContext.setAttribute("disabledAttr", disabledAttr);
    
    // 그라데이션 스타일 처리
    String gradientStyle = "";
    if ("gradient".equals(variantStr)) {
        String fromColor = (String) jspContext.getAttribute("gradientFrom");
        String toColor = (String) jspContext.getAttribute("gradientTo");
        if (fromColor == null || fromColor.isEmpty()) {
            fromColor = "#EA2869";
        }
        if (toColor == null || toColor.isEmpty()) {
            toColor = "#5A3FF2";
        }
        gradientStyle = "background: linear-gradient(90deg, " + fromColor + " 0%, " + toColor + " 100%);";
    }
    jspContext.setAttribute("gradientStyle", gradientStyle);
%>

<button
    type="${buttonType}"
    class="inline-flex items-center justify-center gap-1 rounded-[4px] font-bold leading-[1.5] tracking-[-0.05em] ${sizeClass} ${variantClass} ${widthClass} focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed transition-opacity duration-200 ease-smooth ${className}"
    style="${gradientStyle}"
    aria-label="${propArialLabel}"
    ${onclickAttr}
    ${disabledAttr}>
    <c:if test="${!empty icon && iconPos == 'leading'}">
        <img src="${icon}" alt="${propArialLabel}" class="w-4 h-4" />
    </c:if>
    <c:if test="${!empty label}">
        <span>${label}</span>
    </c:if>
    <c:if test="${!empty icon && iconPos == 'trailing'}">
        <img src="${icon}" alt="${propArialLabel}" class="w-4 h-4" />
    </c:if>
</button>

