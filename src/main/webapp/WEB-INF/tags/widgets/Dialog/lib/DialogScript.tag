<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="dialogId" required="true" %>

<!-- 다이얼로그 공통 스크립트: body 스크롤 잠금/해제, backdrop 클릭 닫기 -->
<script>
(function() {
    const dialogId = '${dialogId}';
    const dialog = document.getElementById(dialogId);
    if (dialog) {
        // 다이얼로그가 열릴 때 body 스크롤 잠금
        const lockBodyScroll = function() {
            document.body.style.overflow = 'hidden';
        };
        
        // 다이얼로그가 닫힐 때 body 스크롤 해제
        const unlockBodyScroll = function() {
            document.body.style.overflow = '';
        };
        
        // open 속성 변경 감지
        const observer = new MutationObserver(function(mutations) {
            mutations.forEach(function(mutation) {
                if (mutation.type === 'attributes' && mutation.attributeName === 'open') {
                    if (dialog.hasAttribute('open')) {
                        lockBodyScroll();
                    } else {
                        unlockBodyScroll();
                    }
                }
            });
        });
        
        observer.observe(dialog, { attributes: true, attributeFilter: ['open'] });
        
        // 초기 상태 확인
        if (dialog.hasAttribute('open')) {
            lockBodyScroll();
        }
        
        // 다이얼로그 닫힘 이벤트 리스너
        dialog.addEventListener('close', unlockBodyScroll);

        // backdrop 클릭 시 다이얼로그 닫기 (드래그와 구분)
        let mouseDownX = 0;
        let mouseDownY = 0;
        let isDragging = false;
        let isMouseDown = false;
        
        dialog.addEventListener('mousedown', function(event) {
            if (event.target === dialog) {
                mouseDownX = event.clientX;
                mouseDownY = event.clientY;
                isDragging = false;
                isMouseDown = true;
            }
        });
        
        dialog.addEventListener('mousemove', function(event) {
            if (isMouseDown && event.target === dialog) {
                const deltaX = Math.abs(event.clientX - mouseDownX);
                const deltaY = Math.abs(event.clientY - mouseDownY);
                // 5px 이상 이동하면 드래그로 간주
                if (deltaX > 5 || deltaY > 5) {
                    isDragging = true;
                }
            }
        });
        
        dialog.addEventListener('mouseup', function(event) {
            isMouseDown = false;
        });
        
        dialog.addEventListener('click', function(event) {
            if (event.target === dialog && !isDragging) {
                dialog.close();
            }
            // 클릭 후 상태 초기화
            isDragging = false;
            isMouseDown = false;
        });
        
        // 터치 이벤트 지원 (모바일)
        let isTouchDown = false;
        
        dialog.addEventListener('touchstart', function(event) {
            if (event.target === dialog) {
                mouseDownX = event.touches[0].clientX;
                mouseDownY = event.touches[0].clientY;
                isDragging = false;
                isTouchDown = true;
            }
        });
        
        dialog.addEventListener('touchmove', function(event) {
            if (isTouchDown && event.target === dialog) {
                const deltaX = Math.abs(event.touches[0].clientX - mouseDownX);
                const deltaY = Math.abs(event.touches[0].clientY - mouseDownY);
                // 5px 이상 이동하면 드래그로 간주
                if (deltaX > 5 || deltaY > 5) {
                    isDragging = true;
                }
            }
        });
        
        dialog.addEventListener('touchend', function(event) {
            if (event.target === dialog && !isDragging) {
                dialog.close();
            }
            // 터치 종료 후 상태 초기화
            isDragging = false;
            isTouchDown = false;
        });
    }
})();
</script>

