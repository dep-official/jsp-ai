package com.core.event.mapper;

import com.core.event.entity.EventBrand;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface EventBrandMapper {
    //Event Brands 목록 조회
    List<EventBrand> getEventBrandsById(@Param("id") Long id);
}

