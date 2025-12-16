package com.core.brand.mapper;

import com.core.brand.entity.Brand;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BrandMapper {
    //모든 브랜드 조회
    List<Brand> getAllBrands();
    
    //단일 브랜드 조회
    Brand getBrandById(@Param("id") Long id);

    // 행사 브랜드 조회
    List<Brand> getEventBrandsById(@Param("id") Long id);
}

