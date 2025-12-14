package com.core.event.mapper;

import com.core.event.entity.Event;
import com.core.event.entity.EventBrand;
import com.core.event.entity.EventNotice;
import com.core.event.entity.EventRecommendedProduct;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface EventMapper {
    Event findById(@Param("id") Long id);
    List<EventNotice> findNoticesByEventId(@Param("eventId") Long eventId);
    List<EventBrand> findBrandsByEventId(@Param("eventId") Long eventId);
    List<EventRecommendedProduct> findRecommendedProductsByEventId(@Param("eventId") Long eventId);
    List<java.util.Map<String, Object>> findAllProductsByEventId(@Param("eventId") Long eventId);
    List<java.util.Map<String, Object>> findProductsByBrandIds(@Param("brandIds") List<Long> brandIds);
    List<java.util.Map<String, Object>> findProductsByEventIdAndTagLabel(@Param("eventId") Long eventId, @Param("tagLabel") String tagLabel);
}

