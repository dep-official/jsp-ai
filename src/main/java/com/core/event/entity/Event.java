package com.core.event.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class Event {
    private Long id;
    private String title;
    private String subtitle;
    private String imageUrl;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private Boolean untilStockOut;
    
    // 템플릿 설정
    private String templateType; // DEFAULT, PRODUCT_SET_A, PRODUCT_SET_B
    private String themeConfig;  // JSON String for theme configuration
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}


