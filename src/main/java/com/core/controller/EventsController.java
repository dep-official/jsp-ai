package com.core.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;


@Controller
public class EventsController {

    @GetMapping("/events")
    public String events(Model model) {
        model.addAttribute("message", "MCP test");
        model.addAttribute("title", "Events Page");
        return "events";
    }

    @GetMapping("/events/{id}")
    public String eventDetail(@PathVariable Long id, Model model) {
        model.addAttribute("eventId", id);
        model.addAttribute("title", "Event #" + id + " - JSP AI");
        // 여기서 id로 이벤트 데이터 조회
        // model.addAttribute("event", eventService.findById(id));
        return "events/[id]"; 
    }
}

