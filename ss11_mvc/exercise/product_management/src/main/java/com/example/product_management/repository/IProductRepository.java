package com.example.product_management.repository;

import com.example.product_management.model.Product;

import java.util.List;

public interface IProductRepository {
   List<Product> findAll();

   void add(Product product);
}
