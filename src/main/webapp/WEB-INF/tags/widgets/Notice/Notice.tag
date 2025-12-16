<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="button" tagdir="/WEB-INF/tags/shared/ui/Button" %>
<%@ attribute name="title" required="false" %>
<%@ attribute name="items" required="true" type="java.util.List" %>
<%@ attribute name="buttonText" required="false" %>
<%@ attribute name="buttonOnClick" required="false" %>
<%@ attribute name="className" required="false" %>

<%-- Default Values --%>
<c:set var="titleValue" value="${empty title ? '유의사항' : title}" />
<c:set var="buttonTextValue" value="${empty buttonText ? '더 많은 사은행사가 궁금하다면' : buttonText}" />
<c:set var="buttonOnClickValue" value="${empty buttonOnClick ? '' : buttonOnClick}" />


<!-- 유의사항 섹션 -->
<section class="flex flex-col mt-[64px] w-full ${className}" aria-label="유의사항">
    <hr class="w-full h-0 border-0 mb-[20px] border-t-[1px] border-[#DDE0E5] border-dashed" aria-hidden="true" />
    
    <!-- 제목 영역 -->
    <div class="flex items-center gap-2 mb-[16px]">
        <img 
            src="${pageContext.request.contextPath}/public/images/icons/ic-m-exclamation-16.svg" 
            alt=""
            class="w-4 h-4"
            aria-hidden="true" />
        <h3 class="text-[#3D444F] font-medium text-[14px] leading-[1.429em] tracking-[-0.05em] m-0">
            ${titleValue}
        </h3>
    </div>
    
    <!-- 항목 리스트 -->
    <ul class="flex flex-col gap-2 mb-[32px] list-none">
        <c:forEach var="item" items="${items}">
            <li class="flex items-start gap-[5px]">
                <span class="flex-shrink-0 w-[3px] h-[3px] rounded-full mt-[8px] ${item.isImportant != null && item.isImportant ? 'bg-[#EA2829]' : 'bg-[#ABB2BE]'}" 
                    aria-hidden="true"></span>
                <p class="flex-1 ${item.isImportant != null && item.isImportant ? 'text-[#EA2829]' : 'text-[#788497]'} font-normal text-[12px] leading-[1.5em] tracking-[-0.05em] m-0">
                    ${item.text}
                </p>
            </li>
        </c:forEach>
    </ul>
    
    <!-- 하단 버튼 -->
    <c:if test="${!empty buttonTextValue}">
        <button:Button 
            label="${buttonTextValue}"
            variant="gradient"
            size="medium"
            fullWidth="true"
            gradientFrom="#EA2869"
            gradientTo="#5A3FF2"
            onclick="${buttonOnClickValue}"
            ariaLabel="${buttonTextValue}"
            className="h-[48px] text-[16px]" />
    </c:if>
</section>

