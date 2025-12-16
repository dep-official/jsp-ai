package com.core.event.service;

import com.core.event.entity.Event;
import com.core.event.entity.EventBrand;
import com.core.event.entity.EventNotice;

import java.util.List;

public interface EventService {

    /**
     * Event ID로 Event 조회 (없으면 예외 발생)
     * 
     * @param id 
     * @return Event
     */
    // 단일 상품 조회
    Event getEventById(Long id);

    /**
     * Event ID로 EventNotice 목록 조회
     * 
     * @param id 
     * @return EventNotice 목록
     */
    List<EventNotice> getEventNoticeById(Long id);

    /**
     * Event ID로 EventBrand 목록 조회
     * 
     * @param id 
     * @return EventBrand 목록
     */
    List<EventBrand> getEventBrandsById(Long id);

    /**
     * Event ID로 Brand ID 목록 조회
     * 
     * @param id Event ID
     * @return Brand ID 목록
     */
    List<Long> getBrandIdsByEventId(Long id);
}
