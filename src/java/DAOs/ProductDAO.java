package DAOs;

import DBConnection.DBConnection;
import Models.Order;
import Models.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProductDAO {

    // Phương thức lấy thông tin sản phẩm theo ID
    public Product getProduct(int id) {
        Connection conn = DBConnection.getConnection();
        Product obj = null;
        try {
            String sql = "SELECT * FROM Products WHERE ProductID = ?;";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id); // Đổi thành setInt
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                obj = new Product(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("Category"),
                        rs.getDouble("Price"),
                        rs.getInt("Quantity"),
                        rs.getString("ImageUrl")
                );
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return obj;
    }

    // Phương thức tạo sản phẩm mới
    public int create(Product obj) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Products (ProductName, Category, Price, Quantity, ImageUrl) VALUES (?, ?, ?, ?, ?)";
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, obj.getProductName());
            pst.setString(2, obj.getCategory());
            pst.setDouble(3, obj.getPrice());
            pst.setInt(4, obj.getQuantity());
            pst.setString(5, obj.getImageUrl());
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return count;
    }

    // Phương thức tìm kiếm sản phẩm dựa trên từ khóa
    public List<Product> searchProducts(String keyword) {
        List<Product> productList = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        try {
            String sql = "SELECT * FROM Products WHERE ProductName LIKE ? OR Category LIKE ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, "%" + keyword + "%");
            pst.setString(2, "%" + keyword + "%");
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("Category"),
                        rs.getDouble("Price"),
                        rs.getInt("Quantity"),
                        rs.getString("ImageUrl")
                );
                productList.add(product);
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return productList;
    }

    // Phương thức lấy tất cả các sản phẩm
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        try {
            String sql = "SELECT * FROM Products";
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("Category"),
                        rs.getDouble("Price"),
                        rs.getInt("Quantity"),
                        rs.getString("ImageUrl")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return products;
    }

    // Phương thức xóa sản phẩm theo ID
    public void deleteProduct(int productID) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Products WHERE ProductID = ?";
        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, productID);
            pst.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }

    // Phương thức xác nhận đơn hàng bằng cách cập nhật trạng thái sản phẩm
    public void confirmOrder(int productID) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Orders SET Status = 'Delivered' WHERE ProductID = ?";
        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, productID);
            pst.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }

    // Phương thức cập nhật sản phẩm
    public void updateProduct(Product product) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Products SET ProductName = ?, Category = ?, Price = ?, Quantity = ?, ImageUrl = ? WHERE ProductID = ?";

        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, product.getProductName());
            pst.setString(2, product.getCategory());
            pst.setDouble(3, product.getPrice());
            pst.setInt(4, product.getQuantity());
            pst.setString(5, product.getImageUrl());
            pst.setInt(6, product.getProductID());

            pst.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }

}
