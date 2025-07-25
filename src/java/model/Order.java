package model;

import java.util.Date;
import java.util.List; // Thêm import này để dùng List

public class Order {
    private String orderID; // Đổi về String
    private String userID;
    private Date orderDate;
    private double total;
    private List<OrderDetail> orderDetails; // Thêm thuộc tính này

    public Order() {}

    public Order(String userID, Date orderDate, double total) {
        this.userID = userID;
        this.orderDate = orderDate;
        this.total = total;
    }

    public Order(String orderID, String userID, Date orderDate, double total) {
        this.orderID = orderID;
        this.userID = userID;
        this.orderDate = orderDate;
        this.total = total;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }
}
