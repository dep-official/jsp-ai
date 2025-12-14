package com.core.event.service;

import com.core.event.entity.Event;
import com.core.event.entity.EventBrand;
import com.core.event.entity.EventNotice;
import com.core.event.entity.EventRecommendedProduct;
import com.core.event.exception.EventNotFoundException;
import com.core.event.mapper.EventMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Transactional(readOnly = true)
public class EventServiceImpl implements EventService {

    @Autowired
    private EventMapper eventMapper;

    /**
     * Event ID로 Event 조회 (없으면 예외 발생)
     * 
     * @param id Event ID
     * @return Event
     * @throws EventNotFoundException
     */
    @Override
    public Event findById(Long id) {
        Event event = eventMapper.findById(id);
        if (event == null) {
            throw new EventNotFoundException(id);
        }
        return event;
    }

    /**
     * Event ID로 EventNotice 목록 조회
     * 
     * @param eventId Event ID
     * @return EventNotice 목록
     * @throws EventNotFoundException
     */
    @Override
    public List<EventNotice> findNoticesByEventId(Long eventId) {
        List<EventNotice> notices = eventMapper.findNoticesByEventId(eventId);
        if (notices == null) {
            throw new EventNotFoundException(eventId);
        }
        return notices;
    }

    /**
     * Event ID로 EventBrand 목록 조회 (행사 브랜드)
     * 
     * @param eventId Event ID
     * @return EventBrand 목록 (없으면 빈 리스트 반환)
     */
    @Override
    public List<EventBrand> findBrandsByEventId(Long eventId) {
        try {
            List<EventBrand> brands = eventMapper.findBrandsByEventId(eventId);
            return brands != null ? brands : new ArrayList<>();
        } catch (Exception e) {
            // 데이터베이스 오류 시 빈 리스트 반환하여 상위 레이어에 오류 전파 방지
            return new ArrayList<>();
        }
    }

    /**
     * Event ID로 행사 브랜드 목록 조회 (View용 DTO 변환)
     * 
     * @param eventId Event ID
     * @return 브랜드 Map 목록 (JSP에서 사용할 형태)
     */
    @Override
    public List<Map<String, Object>> findBrandsForView(Long eventId) {
        List<EventBrand> eventBrands = findBrandsByEventId(eventId);
        List<Map<String, Object>> brands = new ArrayList<>();
        
        if (eventBrands != null) {
            for (EventBrand eventBrand : eventBrands) {
                if (eventBrand.getBrand() != null) {
                    Map<String, Object> brandMap = new HashMap<>();
                    brandMap.put("imageUrl", eventBrand.getBrand().getImageUrl());
                    brandMap.put("name", eventBrand.getBrand().getName());
                    brandMap.put("brandId", eventBrand.getBrand().getId());
                    brands.add(brandMap);
                }
            }
        }
        return brands;
    }

    /**
     * Event ID로 추천 상품 목록 조회
     * 
     * @param eventId Event ID
     * @return EventRecommendedProduct 목록 (없으면 빈 리스트 반환)
     */
    @Override
    public List<EventRecommendedProduct> findRecommendedProductsByEventId(Long eventId) {
        try {
            List<EventRecommendedProduct> eventRecommendedProducts = eventMapper.findRecommendedProductsByEventId(eventId);
            if (eventRecommendedProducts == null) {
                return new ArrayList<>();
            }
            
            // 데이터 누락 오류 방지: product가 null인 항목 필터링
            return eventRecommendedProducts.stream()
                    .filter(eventRecommendedProduct -> eventRecommendedProduct.getProduct() != null)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            // 데이터베이스 오류 시 빈 리스트 반환하여 상위 레이어에 오류 전파 방지
            return new ArrayList<>();
        }
    }

    /**
     * Event ID로 추천 상품 목록 조회 (View용 DTO 변환)
     * 
     * @param eventId Event ID
     * @return 추천 상품 Map 목록 (JSP에서 사용할 형태)
     */
    @Override
    public List<Map<String, Object>> findRecommendedProductsForView(Long eventId) {
        List<EventRecommendedProduct> eventRecommendedProducts = findRecommendedProductsByEventId(eventId);
        List<Map<String, Object>> recommendedProducts = new ArrayList<>();
        
        if (eventRecommendedProducts != null) {
            for (EventRecommendedProduct erp : eventRecommendedProducts) {
                if (erp.getProduct() != null) {
                    Map<String, Object> productMap = new HashMap<>();
                    productMap.put("imageUrl", erp.getProduct().getImageUrl());
                    productMap.put("brand", erp.getProduct().getBrandName());
                    productMap.put("mdKeyword", erp.getProduct().getMdKeyword());
                    productMap.put("name", erp.getProduct().getName());
                    productMap.put("originalPrice", erp.getProduct().getOriginalPrice());
                    productMap.put("discountRate", erp.getProduct().getDiscountRate());
                    productMap.put("discountPrice", erp.getProduct().getDiscountPrice());
                    productMap.put("discountPriceWon", erp.getProduct().getDiscountPriceWon());
                    productMap.put("flags", erp.getProduct().getFlags());
                    productMap.put("isSoldOut", erp.getProduct().getIsSoldOut());
                    recommendedProducts.add(productMap);
                }
            }
        }
        return recommendedProducts;
    }

    /**
     * Event ID로 전체 상품 목록 조회 (View용 DTO 변환)
     * event_brands에 등록된 브랜드의 모든 상품을 조회
     * Mapper에서 조회한 결과를 그대로 반환
     * 
     * @param eventId Event ID
     * @return 전체 상품 Map 목록 (JSP에서 사용할 형태)
     */
    @Override
    public List<Map<String, Object>> findAllProductsForView(Long eventId) {
        try {
            List<Map<String, Object>> products = eventMapper.findAllProductsByEventId(eventId);
            if (products == null || products.isEmpty()) {
                return new ArrayList<>();
            }
            
            // resultType="map"에서 반환된 키 이름을 확인하고, recommendedProducts와 동일한 구조로 변환
            List<Map<String, Object>> convertedProducts = new ArrayList<>();
            for (Map<String, Object> product : products) {
                Map<String, Object> productMap = new HashMap<>();
                
                // 키 이름이 다를 수 있으므로 여러 가능성을 확인
                productMap.put("imageUrl", getValue(product, "imageUrl", "image_url"));
                productMap.put("brand", getValue(product, "brand"));
                productMap.put("mdKeyword", getValue(product, "mdKeyword", "md_keyword"));
                productMap.put("name", getValue(product, "name"));
                productMap.put("originalPrice", getValue(product, "originalPrice", "original_price"));
                productMap.put("discountRate", getValue(product, "discountRate", "discount_rate"));
                productMap.put("discountPrice", getValue(product, "discountPrice", "discount_price"));
                productMap.put("discountPriceWon", getValue(product, "discountPriceWon", "discount_price_won"));
                productMap.put("flags", getValue(product, "flags"));
                productMap.put("isSoldOut", getValue(product, "isSoldOut", "is_sold_out"));
                productMap.put("requiresAdultVerification", getValue(product, "requiresAdultVerification", "requires_adult_verification"));
                productMap.put("isAdultVerified", getValue(product, "isAdultVerified", "is_adult_verified"));
                productMap.put("requiresLoginForDiscount", getValue(product, "requiresLoginForDiscount", "requires_login_for_discount"));
                productMap.put("isLoggedIn", getValue(product, "isLoggedIn", "is_logged_in"));
                
                convertedProducts.add(productMap);
            }
            
            return convertedProducts;
        } catch (Exception e) {
            System.err.println("DEBUG - findAllProductsForView - 오류 발생: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    /**
     * Map에서 값을 가져오는 헬퍼 메서드 (여러 키 이름 시도)
     */
    private Object getValue(Map<String, Object> map, String... keys) {
        for (String key : keys) {
            if (map.containsKey(key)) {
                return map.get(key);
            }
        }
        return null;
    }

    /**
     * 브랜드 ID 목록으로 상품 목록 조회 (View용 DTO 변환)
     * 
     * @param brandIds 브랜드 ID 목록
     * @return 상품 Map 목록 (JSP에서 사용할 형태)
     */
    @Override
    public List<Map<String, Object>> findProductsByBrandIdsForView(List<Long> brandIds) {
        try {
            if (brandIds == null || brandIds.isEmpty()) {
                return new ArrayList<>();
            }
            List<Map<String, Object>> products = eventMapper.findProductsByBrandIds(brandIds);
            return products != null ? products : new ArrayList<>();
        } catch (Exception e) {
            // 데이터베이스 오류 시 빈 리스트 반환하여 상위 레이어에 오류 전파 방지
            return new ArrayList<>();
        }
    }

    /**
     * Event ID와 tag_label로 상품 목록 조회 (View용 DTO 변환)
     * product_sets를 통해 연결된 상품을 조회
     * 
     * @param eventId Event ID
     * @param tagLabel Product Set의 tag_label (예: 'Event 1', 'Event 2')
     * @return 상품 Map 목록 (JSP에서 사용할 형태)
     */
    @Override
    public List<Map<String, Object>> findProductsByEventIdAndTagLabelForView(Long eventId, String tagLabel) {
        try {
            if (eventId == null || tagLabel == null || tagLabel.isEmpty()) {
                return new ArrayList<>();
            }
            List<Map<String, Object>> products = eventMapper.findProductsByEventIdAndTagLabel(eventId, tagLabel);
            return products != null ? products : new ArrayList<>();
        } catch (Exception e) {
            // 데이터베이스 오류 시 빈 리스트 반환하여 상위 레이어에 오류 전파 방지
            return new ArrayList<>();
        }
    }
}

