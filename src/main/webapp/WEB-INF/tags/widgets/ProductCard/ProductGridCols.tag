<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/widgets/ProductCard" %>
<%@ attribute name="products" required="true" type="java.util.List" %>
<%@ attribute name="className" required="false" %>
<%@ attribute name="showBrand" required="false" type="java.lang.Boolean" %>
<%@ attribute name="showMdKeyword" required="false" type="java.lang.Boolean" %>
<%@ attribute name="showDiscountPriceWon" required="false" type="java.lang.Boolean" %>
<%@ attribute name="showFlags" required="false" type="java.lang.Boolean" %>

<ul class="grid gap-[8px] lg:gap-[24px] w-full ${className}">
    <c:forEach var="product" items="${products}">
        <li class="w-full">
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
                showFlags="${showFlags}"
                showBrand="${showBrand}"
                showMdKeyword="${showMdKeyword}"
                showDiscountPriceWon="${showDiscountPriceWon}"
                isSoldOut="${product.isSoldOut}"
                requiresAdultVerification="${product.requiresAdultVerification}"
                isAdultVerified="${product.isAdultVerified}"
                requiresLoginForDiscount="${product.requiresLoginForDiscount}"
                isLoggedIn="${product.isLoggedIn}" />
        </li>
    </c:forEach>
</ul>
