package com.core.event.entity;

import com.core.product.entity.ProductSet;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class Event {
    private Long id;
    private String title;
    private String subtitle;
    private String imageUrl;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private Boolean untilStockOut;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private List<ProductSet> productSets;
}


