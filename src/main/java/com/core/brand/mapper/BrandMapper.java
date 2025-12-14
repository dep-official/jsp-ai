package com.core.brand.mapper;

import com.core.brand.entity.Brand;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BrandMapper {
    List<Brand> findAll();
    Brand findById(@Param("id") Long id);
}

