<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags/shared/ui/Tag" %>
<%@ taglib prefix="banner" tagdir="/WEB-INF/tags/widgets/Banner" %>
<%@ attribute name="items" required="true" type="java.util.List" %>
<%@ attribute name="className" required="false" %>

<!-- 이벤트 배너 리스트 (사은품) -->
<div class="relative w-full bg-[#FAF9F7] rounded-[8px] p-2 ${className}">
    <!-- Gift 배지 (좌측 상단) -->
    <tag:Tag label="Gift" variant="gift" className="absolute top-0 left-0 z-10" />
    
    <!-- 이벤트 배너 항목 리스트 -->
    <ul class="flex flex-col gap-2">
        <c:forEach var="item" items="${items}" varStatus="status">
            <banner:EventBannerItem 
                imageUrl="${item.imageUrl}"
                condition="${item.condition}"
                description="${item.description}"
                showDivider="${!status.last}" />
        </c:forEach>
    </ul>
</div>

