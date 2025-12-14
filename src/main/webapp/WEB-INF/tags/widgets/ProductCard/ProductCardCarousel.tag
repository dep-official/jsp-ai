<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/widgets/ProductCard" %>
<%@ attribute name="products" required="true" type="java.util.List" %>
<%@ attribute name="className" required="false" %>
<%@ variable name-given="sortedProducts" variable-class="java.util.List" scope="AT_END" %>

<%-- 정렬 로직 (공통 lib 사용) --%>
<%@ include file="/WEB-INF/tags/widgets/ProductCard/lib/ProductSorter.tag" %>

<%
    // 고유한 Swiper ID 생성
    String swiperId = "productCardSwiper_" + System.currentTimeMillis() + "_" + (int)(Math.random() * 1000);
    jspContext.setAttribute("swiperId", swiperId);
%>

<!-- 상품 카드 Carousel 위젯 -->
<c:if test="${not empty sortedProducts}">
<div class="swiper ${swiperId} ${className}">
    <ul class="swiper-wrapper">
        <c:forEach var="product" items="${sortedProducts}">
            <li class="w-1/3 min-w-[120px] swiper-slide lg:w-1/4">
                <product:ProductCard 
                    imageUrl="${product.imageUrl}"
                    brand="${product.brand}"
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
            </li>
        </c:forEach>
    </ul>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        new Swiper('.${swiperId}', {
            slidesPerView: 'auto',
            spaceBetween: 16,
            freeMode: true,
            grabCursor: true,
            // 2. 반응형 설정
            breakpoints: {
                // 1200px 이상일 때 적용
                1200: {
                slidesPerView: 4,
                spaceBetween: 24,
                },
            },
        });
    });
</script>
</c:if>


