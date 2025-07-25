package model;

public class Promotion {
    private int promotionID;
    private String promotionName;
    private String description;
    private double discountAmount;
    private double minimumOrderValue;
    private boolean isActive;
    
    public Promotion() {
    }
    
    public Promotion(int promotionID, String promotionName, String description, 
                     double discountAmount, double minimumOrderValue, boolean isActive) {
        this.promotionID = promotionID;
        this.promotionName = promotionName;
        this.description = description;
        this.discountAmount = discountAmount;
        this.minimumOrderValue = minimumOrderValue;
        this.isActive = isActive;
    }

    public int getPromotionID() {
        return promotionID;
    }

    public void setPromotionID(int promotionID) {
        this.promotionID = promotionID;
    }

    public String getPromotionName() {
        return promotionName;
    }

    public void setPromotionName(String promotionName) {
        this.promotionName = promotionName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }

    public double getMinimumOrderValue() {
        return minimumOrderValue;
    }

    public void setMinimumOrderValue(double minimumOrderValue) {
        this.minimumOrderValue = minimumOrderValue;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
}