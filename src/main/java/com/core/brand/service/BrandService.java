package com.core.brand.service;

import com.core.brand.entity.Brand;
import java.util.List;


public interface BrandService {
   
    
    /** 
     * 모든 브랜드 조회
     * 
     * @return 모든 브랜드 목록 
     *  
     */
    List<Brand> getAllBrands();
    
    /** 
     * 단일 브랜드 조회
     * @param id 브랜드 ID
     * @return 단일 브랜드
     */
    Brand getBrandById(Long id);
    
    /** 
     * 행사 브랜드 조회
     * @param id 행사 ID
     * @return 행사 브랜드 목록
     */
    List<Brand> getEventBrandsById(Long id);
}
