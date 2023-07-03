package com.example.product_management.repository;

import com.example.product_management.model.Product;

import java.util.List;

public interface IProductRepository {
   List<Product> findAll();

   void add(Product product);

   Product findById(int id);

   void editProduct(int id, Product product);

   void deleteProduct(int id);

   List<Product> searchByName(String searchStr);
}
