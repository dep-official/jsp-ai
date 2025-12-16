package com.core.event.service;

import com.core.event.entity.Event;
import com.core.event.entity.EventBrand;
import com.core.event.entity.EventNotice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

import com.core.event.mapper.EventMapper;
import com.core.event.mapper.EventBrandMapper;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class EventServiceImpl implements EventService {

    @Autowired 
    private EventMapper eventMapper;

    @Autowired
    private EventBrandMapper eventBrandMapper;

    /**
     * Event ID로 Event 조회 (없으면 예외 발생)
     * 
     * @param id Event ID
     * @return Event
     */
    // 단일 상품 조회
    @Override
    public Event getEventById(Long id) {
        return eventMapper.getEventById(id);
    }

    /**
     * Event ID로 EventNotice 목록 조회
     * 
     * @param eventId Event ID
     * @return EventNotice 목록
     */
    @Override
    public List<EventNotice> getEventNoticeById(Long id) {
        List<EventNotice> notices = eventMapper.getEventNoticeById(id);
        
        // 유의사항이 없으면 기본값(event_id=1)을 사용
        if (notices == null || notices.isEmpty()) {
            notices = eventMapper.getEventNoticeById(1L);
        }
        
        return notices;
    }

    /**
     * Event ID로 EventBrand 목록 조회
     * 
     * @param id Event ID
     * @return EventBrand 목록
     */
    @Override
    public List<EventBrand> getEventBrandsById(Long id) {
        return eventBrandMapper.getEventBrandsById(id);
    }

    /**
     * Event ID로 Brand ID 목록 조회
     * 
     * @param id Event ID
     * @return Brand ID 목록
     */
    @Override
    public List<Long> getBrandIdsByEventId(Long id) {

        List<EventBrand> eventBrands = eventBrandMapper.getEventBrandsById(id);
        
        return eventBrands.stream().map(EventBrand::getBrandId).collect(Collectors.toList());
    }

}
