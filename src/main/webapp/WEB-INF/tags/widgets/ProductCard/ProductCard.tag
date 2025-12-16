<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags/shared/ui/Tag" %>
<%@ taglib prefix="badge" tagdir="/WEB-INF/tags/shared/ui/Badge" %>
<%@ attribute name="imageUrl" required="true" %>
<%@ attribute name="brand" required="false" %>
<%@ attribute name="mdKeyword" required="false" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="originalPrice" required="false" %>
<%@ attribute name="discountRate" required="false" %>
<%@ attribute name="discountPrice" required="false" %>
<%@ attribute name="discountPriceWon" required="false" %>
<%@ attribute name="flags" required="false" %>
<%@ attribute name="isSoldOut" required="false" %>
<%@ attribute name="requiresAdultVerification" required="false" %>
<%@ attribute name="isAdultVerified" required="false" %>
<%@ attribute name="requiresLoginForDiscount" required="false" %>
<%@ attribute name="isLoggedIn" required="false" %>
<%@ attribute name="size" required="false" %>
<%@ attribute name="className" required="false" %>
<%@ attribute name="showPrice" required="false" type="java.lang.Boolean" %>
<%@ attribute name="showFlags" required="false" type="java.lang.Boolean" %>
<%@ attribute name="showBrand" required="false" type="java.lang.Boolean" %>
<%@ attribute name="showMdKeyword" required="false" type="java.lang.Boolean" %>
<%@ attribute name="showDiscountPriceWon" required="false" type="java.lang.Boolean" %>
<%@ attribute name="videoUrl" required="false" %>

<c:choose>
    <c:when test="${size == 'compact'}">
        <c:set var="cartButtonSizeClass" value="w-[26px] h-[26px]" />
    </c:when>
    <c:when test="${size == 'medium'}">
        <c:set var="cartButtonSizeClass" value="w-[29px] h-[29px]" />
    </c:when>
    <c:otherwise>
        <c:set var="cartButtonSizeClass" value="w-[32px] h-[32px]" />
    </c:otherwise>
</c:choose>

<div class="flex flex-col ${className} product-card-item" data-sold-out="${isSoldOut}">
    <figure class="relative w-full bg-[#F5F7FA] rounded overflow-hidden mb-4 aspect-square">
        <c:choose>
            <c:when test="${fn:startsWith(imageUrl, '/public/')}">
                <img src="${pageContext.request.contextPath}${imageUrl}" alt="${name}" class="object-cover w-full h-full mix-blend-multiply" />
            </c:when>
            <c:otherwise>
                <img src="${imageUrl}" alt="${name}" class="object-cover w-full h-full mix-blend-multiply" />
            </c:otherwise>
        </c:choose>
        
        <!-- 썸네일 블러 레이어 (성인인증 필요 상품이고 인증 안된 경우만 표시) -->
        <c:if test="${requiresAdultVerification && !isAdultVerified}">
            <div class="absolute inset-0 bg-[rgba(245,247,250,0.1)] backdrop-blur-[6.71px] rounded-[8px] pointer-events-none"></div>
        </c:if>
        
        <!-- 성인인증 버튼 (성인인증 필요 상품이고 인증 안된 경우만 표시) -->
        <c:if test="${requiresAdultVerification && !isAdultVerified}">
            <button 
                type="button" 
                class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-12 h-12 flex items-center justify-center bg-[rgba(255,255,255,0.8)] rounded-full border-[#CCD1D8] border-[0.6px] hover:bg-white transition-colors duration-200 ease-smooth focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2 z-10"
                aria-label="성인인증">
                <c:set var="adultIconUrl" value="${pageContext.request.contextPath}/public/images/icons/ic-m-19.svg" />
                <img src="${adultIconUrl}" alt="성인인증" class="w-7 h-7" />
            </button>
        </c:if>

        <!-- 영상재생 버튼 -->
        <c:if test="${!empty videoUrl}">
            <button 
                type="button" 
                class="absolute top-[10px] left-[10px] w-6 h-6 flex items-center bg-[rgba(0,0,0,0.08)] justify-center rounded-full shadow-[0_0_0_1px_rgba(0,0,0,0.08)] hover:bg-[#000] transition-colors duration-200 ease-smooth focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2"
                onclick="openVideoDialog('${videoUrl}')"
                aria-label="영상 재생">
                <c:set var="cartIconUrl" value="${pageContext.request.contextPath}/public/images/icons/ic-m-play.svg" />
                <img src="${cartIconUrl}" alt="" class="w-4 h-4" />
            </button>
        </c:if>
        
        <!-- 장바구니 담기 버튼 (품절 상태가 아닐 때만 표시) -->
        <c:if test="${!isSoldOut}">
            <button 
                type="button" 
                class="absolute bottom-0 right-0 ${cartButtonSizeClass} flex items-center justify-center bg-[rgba(27,30,35,0.3)] rounded-tl-[4px] rounded-br-[4px] hover:bg-[#000] transition-colors duration-200 ease-smooth focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2"
                aria-label="장바구니 담기">
                <c:set var="playIconUrl" value="${pageContext.request.contextPath}/public/images/icons/ic-m-shoppinbag.svg" />
                <img src="${playIconUrl}" alt="" class="ml-0.5 w-4 h-4" />
            </button>
        </c:if>
        
        <!-- 재입고 알림 버튼 (품절 상태일 때만 표시) -->
        <c:if test="${isSoldOut}">
            <button
                type="button"
                class="group absolute bottom-0 w-full left-0 focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2"
                onclick="handleRestockAlert()"
                aria-label="재입고 알림">
                <badge:Badge label="재입고 알림" variant="restock" />
            </button>
        </c:if>
    </figure>
    
    <div class="flex flex-col gap-2">
        <div class="flex flex-col gap-0.5">
            <c:if test="${(empty showBrand || showBrand) && !empty brand}">
                <span class="text-[13px] font-bold leading-[1.46em] tracking-[-0.05em] text-[#1B1E23]">${brand}</span>
            </c:if>
            <c:if test="${(empty showMdKeyword || showMdKeyword) && !empty mdKeyword}">
                <p class="text-[13px] font-normal leading-[1.46em] tracking-[-0.05em] text-[#EA2869] line-clamp-2">${mdKeyword}</p>
            </c:if>
            <p class="text-[13px] font-normal leading-[1.46em] tracking-[-0.05em] text-[#3D444F] line-clamp-2">${name}</p>
        </div>
        
        <c:if test="${empty showPrice || showPrice != false}">
            <div class="flex flex-col">
                <!-- 할인율 표시 영역 -->
                <div class="flex gap-1 items-center">
                    <!-- 할인율 표시: 로그인 필요 상품이고 로그인 안 했으면 "로그인 후 할인율 확인", 그 외에는 할인율 표시 -->
                    <c:if test="${discountRate != null}">
                        <c:choose>
                            <c:when test="${requiresLoginForDiscount && !isLoggedIn}">
                                <span class="text-[12px] font-medium leading-[1.5em] tracking-[-0.05em] text-[#788497]">
                                    <span class="underline text-[#EA2869]">로그인</span> 후 할인율 확인
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-[12px] font-medium leading-[1.5em] tracking-[-0.05em] text-[#1B1E23]">${discountRate}%</span>
                                <c:if test="${originalPrice != null}">
                                    <span class="text-[12px] font-normal leading-[1.5em] tracking-[-0.05em] text-[#ABB2BE]">$${originalPrice}</span>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                    
                </div>

                <!-- 할인가격 표시 영역 -->
                <c:if test="${discountPrice != null}">
                    <div class="flex gap-1 items-center">
                        <span class="text-[15px] font-bold leading-[1.47em] tracking-[-0.05em] text-[#EA2829]">$${discountPrice}</span>
                        <c:if test="${(empty showDiscountPriceWon || showDiscountPriceWon) && discountPriceWon != null and discountPriceWon != ''}">
                            <span class="text-[12px] font-normal leading-[1.5em] tracking-[-0.05em] text-[#3D444F]">${discountPriceWon}</span>
                        </c:if>
                    </div>
                </c:if>
            </div>
            
            <c:if test="${(empty showFlags || showFlags) && !empty flags}">
                <div class="flex flex-wrap gap-1 items-center">
                    <c:forEach var="flag" items="${fn:split(flags, ',')}">
                        <tag:Tag label="${fn:trim(flag)}" variant="flag" />
                    </c:forEach>
                </div>
            </c:if>
        </c:if>
    </div>
</div>

