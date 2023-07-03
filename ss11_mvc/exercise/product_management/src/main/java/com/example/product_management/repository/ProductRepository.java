package com.example.product_management.repository;

import com.example.product_management.model.Product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductRepository implements IProductRepository{
    private static Map<Integer,Product> productList;
    static {
        productList = new HashMap<>();
        productList.put(1,new Product(1,"Bully",30000,"Nguyen Phuc Quy","Men In Black"));
        productList.put(2,new Product(2,"Danny",40000,"Nguyen Ho Tai Phat","Men In Black"));
        productList.put(3,new Product(3,"Jackie",25000,"Dam Thoai Tin","Men In Black"));
        productList.put(4,new Product(4,"Chunky",35000,"Vo Nhan Tri","Men In Black"));
        productList.put(5,new Product(5,"Louis",27000,"Le Huy","Men In Black"));
    }

    @Override
    public List<Product> findAll() {
        return new ArrayList<>(productList.values());
    }

    @Override
    public void add(Product product) {
        productList.put(product.getId(),product);
    }

    @Override
    public Product findById(int id) {
        return productList.get(id);
    }

    @Override
    public void editProduct(int id, Product product) {
        productList.replace(id,product);
    }
}
