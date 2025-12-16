<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="swiperId" required="true" %>
<%@ attribute name="paginationClass" required="true" %>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var swiperId = '${swiperId}';
        var paginationEl = '.' + '${paginationClass}';
        var swiperElement = document.querySelector('.' + swiperId);
        
        if (!swiperElement) {
            console.error('Swiper element not found:', '.' + swiperId);
            return;
        }
        
        var paginationContainer = document.querySelector(paginationEl);
        if (!paginationContainer) {
            console.error('Pagination container not found:', paginationEl);
            return;
        }
        
        // Swiper 기본 CSS의 position: absolute를 relative로 강제 오버라이드
        paginationContainer.style.setProperty('position', 'relative', 'important');
        paginationContainer.style.setProperty('text-align', 'center', 'important');
        
        var swiper = new Swiper('.' + swiperId, {
            slidesPerView: 1,
            spaceBetween: 0,
            autoHeight: true,
            pagination: {
                el: paginationContainer,
                clickable: true,
                renderBullet: function (index, className) {
                    var isActive = index === 0;
                    var bgColor = isActive ? '#1B1E23' : '#EBEBEB';
                    return '<span class="' + className + '" style="width: 8px !important; height: 8px !important; margin: 0 !important; opacity: 1 !important; border-radius: 50% !important; background-color: ' + bgColor + ' !important;"></span>';
                },
            },
        });
        
        // Swiper 초기화 완료 후 position 재설정
        swiper.on('init', function() {
            paginationContainer.style.setProperty('position', 'relative', 'important');
        });
        
        // 활성화된 인디케이터 스타일 적용
        swiper.on('slideChange', function () {
            var bullets = document.querySelectorAll(paginationEl + ' .swiper-pagination-bullet');
            bullets.forEach(function(bullet, index) {
                if (index === swiper.activeIndex) {
                    bullet.style.setProperty('background-color', '#1B1E23', 'important');
                } else {
                    bullet.style.setProperty('background-color', '#EBEBEB', 'important');
                }
            });
        });
    });
</script>
