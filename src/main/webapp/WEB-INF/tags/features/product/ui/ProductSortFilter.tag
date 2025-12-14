<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="switch" tagdir="/WEB-INF/tags/shared/ui/Switch" %>
<%@ taglib prefix="dropdownMenu" tagdir="/WEB-INF/tags/shared/ui/Menu" %>
<%@ attribute name="sortOption" required="false" %>
<%@ attribute name="sortOptions" required="false" %>
<%@ attribute name="showSoldOut" required="false" type="java.lang.Boolean" %>
<%@ attribute name="totalCount" required="false" type="java.lang.Integer" %>
<%@ attribute name="className" required="false" %>
<%@ attribute name="id" required="false" %>

<%
    // sortOption 기본값
    String sortOptionValue = (String) jspContext.getAttribute("sortOption");
    if (sortOptionValue == null || sortOptionValue.isEmpty()) {
        sortOptionValue = "베스트순";
    }
    jspContext.setAttribute("sortOptionValue", sortOptionValue);
    
    // sortOptions 기본값 (콤마로 구분된 문자열 또는 List)
    Object sortOptionsObj = jspContext.getAttribute("sortOptions");
    java.util.List<String> sortOptionsList = new java.util.ArrayList<>();
    if (sortOptionsObj != null) {
        if (sortOptionsObj instanceof java.util.List) {
            sortOptionsList = (java.util.List<String>) sortOptionsObj;
        } else if (sortOptionsObj instanceof String) {
            String sortOptionsStr = (String) sortOptionsObj;
            if (!sortOptionsStr.isEmpty()) {
                String[] options = sortOptionsStr.split(",");
                for (String option : options) {
                    sortOptionsList.add(option.trim());
                }
            }
        }
    }
    // 기본값: 정렬 옵션이 없으면 기본 옵션들 추가
    if (sortOptionsList.isEmpty()) {
        sortOptionsList.add("베스트순");
        sortOptionsList.add("최신순");
        sortOptionsList.add("가격낮은순");
        sortOptionsList.add("가격높은순");
    }
    jspContext.setAttribute("sortOptionsList", sortOptionsList);
    
    // showSoldOut 기본값
    Boolean showSoldOutValue = (Boolean) jspContext.getAttribute("showSoldOut");
    if (showSoldOutValue == null) {
        showSoldOutValue = false;
    }
    jspContext.setAttribute("showSoldOutValue", showSoldOutValue);
    
    // totalCount 기본값
    Integer totalCountValue = (Integer) jspContext.getAttribute("totalCount");
    if (totalCountValue == null) {
        totalCountValue = 0;
    }
    jspContext.setAttribute("totalCountValue", totalCountValue);
    
    // ID 처리: 외부에서 지정한 id가 있으면 사용, 없으면 자동 생성
    String externalId = (String) jspContext.getAttribute("id");
    String sortFilterId;
    if (externalId != null && !externalId.isEmpty()) {
        sortFilterId = externalId;
    } else {
        sortFilterId = "productSortFilter_" + System.currentTimeMillis() + "_" + (int)(Math.random() * 1000);
    }
    jspContext.setAttribute("sortFilterId", sortFilterId);
    
    // 건수 포맷팅 (1,234 형식)
    String formattedCount = "0";
    if (totalCountValue != null && totalCountValue > 0) {
        java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
        formattedCount = nf.format(totalCountValue);
    }
    jspContext.setAttribute("formattedCount", formattedCount);
%>

<!-- 정렬 및 필터링 바 -->
<div id="${sortFilterId}" class="relative w-full h-[48px] bg-white ${className}">
    <div class="flex items-center gap-0 px-5 py-[6.54px] h-full">
        <!-- 건수 표시: 왼쪽 정렬 -->
        <div class="flex gap-1 items-center mr-auto">
            <span class="text-[#1B1E23] font-medium text-[14px] leading-[1.4285714285714286em] tracking-[-0.05em]">
                총
            </span>
            <span class="text-[#1B1E23] font-medium text-[14px] leading-[1.4285714285714286em] tracking-[-0.05em]">
                ${formattedCount}건
            </span>
        </div>
        
        <!-- 품절 토글: 아이콘 + 텍스트 + 스위치 -->
        <div class="flex items-center gap-[4px] mr-[16px]">
            <img 
                src="${pageContext.request.contextPath}/public/images/icons/ic_info_line.svg" 
                alt=""
                class="flex-shrink-0 w-4 h-4"
                aria-hidden="true" />
            <span class="text-[#3D444F] font-normal text-[14px] leading-[1.4285714285714286em] tracking-[-0.05em] whitespace-nowrap">
                품절
            </span>
            <!-- 토글 스위치 -->
            <switch:Switch 
                id="${sortFilterId}_soldOutSwitch"
                checked="${showSoldOutValue}"
                ariaLabel="품절 상품 표시"
                className="flex-shrink-0" />
        </div>
        
        <!-- 구분선: 세로 구분선 -->
        <div class="w-0 h-4 border-l border-[#DDE0E5] mx-0 flex-shrink-0" aria-hidden="true"></div>
        
        <!-- 정렬 드롭다운: 텍스트 + 화살표 아이콘 -->
        <div class="ml-[16px]">
            <dropdownMenu:DropDownMenu 
                id="${sortFilterId}_sortDropdown"
                label="${sortOptionValue}"
                options="${sortOptionsList}"
                selectedValue="${sortOptionValue}"
                className=""
                buttonClassName=""
                menuClassName="" />
        </div>
        
        <!-- 필터 버튼: 필터 아이콘 -->
        <button
            type="button"
            aria-label="필터"
            class="flex items-center justify-center w-8 h-8 ml-[10px] p-0 bg-transparent cursor-pointer hover:opacity-70 transition-opacity focus:outline-none focus-visible:ring-2 focus-visible:ring-[#1B1E23] focus-visible:ring-offset-2 flex-shrink-0">
            <img 
                src="${pageContext.request.contextPath}/public/images/icons/ic-m-filter.svg" 
                alt="필터"
                class="w-8 h-8" />
        </button>
    </div>
</div>

