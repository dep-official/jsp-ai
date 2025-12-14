<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="originalPrice" required="false" %>
<%@ attribute name="discountPrice" required="true" %>
<%@ attribute name="discountRate" required="false" %>
<%@ attribute name="currency" required="false" %>
<%@ attribute name="onAddToCart" required="false" %>
<%@ attribute name="disabled" required="false" type="java.lang.Boolean" %>
<%@ attribute name="className" required="false" %>

<%
    // currency 기본값
    String currencyValue = (String) jspContext.getAttribute("currency");
    if (currencyValue == null || currencyValue.isEmpty()) {
        currencyValue = "$";
    }
    jspContext.setAttribute("currencyValue", currencyValue);
    
    // discountRate 기본값
    String discountRateValue = (String) jspContext.getAttribute("discountRate");
    if (discountRateValue == null || discountRateValue.isEmpty()) {
        discountRateValue = "";
    }
    jspContext.setAttribute("discountRateValue", discountRateValue);
    
    // disabled 처리
    Boolean disabledValue = (Boolean) jspContext.getAttribute("disabled");
    if (disabledValue == null) {
        disabledValue = false;
    }
    String disabledStr = disabledValue ? "true" : "false";
    jspContext.setAttribute("disabledStr", disabledStr);
    
    // onAddToCart 기본값
    String onAddToCartValue = (String) jspContext.getAttribute("onAddToCart");
    if (onAddToCartValue == null) {
        onAddToCartValue = "";
    }
    jspContext.setAttribute("onAddToCartValue", onAddToCartValue);
%>

<!-- 제품 가격 및 장바구니 바 -->
<div class="flex items-center justify-between w-full h-[47px] ${className}">
    <!-- 가격 정보 영역 -->
    <dl class="flex flex-col">
        <!-- 할인적용가 및 원가 -->
        <dt class="flex items-center gap-[4px]">
            <span class="text-[#1B1E23] font-bold text-[13px] leading-[1.462em] tracking-[-0.05em]">
                할인적용가
            </span>
            <c:if test="${!empty originalPrice}">
                <span class="text-[#ABB2BE] font-normal text-[14px] leading-[1.429em] tracking-[-0.05em] line-through">
                    ${currencyValue}${originalPrice}
                </span>
            </c:if>
        </dt>
        
        <!-- 할인가 및 할인율 -->
        <dd class="flex items-center gap-[4px]">
            <c:if test="${!empty discountRateValue}">
                <span class="text-[#1B1E23] font-bold text-[18px] leading-[1.5em] tracking-[-0.05em]">
                    ${discountRateValue}%
                </span>
            </c:if>
            <span class="text-[#EA2829] font-bold text-[18px] leading-[1.5em] tracking-[-0.05em]">
                ${currencyValue}${discountPrice}
            </span>
        </dd>
    </dl>
    
    <!-- 장바구니 담기 버튼 -->
    <button 
        type="button"
        class="flex items-center justify-center gap-[4px] px-[12px] py-[6px] pr-[14px] pb-[7px] bg-[#1B1E23] text-white rounded-[4px] hover:bg-[#2B2F35] active:bg-[#16181D] transition-colors duration-200 ease-smooth disabled:opacity-50 disabled:cursor-not-allowed"
        <c:if test="${!empty onAddToCartValue}">onclick="${onAddToCartValue}"</c:if>
        <c:if test="${disabledValue}">disabled</c:if>
        aria-label="장바구니에 담기">
        <img 
            src="${pageContext.request.contextPath}/public/images/icons/ic-m-shoppinbag-16.svg" 
            alt=""
            class="w-4 h-4"
            aria-hidden="true" />
        <span class="text-white font-medium text-[13px] leading-[1.462em] tracking-[-0.05em]">
            담기
        </span>
    </button>
</div>

