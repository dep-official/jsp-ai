<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- GNB (Global Navigation Bar) - Figma 디자인 정확히 반영 -->
<nav class="bg-[#FFFFFF] border-b border-[#DDE0E5] h-[60px] flex items-center relative" style="border-bottom-width: 1px;">
    <!-- 뒤로가기 버튼 (왼쪽: x:20, y:18) -->
    <button class="absolute w-6 h-6 flex items-center justify-center" aria-label="뒤로가기" 
            style="left: 20px; top: 18px;">
        <img src="${pageContext.request.contextPath}/public/images/icons/ic-m-back.svg" alt="뒤로가기" class="w-6 h-6" />
    </button>
    
    <!-- 타이틀 (중앙) - 18px, 700 weight, #1B1E23, letter-spacing: -5% -->
    <h1 class="absolute text-[18px] font-bold text-[#1B1E23] leading-[1.5em]" 
        style="left: 50%; transform: translateX(-50%); letter-spacing: -0.05em; font-family: 'Noto Sans KR', sans-serif;">
        ${title != null ? title : '사은행사'}
    </h1>
    
    <!-- 검색 아이콘 (x:291, y:18) -->
    <button class="absolute w-6 h-6 flex items-center justify-center" aria-label="검색" 
            style="left: 291px; top: 18px;">
        <img src="${pageContext.request.contextPath}/public/images/icons/ic-m-search.svg" alt="검색" class="w-6 h-6" />
    </button>
    
    <!-- 장바구니 아이콘 (x:331, y:18) -->
    <button class="absolute w-6 h-6 flex items-center justify-center" aria-label="장바구니" 
            style="left: 331px; top: 18px;">
        <img src="${pageContext.request.contextPath}/public/images/icons/ic-m-cart.svg" alt="장바구니" class="w-6 h-6" />
    </button>
</nav>
