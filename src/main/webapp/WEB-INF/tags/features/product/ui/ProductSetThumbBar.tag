<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="thumbnails" required="true" type="java.util.List" %>
<%@ attribute name="title" required="false" %>
<%@ attribute name="onClick" required="false" %>
<%@ attribute name="className" required="false" %>

<%
    // title 기본값
    String titleValue = (String) jspContext.getAttribute("title");
    if (titleValue == null || titleValue.isEmpty()) {
        titleValue = "상품 구성";
    }
    jspContext.setAttribute("titleValue", titleValue);
    
    // onClick 기본값
    String onClickValue = (String) jspContext.getAttribute("onClick");
    if (onClickValue == null) {
        onClickValue = "";
    }
    jspContext.setAttribute("onClickValue", onClickValue);
    
    // 썸네일 리스트 처리 (최대 4개 표시, 4개 이상이면 4번째에 +N 오버레이)
    java.util.List thumbnailsList = (java.util.List) jspContext.getAttribute("thumbnails");
    int totalCount = thumbnailsList != null ? thumbnailsList.size() : 0;
    int displayCount = Math.min(totalCount, 4);
    int remainingCount = totalCount > 4 ? totalCount - 4 : 0;
    
    jspContext.setAttribute("displayCount", displayCount);
    jspContext.setAttribute("remainingCount", remainingCount);
%>

<!-- 제품 세트 썸네일 바 -->
<div class="flex items-center justify-between w-full h-[32px] ${className}" 
     <c:if test="${!empty onClickValue}">onclick="${onClickValue}"</c:if>>
    <!-- 제목 영역: 아이콘 + 텍스트 -->
    <div class="flex items-center gap-[4px]">
        <img 
            src="${pageContext.request.contextPath}/public/images/icons/ic-set-12.svg" 
            alt=""
            class="w-3 h-3"
            aria-hidden="true" />
        <span class="text-[#3D444F] font-normal text-[12px] leading-[1.5em] tracking-[-0.05em]">
            ${titleValue}
        </span>
    </div>
    
    <!-- 썸네일 리스트 -->
    <div class="flex items-center gap-[1px]">
        <c:forEach var="thumbnail" items="${thumbnails}" varStatus="status" begin="0" end="3">
            <c:choose>
                <c:when test="${status.first}">
                    <!-- 첫 번째 썸네일: 왼쪽만 둥글게 -->
                    <figure class="overflow-hidden relative flex-shrink-0 w-8 h-8 rounded-l">
                        <img 
                            src="${thumbnail.imageUrl}" 
                            alt="${thumbnail.alt != null ? thumbnail.alt : '제품 이미지'}"
                            class="object-cover w-full h-full"
                            loading="lazy" />
                    </figure>
                </c:when>
                <c:when test="${status.last && remainingCount == 0}">
                    <!-- 마지막 썸네일 (오버레이 없을 때): 오른쪽만 둥글게 -->
                    <figure class="overflow-hidden relative flex-shrink-0 w-8 h-8 rounded-r">
                        <img 
                            src="${thumbnail.imageUrl}" 
                            alt="${thumbnail.alt != null ? thumbnail.alt : '제품 이미지'}"
                            class="object-cover w-full h-full"
                            loading="lazy" />
                    </figure>
                </c:when>
                <c:when test="${status.last && remainingCount > 0}">
                    <!-- 4번째 썸네일 (오버레이 있을 때): 오른쪽만 둥글게, +N 오버레이 -->
                    <figure class="overflow-hidden relative flex-shrink-0 w-8 h-8 rounded-r">
                        <img 
                            src="${thumbnail.imageUrl}" 
                            alt="${thumbnail.alt != null ? thumbnail.alt : '제품 이미지'}"
                            class="object-cover w-full h-full"
                            loading="lazy" />
                        <!-- 오버레이 -->
                        <figcaption class="absolute inset-0 bg-[#1B1E23] opacity-50 flex items-center justify-center rounded-r">
                            <span class="text-white font-medium text-[11px] leading-[1.545em] tracking-[-0.05em]">
                                +${remainingCount}
                            </span>
                        </figcaption>
                    </figure>
                </c:when>
                <c:otherwise>
                    <!-- 중간 썸네일: 둥글지 않음 -->
                    <figure class="overflow-hidden relative flex-shrink-0 w-8 h-8">
                        <img 
                            src="${thumbnail.imageUrl}" 
                            alt="${thumbnail.alt != null ? thumbnail.alt : '제품 이미지'}"
                            class="object-cover w-full h-full"
                            loading="lazy" />
                    </figure>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
</div>

