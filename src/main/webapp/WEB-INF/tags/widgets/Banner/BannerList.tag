<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="banner" tagdir="/WEB-INF/tags/widgets/Banner" %>
<%@ attribute name="banners" required="true" type="java.util.List" %>
<%@ attribute name="className" required="false" %>

<!-- 배너 리스트 -->
<section class="flex flex-col w-full max-w-[335px] ${className}" aria-label="배너 목록">
    <c:forEach var="banner" items="${banners}" varStatus="status">
        <banner:BannerItem 
            imageUrl="${banner.imageUrl}"
            title="${banner.title}"
            description="${banner.description}"
            showDivider="${!status.last}"
            className="${status.first ? '' : ''}" />
    </c:forEach>
</section>

