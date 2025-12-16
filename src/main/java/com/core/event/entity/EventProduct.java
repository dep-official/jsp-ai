package com.core.event.entity;

import lombok.Data;

@Data
public class EventProduct {
    private Long id;
    private Long eventId;
    private Long productId;
    private Integer displayOrder;
    private Boolean isRecommend;
}