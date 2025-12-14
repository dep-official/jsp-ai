<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="imageUrl" required="true" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="onClick" required="false" %>
<%@ attribute name="className" required="false" %>

<!-- 브랜드 아이템 -->
<li class="flex flex-col items-center ${className}" role="button" tabindex="0" aria-label="${name} 브랜드"
    <c:if test="${!empty onClick}">onclick="${onClick}"</c:if>
    <c:if test="${!empty onClick}">style="cursor: pointer;"</c:if>>
    <!-- 브랜드 이미지 -->
    <figure class="w-full aspect-[100/100] rounded-[12px] overflow-hidden mb-[4px]">
        <img 
            src="${imageUrl}" 
            alt="${name} 브랜드 로고"
            class="object-cover w-full h-full" />
    </figure>
    <!-- 브랜드명 -->
    <h3 class="text-[#3D444F] font-medium text-[14px] leading-[1.429em] tracking-[-0.05em] text-center w-[101px] h-[22px] m-0">
        ${name}
    </h3>
</li>

