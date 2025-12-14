<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="title" required="true" %>
<%@ attribute name="showCloseButton" required="false" type="java.lang.Boolean" %>
<%@ attribute name="onClose" required="false" %>
<%@ attribute name="className" required="false" %>

<!-- 다이얼로그 헤더 -->
<header class="flex items-center justify-between px-5 py-4 ${className}">
    <h2 id="dialog-title" class="text-[18px] font-bold leading-[1.44em] tracking-[-0.05em] text-[#1B1E23] m-0">
        ${title}
    </h2>
    <c:if test="${showCloseButton != false}">
        <button
            type="button"
            class="w-8 h-8 flex items-center justify-center rounded-full hover:bg-[#F4F5F7] active:bg-[#E9EBEF] focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2 transition-colors duration-200 ease-smooth"
            aria-label="닫기"
            onclick="<c:choose><c:when test="${!empty onClose}">${onClose}</c:when><c:otherwise>this.closest('dialog').close()</c:otherwise></c:choose>">
            <svg class="w-5 h-5 text-[#5C6677]" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
        </button>
    </c:if>
</header>

