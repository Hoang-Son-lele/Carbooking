package dal;

import model.Role;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * RoleDAO - Data Access Object for Role management
 */
public class RoleDAO extends DBContext {
    
    /**
     * Get all roles
     * @return List of all roles
     */
    public List<Role> getAllRoles() {
        List<Role> roles = new ArrayList<>();
        String sql = "SELECT * FROM Roles ORDER BY RoleID";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                roles.add(extractRoleFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting all roles: " + e.getMessage());
        }
        return roles;
    }
    
    /**
     * Get role by ID
     * @param roleId
     * @return Role object or null
     */
    public Role getRoleById(int roleId) {
        String sql = "SELECT * FROM Roles WHERE RoleID = ?";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, roleId);
            ResultSet rs = stm.executeQuery();
            
            if (rs.next()) {
                return extractRoleFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting role by ID: " + e.getMessage());
        }
        return null;
    }
    
    /**
     * Get role by name
     * @param roleName
     * @return Role object or null
     */
    public Role getRoleByName(String roleName) {
        String sql = "SELECT * FROM Roles WHERE RoleName = ?";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, roleName);
            ResultSet rs = stm.executeQuery();
            
            if (rs.next()) {
                return extractRoleFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting role by name: " + e.getMessage());
        }
        return null;
    }
    
    /**
     * Create a new role
     * @param role
     * @return true if successful, false otherwise
     */
    public boolean createRole(Role role) {
        String sql = "INSERT INTO Roles (RoleName, Description) VALUES (?, ?)";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, role.getRoleName());
            stm.setString(2, role.getDescription());
            
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error creating role: " + e.getMessage());
        }
        return false;
    }
    
    /**
     * Update role
     * @param role
     * @return true if successful, false otherwise
     */
    public boolean updateRole(Role role) {
        String sql = "UPDATE Roles SET RoleName = ?, Description = ?, UpdatedAt = GETDATE() WHERE RoleID = ?";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, role.getRoleName());
            stm.setString(2, role.getDescription());
            stm.setInt(3, role.getRoleId());
            
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating role: " + e.getMessage());
        }
        return false;
    }
    
    /**
     * Delete role
     * @param roleId
     * @return true if successful, false otherwise
     */
    public boolean deleteRole(int roleId) {
        String sql = "DELETE FROM Roles WHERE RoleID = ?";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, roleId);
            
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting role: " + e.getMessage());
        }
        return false;
    }
    
    /**
     * Extract Role object from ResultSet
     * @param rs
     * @return Role object
     * @throws SQLException
     */
    private Role extractRoleFromResultSet(ResultSet rs) throws SQLException {
        Role role = new Role();
        role.setRoleId(rs.getInt("RoleID"));
        role.setRoleName(rs.getString("RoleName"));
        role.setDescription(rs.getString("Description"));
        role.setCreatedAt(rs.getTimestamp("CreatedAt"));
        role.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
        return role;
    }
}
