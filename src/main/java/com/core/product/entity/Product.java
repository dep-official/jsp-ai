package com.core.product.entity;

import lombok.Data;
import java.math.BigDecimal;

@Data
public class Product {
    private Long id;
    private String name;
    private String imageUrl;
    private Long brandId;
    private String brandName;
    private String mdKeyword;
    private BigDecimal originalPrice;
    private BigDecimal discountPrice;
    private String discountPriceWon;
    private Integer discountRate;
    private String flags;
    private Boolean isSoldOut;
    private Boolean requiresAdultVerification;
    private Boolean isAdultVerified;
    private Boolean requiresLoginForDiscount;
    private Boolean isLoggedIn;
}


