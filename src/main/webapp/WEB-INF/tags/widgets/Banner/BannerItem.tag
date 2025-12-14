<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="imageUrl" required="true" %>
<%@ attribute name="title" required="true" %>
<%@ attribute name="description" required="false" %>
<%@ attribute name="showDivider" required="false" type="java.lang.Boolean" %>
<%@ attribute name="className" required="false" %>

<!-- 배너 아이템 -->
<article class="flex flex-col ${className}">
    <div class="flex w-full h-[130px]">
        <!-- 이미지 영역 -->
        <figure class="flex-shrink-0 w-[98px] h-[98px] rounded-full bg-[#F5F7FA] flex items-center justify-center mt-4 ml-3">
            <img 
                src="${imageUrl}" 
                alt="${title}" 
                class="w-[72px] h-[72px] object-cover mix-blend-multiply"
                loading="lazy" />
        </figure>
        
        <!-- 텍스트 영역 -->
        <div class="flex flex-col justify-center ml-[18px] mr-3 flex-1 min-w-0">
            <h3 class="text-[14px] font-bold leading-[1.4285714285714286em] tracking-[-0.05em] text-[#1B1E23] mb-1">
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
            </h3>
            <c:if test="${!empty description}">
                <p class="text-[13px] font-normal leading-[1.4615384615384615em] tracking-[-0.05em] text-[#5C6677]">
                    <%
                        // 줄바꿈 처리: \n을 <br/>로 변환
                        String descStr = (String) jspContext.getAttribute("description");
                        if (descStr != null && !descStr.isEmpty()) {
                            // \n을 |||BREAK|||로 변환
                            descStr = descStr.replace("\n", "|||BREAK|||");
                            descStr = descStr.replace("&#10;", "|||BREAK|||");
                            String[] descLines = descStr.split("\\|\\|\\|BREAK\\|\\|\\|");
                            for (int i = 0; i < descLines.length; i++) {
                                out.print(descLines[i]);
                                if (i < descLines.length - 1) {
                                    out.print("<br/>");
                                }
                            }
                        }
                    %>
                </p>
            </c:if>
        </div>
    </div>
    
    <!-- 구분선 -->
    <c:if test="${showDivider != false}">
        <hr class="w-full h-0 border-0 border-t border-[#EEF0F2] mt-0" aria-hidden="true" />
    </c:if>
</article>

