<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="products" required="true" type="java.util.List<com.core.product.entity.Product>" %>
<%@ attribute name="maxItems" required="false" type="java.lang.Integer" %>
<%@ variable name-given="sortedProducts" variable-class="java.util.List" scope="AT_END" %>

<%-- 
    ProductSorter.tag - 상품 정렬 로직 공통 lib
    부모 태그의 "products" attribute를 받아서 정렬 후 "sortedProducts"로 반환
    
    옵션:
    - maxItems: 최대 렌더링할 상품 개수 (기본값: 무제한, null이면 전체)
--%>
<%
    // null 안전 처리
    java.util.List<com.core.product.entity.Product> resultList = new java.util.ArrayList<>();
    
    if (products != null && !products.isEmpty()) {
        resultList.addAll(products);
        
        // 정렬 (품절 상품 뒤로, 할인율 높은 순)
        java.util.Collections.sort(resultList, new java.util.Comparator<com.core.product.entity.Product>() {
            public int compare(com.core.product.entity.Product p1, com.core.product.entity.Product p2) {
                // 품절 상품을 뒤로, 일반 상품을 앞으로 정렬 (잠시 비활성화)
                /*
                boolean soldOut1 = p1.getIsSoldOut() != null ? p1.getIsSoldOut() : false;
                boolean soldOut2 = p2.getIsSoldOut() != null ? p2.getIsSoldOut() : false;
                
                if (soldOut1 && !soldOut2) {
                    return 1;
                } else if (!soldOut1 && soldOut2) {
                    return -1;
                }
                */
                
                // 할인율이 높은 순으로 정렬
                Double discountRate1 = p1.getDiscountRate() != null ? p1.getDiscountRate() : 0.0;
                Double discountRate2 = p2.getDiscountRate() != null ? p2.getDiscountRate() : 0.0;
                
                return Double.compare(discountRate2, discountRate1); // 내림차순
            }
        });
        
        // maxItems가 설정되어 있으면 제한 적용
        if (maxItems != null && maxItems > 0 && resultList.size() > maxItems) {
            resultList = resultList.subList(0, maxItems);
        }
    }
    
    jspContext.setAttribute("sortedProducts", resultList);
%>
