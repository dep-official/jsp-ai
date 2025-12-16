<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags/shared/ui/Tag" %>
<%@ taglib prefix="productSetThumbBar" tagdir="/WEB-INF/tags/features/product/ui" %>
<%@ taglib prefix="productPriceCartBar" tagdir="/WEB-INF/tags/features/cart/ui" %>
<%@ taglib prefix="addToCartDialog" tagdir="/WEB-INF/tags/widgets/Dialog" %>
<%@ attribute name="imageUrl" required="false" %>
<%@ attribute name="tagLabel" required="false" %>
<%@ attribute name="title" required="true" %>
<%@ attribute name="subtitle" required="false" %>
<%@ attribute name="thumbnails" required="true" type="java.util.List" %>
<%@ attribute name="originalPrice" required="false" %>
<%@ attribute name="discountPrice" required="true" %>
<%@ attribute name="discountRate" required="false" %>
<%@ attribute name="currency" required="false" %>
<%@ attribute name="onAddToCart" required="false" %>
<%@ attribute name="disabled" required="false" type="java.lang.Boolean" %>
<%@ attribute name="className" required="false" %>

<%
    // disabled 처리
    Boolean disabledValue = (Boolean) jspContext.getAttribute("disabled");
    if (disabledValue == null) {
        disabledValue = false;
    }
    jspContext.setAttribute("disabledValue", disabledValue);
    
    // onAddToCart 기본값
    String onAddToCartValue = (String) jspContext.getAttribute("onAddToCart");
    if (onAddToCartValue == null) {
        onAddToCartValue = "";
    }
    jspContext.setAttribute("onAddToCartValue", onAddToCartValue);
    
    // 고유한 Swiper ID 생성
    String swiperId = "productSetSwiper_" + System.currentTimeMillis() + "_" + (int)(Math.random() * 1000);
    jspContext.setAttribute("swiperId", swiperId);
    
    // 고유한 Dialog ID 생성
    String dialogId = "addToCartDialog_" + System.currentTimeMillis() + "_" + (int)(Math.random() * 1000);
    jspContext.setAttribute("dialogId", dialogId);
    
    // thumbnails를 products 형식으로 변환 (Dialog에 전달하기 위해)
    java.util.List thumbnailsList = (java.util.List) jspContext.getAttribute("thumbnails");
    java.util.List productsList = new java.util.ArrayList<>();
    if (thumbnailsList != null) {
        for (Object obj : thumbnailsList) {
            if (obj instanceof java.util.Map) {
                java.util.Map<String, Object> thumbnail = (java.util.Map<String, Object>) obj;
                java.util.Map<String, Object> product = new java.util.HashMap<>();
                product.put("imageUrl", thumbnail.get("imageUrl"));
                // name은 alt가 있으면 alt 사용, 없으면 title 사용
                String name = (String) thumbnail.get("alt");
                if (name == null || name.isEmpty()) {
                    name = (String) jspContext.getAttribute("title");
                }
                product.put("name", name != null ? name : "");
                product.put("brand", thumbnail.get("brand") != null ? thumbnail.get("brand") : "");
                productsList.add(product);
            }
        }
    }
    jspContext.setAttribute("productsList", productsList);
    
    // productId 생성 (title 기반)
    String productIdValue = "product_" + System.currentTimeMillis();
    jspContext.setAttribute("productIdValue", productIdValue);
%>

<article class="flex flex-col w-full bg-white ${className}">
    <div class="flex flex-col items-center w-full">
        <c:if test="${!empty tagLabel}">
            <tag:Tag 
                label="${tagLabel}"
                variant="event"
                className="mb-2 bg-[#7F519C]" />
        </c:if>
        
        <h5 class="text-[#1B1E23] font-bold text-[22px] leading-[1.455em] tracking-[-0.05em] text-center w-full mb-[8px]">
            ${title}
        </h5>
        
        <c:if test="${!empty subtitle}">
            <p class="text-[#5C6677] font-normal text-[14px] leading-[1.429em] tracking-[-0.05em] text-center w-full mb-[24px]">
                ${subtitle}
            </p>
        </c:if>
    </div>
    
    <div class="relative w-full aspect-square overflow-hidden rounded-t-[8px]">
        <div class="swiper ${swiperId} w-full h-full">
            <ul class="swiper-wrapper">
                <c:forEach var="thumbnail" items="${thumbnails}">
                    <li class="relative swiper-slide">
                        <figure class="overflow-hidden w-full h-full">
                            <img 
                                src="${thumbnail.imageUrl}" 
                                alt="${thumbnail.alt != null ? thumbnail.alt : title}"
                                class="object-cover w-full h-full"
                                loading="lazy" />
                        </figure>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="absolute bottom-0 left-0 right-0 h-[96px] bg-gradient-to-t from-[rgba(115,115,115,1)] to-[rgba(115,115,115,0)] pointer-events-none z-[5]" aria-hidden="true"></div>
        <div class="absolute left-0 right-0 mb-[12px] flex justify-center items-center z-10 ${swiperId}-pagination" aria-label="이미지 인디케이터"></div>
    </div>
    
    <script>
    (function() {
        var swiperId = '${swiperId}';
        document.addEventListener('DOMContentLoaded', function() {
            var swiperElement = document.querySelector('.' + swiperId);
            var paginationEl = '.' + swiperId + '-pagination';
            var paginationContainer = document.querySelector(paginationEl);
       
            var swiper = new Swiper('.' + swiperId, {
                slidesPerView: 1,
                spaceBetween: 0,
                loop: false,
                pagination: {
                    el: paginationContainer,
                    clickable: true,
                    renderBullet: function (index, className) {
                        return '<span class="' + className + '"style="width: 6px !important; height: 6px !important; opacity: 1 !important; border-radius: 50% !important; background-color: #EBEBEB !important;"></span>';
                    },
                },
            });
            
            // 활성화된 인디케이터 스타일 적용
            swiper.on('slideChange', function () {
                var bullets = document.querySelectorAll(paginationEl + ' .swiper-pagination-bullet');
                bullets.forEach(function(bullet, index) {
                    if (index === swiper.activeIndex) {
                        bullet.style.backgroundColor = '#1B1E23';
                    } else {
                        bullet.style.backgroundColor = '#EBEBEB';
                    }
                });
            });
            
            // 초기 인디케이터 스타일 설정
            var initialBullets = document.querySelectorAll(paginationEl + ' .swiper-pagination-bullet');
            if (initialBullets.length > 0) {
                initialBullets[0].style.backgroundColor = '#1B1E23';
            }
        });
    })();
    </script>
    
    <div class="px-4 pt-0 pb-4 border border-[#DDE0E5] rounded-b-[8px]">
        <productSetThumbBar:ProductSetThumbBar 
            thumbnails="${thumbnails}"
            title="상품 구성"
            onClick="document.getElementById('${dialogId}').showModal()"
            className="my-4 cursor-pointer" />
        
        <hr class="w-full h-0 border-0 border-t border-[#EEF0F2] mb-4" aria-hidden="true" />
        
        <productPriceCartBar:ProductPriceCartBar 
            originalPrice="${originalPrice}"
            discountPrice="${discountPrice}"
            discountRate="${discountRate}"
            currency="${currency}"
            onAddToCart="${onAddToCartValue}"
            disabled="${disabledValue}"
            className="" />
    </div>
    
    <!-- 장바구니 담기 다이얼로그 -->
    <addToCartDialog:AddToCartDialog 
        id="${dialogId}"
        title="세트 구성보기"
        products="${productsList}"
        productId="${productIdValue}"
        productName="${title}"
        discountRate="${discountRate}"
        quantity="1"
        onAddToCart="${onAddToCartValue}"
        min="1"
        max="10"
        disabled="${disabledValue}"
        showCloseButton="true"
        onClose="document.getElementById('${dialogId}').close()"
        className="" />
</article>

