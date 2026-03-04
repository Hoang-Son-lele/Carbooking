USE CRMS_DB1;
GO

-- Create Services table
CREATE TABLE Services (
    ServiceID INT PRIMARY KEY IDENTITY(1,1),
    ServiceName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    ShortDescription NVARCHAR(500),
    IconClass NVARCHAR(100), -- CSS class for icon (e.g., flaticon-route, flaticon-wedding-car)
    Price DECIMAL(10,2),
    ImageURL NVARCHAR(MAX),
    IsActive BIT DEFAULT 1,
    DisplayOrder INT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Create index for active services
CREATE INDEX IX_Services_IsActive ON Services(IsActive);
CREATE INDEX IX_Services_DisplayOrder ON Services(DisplayOrder);
GO

-- Insert sample services
INSERT INTO Services (ServiceName, Description, ShortDescription, IconClass, Price, ImageURL, IsActive, DisplayOrder) VALUES
(N'Wedding Ceremony', 
 N'<p>Dịch vụ xe cưới sang trọng và chuyên nghiệp dành cho ngày trọng đại của bạn. Chúng tôi cung cấp đội ngũ xe hoa được trang trí lộng lẫy và lái xe chuyên nghiệp.</p>
  <p>Các gói dịch vụ bao gồm:</p>
  <ul>
    <li>Xe hoa trang trí theo chủ đề</li>
    <li>Lái xe chuyên nghiệp có kinh nghiệm</li>
    <li>Trang trí xe theo yêu cầu</li>
    <li>Hỗ trợ chụp ảnh và quay phim</li>
    <li>Phục vụ rượu champagne</li>
  </ul>
  <p>Hãy để chúng tôi làm cho ngày cưới của bạn trở nên hoàn hảo với dịch vụ xe cưới cao cấp.</p>', 
 N'Dịch vụ xe cưới sang trọng với đội xe được trang trí lộng lẫy và lái xe chuyên nghiệp cho ngày trọng đại.', 
 'flaticon-wedding-car', 
 5000000, 
 'images/bg_1.jpg', 
 1, 1),

(N'City Transfer', 
 N'<p>Dịch vụ đưa đón trong thành phố nhanh chóng, tiện lợi và an toàn. Phù hợp cho các chuyến đi công tác, mua sắm, gặp gỡ đối tác.</p>
  <p>Ưu điểm:</p>
  <ul>
    <li>Đặt xe dễ dàng qua app hoặc hotline</li>
    <li>Lái xe am hiểu đường đi trong thành phố</li>
    <li>Xe đời mới, máy lạnh, sạch sẽ</li>
    <li>Giá cả cạnh tranh</li>
    <li>Đón đúng giờ</li>
    <li>Thanh toán linh hoạt</li>
  </ul>
  <p>Đặc biệt phù hợp cho khách doanh nhân, du khách và người dân địa phương cần di chuyển trong thành phố.</p>', 
 N'Dịch vụ đưa đón trong thành phố nhanh chóng, tiện lợi với đội xe đời mới và lái xe chuyên nghiệp.', 
 'flaticon-route', 
 500000, 
 'images/bg_2.jpg', 
 1, 2),

(N'Airport Transfer', 
 N'<p>Dịch vụ đưa đón sân bay 24/7 đảm bảo đúng giờ, thoải mái và an toàn. Phục vụ tất cả các sân bay trong khu vực.</p>
  <p>Dịch vụ bao gồm:</p>
  <ul>
    <li>Đón/tiễn tận nơi đúng giờ</li>
    <li>Theo dõi chuyến bay real-time</li>
    <li>Hỗ trợ hành lý</li>
    <li>Bảng tên đón khách tại sân bay</li>
    <li>Wifi miễn phí trên xe</li>
    <li>Nước uống miễn phí</li>
    <li>Phục vụ 24/7</li>
  </ul>
  <p>Đặc biệt phù hợp cho khách du lịch, doanh nhân và gia đình có nhu cầu di chuyển đến/từ sân bay.</p>', 
 N'Dịch vụ đưa đón sân bay 24/7, theo dõi chuyến bay, đảm bảo đúng giờ và thoải mái.', 
 'flaticon-airport', 
 800000, 
 'images/bg_3.jpg', 
 1, 3),

(N'Whole City Tour', 
 N'<p>Dịch vụ thuê xe du lịch trọn gói khám phá thành phố với hành trình được thiết kế chuyên nghiệp và hướng dẫn viên giàu kinh nghiệm.</p>
  <p>Chương trình tour bao gồm:</p>
  <ul>
    <li>Xe du lịch đời mới, thoải mái</li>
    <li>Lái xe kiêm hướng dẫn viên</li>
    <li>Lộ trình tham quan các địa điểm nổi tiếng</li>
    <li>Dừng chụp ảnh tại các điểm đẹp</li>
    <li>Giới thiệu văn hóa, ẩm thực địa phương</li>
    <li>Linh hoạt thời gian và lịch trình</li>
    <li>Hỗ trợ đặt nhà hàng, mua sắm</li>
  </ul>
  <p>Thích hợp cho gia đình, nhóm bạn hoặc du khách muốn khám phá thành phố một cách toàn diện.</p>', 
 N'Thuê xe du lịch trọn gói khám phá thành phố với lộ trình chuyên nghiệp và hướng dẫn viên.', 
 'flaticon-map', 
 2000000, 
 'images/car-1.jpg', 
 1, 4),

(N'Corporate Service', 
 N'<p>Dịch vụ thuê xe dành riêng cho doanh nghiệp với các gói hợp đồng linh hoạt và ưu đãi hấp dẫn.</p>
  <p>Dịch vụ doanh nghiệp bao gồm:</p>
  <ul>
    <li>Đội xe cao cấp chuyên dụng</li>
    <li>Lái xe chuyên nghiệp, tác phong lịch sự</li>
    <li>Hợp đồng theo tháng/năm</li>
    <li>Ưu đãi đặc biệt cho khách hàng thường xuyên</li>
    <li>Hóa đơn VAT đầy đủ</li>
    <li>Xe dự phòng sẵn sàng</li>
    <li>Quản lý tập trung qua hệ thống</li>
  </ul>
  <p>Lý tưởng cho các công ty cần dịch vụ đưa đón nhân viên, đối tác và khách hàng.</p>', 
 N'Dịch vụ thuê xe doanh nghiệp với hợp đồng linh hoạt và đội xe cao cấp chuyên nghiệp.', 
 'flaticon-user', 
 15000000, 
 'images/car-2.jpg', 
 1, 5),

(N'Long Distance Travel', 
 N'<p>Dịch vụ thuê xe đường dài cho các chuyến đi liên tỉnh, du lịch xa với xe thoải mái và lái xe an toàn.</p>
  <p>Ưu điểm vượt trội:</p>
  <ul>
    <li>Xe chuyên dụng đường dài</li>
    <li>Lái xe kinh nghiệm, an toàn</li>
    <li>Nghỉ ngơi hợp lý theo quy định</li>
    <li>Bảo hiểm đầy đủ</li>
    <li>Hỗ trợ lên kế hoạch hành trình</li>
    <li>Chi phí minh bạch (xăng, phí đường bộ)</li>
    <li>Linh hoạt điểm đón/trả</li>
  </ul>
  <p>Phù hợp cho gia đình, nhóm bạn đi du lịch hoặc công tác đường dài.</p>', 
 N'Dịch vụ thuê xe đường dài liên tỉnh với xe thoải mái và lái xe an toàn có kinh nghiệm.', 
 'flaticon-road', 
 3000000, 
 'images/car-3.jpg', 
 1, 6);
GO

-- View all services
SELECT 
    ServiceID,
    ServiceName,
    ShortDescription,
    IconClass,
    Price,
    IsActive,
    DisplayOrder,
    CreatedAt
FROM Services
ORDER BY DisplayOrder, ServiceID;
GO
