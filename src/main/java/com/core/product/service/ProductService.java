package com.core.product.service;

import com.core.product.entity.Product;
import java.util.List;

public interface ProductService {

    /**
     * 단일 상품 조회
     * 
     * @param id Product ID
     * @return Product
     */
    Product getProductById(Long id);

    /**
     * 전체 상품 목록 조회
     * 
     * @return Product 목록
     */
    List<Product> getAllProducts();

    /**
     * ID 목록으로 상품 목록 조회
     * 
     * @param ids Product ID 목록
     * @return Product 목록
     */
    List<Product> getProductsByIds(List<Long> ids);

    /**
     * 추천 상품 목록 조회
     * 
     * @return 추천 Product 목록
     */
    List<Product> getRecommendedProducts(Long eventId);

    /**
     * eventId로 상품 목록 조회
     * 
     * @param eventId Event ID
     * @return Product 목록
     */
    List<Product> getProductsByEventId(Long eventId);

    /**
     * eventId와 brandId로 상품 목록 조회
     * 
     * @param eventId Event ID
     * @param brandIds Brand ID 목록
     * @return Product 목록
     */
    List<Product> getProductsByEventIdAndBrandIds(Long eventId, List<Long> brandIds);

}
