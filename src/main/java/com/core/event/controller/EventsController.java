package com.core.event.controller;

import com.core.event.service.EventService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
public class EventsController {

    @Autowired
    private EventService eventService;
    
    private final ObjectMapper objectMapper = new ObjectMapper();

    @GetMapping("/events")
    public String events(Model model) {
        return "events";
    }

    @GetMapping("/events/{id}")
    public String eventDetail(@PathVariable String id, Model model, HttpServletRequest request) {
        Long eventId = Long.parseLong(id);

        // Event 조회
        model.addAttribute("KVBanner", eventService.findById(eventId));
        // EventNotice 목록 조회
        model.addAttribute("noticeItems", eventService.findNoticesByEventId(eventId));
        
        // 행사 브랜드 목록 조회 (Service에서 변환)
        model.addAttribute("brands", eventService.findBrandsForView(eventId));
        
        // 추천 상품 목록 조회 (Service에서 변환)
        model.addAttribute("recommendedProducts", eventService.findRecommendedProductsForView(eventId));
        
        // 전체 상품 목록 조회 (Service에서 변환, 클라이언트 사이드 필터링/정렬용)
        List<Map<String, Object>> allProducts = eventService.findAllProductsForView(eventId);
        model.addAttribute("allProducts", allProducts);
        
        // JSON으로 변환하여 전달 (JavaScript에서 파싱하기 쉽도록)
        try {
            String allProductsJson = objectMapper.writeValueAsString(allProducts);
            model.addAttribute("allProductsJson", allProductsJson);
        } catch (Exception e) {
            // JSON 변환 실패 시 빈 배열
            model.addAttribute("allProductsJson", "[]");
        }
        
        // Event 1: 임시로 allProducts 사용 (반응형 개발 완료 후 eventId 기반 조회로 수정 예정)
        model.addAttribute("productsForEvent1", allProducts);
        
        // Event 2: 임시로 allProducts 사용 (반응형 개발 완료 후 eventId 기반 조회로 수정 예정)
        model.addAttribute("productsForEvent2", allProducts);
        
        return "events-detail";
    }
}
