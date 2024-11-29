package Models;

import java.util.Date;

public class Order {
    private int orderID;
    private String userName;
    private String email;
    private String phone;
    private String address;
    private Date orderDate;
    private String status; // trạng thái "chưa giao" hoặc "đã giao"

    // Constructor
    public Order(int orderID, String userName, String email, String phone, String address, Date orderDate, String status) {
        this.orderID = orderID;
        this.userName = userName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.orderDate = orderDate;
        this.status = status;
    }
   

    // Getter và Setter cho các thuộc tính
    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
