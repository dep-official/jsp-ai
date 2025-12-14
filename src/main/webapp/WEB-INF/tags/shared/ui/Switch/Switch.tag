<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="id" required="false" %>
<%@ attribute name="checked" required="false" type="java.lang.Boolean" %>
<%@ attribute name="onChange" required="false" %>
<%@ attribute name="ariaLabel" required="false" %>
<%@ attribute name="disabled" required="false" type="java.lang.Boolean" %>
<%@ attribute name="className" required="false" %>

<%
    // checked 기본값
    Boolean checkedValue = (Boolean) jspContext.getAttribute("checked");
    if (checkedValue == null) {
        checkedValue = false;
    }
    jspContext.setAttribute("checkedValue", checkedValue);
    
    // onChange 기본값
    String onChangeValue = (String) jspContext.getAttribute("onChange");
    if (onChangeValue == null) {
        onChangeValue = "";
    }
    jspContext.setAttribute("onChangeValue", onChangeValue);
    
    // disabled 기본값
    Boolean disabledValue = (Boolean) jspContext.getAttribute("disabled");
    if (disabledValue == null) {
        disabledValue = false;
    }
    jspContext.setAttribute("disabledValue", disabledValue);
    
    // ariaLabel 기본값
    String ariaLabelValue = (String) jspContext.getAttribute("ariaLabel");
    if (ariaLabelValue == null || ariaLabelValue.isEmpty()) {
        ariaLabelValue = "토글 스위치";
    }
    jspContext.setAttribute("ariaLabelValue", ariaLabelValue);
    
    // 고유 ID 생성
    String switchId = (String) jspContext.getAttribute("id");
    if (switchId == null || switchId.isEmpty()) {
        switchId = "switch_" + System.currentTimeMillis() + "_" + (int)(Math.random() * 1000);
    }
    jspContext.setAttribute("switchId", switchId);
%>

<!-- 토글 스위치 -->
<button
    type="button"
    id="${switchId}"
    role="switch"
    aria-checked="${checkedValue}"
    aria-label="${ariaLabelValue}"
    <c:if test="${disabledValue}">disabled</c:if>
    class="relative w-[34px] h-5 rounded-full transition-colors duration-200 focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2 ${checkedValue ? 'bg-[#1B1E23]' : 'bg-[#DDE0E5]'} ${disabledValue ? 'opacity-50 cursor-not-allowed' : 'cursor-pointer'} ${className}"
    onclick="toggleSwitch_${switchId}()">
    <span class="absolute top-1 left-1 w-3 h-3 bg-white rounded-full transition-transform duration-200 ${checkedValue ? 'translate-x-[14px]' : 'translate-x-0'}"></span>
</button>

<script>
(function() {
    var switchId = '${switchId}';
    var switchElement = document.getElementById(switchId);
    var isChecked = ${checkedValue};
    var onChangeHandler = ${onChangeValue != null && !onChangeValue.isEmpty() ? "'" + onChangeValue.replace("'", "\\'") + "'" : "null"};
    
    if (!switchElement) return;
    
    // 전역 토글 함수 생성
    window['toggleSwitch_' + switchId] = function() {
        if (switchElement.disabled) return;
        
        // 상태 토글
        isChecked = !isChecked;
        
        // UI 업데이트
        switchElement.setAttribute('aria-checked', isChecked);
        switchElement.classList.toggle('bg-[#1B1E23]', isChecked);
        switchElement.classList.toggle('bg-[#DDE0E5]', !isChecked);
        
        var thumb = switchElement.querySelector('span');
        if (thumb) {
            thumb.classList.toggle('translate-x-[14px]', isChecked);
            thumb.classList.toggle('translate-x-0', !isChecked);
        }
        
        // onChange 핸들러 호출
        if (onChangeHandler) {
            try {
                // 함수명인 경우
                if (typeof window[onChangeHandler] === 'function') {
                    window[onChangeHandler](isChecked);
                } else {
                    // 문자열 코드인 경우
                    var handlerCode = onChangeHandler;
                    if (handlerCode.indexOf('(') === -1) {
                        handlerCode = handlerCode + '(' + isChecked + ')';
                    } else {
                        handlerCode = handlerCode.replace(/(\(\))/g, '(' + isChecked + ')');
                    }
                    eval(handlerCode);
                }
            } catch (e) {
                console.error('Switch onChange handler error:', e);
            }
        }
    };
    
    // 초기 상태 설정
    switchElement.setAttribute('aria-checked', isChecked);
})();
</script>

