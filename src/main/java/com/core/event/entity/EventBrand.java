package com.core.event.entity;

import lombok.Data;

@Data
public class EventBrand {
    private Long id;
    private Long eventId;
    private Long brandId;
    private Integer displayOrder;
}

