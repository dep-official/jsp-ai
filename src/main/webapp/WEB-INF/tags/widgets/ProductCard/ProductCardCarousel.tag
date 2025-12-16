<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/widgets/ProductCard" %>
<%@ taglib prefix="lib" tagdir="/WEB-INF/tags/widgets/ProductCard/lib" %>
<%@ taglib prefix="features" tagdir="/WEB-INF/tags/features/carousel/lib" %>
<%@ attribute name="products" required="true" type="java.util.List" %>
<%@ attribute name="className" required="false" %>
<%@ attribute name="showBrand" required="false" type="java.lang.Boolean" %>
<%@ attribute name="showMdKeyword" required="false" type="java.lang.Boolean" %>
<%@ attribute name="showDiscountPriceWon" required="false" type="java.lang.Boolean" %>
<%@ attribute name="showFlags" required="false" type="java.lang.Boolean" %>
<%@ variable name-given="sortedProducts" variable-class="java.util.List" scope="AT_END" %>

<!-- 상품 정렬 lib -->
<lib:ProductSorter products="${products}" />

<!-- ID 생성 (lib) -->
<features:IdGenerator prefix="productCardSwiper" />
<c:set var="swiperId" value="${generatedId}" />

<!-- 상품 카드 Carousel 위젯 -->
<c:if test="${not empty sortedProducts}">
<div class="relative ${className}">
    <div class="swiper ${swiperId}">
        <ul class="swiper-wrapper">
            <c:forEach var="product" items="${sortedProducts}">
                <li class="w-1/3 min-w-[120px] swiper-slide lg:w-1/4">
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
                        showBrand="${showBrand}"
                        showMdKeyword="${showMdKeyword}"
                        showDiscountPriceWon="${showDiscountPriceWon}"
                        showFlags="${showFlags}"
                        isSoldOut="${product.isSoldOut}"
                        requiresAdultVerification="${product.requiresAdultVerification}"
                        isAdultVerified="${product.isAdultVerified}"
                        requiresLoginForDiscount="${product.requiresLoginForDiscount}"
                        isLoggedIn="${product.isLoggedIn}" />
                </li>
            </c:forEach>
        </ul>
    </div>
    
    <!-- 네비게이션 버튼 (PC에서만 표시) -->
    <button type="button" class="swiper-button-prev-${swiperId} hidden lg:flex absolute top-1/3 -translate-y-1/3 left-[-20px] z-10 w-[40px] h-[40px] items-center justify-center bg-white rounded-full shadow-[0_2px_8px_0_rgba(0,0,0,0.1)] disabled:opacity-0 disabled:cursor-default transition-opacity duration-200" aria-label="이전 상품">
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M15 18L9 12L15 6" stroke="#1B1E23" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
    </button>
    <button type="button" class="swiper-button-next-${swiperId} hidden lg:flex absolute top-1/3 -translate-y-1/3 right-[-20px] z-10 w-[40px] h-[40px] items-center justify-center bg-white rounded-full shadow-[0_2px_8px_0_rgba(0,0,0,0.1)] disabled:opacity-0 disabled:cursor-default transition-opacity duration-200" aria-label="다음 상품">
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M9 18L15 12L9 6" stroke="#1B1E23" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
    </button>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        new Swiper('.${swiperId}', {
            slidesPerView: 'auto',
            spaceBetween: 16,
            freeMode: true,
            grabCursor: true,
            navigation: {
                nextEl: '.swiper-button-next-${swiperId}',
                prevEl: '.swiper-button-prev-${swiperId}',
            },
            breakpoints: {
                1200: {
                    slidesPerView: 4,
                    spaceBetween: 24,
                    freeMode: false,
                },
            },
        });
    });
</script>
</c:if>
