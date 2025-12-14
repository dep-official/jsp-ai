<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="imageUrl" required="true" %>
<%@ attribute name="condition" required="true" %>
<%@ attribute name="description" required="true" %>
<%@ attribute name="showDivider" required="false" type="java.lang.Boolean" %>
<%@ attribute name="className" required="false" %>

<!-- 이벤트 배너 항목 (사은품) -->
<li class="flex items-center gap-[17px] w-full ${className}">
    <!-- 이미지 영역 -->
    <figure class="flex-shrink-0 w-[100px] h-[100px] rounded overflow-hidden">
        <img 
            src="${imageUrl}" 
            alt="${description}" 
            class="object-cover w-full h-full mix-blend-multiply"
            loading="lazy" />
    </figure>
    
    <!-- 텍스트 영역 -->
    <dl class="flex flex-col gap-[2px] flex-1 text-center">
        <!-- 조건 텍스트 -->
        <dt class="text-[13px] font-medium leading-[1.46em] tracking-[-0.05em] text-[#A58768]">
            ${condition}
        </dt>
        <!-- 설명 텍스트 -->
        <dd class="text-[14px] font-normal leading-[1.43em] tracking-[-0.05em] text-[#3D444F]">
            ${description}
        </dd>
    </dl>
</li>
<!-- 구분선 -->
<c:if test="${showDivider != false}">
    <hr class="h-0 border-0 border-t border-[#EEF0F2] w-full" aria-hidden="true" />
</c:if>

