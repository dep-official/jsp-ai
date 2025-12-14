<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="quantity" required="false" type="java.lang.Integer" %>
<%@ attribute name="onDecrease" required="false" %>
<%@ attribute name="onIncrease" required="false" %>
<%@ attribute name="min" required="false" type="java.lang.Integer" %>
<%@ attribute name="max" required="false" type="java.lang.Integer" %>
<%@ attribute name="disabled" required="false" type="java.lang.Boolean" %>
<%@ attribute name="className" required="false" %>

<%
    // quantity 기본값
    Integer quantityValue = (Integer) jspContext.getAttribute("quantity");
    if (quantityValue == null) {
        quantityValue = 1;
    }
    jspContext.setAttribute("quantityValue", quantityValue);
    
    // min, max 기본값
    Integer minValue = (Integer) jspContext.getAttribute("min");
    if (minValue == null) {
        minValue = 1;
    }
    jspContext.setAttribute("minValue", minValue);
    
    Integer maxValue = (Integer) jspContext.getAttribute("max");
    // max가 설정되지 않으면 무한대로 간주
    jspContext.setAttribute("maxValue", maxValue);
    
    // disabled 기본값 (Boolean 또는 String "true"/"false" 처리)
    Object disabledObj = jspContext.getAttribute("disabled");
    Boolean isDisabled = false;
    if (disabledObj != null) {
        if (disabledObj instanceof Boolean) {
            isDisabled = (Boolean) disabledObj;
        } else if (disabledObj instanceof String) {
            isDisabled = Boolean.parseBoolean((String) disabledObj);
        }
    }
    jspContext.setAttribute("isDisabled", isDisabled);
    
    // onDecrease, onIncrease 기본값 및 속성 문자열 생성
    String onDecreaseValue = (String) jspContext.getAttribute("onDecrease");
    if (onDecreaseValue == null) {
        onDecreaseValue = "";
    }
    String decreaseOnclickAttr = onDecreaseValue.isEmpty() ? "" : "onclick=\"" + onDecreaseValue + "\"";
    jspContext.setAttribute("decreaseOnclickAttr", decreaseOnclickAttr);
    
    String onIncreaseValue = (String) jspContext.getAttribute("onIncrease");
    if (onIncreaseValue == null) {
        onIncreaseValue = "";
    }
    String increaseOnclickAttr = onIncreaseValue.isEmpty() ? "" : "onclick=\"" + onIncreaseValue + "\"";
    jspContext.setAttribute("increaseOnclickAttr", increaseOnclickAttr);
    
    // disabled 속성 문자열 생성
    int qty = quantityValue.intValue();
    boolean canDecrease = qty > minValue && !isDisabled;
    boolean canIncrease = (maxValue == null || qty < maxValue) && !isDisabled;
    String decreaseDisabledAttr = canDecrease ? "" : "disabled";
    String increaseDisabledAttr = canIncrease ? "" : "disabled";
    jspContext.setAttribute("decreaseDisabledAttr", decreaseDisabledAttr);
    jspContext.setAttribute("increaseDisabledAttr", increaseDisabledAttr);
%>

<!-- 수량 조절 버튼 (+ -) -->
<div class="inline-flex items-center gap-2 ${className}">
    <!-- 감소 버튼 (-) -->
    <button
        type="button"
        class="flex items-center justify-center w-[32px] h-[32px] rounded-[4px] bg-white text-[#1B1E23] hover:bg-[#F4F5F7] active:bg-[#E9EBEF] disabled:opacity-50 disabled:cursor-not-allowed focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2 transition-colors duration-200 ease-smooth"
        aria-label="수량 감소"
        ${decreaseDisabledAttr}
        ${decreaseOnclickAttr}>
        <img 
            src="${pageContext.request.contextPath}/public/images/icons/ic-m-minus.svg" 
            alt="감소" 
            class="w-4 h-4" />
    </button>
    
    <!-- 수량 표시 -->
    <span class="min-w-[20px] text-center text-[14px] font-medium leading-[1.43em] tracking-[-0.05em] text-[#1B1E23]">
        ${quantityValue}
    </span>
    
    <!-- 증가 버튼 (+) -->
    <button
        type="button"
        class="flex items-center justify-center w-[32px] h-[32px] rounded-[4px] bg-white text-[#1B1E23] hover:bg-[#F4F5F7] active:bg-[#E9EBEF] disabled:opacity-50 disabled:cursor-not-allowed focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2 transition-colors duration-200 ease-smooth"
        aria-label="수량 증가"
        ${increaseDisabledAttr}
        ${increaseOnclickAttr}>
        <img 
            src="${pageContext.request.contextPath}/public/images/icons/ic-m-plus.svg" 
            alt="증가" 
            class="w-4 h-4" />
    </button>
</div>

