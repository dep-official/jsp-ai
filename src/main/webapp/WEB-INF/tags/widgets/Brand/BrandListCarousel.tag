<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="brandItem" tagdir="/WEB-INF/tags/widgets/Brand/ui/BrandItem" %>
<%@ taglib prefix="features" tagdir="/WEB-INF/tags/features/carousel/lib" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags/shared/ui/Tag" %>
<%@ attribute name="title" required="false" %>
<%@ attribute name="brands" required="true" type="java.util.List" %>
<%@ attribute name="className" required="false" %>
<%@ attribute name="description" required="false" %>

<features:IdGenerator prefix="brandCarousel" />
<c:set var="uniqueId" value="${generatedId}" />

<section class="flex flex-col w-full min-w-0 ${className}" aria-label="브랜드 목록">
    <c:if test="${!empty title}">
        <h2 class="text-[#1B1E23] font-bold text-[18px] leading-[1.5em] tracking-[-0.05em] text-center mb-[20px] m-0">
            ${title}
        </h2>
        <c:if test="${!empty description}">
            <p class="text-[#5C6677] font-normal text-[14px] leading-[1.429em] tracking-[-0.05em] text-center w-full mb-[24px]">
                ${description}
            </p>
        </c:if>
    </c:if>

    
    <div class="relative group">
        <div class="swiper ${uniqueId} w-full min-w-0 overflow-hidden">
            <ul class="swiper-wrapper w-full flex">
                <c:forEach var="brand" items="${brands}">
                    <brandItem:BrandItem 
                        className="swiper-slide w-[calc((100%-32px)/3)] lg:w-[calc((100%-80px)/6)] mr-[16px] last:mr-0"
                        imageUrl="${brand.imageUrl}"
                        name="${brand.brandName}"/>
                </c:forEach>
            </ul>
        </div>
        
        <button type="button" class="swiper-button-prev-${uniqueId} absolute top-1/2 -mt-[16px] -translate-y-1/2 left-[-20px] z-10 w-[40px] h-[40px] flex items-center justify-center bg-white rounded-full shadow-[0_2px_8px_0_rgba(0,0,0,0.1)] disabled:opacity-0 disabled:cursor-default transition-opacity duration-200" aria-label="이전 브랜드">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M15 18L9 12L15 6" stroke="#1B1E23" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </button>
        <button type="button" class="swiper-button-next-${uniqueId} absolute top-1/2 -mt-[16px] -translate-y-1/2 right-[-20px] z-10 w-[40px] h-[40px] flex items-center justify-center bg-white rounded-full shadow-[0_2px_8px_0_rgba(0,0,0,0.1)] disabled:opacity-0 disabled:cursor-default transition-opacity duration-200" aria-label="다음 브랜드">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M9 18L15 12L9 6" stroke="#1B1E23" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </button>
    </div>
</section>

<script>
document.addEventListener('DOMContentLoaded', function() {
    new Swiper('.${uniqueId}', {
        slidesPerView: 'auto',
        spaceBetween: 0, // 레이아웃 시프팅 방지
        navigation: {
            nextEl: '.swiper-button-next-${uniqueId}',
            prevEl: '.swiper-button-prev-${uniqueId}',
        },
        breakpoints: {
            1024: {
                slidesPerView: 'auto',
                spaceBetween: 0 // 레이아웃 시프팅 방지
            }
        }
    });
});
</script>
