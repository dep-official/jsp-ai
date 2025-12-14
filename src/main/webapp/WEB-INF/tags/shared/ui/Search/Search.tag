<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="placeholder" required="false" %>
<%@ attribute name="value" required="false" %>
<%@ attribute name="onBack" required="false" %>
<%@ attribute name="onSearch" required="false" %>
<%@ attribute name="onChange" required="false" %>
<%@ attribute name="className" required="false" %>

<%
    // placeholder 기본값
    String placeholderValue = (String) jspContext.getAttribute("placeholder");
    if (placeholderValue == null || placeholderValue.isEmpty()) {
        placeholderValue = "브랜드명으로 검색해보세요";
    }
    jspContext.setAttribute("placeholderValue", placeholderValue);
%>

<!-- 검색바 컴포넌트 -->
<div class="relative w-full h-[60px] ${className}">
    <div class="flex items-center h-full">
        <!-- Back 버튼 -->
        <button
            type="button"
            class="flex-shrink-0 w-6 h-6 flex items-center justify-center mr-4 focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2"
            aria-label="뒤로가기"
            <c:if test="${!empty onBack}">onclick="${onBack}"</c:if>>
            <img 
                src="${pageContext.request.contextPath}/public/images/icons/back-24px.svg" 
                alt="뒤로가기" 
                class="w-6 h-6" />
        </button>
        
        <!-- 검색 입력 필드 -->
        <input
            type="text"
            class="flex-1 h-6 bg-transparent border-0 outline-none text-[16px] font-normal leading-[1.5em] tracking-[-0.05em] text-[#ABB2BE] placeholder:text-[#ABB2BE] focus:text-[#1B1E23]"
            placeholder="${placeholderValue}"
            value="${value}"
            <c:if test="${!empty onChange}">onchange="${onChange}"</c:if>
            aria-label="검색 입력" />
        
        <!-- Search 버튼 -->
        <button
            type="button"
            class="flex-shrink-0 mr-5 w-6 h-6 flex items-center justify-center ml-4 focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2"
            aria-label="검색"
            <c:if test="${!empty onSearch}">onclick="${onSearch}"</c:if>>
            <img 
                src="${pageContext.request.contextPath}/public/images/icons/search-24px.svg" 
                alt="검색" 
                class="w-6 h-6" />
        </button>
    </div>
    
    <!-- 구분선 -->
    <hr class="absolute w-full border-t-2 border-[#1B1E23]" aria-hidden="true" />
</div>

