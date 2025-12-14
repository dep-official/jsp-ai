<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="banner" tagdir="/WEB-INF/tags/widgets/Banner" %>
<%@ attribute name="banners" required="true" type="java.util.List" %>
<%@ attribute name="className" required="false" %>

<!-- 이미지 배너 리스트 -->
<section class="flex flex-col gap-2 w-full ${className}" aria-label="이미지 배너 목록">
    <ul class="list-none p-0 m-0 flex flex-col gap-2">
        <c:forEach var="banner" items="${banners}">
            <banner:ImageBannerItem 
                imageUrl="${banner.imageUrl}"
                title="${banner.title}"
                description="${banner.description}"
                textColor="${banner.textColor}" />
        </c:forEach>
    </ul>
</section>

