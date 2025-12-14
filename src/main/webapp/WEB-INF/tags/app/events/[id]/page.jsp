<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<%@ taglib prefix="banner" tagdir="/WEB-INF/tags/widgets/Banner" %>

<main class="w-full bg-white">
    <!-- KV 섹션 -->
    <c:set var="periodText" value="" />
    <c:if test="${KVBanner.startDate != null}">
        <fmt:formatDate value="${KVBanner.startDate}" pattern="yyyy.MM.dd" var="startDateFormatted" />
        <c:choose>
            <c:when test="${KVBanner.untilStockOut == true}">
                <c:set var="periodText" value="${startDateFormatted} - 재고소진시까지" />
            </c:when>
            <c:when test="${KVBanner.endDate != null}">
                <fmt:formatDate value="${KVBanner.endDate}" pattern="yyyy.MM.dd" var="endDateFormatted" />
                <c:set var="periodText" value="${startDateFormatted} - ${endDateFormatted}" />
            </c:when>
            <c:otherwise>
                <c:set var="periodText" value="${startDateFormatted}" />
            </c:otherwise>
        </c:choose>
    </c:if>
    <banner:KVBanner 
        imageUrl="${KVBanner.imageUrl}"
        period="${periodText}"
        title="${KVBanner.title}"
        subtitle="${KVBanner.subtitle}"
        bgColor="#C9E1FD"
      />
    
    <!-- Tab 섹션 -->
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
            <div class="mb-[96px]">
                <!-- Title 섹션 -->
                <div class="flex flex-col items-center mb-6 w-full">
                    <c:set var="arrowIconUrl" value="${pageContext.request.contextPath}/public/images/icons/ic-m-arrow-right.svg" />
                    <tag:Tag label="Event 1" variant="event" className="mb-2" />
                    <title:Title 
                        title="라네즈 세트 상품 구매시&#10;40% 할인"
                        subtitle="세트 구성으로 구매시 40% 할인"
                        className="mb-4" />
                    <ui:HashtagButton label="라네즈" icon="${arrowIconUrl}" active="false" />
                </div>
                
                <!-- ProductGridCarousel (3단 + 인디케이터) -->
                <c:if test="${productsForEvent1 != null and not empty productsForEvent1}">
                    <productCard:ProductGridCarousel 
                        products="${productsForEvent1}"
                        className="w-full" 
                        maxItem="12"
                        />
                </c:if>
            </div>
            
            <!-- Event 2: 설화수, 헤라 -->
            <div class="mb-[96px] last:mb-[64px]">
                <!-- Title 섹션 -->
                <div class="flex flex-col items-center mb-6 w-full">
                    <tag:Tag label="Event 2" variant="event" className="mb-2" />
                    <title:Title 
                        title="설화수, 헤라 세트 상품&#10;40% 할인"
                        subtitle="세트 구성으로 구매시 40% 할인"
                        className="mb-4" />
                    <!-- Hashtag 버튼들 (설화수, 헤라) -->
                    <div class="flex gap-1 items-center">
                        <ui:HashtagButton label="설화수" icon="${arrowIconUrl}" active="false" />
                        <ui:HashtagButton label="헤라" icon="${arrowIconUrl}" active="false" />
                    </div>
                </div>
                
                <!-- ProductGridCarousel (3단 + 인디케이터) -->
                <c:if test="${productsForEvent2 != null and not empty productsForEvent2}">
                    <productCard:ProductGridCarousel 
                        products="${productsForEvent2}"
                        className="w-full" 
                        maxItem="12"
                        />
                </c:if>
            </div>
        </div>
        
        <!-- 행사 브랜드 섹션 -->
        <c:if test="${brands != null and not empty brands}">
            <brand:BrandList title="행사 브랜드" brands="${brands}" className="mb-5 px-5 mb-[32px] container mx-auto max-w-[1080px]" />
        </c:if>
        <hr class="w-full h-0 border-0 mb-[20px] border-t-[1px] border-[#DDE0E5] border-dashed lg:hidden" aria-hidden="true" />

        <!-- 유의사항 및 버튼 섹션 -->
        <c:if test="${noticeItems != null and not empty noticeItems}">
            <notice:Notice
                title="유의사항"
                items="${noticeItems}"
                buttonText="더 많은 기획전 행사가 궁금하다면"
                buttonOnClick="console.log('더 많은 기획전 행사 클릭')"
                showDivider="false"
                className="px-5 mb-[32px] container mx-auto max-w-[1080px]" />
        </c:if>
    </section>
    
    <!-- 배경색 구분선 -->
    <div class="h-[8px] bg-[#EEF0F2] lg:hidden" aria-hidden="true"></div>
    
    <!-- 추천상품 섹션 -->
    <section id="section-recommended" class="px-5 py-6 max-w-[1080px] container mx-auto">
        <h2 class="text-[#1B1E23] font-bold text-[18px] leading-[1.5em] tracking-[-0.05em] mb-5">
            추천상품
        </h2>
        <c:if test="${recommendedProducts != null and not empty recommendedProducts}">
            <productCard:ProductCardCarousel 
                products="${recommendedProducts}"
                className="w-full" />
        </c:if>
    </section>
    
    <!-- 배경색 구분선 -->
    <div class="h-[8px] bg-[#EEF0F2] mb-[12px] lg:hidden" aria-hidden="true"></div>
    
    <!-- 전체상품 섹션 -->
    <section id="section-all" class="max-w-[1080px] mx-auto container">
        <!-- 할인율 탭 (Hashtag) -->
        <div class="flex z-20 gap-1 px-5 py-2 bg-white">
            <ui:HashtagButton label="아우구스티누스 바더" active="true" />
            <ui:HashtagButton label="아우구스티누스 바더" active="false" />
        </div>

        <!-- 정렬/필터링 바 -->
        <productFeature:ProductSortFilter
                totalCount="1234"
                showSoldOut="false"
                sortOption="베스트순"
                className="w-full sticky top-[56px] z-30 mb-[12px]" />

        <!-- 상품 그리드 -->
        <c:if test="${allProducts != null and not empty allProducts}">
        <div class="px-5 w-full">
             <productCard:ProductCardList 
                products="${allProducts}"
                className="w-full" />
        </div>
        </c:if>
        <c:if test="${allProducts == null or empty allProducts}">
            <div class="col-span-2 text-center py-8 text-[#5C6677]">상품이 없습니다.</div>
        </c:if>
    </section>
</main>

