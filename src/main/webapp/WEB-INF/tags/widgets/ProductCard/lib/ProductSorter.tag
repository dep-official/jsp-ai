<%-- 
    ProductSorter.tag - 상품 정렬 로직 공통 lib
    include되는 파일이므로 attribute/variable directive 사용 불가
    부모 태그의 "products" attribute를 jspContext에서 가져와서 정렬 후 "sortedProducts"로 설정
    
    옵션:
    - maxItems: 최대 렌더링할 상품 개수 (기본값: 무제한, null이면 전체)
--%>
<%
    // 부모 태그에서 "products" attribute 가져오기
    java.util.List<java.util.Map<String, Object>> products = (java.util.List<java.util.Map<String, Object>>) jspContext.getAttribute("products");
    
    // maxItems 옵션 가져오기 (부모 태그에서 설정 가능)
    Integer maxItems = (Integer) jspContext.getAttribute("maxItems");
    
    // null 안전 처리
    java.util.List<java.util.Map<String, Object>> sortedProducts = new java.util.ArrayList<>();
    
    if (products != null && !products.isEmpty()) {
        sortedProducts.addAll(products);
        
        // 정렬 (품절 상품 뒤로, 할인율 높은 순)
        java.util.Collections.sort(sortedProducts, new java.util.Comparator<java.util.Map<String, Object>>() {
            public int compare(java.util.Map<String, Object> p1, java.util.Map<String, Object> p2) {
                // 품절 상품을 뒤로, 일반 상품을 앞으로 정렬
                String soldOut1 = String.valueOf(p1.get("isSoldOut"));
                String soldOut2 = String.valueOf(p2.get("isSoldOut"));
                
                if ("true".equals(soldOut1) && !"true".equals(soldOut2)) {
                    return 1;
                } else if (!"true".equals(soldOut1) && "true".equals(soldOut2)) {
                    return -1;
                }
                
                // 할인율이 높은 순으로 정렬
                String discountRate1 = String.valueOf(p1.get("discountRate"));
                String discountRate2 = String.valueOf(p2.get("discountRate"));
                
                if (!discountRate1.isEmpty() && !discountRate2.isEmpty()) {
                    try {
                        int rate1 = Integer.parseInt(discountRate1);
                        int rate2 = Integer.parseInt(discountRate2);
                        return Integer.compare(rate2, rate1); // 내림차순
                    } catch (NumberFormatException e) {
                        return 0;
                    }
                }
                
                return 0;
            }
        });
        
        // maxItems가 설정되어 있으면 제한 적용
        if (maxItems != null && maxItems > 0 && sortedProducts.size() > maxItems) {
            sortedProducts = sortedProducts.subList(0, maxItems);
        }
    }
    
    jspContext.setAttribute("sortedProducts", sortedProducts);
%>

