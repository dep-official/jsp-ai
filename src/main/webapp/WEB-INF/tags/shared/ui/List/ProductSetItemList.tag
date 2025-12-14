<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="productSetItem" tagdir="/WEB-INF/tags/shared/ui/List" %>
<%@ attribute name="products" required="true" type="java.util.List" %>
<%@ attribute name="className" required="false" %>

<!-- 제품 세트 리스트 -->
<section class="flex flex-col w-full ${className}" aria-label="제품 목록">
    <ul class="list-none p-0 m-0 flex flex-col gap-4">
        <c:forEach var="product" items="${products}" varStatus="status">
            <productSetItem:ProductSetItem 
                imageUrl="${product.imageUrl}"
                brand="${product.brand}"
                name="${product.name}"
                showDivider="${!status.last}"
                className="" />
        </c:forEach>
    </ul>
</section>

