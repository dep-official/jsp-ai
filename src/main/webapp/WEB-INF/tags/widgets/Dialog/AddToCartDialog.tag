<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dialogHeader" tagdir="/WEB-INF/tags/widgets/Dialog/ui/DialogHeader" %>
<%@ taglib prefix="productSetItemList" tagdir="/WEB-INF/tags/shared/ui/List" %>
<%@ taglib prefix="addToCartButton" tagdir="/WEB-INF/tags/features/cart/ui" %>
<%@ taglib prefix="dialogScript" tagdir="/WEB-INF/tags/widgets/Dialog/lib" %>
<%@ attribute name="id" required="false" %>
<%@ attribute name="open" required="false" type="java.lang.Boolean" %>
<%@ attribute name="title" required="true" %>
<%@ attribute name="products" required="true" type="java.util.List" %>
<%@ attribute name="productId" required="true" %>
<%@ attribute name="productName" required="false" %>
<%@ attribute name="discountRate" required="false" %>
<%@ attribute name="quantity" required="false" type="java.lang.Integer" %>
<%@ attribute name="onAddToCart" required="false" %>
<%@ attribute name="onQuantityChange" required="false" %>
<%@ attribute name="min" required="false" type="java.lang.Integer" %>
<%@ attribute name="max" required="false" type="java.lang.Integer" %>
<%@ attribute name="disabled" required="false" type="java.lang.Boolean" %>
<%@ attribute name="showCloseButton" required="false" type="java.lang.Boolean" %>
<%@ attribute name="onClose" required="false" %>
<%@ attribute name="className" required="false" %>

<%
    // open 기본값
    Boolean isOpen = (Boolean) jspContext.getAttribute("open");
    if (isOpen == null) {
        isOpen = false;
    }
    jspContext.setAttribute("isOpen", isOpen);
%>

<!-- 장바구니 담기 다이얼로그 -->
<dialog
    <c:if test="${!empty id}">id="${id}"</c:if>
    role="dialog"
    aria-labelledby="dialog-title"
    aria-modal="true"
    class="w-full max-w-[335px] rounded-[8px] bg-white shadow-lg p-0 backdrop:bg-black/50 ${className}"
    <c:if test="${isOpen}">open</c:if>>
    
    <!-- 다이얼로그 헤더 -->
    <dialogHeader:DialogHeader 
        title="${title}"
        showCloseButton="${showCloseButton != false}"
        onClose="${onClose}" />
        
    <!-- 세트 정보: 할인율 및 제품명 -->
    <c:if test="${!empty discountRate || !empty productName}">
        <div class="flex items-center gap-[16px] px-5 pb-2 h-full">
            <!-- 할인율 -->
            <c:if test="${!empty discountRate}">
                <span class="text-[#EA2829] font-bold text-[24px] leading-[0.833em] w-[44px] h-[20px] font-['Times_New_Roman']">
                    ${discountRate}%
                </span>
            </c:if>
            <!-- 제품명 -->
            <c:if test="${!empty productName}">
                <p class="text-[#1B1E23] font-bold text-[14px] leading-[1.429em] tracking-[-0.05em] h-[40px] flex items-center flex-1">
                    ${productName}
                </p>
            </c:if>
        </div>
    </c:if>

    <!-- 다이얼로그 내용: 제품 리스트 -->
    <div class="px-5 py-4 overflow-y-auto max-h-[40vh]">
        <productSetItemList:ProductSetItemList 
            products="${products}"
            className="" />
    </div>
    
    <!-- 장바구니 담기 버튼 -->
    <addToCartButton:AddToCartButton 
    productId="${productId}"
    quantity="${quantity}"
    onAddToCart="${onAddToCart}"
    onQuantityChange="${onQuantityChange}"
    min="${min}"
    max="${max}"
    disabled="${disabled}"
    className="" />
</dialog>

<c:if test="${!empty id}">
    <dialogScript:DialogScript dialogId="${id}" />
</c:if>

