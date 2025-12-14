<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dialogActions" tagdir="/WEB-INF/tags/widgets/Dialog/ui/DialogActions" %>
<%@ taglib prefix="indicator" tagdir="/WEB-INF/tags/widgets/Dialog/ui/Indicator" %>
<%@ taglib prefix="search" tagdir="/WEB-INF/tags/shared/ui/Search" %>
<%@ taglib prefix="tabs" tagdir="/WEB-INF/tags/widgets/Tabs" %>
<%@ taglib prefix="banner" tagdir="/WEB-INF/tags/widgets/Banner" %>
<%@ taglib prefix="dialogScript" tagdir="/WEB-INF/tags/widgets/Dialog/lib" %>
<%@ attribute name="id" required="false" %>
<%@ attribute name="open" required="false" type="java.lang.Boolean" %>
<%@ attribute name="title" required="true" %>
<%@ attribute name="tabs" required="false" %>
<%@ attribute name="activeTab" required="false" %>
<%@ attribute name="banners" required="true" type="java.util.List" %>
<%@ attribute name="actions" required="false" %>
<%@ attribute name="showCloseButton" required="false" type="java.lang.Boolean" %>
<%@ attribute name="onClose" required="false" %>
<%@ attribute name="onBack" required="false" %>
<%@ attribute name="onSearch" required="false" %>
<%@ attribute name="onChange" required="false" %>
<%@ attribute name="placeholder" required="false" %>
<%@ attribute name="className" required="false" %>

<%
    // open 기본값
    Boolean isOpen = (Boolean) jspContext.getAttribute("open");
    if (isOpen == null) {
        isOpen = false;
    }
    jspContext.setAttribute("isOpen", isOpen);

    // onClose 속성 처리 - 비어있으면 빈 문자열로 설정
    String onCloseValue = (String) jspContext.getAttribute("onClose");
    if (onCloseValue == null) {
        onCloseValue = "";
    }
    jspContext.setAttribute("onCloseValue", onCloseValue);
%>

<!-- 이미지 배너 다이얼로그 -->
<dialog
    <c:if test="${!empty id}">id="${id}"</c:if>
    role="dialog"
    aria-labelledby="dialog-title"
    aria-modal="true"
    class="relative w-full max-w-[335px] rounded-[8px] bg-white shadow-lg p-0 backdrop:bg-black/50 ${className}"
    <c:if test="${isOpen}">open</c:if>>

    <!-- Dialog Top Indicator -->
    <indicator:TopIndicator />


    <!-- 다이얼로그 내용 -->
    <div class="flex overflow-hidden flex-col">
        <!-- 검색 컴포넌트 -->
        <search:Search 
            placeholder="${placeholder}"
            onBack="${onBack}"
            onSearch="${onSearch}"
            onChange="${onChange}"
            className="pl-5" />

        <!-- 탭 컴포넌트 -->
        <c:if test="${!empty tabs}">
            <tabs:Tabs tabs="${tabs}" activeTab="${activeTab}" size="secondary" className="h-[52px]" />
        </c:if>


        <!-- 이미지 배너 리스트 -->
        <div class="px-5 pt-4 pb-[54px] overflow-y-auto max-h-[60vh] [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]">
            <banner:ImageBannerList banners="${banners}" />
        </div>
    </div>

    <!-- 다이얼로그 액션 버튼 -->
    <c:if test="${!empty actions}">
        <dialogActions:DialogActions actions="${actions}" alignment="right" />
    </c:if>

    <!-- Dialog Bottom Indicator -->
    <indicator:BottomIndicator />
</dialog>

<c:if test="${!empty id}">
    <dialogScript:DialogScript dialogId="${id}" />
</c:if>

