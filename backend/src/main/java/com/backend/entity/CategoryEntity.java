package com.backend.entity;

import org.springframework.data.annotation.Id;

public class CategoryEntity {
    @Id
    String categoryName;

    public CategoryEntity(String categoryName) {
        this.categoryName = categoryName;
    }

    public void setCategoryName(String categoryName){this.categoryName = categoryName;}
    public String getCategoryName(){return this.categoryName;}
}
