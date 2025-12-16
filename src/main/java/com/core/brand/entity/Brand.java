package com.core.brand.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class Brand {

    // DB Primary Key (PK)
    private Long id;

    // 브랜드 이름 (필수)
    private String brandName;

    // 브랜드 관리 코드
    private String brandCode;

    // 브랜드 대표 이미지 URL
    private String imageUrl;

    // 브랜드 설명 또는 슬로건
    private String description;

    // 노출 여부 (관리자 설정)
    private Boolean isDisplay;

    // 목록 표시 순서 (정렬 기준)
    private Integer displayOrder;

    // 생성 및 수정 시간 (Audit Fields)
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}