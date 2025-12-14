<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="imageUrl" required="true" %>
<%@ attribute name="title" required="true" %>
<%@ attribute name="description" required="false" %>
<%@ attribute name="textColor" required="false" %>
<%@ attribute name="className" required="false" %>

<%
    // 텍스트 색상 기본값 설정
    String textColorValue = (String) jspContext.getAttribute("textColor");
    if (textColorValue == null || textColorValue.isEmpty()) {
        textColorValue = "white"; // 기본값: 흰색
    }
    jspContext.setAttribute("textColorValue", textColorValue);
    
    // 텍스트 색상 클래스 결정
    String titleColorClass = "";
    String descColorClass = "";
    if ("dark".equals(textColorValue)) {
        titleColorClass = "text-[#1B1E23]";
        descColorClass = "text-[#5C6677]";
    } else {
        titleColorClass = "text-white";
        descColorClass = "text-white";
    }
    jspContext.setAttribute("titleColorClass", titleColorClass);
    jspContext.setAttribute("descColorClass", descColorClass);
%>

<!-- 이미지 배너 아이템 -->
<dl class="list-none relative flex items-center pl-5 w-full h-[118px] rounded overflow-hidden ${className}">
    <!-- 배경 이미지 -->
    <figure class="absolute overflow-hidden inset-0 w-full h-full">
        <img 
            src="${imageUrl}" 
            alt="${title}" 
            class="object-cover w-full h-full"
            loading="lazy" />
    </figure>
    
    <!-- 텍스트 오버레이 -->
    <div class="flex relative z-10 flex-col gap-1 w-full">
        <!-- 제목 -->
        <dt class="${titleColorClass} text-[16px] font-bold leading-[1.5em] tracking-[-0.05em]">
            <%
                // 줄바꿈 처리: \n을 <br/>로 변환
                String titleStr = (String) jspContext.getAttribute("title");
                if (titleStr != null && !titleStr.isEmpty()) {
                    // \n을 |||BREAK|||로 변환
                    titleStr = titleStr.replace("\n", "|||BREAK|||");
                    titleStr = titleStr.replace("&#10;", "|||BREAK|||");
                    String[] titleLines = titleStr.split("\\|\\|\\|BREAK\\|\\|\\|");
                    for (int i = 0; i < titleLines.length; i++) {
                        out.print(titleLines[i]);
                        if (i < titleLines.length - 1) {
                            out.print("<br/>");
                        }
                    }
                }
            %>
        </dt>
        <!-- 설명 -->
        <c:if test="${!empty description}">
            <dd class="${descColorClass} text-[13px] font-normal leading-[1.46em] tracking-[-0.05em]">
                ${description}
            </dd>
        </c:if>
    </dl>
</li>

