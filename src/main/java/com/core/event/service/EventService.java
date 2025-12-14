package com.core.event.service;

import com.core.event.entity.Event;
import com.core.event.entity.EventBrand;
import com.core.event.entity.EventNotice;
import com.core.event.entity.EventRecommendedProduct;

import java.util.List;
import java.util.Map;

/**
 * Event 관련 비즈니스 로직 인터페이스
 */
public interface EventService {

    /**
     * Event ID로 Event 조회 (없으면 예외 발생)
     * 
     * @param id Event ID
     * @return Event
     * @throws com.core.event.exception.EventNotFoundException 
     */
    Event findById(Long id);

    /**
     * Event ID로 EventNotice 목록 조회
     * 
     * @param eventId Event ID
     * @return EventNotice 목록
     * @throws com.core.event.exception.EventNotFoundException
     */
    List<EventNotice> findNoticesByEventId(Long eventId);

    /**
     * Event ID로 EventBrand 목록 조회 (행사 브랜드)
     * 
     * @param eventId Event ID
     * @return EventBrand 목록
     */
    List<EventBrand> findBrandsByEventId(Long eventId);

    /**
     * Event ID로 행사 브랜드 목록 조회 (View용 DTO 변환)
     * 
     * @param eventId Event ID
     * @return 브랜드 Map 목록 (JSP에서 사용할 형태)
     */
    List<Map<String, Object>> findBrandsForView(Long eventId);

    /**
     * Event ID로 추천 상품 목록 조회
     * 
     * @param eventId Event ID
     * @return EventRecommendedProduct 목록
     */
    List<EventRecommendedProduct> findRecommendedProductsByEventId(Long eventId);

    /**
     * Event ID로 추천 상품 목록 조회 (View용 DTO 변환)
     * 
     * @param eventId Event ID
     * @return 추천 상품 Map 목록 (JSP에서 사용할 형태)
     */
    List<Map<String, Object>> findRecommendedProductsForView(Long eventId);

    /**
     * Event ID로 전체 상품 목록 조회 (View용 DTO 변환)
     * event_brands에 등록된 브랜드의 모든 상품을 조회
     * 
     * @param eventId Event ID
     * @return 전체 상품 Map 목록 (JSP에서 사용할 형태, 클라이언트 사이드 필터링/정렬용)
     */
    List<Map<String, Object>> findAllProductsForView(Long eventId);

    /**
     * 브랜드 ID 목록으로 상품 목록 조회 (View용 DTO 변환)
     * 
     * @param brandIds 브랜드 ID 목록
     * @return 상품 Map 목록 (JSP에서 사용할 형태)
     */
    List<Map<String, Object>> findProductsByBrandIdsForView(List<Long> brandIds);

    /**
     * Event ID와 tag_label로 상품 목록 조회 (View용 DTO 변환)
     * product_sets를 통해 연결된 상품을 조회
     * 
     * @param eventId Event ID
     * @param tagLabel Product Set의 tag_label (예: 'Event 1', 'Event 2')
     * @return 상품 Map 목록 (JSP에서 사용할 형태)
     */
    List<Map<String, Object>> findProductsByEventIdAndTagLabelForView(Long eventId, String tagLabel);
}
