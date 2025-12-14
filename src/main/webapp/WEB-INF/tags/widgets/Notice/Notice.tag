<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="button" tagdir="/WEB-INF/tags/shared/ui/Button" %>
<%@ attribute name="title" required="false" %>
<%@ attribute name="items" required="true" type="java.util.List" %>
<%@ attribute name="buttonText" required="false" %>
<%@ attribute name="buttonOnClick" required="false" %>
<%@ attribute name="showDivider" required="false" type="java.lang.Boolean" %>
<%@ attribute name="className" required="false" %>

<%
    // title 기본값
    String titleValue = (String) jspContext.getAttribute("title");
    if (titleValue == null || titleValue.isEmpty()) {
        titleValue = "유의사항";
    }
    jspContext.setAttribute("titleValue", titleValue);
    
    // buttonText 기본값
    String buttonTextValue = (String) jspContext.getAttribute("buttonText");
    if (buttonTextValue == null || buttonTextValue.isEmpty()) {
        buttonTextValue = "더 많은 사은행사가 궁금하다면";
    }
    jspContext.setAttribute("buttonTextValue", buttonTextValue);
    
    // showDivider 기본값
    Boolean showDividerValue = (Boolean) jspContext.getAttribute("showDivider");
    if (showDividerValue == null) {
        showDividerValue = true;
    }
    jspContext.setAttribute("showDividerValue", showDividerValue);
    
    // buttonOnClick 기본값
    String buttonOnClickValue = (String) jspContext.getAttribute("buttonOnClick");
    if (buttonOnClickValue == null) {
        buttonOnClickValue = "";
    }
    jspContext.setAttribute("buttonOnClickValue", buttonOnClickValue);
%>

<!-- 유의사항 섹션 -->
<section class="flex flex-col w-full ${className}" aria-label="유의사항">
    <!-- 상단 점선 구분선 -->
    <c:if test="${showDividerValue}">
        <hr class="w-full h-0 border-0 border-t-[1px] border-[#DDE0E5] border-dashed mb-5" aria-hidden="true" />
    </c:if>
    
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
                <!-- 불릿 포인트 -->
                <span class="flex-shrink-0 w-[3px] h-[3px] rounded-full mt-[8px] ${item.isImportant != null && item.isImportant ? 'bg-[#EA2829]' : 'bg-[#ABB2BE]'}" 
                    aria-hidden="true"></span>
                <!-- 텍스트 -->
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

