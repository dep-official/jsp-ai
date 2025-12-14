<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="id" required="false" %>
<%@ attribute name="label" required="true" %>
<%@ attribute name="options" required="true" type="java.util.List" %>
<%@ attribute name="selectedValue" required="false" %>
<%@ attribute name="onChange" required="false" %>
<%@ attribute name="className" required="false" %>
<%@ attribute name="buttonClassName" required="false" %>
<%@ attribute name="menuClassName" required="false" %>

<%
    // 고유 ID 생성
    String dropdownId = (String) jspContext.getAttribute("id");
    if (dropdownId == null || dropdownId.isEmpty()) {
        dropdownId = "dropdown_" + System.currentTimeMillis() + "_" + (int)(Math.random() * 1000);
    }
    jspContext.setAttribute("dropdownId", dropdownId);
    
    // selectedValue 기본값
    String selectedValue = (String) jspContext.getAttribute("selectedValue");
    if (selectedValue == null) {
        selectedValue = "";
    }
    jspContext.setAttribute("selectedValue", selectedValue);
    
    // onChange 기본값
    String onChangeValue = (String) jspContext.getAttribute("onChange");
    if (onChangeValue == null) {
        onChangeValue = "";
    }
    jspContext.setAttribute("onChangeValue", onChangeValue);
    
    // buttonClassName 기본값
    String buttonClassNameValue = (String) jspContext.getAttribute("buttonClassName");
    if (buttonClassNameValue == null) {
        buttonClassNameValue = "";
    }
    jspContext.setAttribute("buttonClassNameValue", buttonClassNameValue);
    
    // menuClassName 기본값
    String menuClassNameValue = (String) jspContext.getAttribute("menuClassName");
    if (menuClassNameValue == null) {
        menuClassNameValue = "";
    }
    jspContext.setAttribute("menuClassNameValue", menuClassNameValue);
%>

<div class="relative ${className}">
    <button
        type="button"
        id="${dropdownId}_button"
        aria-label="옵션 선택"
        aria-expanded="false"
        aria-haspopup="true"
        class="dropdown-btn flex items-center gap-1 px-0 py-0 bg-transparent border-0 text-[#5C6677] font-medium text-[13px] leading-[1.4615384615384615em] tracking-[-0.05em] cursor-pointer hover:text-[#3D444F] transition-colors focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2 whitespace-nowrap ${buttonClassNameValue}">
        <span id="${dropdownId}_text">${label}</span>
        <img 
            id="${dropdownId}_arrow"
            src="${pageContext.request.contextPath}/public/images/icons/ic-m-arrow-down.svg" 
            alt=""
            class="flex-shrink-0 w-4 h-4 transition-transform duration-200"
            aria-hidden="true" />
    </button>
    
    <!-- 드롭다운 메뉴 -->
    <div
        id="${dropdownId}_menu"
        class="absolute top-full right-0 mt-2 w-[120px] bg-white rounded-[8px] shadow-lg border border-[#1B1E23] z-50 hidden ${menuClassNameValue}">
        <ul class="py-2" role="menu" aria-labelledby="${dropdownId}_button">
            <c:forEach var="option" items="${options}">
                <%
                    String optionValue = (String) jspContext.getAttribute("option");
                    boolean isSelected = optionValue != null && optionValue.equals(selectedValue);
                    String optionClass = isSelected ? "text-[#1B1E23] font-medium underline" : "text-[#3D444F] font-normal";
                    jspContext.setAttribute("optionClass", optionClass);
                %>
                <li role="none" class="mx-[8px] rounded-[8px] overflow-hidden">
                    <button
                        type="button"
                        role="menuitem"
                        data-option="${option}"
                        class="dropdown-option-btn w-full px-2 py-2 text-left text-[12px] leading-[1.4285714285714286em] tracking-[-0.05em] hover:bg-[#F4F5F7] transition-colors focus:outline-none focus:bg-[#F4F5F7] ${optionClass}">
                        ${option}
                    </button>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>

<script>
(function() {
    var dropdownId = '${dropdownId}';
    var menu = document.getElementById(dropdownId + '_menu');
    var button = document.getElementById(dropdownId + '_button');
    var text = document.getElementById(dropdownId + '_text');
    var arrow = document.getElementById(dropdownId + '_arrow');
    var isOpen = false;
    var onChangeHandler = ${onChangeValue != null && !onChangeValue.isEmpty() ? "'" + onChangeValue.replace("'", "\\'") + "'" : "null"};
    
    if (!menu || !button) return;
    
    // 드롭다운 버튼 클릭 이벤트
    button.addEventListener('click', function(e) {
        e.stopPropagation();
        isOpen = !isOpen;
        
        if (isOpen) {
            menu.classList.remove('hidden');
            button.setAttribute('aria-expanded', 'true');
            arrow.style.transform = 'rotate(180deg)';
        } else {
            menu.classList.add('hidden');
            button.setAttribute('aria-expanded', 'false');
            arrow.style.transform = 'rotate(0deg)';
        }
    });
    
    // 옵션 선택 이벤트
    var menuItems = menu.querySelectorAll('.dropdown-option-btn');
    menuItems.forEach(function(btn) {
        btn.addEventListener('click', function(e) {
            e.stopPropagation();
            var selectedOption = btn.getAttribute('data-option');
            text.textContent = selectedOption;
            isOpen = false;
            menu.classList.add('hidden');
            button.setAttribute('aria-expanded', 'false');
            arrow.style.transform = 'rotate(0deg)';
            
            // 선택된 항목 스타일 업데이트
            menuItems.forEach(function(item) {
                var option = item.getAttribute('data-option');
                if (option === selectedOption) {
                    item.classList.remove('text-[#3D444F]', 'font-normal');
                    item.classList.add('text-[#1B1E23]', 'font-medium', 'underline');
                } else {
                    item.classList.remove('text-[#1B1E23]', 'font-medium', 'underline');
                    item.classList.add('text-[#3D444F]', 'font-normal');
                }
            });
            
            // onChange 핸들러 호출
            if (onChangeHandler) {
                try {
                    if (typeof window[onChangeHandler] === 'function') {
                        window[onChangeHandler](selectedOption);
                    } else {
                        var handlerCode = onChangeHandler;
                        if (handlerCode.indexOf('(') === -1) {
                            handlerCode = handlerCode + '(' + JSON.stringify(selectedOption) + ')';
                        }
                        eval(handlerCode);
                    }
                } catch (e) {
                    console.error('DropDownMenu onChange handler error:', e);
                }
            }
        });
    });
    
    // 외부 클릭 시 드롭다운 닫기
    document.addEventListener('click', function(event) {
        if (!button.contains(event.target) && !menu.contains(event.target)) {
            if (isOpen) {
                isOpen = false;
                menu.classList.add('hidden');
                button.setAttribute('aria-expanded', 'false');
                arrow.style.transform = 'rotate(0deg)';
            }
        }
    });
})();
</script>

