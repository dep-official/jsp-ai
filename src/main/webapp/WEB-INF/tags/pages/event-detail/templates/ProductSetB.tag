<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="title" tagdir="/WEB-INF/tags/widgets/Title" %>
<%@ taglib prefix="tab" tagdir="/WEB-INF/tags/widgets/Tabs" %>
<%@ taglib prefix="productSet" tagdir="/WEB-INF/tags/widgets/ProductSet" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/widgets/ProductCard" %>
<%@ taglib prefix="productCard" tagdir="/WEB-INF/tags/widgets/ProductCard" %>
<%@ taglib prefix="brand" tagdir="/WEB-INF/tags/widgets/Brand" %>
<%@ taglib prefix="notice" tagdir="/WEB-INF/tags/widgets/Notice" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags/shared/ui/Button" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags/shared/ui/Tag" %>
<%@ taglib prefix="productFeature" tagdir="/WEB-INF/tags/features/product/ui" %>
<%@ taglib prefix="kvBanner" tagdir="/WEB-INF/tags/widgets/Banner" %>
<%@ taglib prefix="productList" tagdir="/WEB-INF/tags/widgets/ProductCard" %>
<%@ taglib prefix="productGridCarousel" tagdir="/WEB-INF/tags/widgets/ProductCard" %>

<%@ attribute name="event" required="true" type="com.core.event.entity.Event" %>
<%@ attribute name="products" required="false" type="java.util.List" %>
<%@ attribute name="eventProducts" required="false" type="java.util.List" %>
<%@ attribute name="recommendedProducts" required="false" type="java.util.List" %>
<%@ attribute name="brands" required="false" type="java.util.List" %>
<%@ attribute name="noticeItems" required="false" type="java.util.List" %>

<main class="w-full bg-white">
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
    <section id="section-event" class="pt-[48px]">
        <div class="px-5 container mx-auto max-w-[1080px]">
            <!-- Event 1: 라네즈 -->
            <div class="mb-[96px]" id="event1-section">
                <div class="flex flex-col items-center mb-6 w-full">
                    <c:set var="arrowIconUrl" value="${pageContext.request.contextPath}/public/images/icons/ic-m-arrow-right.svg" />
                    <tag:Tag label="Event 1" variant="event" className="mb-2" />
                    <title:Title 
                        title="라네즈 세트 상품 구매시&#10;40% 할인"
                        subtitle="세트 구성으로 구매시 40% 할인"
                        className="mb-4" />
                    <ui:HashtagButton label="라네즈" icon="${arrowIconUrl}" active="false" />
                </div>

                <div id="event1ProductsContainer" class="w-full">
                    <productGridCarousel:ProductGridCarousel 
                        products="${eventProducts}" 
                        showBrand="false"
                        showMdKeyword="false"
                        showDiscountPriceWon="false" />
                </div>
            </div>
            
            <!-- Event 2: 설화수, 헤라 -->
            <div class="mb-[96px] last:mb-[64px]" id="event2-section">
                <div class="flex flex-col items-center mb-6 w-full">
                    <tag:Tag label="Event 2" variant="event" className="mb-2" />
                    <title:Title 
                        title="설화수, 헤라 세트 상품&#10;40% 할인"
                        subtitle="세트 구성으로 구매시 40% 할인"
                        className="mb-4" />
                    <div class="flex gap-1 items-center">
                        <ui:HashtagButton label="설화수" icon="${arrowIconUrl}" active="false" />
                        <ui:HashtagButton label="헤라" icon="${arrowIconUrl}" active="false" />
                    </div>
                </div>
                
                <div id="event2ProductsContainer" class="w-full">
                    <productGridCarousel:ProductGridCarousel 
                        products="${eventProducts}" 
                        showBrand="false"
                        showMdKeyword="false"
                        showDiscountPriceWon="false" />
                </div>
            </div>
        </div>
        
        <!-- 행사 브랜드 -->
        <c:if test="${brands != null and not empty brands}">
            <brand:BrandList title="행사 브랜드" brands="${brands}" className="px-5 mb-[32px] container mx-auto max-w-[1080px]" />
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
