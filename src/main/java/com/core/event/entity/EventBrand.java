package com.core.event.entity;

import com.core.brand.entity.Brand;
import lombok.Data;

@Data
public class EventBrand {
    private Long id;
    private Long eventId;
    private Long brandId;
    private Integer displayOrder;
    // 조인된 브랜드 정보
    private Brand brand;
}

