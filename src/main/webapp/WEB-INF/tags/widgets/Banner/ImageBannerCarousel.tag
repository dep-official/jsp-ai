<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="banner" tagdir="/WEB-INF/tags/widgets/Banner" %>
<%@ attribute name="banners" required="true" type="java.util.List" %>
<%@ attribute name="className" required="false" %>

<%
    // 고유한 Swiper ID 생성
    String swiperId = "imageBannerSwiper_" + System.currentTimeMillis() + "_" + (int)(Math.random() * 1000);
    jspContext.setAttribute("swiperId", swiperId);
%>

<!-- 이미지 배너 캐러셀 -->
<div class="swiper ${swiperId} w-full ${className}">
    <ul class="swiper-wrapper">
        <c:forEach var="banner" items="${banners}">
            <li class="swiper-slide">
                <banner:ImageBannerItem 
                    imageUrl="${banner.imageUrl}"
                    title="${banner.title}"
                    description="${banner.description}"
                    textColor="${banner.textColor}" />
            </li>
        </c:forEach>
    </ul>
</div>

<!-- Swiper JS -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        new Swiper('.${swiperId}', {
            slidesPerView: 1,
            spaceBetween: 8,
            loop: false,
            autoplay: {
                delay: 3000,
                disableOnInteraction: false,
            },
            pagination: {
                el: '.${swiperId}-pagination',
                clickable: true,
            },
        });
    });
</script>

