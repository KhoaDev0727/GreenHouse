package DAOs;

import DBConnection.DBConnection;
import Models.Order;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OrderDAO {

    // Phương thức lấy tất cả các đơn hàng
    public List<Order> getAllOrders() {
        List<Order> orderList = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        try {
            String sql = "SELECT * FROM Orders";
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("OrderID"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getString("Address"),
                        rs.getDate("OrderDate"),
                        rs.getString("Status")
                );
                orderList.add(order);
            }
        } catch (SQLException e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return orderList;
    }

    // Phương thức cập nhật trạng thái đơn hàng
    public void updateOrderStatus(String orderID, String status) {
        Connection conn = DBConnection.getConnection();
        try {
            String sql = "UPDATE Orders SET Status = ? WHERE OrderID = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, status);
            pst.setString(2, orderID);
            pst.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }
    
    public void addOrder(Order order) {
    Connection conn = DBConnection.getConnection();
    String sql = "INSERT INTO Orders (FullName, Email, Phone, Address, OrderDate, Status) VALUES (?, ?, ?, ?, NOW(), 'chưa giao')";
    try {
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, order.getUserName());
        pst.setString(2, order.getEmail());
        pst.setString(3, order.getPhone());
        pst.setString(4, order.getAddress());
        pst.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}


}
