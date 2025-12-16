<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
    /**
     * 상품 필터링 로직
     * @param {string} filterId - 필터 컴포넌트의 고유 ID
     * @param {string} containerId - 상품 리스트 컨테이너 ID
     * @param {string} countElementId - 건수 표시 요소 ID
     */
    window.createProductFilter = function(filterId, containerId, countElementId) {
        return function(showSoldOut) {
            var countElement = document.getElementById(countElementId);
            var allProductsContainer = document.getElementById(containerId);
            
            if (!allProductsContainer) return;
            
            var productCards = allProductsContainer.querySelectorAll('.product-card-item');
            var visibleCount = 0;
            
            productCards.forEach(function(card) {
                var isSoldOut = card.getAttribute('data-sold-out') === 'true';
                
                // "품절 상품 보기"가 꺼져있고(false), 상품이 품절(true)이면 숨김
                if (!showSoldOut && isSoldOut) {
                    card.style.display = 'none';
                } else {
                    card.style.display = 'flex'; // flex flex-col 이므로
                    visibleCount++;
                }
            });
            
            // 건수 업데이트
            if (countElement) {
                countElement.textContent = new Intl.NumberFormat().format(visibleCount) + '건';
            }
        };
    };
</script>
