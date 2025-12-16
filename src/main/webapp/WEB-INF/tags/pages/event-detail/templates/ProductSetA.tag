<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="brand" tagdir="/WEB-INF/tags/widgets/Brand" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags/shared/ui/Tag" %>
<%@ taglib prefix="tab" tagdir="/WEB-INF/tags/widgets/Tabs" %>
<%@ taglib prefix="title" tagdir="/WEB-INF/tags/shared/ui/Title" %>
<%@ taglib prefix="productSet" tagdir="/WEB-INF/tags/widgets/ProductSet" %>
<%@ taglib prefix="ProductCard" tagdir="/WEB-INF/tags/widgets/ProductCard" %>
<%@ taglib prefix="productCard" tagdir="/WEB-INF/tags/widgets/ProductCard" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/widgets/ProductCard" %>
<%@ taglib prefix="kvBanner" tagdir="/WEB-INF/tags/widgets/Banner" %>
<%@ taglib prefix="notice" tagdir="/WEB-INF/tags/widgets/Notice" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags/shared/ui/Button" %>
<%@ taglib prefix="productFeature" tagdir="/WEB-INF/tags/features/product/ui" %>
<%@ attribute name="event" required="true" type="com.core.event.entity.Event" %>
<%@ attribute name="products" required="false" type="java.util.List" %>
<%@ attribute name="eventProducts" required="false" type="java.util.List" %>
<%@ attribute name="recommendedProducts" required="false" type="java.util.List" %>
<%@ attribute name="brands" required="false" type="java.util.List" %>
<%@ attribute name="noticeItems" required="false" type="java.util.List" %>

<main>
    <section>
        <!-- KV 섹션 -->
        <c:set var="periodText" value="" />
        <c:if test="${event.startDate != null}">
            <%
                com.core.event.entity.Event evt = (com.core.event.entity.Event) jspContext.getAttribute("event");
                java.time.format.DateTimeFormatter dtf = java.time.format.DateTimeFormatter.ofPattern("yyyy.MM.dd");
                String start = evt.getStartDate() != null ? evt.getStartDate().format(dtf) : "";
                String end = evt.getEndDate() != null ? evt.getEndDate().format(dtf) : "";
                jspContext.setAttribute("startDateFormatted", start);
                jspContext.setAttribute("endDateFormatted", end);
            %>
            <c:choose>
                <c:when test="${event.untilStockOut == true}">
                    <c:set var="periodText" value="${startDateFormatted} - 재고소진시까지" />
                </c:when>
                <c:when test="${event.endDate != null}">
                    <c:set var="periodText" value="${startDateFormatted} - ${endDateFormatted}" />
                </c:when>
                <c:otherwise>
                    <c:set var="periodText" value="${startDateFormatted} -" />
                </c:otherwise>
            </c:choose>
        </c:if>
        <kvBanner:KVBanner
            imageUrl="${event.imageUrl}"
            period="${periodText}"
            title="${event.title}"
            subtitle="${event.subtitle}"
            bgColor="#C9E1FD"
        />
    </section>

    <!-- Tab -->
    <section class="sticky top-0 z-40 bg-white border-b border-[#DDE0E5] lg:border-0">
        <tab:Tabs 
            tabs="행사,추천상품,전체상품" 
            activeTab="0" 
            size="primary" 
            className="h-[56px]"
            tabBarHeight="56" />
    </section>
    
    <!-- 행사 섹션 -->
    <section id="section-event" class="pt-[48px] mb-[96px] container mx-auto max-w-[1080px]">
        <div class="flex flex-col items-center mb-6 w-full">
            <tag:Tag label="Event 1" variant="event" className="mb-2" />
            <title:Title 
                title="라네즈 외 7개 브랜드<br/> 40% 할인"
                subtitle="7개 브랜드의 SUN 제품을 40% 할인가에 만나보세요!"
                className="mb-4" />
        </div>
        <c:if test="${brands != null and not empty brands}">
                <brand:BrandListCarousel 
                    brands="${brands}" 
                    className="mb-[32px] w-full hidden lg:block" />
                <brand:BrandList
                    brands="${brands}" 
                    className="mb-[32px] w-full lg:hidden" />
            </c:if>
    </section>


    <section class="mb-[96px] container mx-auto max-w-[1080px]" id="event2-section">
        <div class="flex flex-col items-center mb-6 w-full">
            <tag:Tag label="Event 2" variant="event" className="mb-2" />
            <title:Title 
                title="햇살 가리는 SUN 제품<br/> 70% 할인"
                subtitle="7개 브랜드의 SUN 제품을 70% 할인가에 만나보세요!"
                className="mb-4" />
        </div>
        
        <ProductCard:ProductGridCarousel 
            products="${eventProducts}" 
            showBrand="false"
            showMdKeyword="false"
            showDiscountPriceWon="false" />
    </section>    


    <section>
         <div class="flex flex-col gap-4">
                <%
                    java.util.List<java.util.Map<String, Object>> cardThumbnails = new java.util.ArrayList<>();
                    String cardContextPath = request.getContextPath();
                    
                    // 썸네일 데이터 추가 (13개로 설정하여 +9 표시 테스트)
                    for (int i = 1; i <= 13; i++) {
                        java.util.Map<String, Object> thumb = new java.util.HashMap<>();
                        thumb.put("imageUrl", cardContextPath + "/public/images/products/product-" + ((i % 2 == 0) ? "8" : "9") + ".jpg");
                        thumb.put("alt", "제품 " + i);
                        cardThumbnails.add(thumb);
                    }
                    
                    jspContext.setAttribute("cardThumbnails", cardThumbnails);
                %>
                <productSet:ProductSetCard 
                    imageUrl=""
                    tagLabel="Event 1"
                    title="해를 가려라, SUN 제품<br/> 세트상품 10% 할인"
                    subtitle="종아리 마사지기 V3 지퍼 벨크로형 + 무선 목어깨 마사지기"
                    thumbnails="${cardThumbnails}"
                    originalPrice="176"
                    discountPrice="112.64"
                    discountRate="36"
                    currency="$"
                    onAddToCart="console.log('장바구니에 담기')"
                    disabled="false"
                    className="mx-auto" />
            </div>
    </section>

    <section>
        <!-- 행사 브랜드 -->
        <c:if test="${brands != null and not empty brands}">
            <brand:BrandList title="브랜드관" brands="${brands}" className="px-5 mb-[32px] container mx-auto max-w-[1080px]" />
        </c:if>

        <!-- 유의사항 -->
        <c:if test="${noticeItems != null and not empty noticeItems}">
            <notice:Notice
                title="유의사항"
                items="${noticeItems}"
                buttonText="더 많은 기획전 행사가 궁금하다면"
                buttonOnClick="console.log('더 많은 기획전 행사 클릭')"
                className="px-5 mb-[32px] container mx-auto max-w-[1080px]" />
        </c:if>
    </section>

   <hr class="h-[8px] bg-[#EEF0F2] lg:hidden" aria-hidden="true"></hr>
    
    <!-- 추천상품 -->
    <section id="section-recommended" class="px-5 py-6 max-w-[1080px] container mx-auto">
        <h2 class="text-[#1B1E23] font-bold text-[18px] leading-[1.5em] tracking-[-0.05em] mb-5">
            추천상품
        </h2>
        <c:if test="${recommendedProducts != null and not empty recommendedProducts}">
            <productCard:ProductCardCarousel 
                products="${recommendedProducts}"
                showFlags="false"
                className="w-full" />
        </c:if>
    </section>
    
    <hr class="h-[8px] bg-[#EEF0F2] mb-[12px] lg:hidden" aria-hidden="true"></hr>
    
    <!-- 전체상품 -->
    <section id="section-all" class="max-w-[1080px] mx-auto container">
        
        <div class="flex z-20 gap-1 px-5 py-2 bg-white">
            <ui:HashtagButton label="아우구스티누스 바더" active="true" />
            <ui:HashtagButton label="아우구스티누스 바더" active="false" />
        </div>

        <!-- 정렬/필터링 바 -->
        <productFeature:ProductSortFilter
                id="productSortFilter"
                totalCount="${fn:length(products)}"
                showSoldOut="true"
                sortOption="베스트순"
                className="w-full sticky top-[56px] z-30 mb-[12px]" />

         <div id="allProductsContainer" class="px-5 w-full">
            <product:ProductCardList products="${products}" />
         </div>
    </section>
</main>
