<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="imageUrl" required="true" %>
<%@ attribute name="brand" required="false" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="showDivider" required="false" type="java.lang.Boolean" %>
<%@ attribute name="className" required="false" %>

<%
    // showDivider 기본값
    Boolean showDividerValue = (Boolean) jspContext.getAttribute("showDivider");
    if (showDividerValue == null) {
        showDividerValue = true;
    }
    jspContext.setAttribute("showDividerValue", showDividerValue);
%>

<!-- 제품 세트 리스트 아이템 -->
<li class="list-none ${className}">
    <article class="flex items-start gap-4 w-full max-w-[285px]">
        <!-- 제품 이미지 -->
        <figure class="flex-shrink-0 w-[80px] h-[80px] rounded overflow-hidden bg-[#F5F7FA]">
            <img 
                src="${imageUrl}" 
                alt="${name}" 
                class="object-cover w-full h-full mix-blend-multiply"
                loading="lazy" />
        </figure>
        
        <!-- 제품 정보 -->
        <div class="flex flex-col flex-1 min-w-0">
            <!-- 브랜드명 및 제품명 -->
            <dl class="flex flex-col gap-0">
                <!-- 브랜드명: 13px, 700 weight, #1B1E23 -->
                <c:if test="${!empty brand}">
                    <dt class="text-[13px] font-bold leading-[1.46em] tracking-[-0.05em] text-[#1B1E23]">
                        ${brand}
                    </dt>
                </c:if>
                <!-- 제품명: 14px, 500 weight, #3D444F, 2줄 가능 -->
                <dd class="text-[14px] font-medium leading-[1.43em] tracking-[-0.05em] text-[#3D444F] line-clamp-2 mt-0.5">
                    ${name}
                </dd>
            </dl>
        </div>
    </article>
    
    <!-- 구분선: #EEF0F2, 1px -->
    <c:if test="${showDividerValue}">
        <hr class="w-full h-0 border-0 border-t border-[#EEF0F2] mt-4" aria-hidden="true" />
    </c:if>
</li>

