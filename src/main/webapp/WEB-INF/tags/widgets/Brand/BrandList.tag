<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="brandItem" tagdir="/WEB-INF/tags/widgets/Brand/ui/BrandItem" %>
<%@ attribute name="title" required="false" %>
<%@ attribute name="brands" required="true" type="java.util.List" %>
<%@ attribute name="className" required="false" %>

<!-- 브랜드 리스트 -->
<section class="flex flex-col w-full ${className}" aria-label="브랜드 목록">
    <!-- 제목 -->
    <c:if test="${!empty title}">
        <h2 class="text-[#1B1E23] font-bold text-[18px] leading-[1.5em] tracking-[-0.05em] text-center mb-[20px] m-0">
            ${title}
        </h2>
    </c:if>
    
    <!-- 브랜드 리스트 (모바일 3단, PC 6단) -->
    <ul class="grid grid-cols-3 lg:grid-cols-6 justify-items-center gap-[16px]">
        <c:forEach var="brand" items="${brands}">
            <brandItem:BrandItem 
                imageUrl="${brand.imageUrl}"
                name="${brand.name}"
                onClick="${brand.onClick}"
                 />
        </c:forEach>
    </ul>
</section>

