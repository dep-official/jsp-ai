<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags/shared/ui/Button" %>
<%@ attribute name="tabs" required="true" %>
<%@ attribute name="activeTab" required="false" %>
<%@ attribute name="size" required="false" %>
<%@ attribute name="className" required="false" %>

<%
    // 고유한 Swiper ID 생성
    String swiperId = "tabsCarousel_" + System.currentTimeMillis() + "_" + (int)(Math.random() * 1000);
    jspContext.setAttribute("swiperId", swiperId);
    
    // 사이즈 기본값
    String tabSize = (String) jspContext.getAttribute("size");
    if (tabSize == null || tabSize.isEmpty()) {
        tabSize = "P2";
    }
    jspContext.setAttribute("tabSize", tabSize);
    
    // activeTab을 숫자로 변환
    Object activeTabObj = jspContext.getAttribute("activeTab");
    Integer activeTabIndex = null;
    if (activeTabObj != null) {
        if (activeTabObj instanceof Integer) {
            activeTabIndex = (Integer) activeTabObj;
        } else if (activeTabObj instanceof String) {
            try {
                activeTabIndex = Integer.parseInt((String) activeTabObj);
            } catch (NumberFormatException e) {
                // 문자열이면 그대로 사용 (예: "전체")
            }
        }
    }
    jspContext.setAttribute("activeTabIndex", activeTabIndex);
%>

<c:choose>
    <c:when test="${fn:contains(tabs, ',')}">
        <c:set var="tabsArray" value="${fn:split(tabs, ',')}" />
    </c:when>
    <c:otherwise>
        <c:set var="tabsArray" value="${tabs}" />
    </c:otherwise>
</c:choose>

<!-- 탭 Carousel 위젯 -->
<nav class="bg-white border-b border-[#DDE0E5] relative ${className}" id="tabs-carousel-${fn:replace(fn:toLowerCase(tabs), ',', '-')}">
    <div class="swiper ${swiperId} h-full [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]">
        <div class="swiper-wrapper px-5">
            <c:forEach var="tab" items="${tabsArray}" varStatus="status">
                <c:set var="tabLabel" value="${fn:trim(tab)}" />
                <c:set var="isActive" value="${(activeTabIndex != null && status.index == activeTabIndex) || (activeTabIndex == null && (status.index == activeTab || tabLabel == activeTab))}" />
                <div class="swiper-slide relative h-full tab-item w-auto ${status.index > 0 ? 'pl-6' : ''}" data-tab-index="${status.index}" data-active="${isActive}">
                    <ui:TextButton label="${tabLabel}" size="${tabSize}" active="${isActive}" className="w-auto" />
                    <c:if test="${isActive}">
                        <div class="tab-active-bar absolute bottom-0 left-0 right-0 h-[2px] bg-[#1B1E23] transition-all duration-200 ease-smooth"></div>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </div>
</nav>

<script>
(function() {
    function initSwiper() {
        const swiperElement = document.querySelector('.${swiperId}');
        if (!swiperElement) return null;
        
        // 이미 초기화된 Swiper가 있으면 제거
        if (swiperElement.swiper) {
            swiperElement.swiper.destroy(true, true);
        }
        
        const swiper = new Swiper('.${swiperId}', {
            slidesPerView: 'auto',
            freeMode: true,
            resistance: true,
            resistanceRatio: 0,
            touchRatio: 1,
            touchAngle: 45,
            threshold: 5,
        });
        
        return swiper;
    }
    
    // DOMContentLoaded 또는 즉시 초기화
    let swiperInstance = null;
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', function() {
            swiperInstance = initSwiper();
        });
    } else {
        swiperInstance = initSwiper();
    }
    
    // 다이얼로그가 열릴 때도 초기화
    const swiperElement = document.querySelector('.${swiperId}');
    if (swiperElement) {
        const dialog = swiperElement.closest('dialog');
        if (dialog) {
            // 다이얼로그가 열릴 때 Swiper 초기화
            const observer = new MutationObserver(function() {
                if (dialog.hasAttribute('open')) {
                    setTimeout(function() {
                        swiperInstance = initSwiper();
                    }, 100);
                }
            });
            observer.observe(dialog, { attributes: true, attributeFilter: ['open'] });
        }
    }
    
    // 전역 변수로 Swiper 인스턴스 저장
    window['swiper_${swiperId}'] = function() {
        const swiperEl = document.querySelector('.${swiperId}');
        return swiperEl && swiperEl.swiper ? swiperEl.swiper : swiperInstance;
    };
})();
</script>

<script>
(function() {
    const tabsContainer = document.getElementById('tabs-carousel-${fn:replace(fn:toLowerCase(tabs), ',', '-')}');
    if (!tabsContainer) return;
    
    const tabSize = '${tabSize}';
    const tabItems = tabsContainer.querySelectorAll('.tab-item');
    
    function getSwiper() {
        return window['swiper_${swiperId}'] ? window['swiper_${swiperId}']() : null;
    }
    
    function updateActiveTab(activeItem) {
        tabItems.forEach(function(item) {
            const button = item.querySelector('button');
            const activeBar = item.querySelector('.tab-active-bar');
            const isActive = item === activeItem;
            
            item.setAttribute('data-active', isActive);
            
            if (isActive) {
                if (tabSize === 'H4') {
                    button.className = button.className.replace(/text-\[#ABB2BE\]/g, 'text-[#1B1E23]');
                } else if (tabSize === 'P2') {
                    button.className = button.className.replace(/text-\[#788497\]/g, 'text-[#1B1E23]').replace(/font-normal/g, 'font-bold');
                }
                
                if (!activeBar) {
                    const bar = document.createElement('div');
                    bar.className = 'tab-active-bar absolute bottom-0 left-0 right-0 h-[2px] bg-[#1B1E23] transition-all duration-200 ease-smooth';
                    item.appendChild(bar);
                }
            } else {
                if (tabSize === 'H4') {
                    button.className = button.className.replace(/text-\[#1B1E23\]/g, 'text-[#ABB2BE]');
                } else if (tabSize === 'P2') {
                    button.className = button.className.replace(/text-\[#1B1E23\]/g, 'text-[#788497]').replace(/font-bold/g, 'font-normal');
                }
                
                if (activeBar) {
                    activeBar.remove();
                }
            }
        });
    }
    
    let isDragging = false;
    let startX = 0;
    let startY = 0;
    
    tabItems.forEach(function(tabItem) {
        tabItem.style.cursor = 'pointer';
        
        // 드래그 시작 감지
        tabItem.addEventListener('mousedown', function(e) {
            startX = e.clientX;
            startY = e.clientY;
            isDragging = false;
        });
        
        tabItem.addEventListener('mousemove', function(e) {
            if (startX !== 0 || startY !== 0) {
                const deltaX = Math.abs(e.clientX - startX);
                const deltaY = Math.abs(e.clientY - startY);
                if (deltaX > 5 || deltaY > 5) {
                    isDragging = true;
                }
            }
        });
        
        tabItem.addEventListener('mouseup', function(e) {
            if (!isDragging) {
                updateActiveTab(this);
            }
            startX = 0;
            startY = 0;
            isDragging = false;
        });
        
        // 터치 이벤트도 처리
        tabItem.addEventListener('touchstart', function(e) {
            startX = e.touches[0].clientX;
            startY = e.touches[0].clientY;
            isDragging = false;
        });
        
        tabItem.addEventListener('touchmove', function(e) {
            if (startX !== 0 || startY !== 0) {
                const deltaX = Math.abs(e.touches[0].clientX - startX);
                const deltaY = Math.abs(e.touches[0].clientY - startY);
                if (deltaX > 5 || deltaY > 5) {
                    isDragging = true;
                }
            }
        });
        
        tabItem.addEventListener('touchend', function(e) {
            if (!isDragging) {
                updateActiveTab(this);
            }
            startX = 0;
            startY = 0;
            isDragging = false;
        });
    });
})();
</script>

