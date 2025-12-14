package com.core.event.entity;

import lombok.Data;

@Data
public class EventNotice {
    private Long id;
    private Long eventId;
    private String text;
    private Boolean isImportant;
    private Integer displayOrder;
}


