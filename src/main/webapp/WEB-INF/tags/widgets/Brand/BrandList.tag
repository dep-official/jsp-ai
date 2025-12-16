<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="brandItem" tagdir="/WEB-INF/tags/widgets/Brand/ui/BrandItem" %>
<%@ attribute name="title" required="false" %>
<%@ attribute name="brands" required="true" type="java.util.List" %>
<%@ attribute name="className" required="false" %>
<%@ attribute name="description" required="false" %>

<!-- 브랜드 리스트 -->
<section class="flex flex-col w-full ${className}" aria-label="브랜드 목록">
    <!-- 제목 -->
    <c:if test="${!empty title}">
        <h2 class="text-[#1B1E23] lg:hidden font-bold text-[18px] leading-[1.5em] tracking-[-0.05em] text-center mb-[20px] m-0">
            ${title}
        </h2>
        
        <c:if test="${!empty description}">
            <p class="text-[#5C6677]  lg:hidden font-normal text-[14px] leading-[1.429em] tracking-[-0.05em] text-center w-full mb-[24px]">
                ${description}
            </p>
        </c:if>
    </c:if>
    
    <!-- 브랜드 리스트 (모바일 3단, PC 6단) -->
    <ul class="grid grid-cols-3 lg:grid-cols-6 justify-items-center gap-[16px] [&>li:last-child:nth-child(3n+1)]:col-start-2 lg:[&>li:last-child:nth-child(3n+1)]:col-start-auto lg:[&>li:last-child:nth-child(6n+1)]:col-span-6 lg:[&>li:last-child:nth-child(6n+1)]:w-[calc((100%_-_80px)/6)]">
        <c:forEach var="brand" items="${brands}">
            <brandItem:BrandItem 
                imageUrl="${brand.imageUrl}"
                name="${brand.brandName}"/>
        </c:forEach>
    </ul>
</section>

