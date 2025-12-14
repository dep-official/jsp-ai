<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags/shared/ui/Button" %>

<c:set var="iconUrlBack" value="${pageContext.request.contextPath}/public/images/icons/ic-m-back.svg" />
<c:set var="iconUrlSearch" value="${pageContext.request.contextPath}/public/images/icons/ic-m-search.svg" />
<c:set var="iconUrlCart" value="${pageContext.request.contextPath}/public/images/icons/ic-m-cart.svg" />

<header>
    <nav class="border-b border-[#DDE0E5] h-[60px] flex items-center justify-between px-5 lg:hidden">
        <ui:IconButton src="${iconUrlBack}" size="sm" ariaLabel="뒤로가기" />

        <h1 class="flex-1 text-center text-[18px] absolute left-1/2 -translate-x-1/2 font-bold text-[#1B1E23] leading-[1.5em] tracking-[-0.05em]">
            ${title != null ? title : '사은행사'}
        </h1>

        <div class="flex items-center gap-4">
            <ui:IconButton src="${iconUrlSearch}" size="sm" ariaLabel="검색" />
            <ui:IconButton src="${iconUrlCart}" size="sm" ariaLabel="장바구니" />
        </div>
    </nav>
</header>

