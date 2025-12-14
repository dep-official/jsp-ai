<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="imageUrl" required="true" %>
<%@ attribute name="period" required="false" %>
<%@ attribute name="title" required="true" %>
<%@ attribute name="subtitle" required="false" %>
<%@ attribute name="bgColor" required="false" %>
<%@ attribute name="onClick" required="false" %>
<%@ attribute name="className" required="false" %>

<%
    // 배경색 기본값
    String bgColor = (String) jspContext.getAttribute("bgColor");
    if (bgColor == null || bgColor.isEmpty()) {
        bgColor = "#F3E1CC";
    }
    jspContext.setAttribute("bgColor", bgColor);
%>

<!-- KV 배너 -->
<article class="relative w-full mb-[16px] ${className}"
    tabindex="0"
    aria-label="${title}"
    <c:if test="${!empty onClick}">onclick="${onClick}"</c:if>
    <c:if test="${!empty onClick}">style="cursor: pointer;"</c:if>>
    
    <!-- 배경색 영역 -->
    <div class="absolute top-0 left-0 w-full bg-[${bgColor}] h-[360px] lg:h-[540px]" aria-hidden="true"></div>
    
    <!-- 제목 영역 -->
    <div class="relative px-5 pt-[48px] container mx-auto">
        <div class="flex flex-col items-center gap-[8px] mb-[12px]">
            <!-- 날짜/기간 -->
            <c:if test="${!empty period}">
                <p class="text-[#3D444F] font-normal text-[13px] leading-[1.462em] tracking-[-0.05em] text-center w-full">
                    ${period}
                </p>
            </c:if>
            <!-- 메인 제목 -->
            <h2 class="text-[#1B1E23] font-bold text-[28px] leading-[1.429em] tracking-[-0.05em] text-center w-full">
                <c:set var="normalizedTitle" value="${fn:replace(title, '<br/>', '|||BREAK|||')}" />
                <c:set var="normalizedTitle" value="${fn:replace(normalizedTitle, '<br>', '|||BREAK|||')}" />
                <c:set var="titleLines" value="${fn:split(normalizedTitle, '|||BREAK|||')}" />
                <c:forEach var="line" items="${titleLines}" varStatus="status">
                    <c:out value="${line}" /><c:if test="${!status.last}"><br/></c:if>
                </c:forEach>
            </h2>
        </div>
        
        <!-- 서브 제목 -->
        <c:if test="${!empty subtitle}">
            <p class="text-[#5C6677] font-normal text-[14px] leading-[1.429em] tracking-[-0.05em] text-center w-full mb-[32px]">
                ${subtitle}
            </p>
        </c:if>
    </div>
    
    <!-- 이미지 영역 -->
    <div class="relative px-5 container mx-auto">
        <figure class="w-full aspect-[804/512] max-w-[900px] mx-auto min-h-[280px] rounded-[12px] overflow-hidden">
            <%
                // alt 텍스트에서 HTML 태그 제거
                String altText = (String) jspContext.getAttribute("title");
                if (altText != null) {
                    altText = altText.replaceAll("<br/?>", " ").replaceAll("<[^>]+>", "").trim();
                } else {
                    altText = "";
                }
                jspContext.setAttribute("altText", altText);
            %>
            <img 
                src="${imageUrl}" 
                alt="${altText}"
                class="w-full h-full object-cover rounded-[12px]"
                loading="lazy" />
        </figure>
    </div>
</article>

