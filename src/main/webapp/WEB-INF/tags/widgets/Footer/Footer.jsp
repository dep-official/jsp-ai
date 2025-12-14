<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String contextPath = request.getContextPath();
    String arrowIcon16 = contextPath + "/public/images/icons/ic-m-arrow-right-16.svg";
    String arrowIcon18 = contextPath + "/public/images/icons/ic-m-arrow-right-18.svg";
    pageContext.setAttribute("arrowIcon16", arrowIcon16);
    pageContext.setAttribute("arrowIcon18", arrowIcon18);
    
    // 공지사항 (pageContext에서 가져오거나 기본값 사용)
    java.util.Map<String, Object> notice = (java.util.Map<String, Object>) pageContext.getAttribute("notice");
    if (notice == null) {
        notice = new java.util.HashMap<>();
        notice.put("text", "[공지사항] 로즈몽 外 4개 브랜드 적립금 사용안내");
        notice.put("onClick", "");
    }
    pageContext.setAttribute("notice", notice);
    
    // 안내 링크들 (pageContext에서 가져오거나 기본값 사용)
    java.util.List<java.util.Map<String, Object>> guideLinks = (java.util.List<java.util.Map<String, Object>>) pageContext.getAttribute("guideLinks");
    if (guideLinks == null) {
        guideLinks = new java.util.ArrayList<>();
        String[] guideLabels = {"지점안내", "인도장안내", "고객센터", "입점/제휴"};
        for (String label : guideLabels) {
            java.util.Map<String, Object> link = new java.util.HashMap<>();
            link.put("label", label);
            link.put("href", "#");
            guideLinks.add(link);
        }
    }
    pageContext.setAttribute("guideLinks", guideLinks);
    
    // 푸터 링크들 (pageContext에서 가져오거나 기본값 사용)
    java.util.List<java.util.Map<String, Object>> footerLinks = (java.util.List<java.util.Map<String, Object>>) pageContext.getAttribute("footerLinks");
    if (footerLinks == null) {
        footerLinks = new java.util.ArrayList<>();
        String[] footerLabels = {"H.Point", "Family Site", "㈜현대디에프"};
        for (String label : footerLabels) {
            java.util.Map<String, Object> link = new java.util.HashMap<>();
            link.put("label", label);
            link.put("href", "#");
            footerLinks.add(link);
        }
    }
    pageContext.setAttribute("footerLinks", footerLinks);
    
    // 언어 링크들 (pageContext에서 가져오거나 기본값 사용)
    java.util.List<java.util.Map<String, Object>> languageLinks = (java.util.List<java.util.Map<String, Object>>) pageContext.getAttribute("languageLinks");
    if (languageLinks == null) {
        languageLinks = new java.util.ArrayList<>();
        String[] langLabels = {"PC버전", "中文网"};
        for (String label : langLabels) {
            java.util.Map<String, Object> link = new java.util.HashMap<>();
            link.put("label", label);
            link.put("href", "#");
            languageLinks.add(link);
        }
    }
    pageContext.setAttribute("languageLinks", languageLinks);
    
    // 환율 정보 (pageContext에서 가져오거나 기본값 사용)
    java.util.Map<String, Object> exchangeRate = (java.util.Map<String, Object>) pageContext.getAttribute("exchangeRate");
    if (exchangeRate == null) {
        exchangeRate = new java.util.HashMap<>();
        exchangeRate.put("label", "환율");
        exchangeRate.put("value", "$1 = 1,103.1원");
    }
    pageContext.setAttribute("exchangeRate", exchangeRate);
    
    // 약관 링크들 (pageContext에서 가져오거나 기본값 사용)
    java.util.List<java.util.Map<String, Object>> policyLinks = (java.util.List<java.util.Map<String, Object>>) pageContext.getAttribute("policyLinks");
    if (policyLinks == null) {
        policyLinks = new java.util.ArrayList<>();
        String[] policyLabels = {"이용약관", "개인정보처리방침", "영상정보 처리기기/관리방침"};
        boolean[] isHighlighted = {false, true, false};
        for (int i = 0; i < policyLabels.length; i++) {
            java.util.Map<String, Object> link = new java.util.HashMap<>();
            link.put("label", policyLabels[i]);
            link.put("href", "#");
            link.put("isHighlighted", isHighlighted[i]);
            policyLinks.add(link);
        }
    }
    pageContext.setAttribute("policyLinks", policyLinks);
    
    // 저작권 정보 (pageContext에서 가져오거나 기본값 사용)
    String copyright = (String) pageContext.getAttribute("copyright");
    if (copyright == null || copyright.isEmpty()) {
        copyright = "COPYRIGHT © HYUNDAI DF Co,. Ltd. ALL RIGHTS RESERVED.";
    }
    pageContext.setAttribute("copyright", copyright);
%>

<footer class="w-full">
    <!-- 공지사항 영역 -->
    <a class="relative bg-white h-[52px] flex items-center justify-between px-5 border-b border-[#EEF0F2]"
        <c:if test="${!empty notice.onClick}">onclick="${notice.onClick}"</c:if>
        <c:if test="${!empty notice.onClick}">style="cursor: pointer;"</c:if>>
        <p class="text-[#5C6677] font-normal text-[14px] leading-[1.429em] tracking-[-0.05em] flex-1">
            ${notice.text}
        </p>
        <img 
            src="${arrowIcon16}" 
            alt="더보기"
            class="flex-shrink-0 w-4 h-4"
            aria-hidden="true" />
    </a>
    
    <!-- 안내 영역 -->
    <ul class="flex items-center h-[52px] gap-[38px] bg-[#282C34] px-[22px]" aria-label="서비스 안내">
        <c:forEach var="link" items="${guideLinks}">
            <li>
                <a href="${link.href}" class="text-[#ABB2BE] font-normal text-[14px] leading-[1.429em] tracking-[-0.05em] hover:text-white transition-colors">
                        ${link.label}
                </a>
            </li>
        </c:forEach>
    </ul>

    <!-- 푸터 정보 영역 -->
    <div class="bg-[#1B1E23] px-5 py-5">
        <div class="flex flex-col gap-5">
            <!-- 링크 영역 -->
            <ul>
                <li class="flex flex-col gap-5">
                    <c:forEach var="link" items="${footerLinks}">
                        <a href="${link.href}" class="flex items-center gap-[10px] w-fit group">
                            <span class="text-[#788497] font-bold text-[14px] leading-[1.429em] tracking-[-0.05em] group-hover:text-white transition-colors">
                                    ${link.label}
                            </span>
                            <img
                                    src="${arrowIcon18}"
                                    alt=""
                                    class="w-[8px] h-[8px]"
                                    aria-hidden="true" />
                        </a>
                    </c:forEach>
                </li>
            </ul>

            <!-- 구분선 -->
            <hr class="w-full h-0 border-0 border-t border-[#5C6677] opacity-[0.28]" aria-hidden="true" />

            <!-- 언어/환율 정보 -->
            <div class="flex justify-between items-center w-full">
                <div class="flex gap-3 items-center">
                    <c:forEach var="link" items="${languageLinks}" varStatus="status">
                        <a href="${link.href}" class="text-[#788497] font-normal text-[14px] leading-[1.429em] tracking-[-0.05em] hover:text-white transition-colors">
                            ${link.label}
                        </a>
                        <c:if test="${!status.last}">
                            <span class="w-0 h-3 border-l border-[#5C6677]" aria-hidden="true"></span>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="flex gap-1 items-center">
                    <span class="text-[#ABB2BE] font-normal text-[14px] leading-[1.429em] tracking-[-0.05em]">
                        ${exchangeRate.label}
                    </span>
                    <span class="text-[#ABB2BE] font-bold text-[14px] leading-[1.429em] tracking-[-0.05em]">
                        ${exchangeRate.value}
                    </span>
                </div>
            </div>

            <!-- 구분선 -->
            <hr class="w-full h-0 border-0 border-t border-[#5C6677] opacity-[0.28]" aria-hidden="true" />

            <!-- 약관 링크 -->
            <ul aria-label="약관 및 정책">
                <li class="flex flex-wrap gap-3 items-center">
                    <c:forEach var="link" items="${policyLinks}" varStatus="status">
                        <a href="${link.href}" class="${link.isHighlighted ? 'text-[#EEF0F2]' : 'text-[#788497]'} font-normal text-[13px] leading-[1.462em] tracking-[-0.05em] hover:text-white transition-colors">
                                ${link.label}
                        </a>
                        <c:if test="${!status.last}">
                            <span class="w-0 h-3 border-l border-[#424956]" aria-hidden="true"></span>
                        </c:if>
                    </c:forEach>
                </li>
            </ul>

            <!-- 저작권 정보 -->
            <p class="text-[#788497] font-normal text-[12px] leading-[1.5em] tracking-[-0.05em]">
                ${copyright}
            </p>
        </div>
    </div>
</footer>
