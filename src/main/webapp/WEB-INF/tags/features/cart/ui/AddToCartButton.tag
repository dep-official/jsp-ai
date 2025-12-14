<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="button" tagdir="/WEB-INF/tags/shared/ui/Button" %>
<%@ attribute name="productId" required="true" %>
<%@ attribute name="quantity" required="false" type="java.lang.Integer" %>
<%@ attribute name="onAddToCart" required="false" %>
<%@ attribute name="onQuantityChange" required="false" %>
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
    
    // onAddToCart 기본값
    String onAddToCartValue = (String) jspContext.getAttribute("onAddToCart");
    if (onAddToCartValue == null) {
        onAddToCartValue = "";
    }
    jspContext.setAttribute("onAddToCartValue", onAddToCartValue);
    
    // onQuantityChange 기본값
    String onQuantityChangeValue = (String) jspContext.getAttribute("onQuantityChange");
    if (onQuantityChangeValue == null) {
        onQuantityChangeValue = "";
    }
    jspContext.setAttribute("onQuantityChangeValue", onQuantityChangeValue);
    
    // disabled 처리
    Boolean disabledValue = (Boolean) jspContext.getAttribute("disabled");
    if (disabledValue == null) {
        disabledValue = false;
    }
    String disabledStr = disabledValue ? "true" : "false";
    jspContext.setAttribute("disabledStr", disabledStr);
%>

<!-- 장바구니 담기 버튼 -->
<div class="relative border-t border-[#DDE0E5] h-[88px] w-full ${className}">
    <div class="px-5 flex items-center gap-[42px] h-full">
        <!-- 수량 조절 버튼 -->
        <button:QuantityButton 
            quantity="${quantityValue}"
            onDecrease="${onQuantityChangeValue}"
            onIncrease="${onQuantityChangeValue}"
            min="${min}"
            max="${max}"
            disabled="${disabledStr}" />
        
        <!-- 장바구니 담기 버튼 -->
        <button:Button 
            label="장바구니 담기"
            variant="filled"
            size="medium"
            fullWidth="true"
            ariaLabel="장바구니에 담기"
            onclick="${onAddToCartValue}"
            disabled="${disabledStr}"
            className="flex-1" />
    </div>
</div>

