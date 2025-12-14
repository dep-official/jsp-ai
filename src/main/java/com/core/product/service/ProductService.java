package com.core.product.service;

import com.core.product.entity.Product;
import com.core.product.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class ProductService {

    @Autowired
    private ProductMapper productMapper;

    public List<Product> findRecommendedProducts() {
        return productMapper.findRecommendedProducts();
    }

    public List<Product> findByIds(List<Long> ids) {
        return productMapper.findByIds(ids);
    }
}
