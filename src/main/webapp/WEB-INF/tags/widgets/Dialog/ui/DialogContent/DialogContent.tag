<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="content" required="false" %>
<%@ attribute name="className" required="false" %>

<!-- 다이얼로그 내용 -->
<div class="px-5 py-4 overflow-y-auto max-h-[60vh] ${className}">
    <c:choose>
        <c:when test="${!empty content}">
            <p class="text-[14px] font-normal leading-[1.5em] tracking-[-0.05em] text-[#3D444F] m-0">
                ${content}
            </p>
        </c:when>
        <c:otherwise>
            <!-- 슬롯 컨텐츠 -->
            <jsp:doBody />
        </c:otherwise>
    </c:choose>
</div>

