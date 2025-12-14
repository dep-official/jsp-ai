<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags/shared/ui/Button" %>
<%@ attribute name="tabs" required="true" %>
<%@ attribute name="activeTab" required="false" %>
<%@ attribute name="className" required="false" %>

<c:choose>
    <c:when test="${fn:contains(tabs, ',')}">
        <c:set var="tabsArray" value="${fn:split(tabs, ',')}" />
    </c:when>
    <c:otherwise>
        <c:set var="tabsArray" value="${tabs}" />
    </c:otherwise>
</c:choose>

<div class="flex items-center gap-1 overflow-x-auto px-5 py-2 ${className}" id="hashtag-tabs-${fn:replace(fn:toLowerCase(tabs), ',', '-')}">
    <c:forEach var="tab" items="${tabsArray}" varStatus="status">
        <c:set var="tabLabel" value="${fn:trim(tab)}" />
        <c:set var="isActive" value="${status.index == activeTab || tabLabel == activeTab}" />
        <div class="hashtag-tab-item" data-tab-index="${status.index}" data-active="${isActive}">
            <ui:HashtagButton label="${tabLabel}" active="${isActive}" />
        </div>
    </c:forEach>
</div>
<script>
(function() {
    const tabsContainer = document.getElementById('hashtag-tabs-${fn:replace(fn:toLowerCase(tabs), ',', '-')}');
    if (!tabsContainer) return;
    
    const tabItems = tabsContainer.querySelectorAll('.hashtag-tab-item');
    
    function updateActiveTab(activeItem) {
        tabItems.forEach(function(item) {
            const button = item.querySelector('button');
            const isActive = item === activeItem;
            
            item.setAttribute('data-active', isActive);
            
            if (isActive) {
                button.className = button.className.replace(/bg-white/g, 'bg-[#1B1E23]')
                    .replace(/border border-\[#DDE0E5\]/g, '')
                    .replace(/text-\[#5C6677\]/g, 'text-white')
                    .replace(/font-normal/g, 'font-medium');
            } else {
                button.className = button.className.replace(/bg-\[#1B1E23\]/g, 'bg-white')
                    .replace(/text-white/g, 'text-[#5C6677]')
                    .replace(/font-medium/g, 'font-normal');
                
                if (!button.className.includes('border')) {
                    button.className += ' border border-[#DDE0E5]';
                }
            }
        });
    }
    
    tabItems.forEach(function(tabItem) {
        tabItem.style.cursor = 'pointer';
        tabItem.addEventListener('click', function() {
            updateActiveTab(this);
        });
    });
})();
</script>

