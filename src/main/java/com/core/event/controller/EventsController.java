package com.core.event.controller;

import com.core.brand.service.BrandService;
import com.core.event.service.EventService;
import com.core.product.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.http.HttpServletRequest;

@Controller
public class EventsController {

    @Autowired
    private EventService eventService;

    @Autowired
    private ProductService productService;

    @Autowired
    private BrandService brandService;

    @GetMapping("/events")
    public String events(Model model) {
        return "events";
    }

    @GetMapping("/events/{id}")
    public String eventDetail(@PathVariable Long id, Model model, HttpServletRequest request) {

        // Event 조회
        model.addAttribute("event", eventService.getEventById(id));

        // EventNotice 목록 조회
        model.addAttribute("noticeItems", eventService.getEventNoticeById(id));

        // eventId로 상품 목록 조회
        model.addAttribute("products", productService.getProductsByEventId(id));

        // eventId로 추천 상품 목록 조회 
        model.addAttribute("recommendedProducts", productService.getRecommendedProducts(id));

        // eventId로 브랜드 목록 조회
        model.addAttribute("brands", eventService.getEventBrandsById(id));

        // eventId를 JSP에 전달
        model.addAttribute("eventId", id);

        // eventId와 brandId로 상품 목록 조회
        model.addAttribute("eventProducts", productService.getProductsByEventIdAndBrandIds(id, eventService.getBrandIdsByEventId(id)));
        
        // eventId로 브랜드 목록 조회
        model.addAttribute("brands", brandService.getEventBrandsById(id));

        return "events-detail";
    }

}
