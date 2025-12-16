package com.core.product.service;

import com.core.product.entity.Product;
import com.core.product.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductMapper productMapper;

    /**
     * 단일 상품 조회
     * 
     * @param id Product ID
     * @return Product
     */
    @Override
    public Product getProductById(Long id) {
        return productMapper.getProductById(id);
    }

    /**
     * 전체 상품 목록 조회
     * 
     * @return Product 목록
     */
    @Override
    public List<Product> getAllProducts() {
        return productMapper.getAllProducts();
    }

    /**
     * ID 목록으로 상품 목록 조회
     * 
     * @param ids Product ID 목록
     * @return Product 목록
     */
    @Override
    public List<Product> getProductsByIds(List<Long> ids) {
        return productMapper.getProductByIds(ids);
    }

    /**
     * 추천 상품 목록 조회
     * 
     * @return 추천 Product 목록
     */
    @Override
    public List<Product> getRecommendedProducts(Long eventId) {
        return productMapper.getRecommendedProducts(eventId);
    }

    /**
     * eventId로 상품 목록 조회
     * 
     * @param eventId Event ID
     * @return Product 목록
     */
    @Override
    public List<Product> getProductsByEventId(Long eventId) {
        return productMapper.getProductsByEventId(eventId);
    }

    /**
     * eventId와 brandId로 상품 목록 조회
     * 
     * @param eventId Event ID
     * @param brandIds Brand ID 목록
     * @return Product 목록
     */
    @Override
    public List<Product> getProductsByEventIdAndBrandIds(Long eventId, List<Long> brandIds) {
        return productMapper.getProductsByEventIdAndBrandIds(eventId, brandIds);
    }

}
