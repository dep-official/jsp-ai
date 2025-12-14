package com.core.event.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * Event를 찾을 수 없을 때 발생하는 예외
 * 404 Not Found 상태 코드를 자동으로 반환
 */
@ResponseStatus(HttpStatus.NOT_FOUND)
public class EventNotFoundException extends RuntimeException {
    
    public EventNotFoundException(Long eventId) {
        super("Event not found with id: " + eventId);
    }
}

