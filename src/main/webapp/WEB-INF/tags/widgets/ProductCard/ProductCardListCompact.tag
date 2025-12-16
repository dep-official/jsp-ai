<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/widgets/ProductCard" %>
<%@ taglib prefix="lib" tagdir="/WEB-INF/tags/widgets/ProductCard/lib" %>
<%@ attribute name="products" required="true" type="java.util.List" %>
<%@ attribute name="className" required="false" %>
<%@ variable name-given="sortedProducts" variable-class="java.util.List" scope="AT_END" %>

<!-- 상품 정렬 (lib) -->
<lib:ProductSorter products="${products}" />

<!-- 상품 리스트 위젯 (3단 그리드) -->
<div class="grid grid-cols-3 gap-x-[8px] gap-y-8 w-full ${className}">
    <c:forEach var="product" items="${sortedProducts}">
        <product:ProductCard 
            size="compact"
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

