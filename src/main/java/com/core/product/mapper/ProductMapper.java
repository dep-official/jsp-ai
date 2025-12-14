package com.core.product.mapper;

import com.core.product.entity.Product;
import com.core.product.entity.ProductSetItem;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ProductMapper {
    List<Product> findRecommendedProducts();
    List<Product> findByIds(@Param("ids") List<Long> ids);
    List<ProductSetItem> findProductSetItemsByProductSetId(@Param("productSetId") Long productSetId);
    Product findById(@Param("id") Long id);
}

