package com.core.product.entity;

import lombok.Data;
import java.math.BigDecimal;

@Data
public class ProductSet {
    private Long id;
    private Long eventId;
    private String title;
    private String subtitle;
    private String tagLabel;
    private BigDecimal originalPrice;
    private BigDecimal discountPrice;
    private Integer discountRate;
}


