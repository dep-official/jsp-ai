package com.core.brand.service;

import com.core.brand.entity.Brand;
import com.core.brand.mapper.BrandMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class BrandService {

    @Autowired
    private BrandMapper brandMapper;

    public List<Brand> findAll() {
        return brandMapper.findAll();
    }
}
