<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tab" tagdir="/WEB-INF/tags/widgets/Tabs" %>
<%@ taglib prefix="title" tagdir="/WEB-INF/tags/widgets/Title" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags/shared/ui/Button" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags/shared/ui/Tag" %>
<%@ taglib prefix="badge" tagdir="/WEB-INF/tags/shared/ui/Badge" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/widgets/ProductCard" %>
<%@ taglib prefix="banner" tagdir="/WEB-INF/tags/widgets/Banner" %>
<%@ taglib prefix="dialog" tagdir="/WEB-INF/tags/widgets/Dialog" %>
<%@ taglib prefix="search" tagdir="/WEB-INF/tags/shared/ui/Search" %>
<%@ taglib prefix="productSetList" tagdir="/WEB-INF/tags/shared/ui/List" %>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/features/cart/ui" %>
<%@ taglib prefix="brand" tagdir="/WEB-INF/tags/widgets/Brand" %>
<%@ taglib prefix="notice" tagdir="/WEB-INF/tags/widgets/Notice" %>
<%@ taglib prefix="productFeature" tagdir="/WEB-INF/tags/features/product/ui" %>
<%@ taglib prefix="productSet" tagdir="/WEB-INF/tags/widgets/ProductSet" %>
<%@ taglib prefix="toast" tagdir="/WEB-INF/tags/shared/ui/Toast" %>

<main class="container px-5 py-8 mx-auto max-w-[390px]">
    <div class="flex flex-col gap-8">
        <div>
            <h2 class="mb-4 text-2xl font-bold">Title 위젯</h2>
            <c:set var="arrowIconUrl" value="${pageContext.request.contextPath}/public/images/icons/ic-m-arrow-right.svg" />
            <title:Title 
                title="라네즈 세트 상품 구매시<br/>40% 할인"
                subtitle="세트 구성으로 구매시 40% 할인"
                tagLabel="Event 1"
                hashtagLabel="라네즈"
                hashtagIcon="${arrowIconUrl}"
                className="w-full max-w-[335px] mx-auto py-8" />
        </div>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">Search 컴포넌트</h3>
            <div class="flex flex-col gap-4">
                <search:Search 
                    placeholder="브랜드명으로 검색해보세요"
                    onBack="console.log('Back clicked')"
                    onSearch="console.log('Search clicked')"
                    onChange="console.log('Input changed', this.value)" />
            </div>
        </section>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">Banner 리스트</h3>
            <%
                java.util.List<java.util.Map<String, Object>> bannerList = new java.util.ArrayList<>();
                String bannerContextPath = request.getContextPath();
                
                java.util.Map<String, Object> b1 = new java.util.HashMap<>();
                b1.put("imageUrl", bannerContextPath + "/public/images/banners/banner-gift-1.png");
                b1.put("title", "아우구스티누스 바더\n단독 구매 사은 이벤트");
                b1.put("description", "When purchaasing GLASS SKIN ESSENCE PACT,  Heart Quilting Pouch Gift");
                bannerList.add(b1);
                
                java.util.Map<String, Object> b2 = new java.util.HashMap<>();
                b2.put("imageUrl", bannerContextPath + "/public/images/banners/banner-gift-2.png");
                b2.put("title", "블리브유 신규입점 사은행사");
                b2.put("description", "선착순 리뷰 이벤트 및 구매 금액별\n사은행사");
                bannerList.add(b2);
                
                java.util.Map<String, Object> b3 = new java.util.HashMap<>();
                b3.put("imageUrl", bannerContextPath + "/public/images/banners/banner-gift-3.png");
                b3.put("title", "설화수 8월 사은행사");
                b3.put("description", "구매고객 100% 사은증정");
                bannerList.add(b3);
                
                java.util.Map<String, Object> b4 = new java.util.HashMap<>();
                b4.put("imageUrl", bannerContextPath + "/public/images/banners/banner-gift-5.svg");
                b4.put("title", "정관장 신상품 출시 기념\n역대급 혜택");
                b4.put("description", "신상품 출시 구매 사은행사");
                bannerList.add(b4);
                
                java.util.Map<String, Object> b5 = new java.util.HashMap<>();
                b5.put("imageUrl", bannerContextPath + "/public/images/banners/banner-gift-8.png");
                b5.put("title", "라네즈 단독 기획전");
                b5.put("description", "구매고객 100% 사은증정");
                bannerList.add(b5);
                
                pageContext.setAttribute("bannerList", bannerList);
            %>
            <banner:BannerList banners="${bannerList}" />
        </section>
        
        <h2 class="mb-4 text-2xl font-bold">Tabs 컴포넌트 테스트</h2>
        <div class="mb-8">
            <h3 class="mb-2 text-lg font-semibold">Primary 사이즈 (사은행사 탭)</h3>
            <tab:Tabs tabs="사은행사,추천상품,전체상품" activeTab="0" size="primary" className="h-[56px]" />
        </div>
        <div>
            <h3 class="mb-2 text-lg font-semibold">Secondary 사이즈 (카테고리 탭)</h3>
            <tab:Tabs tabs="전체,스킨케어,메이크업,향수/헤어/바디,가방/지갑" activeTab="0" size="secondary" className="h-[52px]" />
        </div>
        <div>
            <h3 class="mb-2 text-lg font-semibold">Hashtag 탭</h3>
            <tab:HashtagTabs tabs="아우구스티누스 바더,할인율,추천상품" activeTab="0" />
        </div>
        <div>
            <h3 class="mb-2 text-lg font-semibold">Hashtag Button (아이콘 포함)</h3>
            <c:set var="arrowIconUrl" value="${pageContext.request.contextPath}/public/images/icons/ic-m-arrow-right.svg" />
            <div class="flex gap-2 items-center">
                <ui:HashtagButton label="라네즈" icon="${arrowIconUrl}" active="false" />
            </div>
        </div>
        <div>
            <h3 class="mb-2 text-lg font-semibold">Tag 컴포넌트</h3>
            <div class="flex flex-wrap gap-2 items-center">
                <tag:Tag label="Event 1" variant="event" />
                <tag:Tag label="Gift" variant="gift" />
                <tag:Tag label="베스트" variant="flag" />
            </div>
        </div>
        <div>
            <h3 class="mb-2 text-lg font-semibold">Badge 컴포넌트</h3>
            <div class="flex gap-2 items-center">
                <badge:Badge label="재고소진" variant="soldout" />
                <badge:Badge label="재입고 알림" variant="restock" />
            </div>
        </div>
        <section>
            <h3 class="mb-4 text-lg font-semibold">ProductCard 컴포넌트</h3>
            <div class="grid grid-cols-2 gap-2">
                <c:set var="product1Image" value="${pageContext.request.contextPath}/public/images/products/product-1.png" />
                <product:ProductCard 
                    imageUrl="${product1Image}"
                    brand="바비브라운"
                    mdKeyword="MD 키워드 최대 2줄 노출 가능"
                    name="인텐시브 세럼 파운데이션 SPF 40 #Po..."
                    originalPrice="$39"
                    discountRate="40"
                    discountPrice="$61"
                    discountPriceWon="72,320원"
                    flags="세일,베스트"
                    requiresAdultVerification="false"
                    isAdultVerified="false" />
                
                <c:set var="product2Image" value="${pageContext.request.contextPath}/public/images/products/product-2.png" />
                <product:ProductCard 
                    imageUrl="${product2Image}"
                    brand="바비브라운"
                    name="엑스트라 리페어 모이스춰 크림 인텐스..."
                    originalPrice="$39"
                    discountRate="40"
                    discountPrice="$61"
                    flags="세일,베스트"
                    requiresAdultVerification="false" />
                
                <c:set var="product3Image" value="${pageContext.request.contextPath}/public/images/products/product-3.png" />
                <product:ProductCard 
                    imageUrl="${product3Image}"
                    brand="바비브라운"
                    name="엑스트라 립 틴트 #베어 체리"
                    originalPrice="$39"
                    discountRate="40"
                    discountPrice="$61"
                    flags="세일"
                    isSoldOut="true"
                    requiresAdultVerification="false" />
                
                <c:set var="product4Image" value="${pageContext.request.contextPath}/public/images/products/product-4.png" />
                <product:ProductCard 
                    imageUrl="${product4Image}"
                    brand="조니워커"
                    name="조니워커 블루라벨"
                    originalPrice="$39"
                    discountRate="40"
                    discountPrice="$61"
                    flags="세일,베스트"
                    requiresAdultVerification="true"
                    isAdultVerified="false" />
                
                <c:set var="product5Image" value="${pageContext.request.contextPath}/public/images/products/product-5.png" />
                <product:ProductCard 
                    imageUrl="${product5Image}"
                    name="라네즈 크림스킨 170ML"
                    discountRate="40"
                    discountPrice="$11.7"
                    requiresAdultVerification="false"
                    requiresLoginForDiscount="true"
                    isLoggedIn="false" />
            </div>
        </section>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">ProductList 위젯 (2단)</h3>
            <%
                java.util.List<com.core.product.entity.Product> productList = new java.util.ArrayList<>();
                String contextPath = request.getContextPath();
                
                com.core.product.entity.Product p1 = new com.core.product.entity.Product();
                p1.setImageUrl(contextPath + "/public/images/products/product-1.png");
                p1.setBrandName("바비브라운");
                p1.setMdKeyword("MD 키워드 최대 2줄 노출 가능");
                p1.setName("인텐시브 세럼 파운데이션 SPF 40 #Po...");
                p1.setOriginalPrice(new java.math.BigDecimal("39"));
                p1.setDiscountRate(40);
                p1.setDiscountPrice(new java.math.BigDecimal("61"));
                p1.setDiscountPriceWon("72,320원");
                p1.setFlags("세일,베스트");
                p1.setRequiresAdultVerification(false);
                p1.setIsAdultVerified(false);
                productList.add(p1);
                
                com.core.product.entity.Product p2 = new com.core.product.entity.Product();
                p2.setImageUrl(contextPath + "/public/images/products/product-2.png");
                p2.setBrandName("바비브라운");
                p2.setName("엑스트라 리페어 모이스춰 크림 인텐스...");
                p2.setOriginalPrice(new java.math.BigDecimal("39"));
                p2.setDiscountRate(40);
                p2.setDiscountPrice(new java.math.BigDecimal("61"));
                p2.setFlags("세일,베스트");
                p2.setRequiresAdultVerification(false);
                productList.add(p2);
                
                com.core.product.entity.Product p3 = new com.core.product.entity.Product();
                p3.setImageUrl(contextPath + "/public/images/products/product-3.png");
                p3.setBrandName("바비브라운");
                p3.setName("엑스트라 립 틴트 #베어 체리");
                p3.setOriginalPrice(new java.math.BigDecimal("39"));
                p3.setDiscountRate(40);
                p3.setDiscountPrice(new java.math.BigDecimal("61"));
                p3.setFlags("세일");
                p3.setIsSoldOut(true);
                p3.setRequiresAdultVerification(false);
                productList.add(p3);
                
                com.core.product.entity.Product p4 = new com.core.product.entity.Product();
                p4.setImageUrl(contextPath + "/public/images/products/product-4.png");
                p4.setBrandName("조니워커");
                p4.setName("조니워커 블루라벨");
                p4.setOriginalPrice(new java.math.BigDecimal("39"));
                p4.setDiscountRate(40);
                p4.setDiscountPrice(new java.math.BigDecimal("61"));
                p4.setFlags("세일,베스트");
                p4.setRequiresAdultVerification(true);
                p4.setIsAdultVerified(false);
                productList.add(p4);
                
                com.core.product.entity.Product p5 = new com.core.product.entity.Product();
                p5.setImageUrl(contextPath + "/public/images/products/product-5.png");
                p5.setName("라네즈 크림스킨 170ML");
                p5.setDiscountRate(40);
                p5.setDiscountPrice(new java.math.BigDecimal("11.7"));
                p5.setRequiresAdultVerification(false);
                p5.setRequiresLoginForDiscount(true);
                p5.setIsLoggedIn(false);
                productList.add(p5);
                
                // 추가 제품 (6-12)
                com.core.product.entity.Product p6 = new com.core.product.entity.Product();
                p6.setImageUrl(contextPath + "/public/images/products/product-1.png");
                p6.setBrandName("라네즈");
                p6.setName("라네즈 네오 에센셜 블러링 피니시 파우더");
                p6.setOriginalPrice(new java.math.BigDecimal("39"));
                p6.setDiscountRate(70);
                p6.setDiscountPrice(new java.math.BigDecimal("11.7"));
                p6.setRequiresAdultVerification(false);
                productList.add(p6);
                
                com.core.product.entity.Product p7 = new com.core.product.entity.Product();
                p7.setImageUrl(contextPath + "/public/images/products/product-2.png");
                p7.setBrandName("라네즈");
                p7.setName("라네즈 워터뱅크 블루 히알루로닉 모이스춰 크림");
                p7.setOriginalPrice(new java.math.BigDecimal("39"));
                p7.setDiscountRate(70);
                p7.setDiscountPrice(new java.math.BigDecimal("11.7"));
                p7.setRequiresAdultVerification(false);
                productList.add(p7);
                
                com.core.product.entity.Product p8 = new com.core.product.entity.Product();
                p8.setImageUrl(contextPath + "/public/images/products/product-3.png");
                p8.setBrandName("라네즈");
                p8.setName("라네즈 래디언씨 더블 액티브 브라이트닝 에센스");
                p8.setOriginalPrice(new java.math.BigDecimal("39"));
                p8.setDiscountRate(70);
                p8.setDiscountPrice(new java.math.BigDecimal("11.7"));
                p8.setIsSoldOut(true);
                p8.setRequiresAdultVerification(false);
                productList.add(p8);
                
                com.core.product.entity.Product p9 = new com.core.product.entity.Product();
                p9.setImageUrl(contextPath + "/public/images/products/product-4.png");
                p9.setBrandName("라네즈");
                p9.setName("라네즈 워터슬리핑마스크 EX 70ml");
                p9.setOriginalPrice(new java.math.BigDecimal("39"));
                p9.setDiscountRate(70);
                p9.setDiscountPrice(new java.math.BigDecimal("11.7"));
                p9.setRequiresAdultVerification(false);
                productList.add(p9);
                
                com.core.product.entity.Product p10 = new com.core.product.entity.Product();
                p10.setImageUrl(contextPath + "/public/images/products/product-5.png");
                p10.setBrandName("라네즈");
                p10.setName("라네즈 스킨베일베이스 EX_40호 듀오세트");
                p10.setOriginalPrice(new java.math.BigDecimal("39"));
                p10.setDiscountRate(70);
                p10.setDiscountPrice(new java.math.BigDecimal("11.7"));
                p10.setRequiresAdultVerification(false);
                productList.add(p10);
                
                com.core.product.entity.Product p11 = new com.core.product.entity.Product();
                p11.setImageUrl(contextPath + "/public/images/products/product-1.png");
                p11.setBrandName("바비브라운");
                p11.setName("인텐시브 세럼 파운데이션 SPF 40 #Po...");
                p11.setOriginalPrice(new java.math.BigDecimal("39"));
                p11.setDiscountRate(50);
                p11.setDiscountPrice(new java.math.BigDecimal("19.5"));
                p11.setFlags("세일,베스트");
                p11.setRequiresAdultVerification(false);
                productList.add(p11);
                
                com.core.product.entity.Product p12 = new com.core.product.entity.Product();
                p12.setImageUrl(contextPath + "/public/images/products/product-2.png");
                p12.setBrandName("바비브라운");
                p12.setName("엑스트라 리페어 모이스춰 크림 인텐스...");
                p12.setOriginalPrice(new java.math.BigDecimal("39"));
                p12.setDiscountRate(60);
                p12.setDiscountPrice(new java.math.BigDecimal("15.6"));
                p12.setFlags("세일");
                p12.setRequiresAdultVerification(false);
                productList.add(p12);
                
                pageContext.setAttribute("productList", productList);
            %>
            <product:ProductCardList products="${productList}" />
        </section>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">ProductList 위젯 (3단)</h3>
            <product:ProductCardListCompact products="${productList}" />
        </section>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">ProductList 위젯 (Carousel)</h3>
            <product:ProductCardCarousel products="${productList}" />
        </section>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">ProductList 위젯 (3단 + 인디케이터)</h3>
            <product:ProductGridCarousel products="${productList}" />
        </section>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">이벤트 배너 리스트 (사은품)</h3>
            <%
                java.util.List<java.util.Map<String, Object>> eventBannerList = new java.util.ArrayList<>();
                String eventBannerContextPath = request.getContextPath();
                
                java.util.Map<String, Object> g1 = new java.util.HashMap<>();
                g1.put("imageUrl", eventBannerContextPath + "/public/images/gwp/gwp-img02.svg");
                g1.put("condition", "$1이상 구매시");
                g1.put("description", "슈퍼바이탈 세럼 크림 듀오 샘플 증정");
                eventBannerList.add(g1);
                
                java.util.Map<String, Object> g2 = new java.util.HashMap<>();
                g2.put("imageUrl", eventBannerContextPath + "/public/images/gwp/gwp-img03.svg");
                g2.put("condition", "$50이상 구매시");
                g2.put("description", "슈퍼바이탈 에멀젼 18ml + 소프너 18ml 증정");
                eventBannerList.add(g2);
                
                java.util.Map<String, Object> g3 = new java.util.HashMap<>();
                g3.put("imageUrl", eventBannerContextPath + "/public/images/gwp/gwp-img04.svg");
                g3.put("condition", "$80이상 구매시");
                g3.put("description", "슈퍼바이탈 5종 증정");
                eventBannerList.add(g3);
                
                pageContext.setAttribute("eventBannerList", eventBannerList);
            %>
            <banner:EventBannerList items="${eventBannerList}" />
        </section>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">이미지 배너 캐러셀</h3>
            <%
                java.util.List<java.util.Map<String, Object>> imageBannerList = new java.util.ArrayList<>();
                String imageBannerContextPath = request.getContextPath();
                
                java.util.Map<String, Object> ib1 = new java.util.HashMap<>();
                ib1.put("imageUrl", imageBannerContextPath + "/public/images/banners/banner-image-01.png");
                ib1.put("title", "라네즈 외 7개 브랜드\n햇살 가림 상품 기획전");
                ib1.put("description", "선착순 리뷰 이벤트 및 구매 금액별 사은행사");
                ib1.put("textColor", "white");
                imageBannerList.add(ib1);
                
                java.util.Map<String, Object> ib2 = new java.util.HashMap<>();
                ib2.put("imageUrl", imageBannerContextPath + "/public/images/banners/banner-image-02.png");
                ib2.put("title", "차앤박 구매사은행사");
                ib2.put("description", "$1이상 구매시 사은품 증정");
                ib2.put("textColor", "dark");
                imageBannerList.add(ib2);
                
                java.util.Map<String, Object> ib3 = new java.util.HashMap<>();
                ib3.put("imageUrl", imageBannerContextPath + "/public/images/banners/banner-image-03.png");
                ib3.put("title", "수려한 구매사은행사");
                ib3.put("description", "$50이상 구매시 사은품 증정");
                ib3.put("textColor", "dark");
                imageBannerList.add(ib3);
                
                java.util.Map<String, Object> ib4 = new java.util.HashMap<>();
                ib4.put("imageUrl", imageBannerContextPath + "/public/images/banners/banner-image-04.png");
                ib4.put("title", "이니스프리 기획전");
                ib4.put("description", "$30이상 구매시 사은품 증정");
                ib4.put("textColor", "white");
                imageBannerList.add(ib4);
                
                java.util.Map<String, Object> ib5 = new java.util.HashMap<>();
                ib5.put("imageUrl", imageBannerContextPath + "/public/images/banners/banner-image-05.png");
                ib5.put("title", "볼앤체인\n포토리뷰 이벤트");
                ib5.put("description", "선착순 리뷰 이벤트 및 구매 금액별 사은행사");
                ib5.put("textColor", "white");
                imageBannerList.add(ib5);
                
                pageContext.setAttribute("imageBannerList", imageBannerList);
            %>
            <banner:ImageBannerCarousel banners="${imageBannerList}" />
        </section>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">이미지 배너 리스트</h3>
            <banner:ImageBannerList banners="${imageBannerList}" />
        </section>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">Dialog 컴포넌트</h3>
            <div class="flex flex-col gap-4">
                <div>
                    <button 
                        type="button"
                        onclick="document.getElementById('sampleDialog1').showModal()"
                        class="px-4 py-2 bg-[#1B1E23] text-white rounded-[4px] hover:bg-[#2B2F35] transition-colors duration-200 ease-smooth">
                        기본 다이얼로그 열기
                    </button>
                    <dialog:Dialog 
                        id="sampleDialog1"
                        title="다이얼로그 제목"
                        content="다이얼로그 내용입니다. 여기에 표시할 내용을 입력하세요."
                        actions="cancel,confirm"
                        showCloseButton="true" />
                </div>
                
                <div>
                    <button 
                        type="button"
                        onclick="document.getElementById('sampleDialog2').showModal()"
                        class="px-4 py-2 bg-[#1B1E23] text-white rounded-[4px] hover:bg-[#2B2F35] transition-colors duration-200 ease-smooth">
                        확인 다이얼로그 열기
                    </button>
                    <dialog:Dialog 
                        id="sampleDialog2"
                        title="확인"
                        content="이 작업을 진행하시겠습니까?"
                        actions="cancel,confirm"
                        showCloseButton="false" />
                </div>
                
                <div>
                    <button 
                        type="button"
                        onclick="document.getElementById('imageBannerDialog').showModal()"
                        class="px-4 py-2 bg-[#1B1E23] text-white rounded-[4px] hover:bg-[#2B2F35] transition-colors duration-200 ease-smooth">
                        이미지 배너 다이얼로그 열기
                    </button>
                    <dialog:ImageBannerDialog 
                        id="imageBannerDialog"
                        title="검색"
                        tabs="전체,스킨케어,메이크업,향수/헤어/바디,가방/지갑,패션/의류,신발/액세서리,홈/리빙,식품/건강,뷰티도구,남성용품,여성용품"
                        activeTab="0"
                        placeholder="브랜드명으로 검색해보세요"
                        banners="${imageBannerList}"
                        showCloseButton="true"
                        onBack="document.getElementById('imageBannerDialog').close()"
                        onSearch="console.log('Search clicked')"
                        onChange="console.log('Input changed', this.value)" />
                </div>
            </div>
        </section>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">ProductSetItemList 컴포넌트</h3>
            <%
                java.util.List<java.util.Map<String, Object>> simpleProductList = new java.util.ArrayList<>();
                String productContextPath = request.getContextPath();
                
                java.util.Map<String, Object> sp1 = new java.util.HashMap<>();
                sp1.put("imageUrl", productContextPath + "/public/images/products/product-6.png");
                sp1.put("brand", "구찌 뷰티");
                sp1.put("name", "구찌 루즈 아 레브르 매트 208 데이 멧 인 아르헨티나 구찌 루즈 아 레브르 매트 208 데이 멧 인");
                simpleProductList.add(sp1);
                
                java.util.Map<String, Object> sp2 = new java.util.HashMap<>();
                sp2.put("imageUrl", productContextPath + "/public/images/products/product-7.png");
                sp2.put("brand", "구찌 뷰티");
                sp2.put("name", "구찌 뷰티 플루이드 드 보떼 피니 나뛰렐 – 내추럴 피니시");
                simpleProductList.add(sp2);
                
                java.util.Map<String, Object> sp3 = new java.util.HashMap<>();
                sp3.put("imageUrl", productContextPath + "/public/images/products/product-6.png");
                sp3.put("brand", "구찌 뷰티");
                sp3.put("name", "구찌 뷰티 플루이드 드 보떼 피니 나뛰렐 – 내추럴 피니시");
                simpleProductList.add(sp3);
                
                java.util.Map<String, Object> sp4 = new java.util.HashMap<>();
                sp4.put("imageUrl", productContextPath + "/public/images/products/product-7.png");
                sp4.put("brand", "구찌 뷰티");
                sp4.put("name", "구찌 뷰티 플루이드 드 보떼 피니 나뛰렐 – 내추럴 피니시");
                simpleProductList.add(sp4);
                
                pageContext.setAttribute("simpleProductList", simpleProductList);
            %>
            <div class="w-full max-w-[335px]">
                <productSetList:ProductSetItemList products="${simpleProductList}" />
            </div>
        </section>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">AddToCartButton 컴포넌트</h3>
            <div class="flex flex-col gap-4 w-full max-w-[335px]">
                <cart:AddToCartButton 
                    productId="product-1"
                    quantity="1"
                    onAddToCart="console.log('장바구니에 추가', 'product-1', 1)"
                    onQuantityChange="console.log('수량 변경', this)"
                    min="1"
                    max="10" />
            </div>
        </section>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">AddToCartDialog 컴포넌트</h3>
            <div class="flex flex-col gap-4">
                <div>
                    <button 
                        type="button"
                        onclick="document.getElementById('addToCartDialog').showModal()"
                        class="px-4 py-2 bg-[#1B1E23] text-white rounded-[4px] hover:bg-[#2B2F35] transition-colors duration-200 ease-smooth">
                        장바구니 담기 다이얼로그 열기
                    </button>
                    <%
                        java.util.List<java.util.Map<String, Object>> dialogProductList = new java.util.ArrayList<>();
                        String dialogProductContextPath = request.getContextPath();
                        
                        java.util.Map<String, Object> dp1 = new java.util.HashMap<>();
                        dp1.put("imageUrl", dialogProductContextPath + "/public/images/products/product-6.png");
                        dp1.put("brand", "구찌 뷰티");
                        dp1.put("name", "구찌 루즈 아 레브르 매트 208 데이 멧 인 아르헨티나 구찌 루즈 아 레브르 매트 208 데이 멧 인");
                        dialogProductList.add(dp1);
                        
                        java.util.Map<String, Object> dp2 = new java.util.HashMap<>();
                        dp2.put("imageUrl", dialogProductContextPath + "/public/images/products/product-7.png");
                        dp2.put("brand", "구찌 뷰티");
                        dp2.put("name", "구찌 뷰티 플루이드 드 보떼 피니 나뛰렐 – 내추럴 피니시");
                        dialogProductList.add(dp2);
                        
                        java.util.Map<String, Object> dp3 = new java.util.HashMap<>();
                        dp3.put("imageUrl", dialogProductContextPath + "/public/images/products/product-6.png");
                        dp3.put("brand", "구찌 뷰티");
                        dp3.put("name", "구찌 뷰티 플루이드 드 보떼 피니 나뛰렐 – 내추럴 피니시");
                        dialogProductList.add(dp3);
                        
                        java.util.Map<String, Object> dp4 = new java.util.HashMap<>();
                        dp4.put("imageUrl", dialogProductContextPath + "/public/images/products/product-7.png");
                        dp4.put("brand", "구찌 뷰티");
                        dp4.put("name", "구찌 루즈 아 레브르 매트 208 데이 멧 인 아르헨티나 구찌 루즈 아 레브르 매트 208 데이 멧 인");
                        dialogProductList.add(dp4);
                        
                        java.util.Map<String, Object> dp5 = new java.util.HashMap<>();
                        dp5.put("imageUrl", dialogProductContextPath + "/public/images/products/product-6.png");
                        dp5.put("brand", "구찌 뷰티");
                        dp5.put("name", "구찌 뷰티 플루이드 드 보떼 피니 나뛰렐 – 내추럴 피니시");
                        dialogProductList.add(dp5);
                        
                        java.util.Map<String, Object> dp6 = new java.util.HashMap<>();
                        dp6.put("imageUrl", dialogProductContextPath + "/public/images/products/product-7.png");
                        dp6.put("brand", "구찌 뷰티");
                        dp6.put("name", "구찌 루즈 아 레브르 매트 208 데이 멧 인 아르헨티나 구찌 루즈 아 레브르 매트 208 데이 멧 인");
                        dialogProductList.add(dp6);
                        
                        java.util.Map<String, Object> dp7 = new java.util.HashMap<>();
                        dp7.put("imageUrl", dialogProductContextPath + "/public/images/products/product-6.png");
                        dp7.put("brand", "구찌 뷰티");
                        dp7.put("name", "구찌 뷰티 플루이드 드 보떼 피니 나뛰렐 – 내추럴 피니시");
                        dialogProductList.add(dp7);
                        
                        pageContext.setAttribute("dialogProductList", dialogProductList);
                    %>
                    <dialog:AddToCartDialog 
                        id="addToCartDialog"
                        title="세트 구성보기"
                        products="${dialogProductList}"
                        productId="product-set-1"
                        quantity="1"
                        onAddToCart="console.log('장바구니에 추가', 'product-set-1', 1)"
                        onQuantityChange="console.log('수량 변경', this)"
                        min="1"
                        max="10"
                        showCloseButton="true"
                        onClose="document.getElementById('addToCartDialog').close()" />
                </div>
            </div>
        </section>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">BrandList 컴포넌트</h3>
            <div class="flex flex-col gap-4">
                <%
                    java.util.List<java.util.Map<String, Object>> brandList = new java.util.ArrayList<>();
                    String brandContextPath = request.getContextPath();
                    
                    // 브랜드 데이터 추가
                    String[] brandNames = {"정관장", "오쏘몰", "센트룸", "온누리스토어", "헤어메스", "지앤씨(수입)", "솔가", "익스트림", "스위스", "종근당건강", "오쏘몰", "센트룸"};
                    
                    for (int i = 0; i < brandNames.length; i++) {
                        java.util.Map<String, Object> brand = new java.util.HashMap<>();
                        brand.put("imageUrl", brandContextPath + "/public/images/brands/brand-" + (i + 1) + ".svg");
                        brand.put("brandName", brandNames[i]);
                        brand.put("onClick", "console.log('브랜드 클릭', '" + brandNames[i] + "')");
                        brandList.add(brand);
                    }
                    
                    pageContext.setAttribute("brandList", brandList);
                %>
                <brand:BrandList 
                    title="브랜드관"
                    brands="${brandList}"
                    className="w-full max-w-[335px] mx-auto" />
            </div>
        </section>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">KVBanner 컴포넌트</h3>
            <div class="flex flex-col gap-4">
                <%
                    String kvBannerContextPath = request.getContextPath();
                %>
                <banner:KVBanner 
                    imageUrl="${kvBannerContextPath}/public/images/banners/kv.jpg"
                    period="2025.01.01 - 재고소진시까지"
                    title="아이오페 단독 프로모션"
                    subtitle="현대면세점 단독 혜택도 만나보세요!"
                    bgColor="#F3E1CC"
                    onClick="console.log('KV 배너 클릭')"
                    className="w-full max-w-[375px] mx-auto" />
            </div>
        </section>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">Notice 컴포넌트</h3>
            <div class="flex flex-col gap-4">
                <%
                    java.util.List<java.util.Map<String, Object>> noticeItems = new java.util.ArrayList<>();
                    
                    java.util.Map<String, Object> item1 = new java.util.HashMap<>();
                    item1.put("text", "한 ID 당 1일 1회 증정됩니다.");
                    item1.put("isImportant", false);
                    noticeItems.add(item1);
                    
                    java.util.Map<String, Object> item2 = new java.util.HashMap<>();
                    item2.put("text", "사은품은 중복 증정이 되지 않습니다.");
                    item2.put("isImportant", false);
                    noticeItems.add(item2);
                    
                    java.util.Map<String, Object> item3 = new java.util.HashMap<>();
                    item3.put("text", "사은품은 디자인 및 구성이 임의로 증정되며, 선택할 수 없습니다.");
                    item3.put("isImportant", false);
                    noticeItems.add(item3);
                    
                    java.util.Map<String, Object> item4 = new java.util.HashMap<>();
                    item4.put("text", "사은품의 재고 소진 이후에도 해당 페이지와 관련 배너는 보여질 수 있습니다.");
                    item4.put("isImportant", true);
                    noticeItems.add(item4);
                    
                    pageContext.setAttribute("noticeItems", noticeItems);
                %>
                <notice:Notice 
                    title="유의사항"
                    items="${noticeItems}"
                    buttonText="더 많은 사은행사가 궁금하다면"
                    buttonOnClick="console.log('더 많은 사은행사 클릭')"
                    className="w-full max-w-[335px] mx-auto" />
            </div>
        </section>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">ProductPriceCartBar 컴포넌트</h3>
            <div class="flex flex-col gap-4">
                <cart:ProductPriceCartBar 
                    originalPrice="176"
                    discountPrice="112.64"
                    discountRate="36"
                    currency="$"
                    onAddToCart="console.log('장바구니에 담기')"
                    disabled="false"
                    className="w-full max-w-[303px] mx-auto" />
            </div>
        </section>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">ProductSetThumbBar 컴포넌트</h3>
            <div class="flex flex-col gap-4">
                <%
                    java.util.List<java.util.Map<String, Object>> thumbnails = new java.util.ArrayList<>();
                    String thumbnailContextPath = request.getContextPath();
                    
                    // 썸네일 데이터 추가 (13개로 설정하여 +9 표시 테스트)
                    for (int i = 1; i <= 13; i++) {
                        java.util.Map<String, Object> thumb = new java.util.HashMap<>();
                        thumb.put("imageUrl", thumbnailContextPath + "/public/images/products/product-" + ((i % 2 == 0) ? "8" : "9") + ".jpg");
                        thumb.put("alt", "제품 " + i);
                        thumbnails.add(thumb);
                    }
                    
                    pageContext.setAttribute("thumbnails", thumbnails);
                %>
                <productFeature:ProductSetThumbBar 
                    thumbnails="${thumbnails}"
                    title="상품 구성"
                    onClick="console.log('상품 구성 클릭')"
                    className="w-full max-w-[303px] mx-auto" />
            </div>
        </section>
        
        <section>
            <h3 class="mb-4 text-lg font-semibold">ProductSetCard 컴포넌트</h3>
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
                    
                    pageContext.setAttribute("cardThumbnails", cardThumbnails);
                %>
                <productSet:ProductSetCard 
                    imageUrl=""
                    tagLabel="Event 1"
                    title="풀리오 세트 A"
                    subtitle="종아리 마사지기 V2 (지퍼 벨크로 이중형)24년형/2.6리터 + 무선 목어깨 마사지기"
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
            <h3 class="mb-4 text-lg font-semibold">Toast 컴포넌트</h3>
            <div class="flex flex-col gap-4">
                <button 
                    type="button"
                    onclick="showToast_toast_sample()"
                    class="px-4 py-2 bg-[#1B1E23] text-white rounded hover:bg-[#2B2F35] transition-colors">
                    Toast 표시하기
                </button>
                <toast:Toast 
                    id="toast_sample"
                    message="장바구니에 담겼습니다 :)"
                    duration="3000"
                    className="" />
            </div>
        </section>

        <section>
            <h3 class="mb-4 text-lg font-semibold">ProductSortFilter 컴포넌트</h3>
            <div class="flex flex-col gap-4">
                <productFeature:ProductSortFilter 
                    sortOption="베스트순"
                    showSoldOut="false"
                    totalCount="1234"
                    className="w-full max-w-[375px] mx-auto" />
            </div>
        </section>
    </div>
</main>

