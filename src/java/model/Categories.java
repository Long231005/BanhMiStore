/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Home
 */
public class Categories {
    private String categoryID, categoryName,describe;
    
    

    public Categories(String categoryID, String categoryName, String describe) {
        this.categoryID = categoryID;
        this.categoryName = categoryName;
        this.describe = describe;
    }

    public Categories() {
    }
    
    public String getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescription(String description) {
        this.describe = describe;
    }

    @Override
    public String toString() {
        return "Categories{" + "categoryID=" + categoryID + ", categoryName=" + categoryName + ", description=" + describe + '}';
    }
    
    
}
