package model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * CarAvailability Model
 * Represents blocked/unavailable periods for a car
 */
public class CarAvailability {
    private int availabilityId;
    private int carId;
    private Date startDate;
    private Date endDate;
    private boolean isAvailable;
    private String reason;
    private Timestamp createdAt;
    
    // For display purposes
    private String carName;
    private String licensePlate;
    
    // Constructors
    public CarAvailability() {
    }
    
    public CarAvailability(int availabilityId, int carId, Date startDate, Date endDate, 
                          boolean isAvailable, String reason, Timestamp createdAt) {
        this.availabilityId = availabilityId;
        this.carId = carId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.isAvailable = isAvailable;
        this.reason = reason;
        this.createdAt = createdAt;
    }
    
    // Getters and Setters
    public int getAvailabilityId() {
        return availabilityId;
    }
    
    public void setAvailabilityId(int availabilityId) {
        this.availabilityId = availabilityId;
    }
    
    public int getCarId() {
        return carId;
    }
    
    public void setCarId(int carId) {
        this.carId = carId;
    }
    
    public Date getStartDate() {
        return startDate;
    }
    
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }
    
    public Date getEndDate() {
        return endDate;
    }
    
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
    
    public boolean isAvailable() {
        return isAvailable;
    }
    
    public void setAvailable(boolean available) {
        isAvailable = available;
    }
    
    public String getReason() {
        return reason;
    }
    
    public void setReason(String reason) {
        this.reason = reason;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public String getCarName() {
        return carName;
    }
    
    public void setCarName(String carName) {
        this.carName = carName;
    }
    
    public String getLicensePlate() {
        return licensePlate;
    }
    
    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }
    
    @Override
    public String toString() {
        return "CarAvailability{" +
                "availabilityId=" + availabilityId +
                ", carId=" + carId +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", isAvailable=" + isAvailable +
                ", reason='" + reason + '\'' +
                '}';
    }
}
