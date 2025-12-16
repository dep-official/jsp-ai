<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/widgets/ProductCard" %>
<%@ taglib prefix="productLib" tagdir="/WEB-INF/tags/widgets/ProductCard/lib" %>
<%@ taglib prefix="features" tagdir="/WEB-INF/tags/features/carousel/lib" %>
<%@ attribute name="products" required="true" type="java.util.List<com.core.product.entity.Product>" %>
<%@ attribute name="className" required="false" %>
<%@ attribute name="maxItem" required="false" type="java.lang.Integer" %>
<%@ attribute name="showBrand" required="false" type="java.lang.Boolean" %>
<%@ attribute name="showMdKeyword" required="false" type="java.lang.Boolean" %>
<%@ attribute name="showDiscountPriceWon" required="false" type="java.lang.Boolean" %>
<%@ attribute name="showFlags" required="false" type="java.lang.Boolean" %>
<%@ variable name-given="sortedProducts" variable-class="java.util.List" scope="AT_END" %>

<%-- 정렬 로직 (공통 lib 사용) - maxItem 제한 적용 --%>
<%
    // maxItem이 설정되어 있으면 maxItems로 변환하여 lib에 전달
    Integer maxItemsVal = Integer.valueOf(12); // 기본값
    if (maxItem != null && maxItem > 0) {
        maxItemsVal = maxItem;
    }
    jspContext.setAttribute("maxItemsVal", maxItemsVal);
%>

<!-- 상품 정렬 (lib) -->
<productLib:ProductSorter products="${products}" maxItems="${maxItemsVal}" />

<!-- ID 생성 (lib) -->
<features:IdGenerator prefix="productGridSwiper" />
<c:set var="swiperId" value="${generatedId}" />

<!-- 리스트 분할 (lib) -->
<productLib:ListChunker list="${sortedProducts}" chunkSize="6" />

<!-- 상품 그리드 Carousel 위젯 (그리드 + 인디케이터) -->
<c:if test="${not empty sortedProducts}">
<div class="flex flex-col gap-[18px] ${className}">
    <div class="swiper ${swiperId} w-full h-auto">
        <ul class="swiper-wrapper">
            <c:forEach var="slide" items="${chunkedList}">
                <li class="swiper-slide w-full">
                    <product:ProductGridCols 
                        products="${slide}" 
                        className="grid-cols-3"
                        showBrand="${showBrand}"
                        showMdKeyword="${showMdKeyword}"
                        showDiscountPriceWon="${showDiscountPriceWon}"
                        showFlags="${showFlags}" />
                </li>
            </c:forEach>
        </ul>
    </div>
    <div class="swiper-pagination ${swiperId}-pagination relative mt-6 flex items-center justify-center gap-2"></div>
</div>

<!-- Swiper 인디케이터 초기화 (lib) -->
<productLib:SwiperIndicatorInit swiperId="${swiperId}" paginationClass="${swiperId}-pagination" />

</c:if>

