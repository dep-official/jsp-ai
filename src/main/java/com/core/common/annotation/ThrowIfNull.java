package com.core.common.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 메서드 반환값이 null일 경우 예외를 던지는 어노테이션
 * AOP를 통해 자동으로 null 체크 및 예외 처리
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface ThrowIfNull {
    /**
     * 예외 클래스 (기본값: RuntimeException)
     */
    Class<? extends RuntimeException> exception() default RuntimeException.class;
    
    /**
     * 예외 메시지 (null이면 기본 메시지 사용)
     */
    String message() default "";
    
    /**
     * 메서드 파라미터 중 ID로 사용할 파라미터의 인덱스 (0부터 시작)
     * 예외 메시지에 ID를 포함할 때 사용
     */
    int idParamIndex() default -1;
}

