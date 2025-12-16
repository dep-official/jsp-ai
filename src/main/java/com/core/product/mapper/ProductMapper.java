package com.core.product.mapper;

import com.core.product.entity.Product;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ProductMapper {
    //단일 상품 조회 
    Product getProductById(@Param("id") Long id);

    //추천 상품 목록 조회 
    List<Product> getRecommendedProducts(@Param("eventId") Long eventId);

    //전체 상품 목록 조회 (파라미터 없는 메서드)
    List<Product> getAllProducts();

    //ID 목록으로 상품 목록 조회 
    List<Product> getProductByIds(@Param("ids") List<Long> ids);
    
    // 특정 이벤트 ID에 연결된 상품 목록을 조회합니다.
    List<Product> getProductsByEventId(@Param("eventId") Long eventId);

    //brandId 목록으로 상품 목록 조회 
    List<Product> getProductsByBrandIds(@Param("brandIds") List<Long> brandIds);

    //eventId와 brandId로 상품 목록 조회 
    List<Product> getProductsByEventIdAndBrandIds(@Param("eventId") Long eventId, @Param("brandIds") List<Long> brandIds);


}

    

