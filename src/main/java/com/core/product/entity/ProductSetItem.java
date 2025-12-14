package com.core.product.entity;

import lombok.Data;

@Data
public class ProductSetItem {
    private Long id;
    private Long productSetId;
    private Long productId;
    private Integer displayOrder;
}


