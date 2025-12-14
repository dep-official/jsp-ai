<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="id" required="false" %>
<%@ attribute name="message" required="true" %>
<%@ attribute name="duration" required="false" type="java.lang.Integer" %>
<%@ attribute name="className" required="false" %>

<%
    // duration 기본값 (밀리초, 0이면 자동으로 사라지지 않음)
    Integer durationValue = (Integer) jspContext.getAttribute("duration");
    if (durationValue == null) {
        durationValue = 3000; // 기본 3초
    }
    jspContext.setAttribute("durationValue", durationValue);
    
    // 고유 ID 생성 (id가 없을 경우)
    String toastId = (String) jspContext.getAttribute("id");
    if (toastId == null || toastId.isEmpty()) {
        toastId = "toast_" + System.currentTimeMillis() + "_" + (int)(Math.random() * 1000);
    }
    jspContext.setAttribute("toastId", toastId);
%>

<!-- Toast 알림 -->
<div 
    id="${toastId}"
    role="alert"
    aria-live="polite"
    class="fixed left-1/2 top-[20px] -translate-x-1/2 z-[9999] flex items-center justify-center px-6 py-2 rounded-[18px] bg-[rgba(92,102,119,0.9)] backdrop-blur-sm shadow-lg ${className}"
    style="display: none;">
    <p class="text-white font-medium text-[13px] leading-[1.4615384615384615em] tracking-[-0.05em] text-center whitespace-nowrap">
        ${message}
    </p>
</div>

<script>
(function() {
    var toastId = '${toastId}';
    var duration = ${durationValue};
    var toastElement = document.getElementById(toastId);
    
    if (!toastElement) return;
    
    // Toast 표시 함수
    function showToast() {
        toastElement.style.display = 'flex';
        toastElement.style.animation = 'fadeInDown 0.3s ease-out';
        
        // duration이 0보다 크면 자동으로 사라지게 함
        if (duration > 0) {
            setTimeout(function() {
                hideToast();
            }, duration);
        }
    }
    
    // Toast 숨김 함수
    function hideToast() {
        toastElement.style.animation = 'fadeOutUp 0.3s ease-in';
        setTimeout(function() {
            toastElement.style.display = 'none';
        }, 300);
    }
    
    // 전역 함수로 노출 (외부에서 호출 가능)
    window['showToast_' + toastId] = showToast;
    window['hideToast_' + toastId] = hideToast;
    
    // CSS 애니메이션 추가 (이미 있으면 추가하지 않음)
    if (!document.getElementById('toast-animations')) {
        var style = document.createElement('style');
        style.id = 'toast-animations';
        style.textContent = '@keyframes fadeInDown { from { opacity: 0; transform: translate(-50%, -20px); } to { opacity: 1; transform: translate(-50%, 0); } } @keyframes fadeOutUp { from { opacity: 1; transform: translate(-50%, 0); } to { opacity: 0; transform: translate(-50%, -20px); } }';
        document.head.appendChild(style);
    }
})();
</script>

