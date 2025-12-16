package com.core.brand.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.core.brand.entity.Brand;
import com.core.brand.mapper.BrandMapper;

@Service
@Transactional(readOnly = true)
public class BrandServiceImpl implements BrandService {
    
    @Autowired
    private BrandMapper brandMapper;

    @Override
    public List<Brand> getAllBrands() {
        return brandMapper.getAllBrands();
    }

    @Override
    public Brand getBrandById(Long id) {
        return brandMapper.getBrandById(id);
    }

    @Override
    public List<Brand> getEventBrandsById(Long id) {
        return brandMapper.getEventBrandsById(id);
    }
}
