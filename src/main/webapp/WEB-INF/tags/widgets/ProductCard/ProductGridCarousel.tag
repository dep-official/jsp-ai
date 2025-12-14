<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/widgets/ProductCard" %>
<%@ attribute name="products" required="true" type="java.util.List" %>
<%@ attribute name="className" required="false" %>
<%@ attribute name="maxItem" required="false" type="java.lang.Integer" %>
<%@ variable name-given="sortedProducts" variable-class="java.util.List" scope="AT_END" %>

<%-- 정렬 로직 (공통 lib 사용) - maxItem 제한 적용 --%>
<%
    // maxItem이 설정되어 있으면 maxItems로 변환하여 lib에 전달
    if (maxItem != null && maxItem > 0) {
        jspContext.setAttribute("maxItems", maxItem);
    } else {
        // 기본값: 12개 제한
        jspContext.setAttribute("maxItems", Integer.valueOf(12));
    }
%>
<%@ include file="/WEB-INF/tags/widgets/ProductCard/lib/ProductSorter.tag" %>

<%
    // 고유한 Swiper ID 생성
    String swiperId = "productGridSwiper_" + System.currentTimeMillis() + "_" + (int)(Math.random() * 1000);
    jspContext.setAttribute("swiperId", swiperId);
    
    // 6개씩 그룹화하여 슬라이드 리스트 생성
    int itemsPerSlide = 6;
    java.util.List<java.util.List<java.util.Map<String, Object>>> slides = new java.util.ArrayList<>();
    for (int i = 0; i < sortedProducts.size(); i += itemsPerSlide) {
        int end = Math.min(i + itemsPerSlide, sortedProducts.size());
        java.util.List<java.util.Map<String, Object>> slide = new java.util.ArrayList<>();
        for (int j = i; j < end; j++) {
            slide.add(sortedProducts.get(j));
        }
        slides.add(slide);
    }
    jspContext.setAttribute("slides", slides);
%>

<!-- 상품 그리드 Carousel 위젯 (3단 그리드 + 인디케이터) -->
<c:if test="${not empty sortedProducts}">
<div class="flex flex-col gap-[18px] ${className}">
    <div class="swiper ${swiperId} w-full h-auto">
        <ul class="swiper-wrapper">
            <c:forEach var="slide" items="${slides}">
                <li class="swiper-slide" style="width: 100%;">
                    <div class="flex flex-col gap-6 w-full">
                        <%
                            // 2행으로 분할 (각 행에 3개씩)
                            java.util.List<java.util.Map<String, Object>> slideList = (java.util.List<java.util.Map<String, Object>>) jspContext.getAttribute("slide");
                            java.util.List<java.util.Map<String, Object>> row1 = new java.util.ArrayList<>();
                            java.util.List<java.util.Map<String, Object>> row2 = new java.util.ArrayList<>();
                            if (slideList != null) {
                                for (int i = 0; i < slideList.size(); i++) {
                                    if (i < 3) {
                                        row1.add(slideList.get(i));
                                    } else {
                                        row2.add(slideList.get(i));
                                    }
                                }
                            }
                            jspContext.setAttribute("row1", row1);
                            jspContext.setAttribute("row2", row2);
                        %>
                        <!-- 첫 번째 행 (3단) -->
                        <div class="grid grid-cols-3 gap-[8px] lg:gap-[24px] w-full">
                            <c:forEach var="product" items="${row1}">
                                <div class="w-full min-w-0">
                                    <product:ProductCard 
                                        size="compact"
                                        imageUrl="${product.imageUrl}"
                                        brand="${product.brand}"
                                        mdKeyword="${product.mdKeyword}"
                                        name="${product.name}"
                                        originalPrice="${product.originalPrice}"
                                        discountRate="${product.discountRate}"
                                        discountPrice="${product.discountPrice}"
                                        discountPriceWon="${product.discountPriceWon}"
                                        showFlags="false"
                                        isSoldOut="${product.isSoldOut}"
                                        requiresAdultVerification="${product.requiresAdultVerification}"
                                        isAdultVerified="${product.isAdultVerified}"
                                        requiresLoginForDiscount="${product.requiresLoginForDiscount}"
                                        isLoggedIn="${product.isLoggedIn}" />
                                </div>
                            </c:forEach>
                        </div>
                        <!-- 두 번째 행 (3단) -->
                        <c:if test="${!empty row2}">
                            <div class="grid grid-cols-3 gap-[8px] lg:gap-[24px] w-full">
                                <c:forEach var="product" items="${row2}">
                                    <div class="w-full min-w-0">
                                        <product:ProductCard 
                                            size="compact"
                                            imageUrl="${product.imageUrl}"
                                            brand="${product.brand}"
                                            mdKeyword="${product.mdKeyword}"
                                            name="${product.name}"
                                            originalPrice="${product.originalPrice}"
                                            discountRate="${product.discountRate}"
                                            discountPrice="${product.discountPrice}"
                                            discountPriceWon="${product.discountPriceWon}"
                                            showFlags="false"
                                            isSoldOut="${product.isSoldOut}"
                                            requiresAdultVerification="${product.requiresAdultVerification}"
                                            isAdultVerified="${product.isAdultVerified}"
                                            requiresLoginForDiscount="${product.requiresLoginForDiscount}"
                                            isLoggedIn="${product.isLoggedIn}" />
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
    <!-- 인디케이터 (Swiper pagination) -->
    <div class="swiper-pagination ${swiperId}-pagination relative mt-6 flex items-center justify-center gap-2"></div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var swiperId = '${swiperId}';
        var swiperElement = document.querySelector('.' + swiperId);
        var paginationEl = '.' + swiperId + '-pagination';
        
        if (!swiperElement) {
            console.error('Swiper element not found:', '.' + swiperId);
            return;
        }
        
        var paginationContainer = document.querySelector(paginationEl);
        if (!paginationContainer) {
            console.error('Pagination container not found:', paginationEl);
            return;
        }
        
        // Swiper 기본 CSS의 position: absolute를 relative로 강제 오버라이드
        paginationContainer.style.setProperty('position', 'relative', 'important');
        paginationContainer.style.setProperty('text-align', 'center', 'important');
        
        var swiper = new Swiper('.' + swiperId, {
            slidesPerView: 1,
            spaceBetween: 0,
            autoHeight: true,
            pagination: {
                el: paginationContainer,
                clickable: true,
                renderBullet: function (index, className) {
                    var isActive = index === 0;
                    var bgColor = isActive ? '#1B1E23' : '#EBEBEB';
                    return '<span class="' + className + '" style="width: 8px !important; height: 8px !important; margin: 0 !important; opacity: 1 !important; border-radius: 50% !important; background-color: ' + bgColor + ' !important;"></span>';
                },
            },
        });
        
        // Swiper 초기화 완료 후 position 재설정
        swiper.on('init', function() {
            paginationContainer.style.setProperty('position', 'relative', 'important');
        });
        
        // 활성화된 인디케이터 스타일 적용
        swiper.on('slideChange', function () {
            var bullets = document.querySelectorAll(paginationEl + ' .swiper-pagination-bullet');
            bullets.forEach(function(bullet, index) {
                if (index === swiper.activeIndex) {
                    bullet.style.setProperty('background-color', '#1B1E23', 'important');
                } else {
                    bullet.style.setProperty('background-color', '#EBEBEB', 'important');
                }
            });
        });
    });
</script>
</c:if>

