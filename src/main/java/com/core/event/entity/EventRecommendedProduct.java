package com.core.event.entity;

import com.core.product.entity.Product;
import lombok.Data;

@Data
public class EventRecommendedProduct {
    private Long id;
    private Long eventId;
    private Long productId;
    private Integer displayOrder;
    // 조인된 상품 정보
    private Product product;
}

