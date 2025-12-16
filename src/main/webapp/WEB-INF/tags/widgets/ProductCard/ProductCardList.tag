<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/widgets/ProductCard" %>
<%@ taglib prefix="lib" tagdir="/WEB-INF/tags/widgets/ProductCard/lib" %>
<%@ attribute name="products" required="true" type="java.util.List<com.core.product.entity.Product>" %>
<%@ attribute name="className" required="false" %>
<%@ variable name-given="sortedProducts" variable-class="java.util.List" scope="AT_END" %>

<!-- 상품 정렬 lib -->
<lib:ProductSorter products="${products}" />

<!-- 상품 리스트 위젯 (2단 그리드) -->
<div class="grid grid-cols-2 lg:grid-cols-4 gap-x-[9px] gap-y-8 lg:gap-x-[24px] lg:gap-y-[48px] w-full ${className}">
    <c:forEach var="product" items="${sortedProducts}">
        <product:ProductCard 
            imageUrl="${product.imageUrl}"
            brand="${product.brandName}"
            mdKeyword="${product.mdKeyword}"
            name="${product.name}"
            originalPrice="${product.originalPrice}"
            discountRate="${product.discountRate}"
            discountPrice="${product.discountPrice}"
            discountPriceWon="${product.discountPriceWon}"
            flags="${product.flags}"
            isSoldOut="${product.isSoldOut}"
            requiresAdultVerification="${product.requiresAdultVerification}"
            isAdultVerified="${product.isAdultVerified}"
            requiresLoginForDiscount="${product.requiresLoginForDiscount}"
            isLoggedIn="${product.isLoggedIn}" />
    </c:forEach>
</div>

