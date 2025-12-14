<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags/shared/ui/Button" %>
<%@ attribute name="tabs" required="true" %>
<%@ attribute name="activeTab" required="false" %>
<%@ attribute name="size" required="false" %>
<%@ attribute name="className" required="false" %>
<%@ attribute name="sections" required="false" %>
<%@ attribute name="tabBarHeight" required="false" %>

<c:choose>
    <c:when test="${empty size}">
        <c:set var="tabSize" value="primary" />
    </c:when>
    <c:otherwise>
        <c:set var="tabSize" value="${size}" />
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${tabSize == 'secondary'}">
        <c:set var="containerClass" value="flex items-center gap-[24px] overflow-x-auto whitespace-nowrap px-5 [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]" />
    </c:when>
    <c:otherwise>
        <c:set var="containerClass" value="flex items-center justify-between px-5" />
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${fn:contains(tabs, ',')}">
        <c:set var="tabsArray" value="${fn:split(tabs, ',')}" />
    </c:when>
    <c:otherwise>
        <c:set var="tabsArray" value="${tabs}" />
    </c:otherwise>
</c:choose>

<aside class="bg-white border-b border-[#DDE0E5] container mx-auto max-w-[604px] lg:border-0 relative ${className}" id="tabs-${fn:replace(fn:toLowerCase(tabs), ',', '-')}">
    <ul class="h-full ${containerClass}">
        <c:forEach var="tab" items="${tabsArray}" varStatus="status">
            <c:set var="tabLabel" value="${fn:trim(tab)}" />
            <c:set var="isActive" value="${status.index == activeTab || tabLabel == activeTab}" />
            <li class="${tabSize == 'primary' ? 'flex-1' : 'flex-shrink-0'} relative h-full tab-item" data-tab-index="${status.index}" data-active="${isActive}">
                <ui:TextButton label="${tabLabel}" size="${tabSize}" active="${isActive}" className="${tabSize == 'secondary' ? 'w-auto' : ''}" />
                <c:if test="${isActive}">
                    <div class="tab-active-bar absolute bottom-0 left-0 right-0 h-[2px] bg-[#1B1E23] transition-all duration-200 ease-smooth"></div>
                </c:if>
            </li>
        </c:forEach>
    </ul>
</aside>

<!-- TabScrollHandler -->
<%@ include file="/WEB-INF/tags/widgets/Tabs/lib/TabScrollHandler.tag" %>

<!-- TabScrollHandler 초기화 -->
<script>
(function() {
    var navElement = document.getElementById('tabs-<c:out value="${fn:replace(fn:toLowerCase(tabs), ',', '-')}" />');
    if (!navElement) return;
    
    var tabsContainerId = navElement.id;
    var tabBarHeight = <c:out value="${empty tabBarHeight ? 56 : tabBarHeight}" />;
    
    // tabs 속성 기반으로 자동 매핑 (고정된 섹션 ID)
    var sectionsData = {};
    var tabsArray = [<c:forEach var="tab" items="${tabsArray}" varStatus="status">'<c:out value="${fn:trim(tab)}" />'<c:if test="${!status.last}">,</c:if></c:forEach>];
    tabsArray.forEach(function(tabName, index) {
        var sectionId = '';
        if (tabName === '행사') {
            sectionId = 'section-event';
        } else if (tabName === '추천상품') {
            sectionId = 'section-recommended';
        } else if (tabName === '전체상품') {
            sectionId = 'section-all';
        } else {
            // 기본 패턴: section-{tabName을 소문자로 변환하고 공백을 하이픈으로}
            sectionId = 'section-' + tabName.toLowerCase().replace(/\s+/g, '-');
        }
        if (sectionId) {
            sectionsData[index] = sectionId;
        }
    });
    
    function initTabScrollHandler() {
        if (typeof window.TabScrollHandler === 'undefined') {
            setTimeout(initTabScrollHandler, 100);
            return;
        }
        
        if (navElement.hasAttribute('data-tab-scroll-initialized')) {
            return;
        }
        navElement.setAttribute('data-tab-scroll-initialized', 'true');
        
        new window.TabScrollHandler({
            tabsContainerId: tabsContainerId,
            sections: sectionsData,
            tabBarHeight: tabBarHeight
        });
    }
    
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initTabScrollHandler);
    } else {
        setTimeout(initTabScrollHandler, 0);
    }
})();
</script>

