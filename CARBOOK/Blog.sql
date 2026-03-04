-- ======================================
-- Create Blog Table
-- ======================================

USE CRMS_DB1;
GO

-- Drop table if exists
IF OBJECT_ID('dbo.Blogs', 'U') IS NOT NULL
    DROP TABLE dbo.Blogs;
GO

-- Create Blogs table
CREATE TABLE Blogs (
    BlogID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(255) NOT NULL,
    Content NVARCHAR(MAX) NOT NULL,
    Summary NVARCHAR(500),
    ImageURL NVARCHAR(500),
    AuthorID INT NOT NULL,
    CategoryName NVARCHAR(100),
    ViewCount INT DEFAULT 0,
    IsPublished BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (AuthorID) REFERENCES Users(UserID)
);
GO

-- Create index for better performance
CREATE INDEX IX_Blogs_AuthorID ON Blogs(AuthorID);
CREATE INDEX IX_Blogs_CreatedAt ON Blogs(CreatedAt DESC);
CREATE INDEX IX_Blogs_IsPublished ON Blogs(IsPublished);
GO

-- ======================================
-- Insert Sample Blog Data
-- ======================================

-- Insert sample blogs
INSERT INTO Blogs (Title, Content, Summary, ImageURL, AuthorID, CategoryName, ViewCount, IsPublished)
VALUES 
(
    N'Top 10 Tips for First-Time Car Renters',
    N'<p>Renting a car for the first time can be overwhelming. Here are our top 10 tips to make your experience smooth and hassle-free.</p>
    <h3>1. Book in Advance</h3>
    <p>Booking your rental car in advance often results in better rates and ensures vehicle availability, especially during peak seasons.</p>
    <h3>2. Check Insurance Coverage</h3>
    <p>Review your personal auto insurance and credit card benefits before purchasing additional coverage from the rental company.</p>
    <h3>3. Inspect the Vehicle</h3>
    <p>Take photos and note any existing damage before driving off the lot. This protects you from false damage claims later.</p>
    <h3>4. Understand the Fuel Policy</h3>
    <p>Know whether you need to return the car with a full tank or if there''s a prepaid fuel option.</p>
    <h3>5. Read the Contract Carefully</h3>
    <p>Pay attention to mileage limits, late return fees, and additional driver charges.</p>',
    N'Your comprehensive guide to renting a car for the first time. Learn essential tips to save money and avoid common pitfalls.',
    'images/blog_1.jpg',
    1,
    N'Rental Tips',
    245,
    1
),
(
    N'How to Choose the Right Car for Your Trip',
    N'<p>Selecting the perfect rental car depends on several factors including your destination, number of passengers, and budget.</p>
    <h3>Consider Your Needs</h3>
    <p>Are you traveling alone for business or with family for vacation? The number of passengers and amount of luggage will determine the size of car you need.</p>
    <h3>Terrain and Weather</h3>
    <p>If you''re heading to mountainous areas or expect bad weather, consider an SUV or 4WD vehicle for better handling and safety.</p>
    <h3>Fuel Efficiency</h3>
    <p>For long-distance trips, a fuel-efficient sedan or hybrid can save you significant money on gas.</p>
    <h3>Budget Considerations</h3>
    <p>While luxury cars are appealing, they come with higher rental rates and insurance costs. Balance your desires with your budget.</p>',
    N'Learn how to select the perfect rental car based on your travel needs, destination, and budget considerations.',
    'images/blog_2.jpg',
    1,
    N'Car Selection',
    189,
    1
),
(
    N'Understanding Car Rental Insurance: What You Need to Know',
    N'<p>Car rental insurance can be confusing. This guide breaks down the different types of coverage and helps you make informed decisions.</p>
    <h3>Types of Coverage</h3>
    <p><strong>CDW/LDW:</strong> Collision Damage Waiver or Loss Damage Waiver limits your financial responsibility if the car is damaged or stolen.</p>
    <p><strong>SLI:</strong> Supplemental Liability Insurance provides additional liability coverage beyond the basic policy.</p>
    <p><strong>PAI:</strong> Personal Accident Insurance covers medical costs for you and your passengers.</p>
    <h3>What''s Already Covered?</h3>
    <p>Check your personal auto insurance policy and credit card benefits. Many provide rental car coverage, potentially saving you $10-30 per day.</p>
    <h3>International Rentals</h3>
    <p>When renting abroad, local laws may require specific insurance types. Research requirements for your destination country.</p>',
    N'Demystify car rental insurance options and learn what coverage you actually need to protect yourself and save money.',
    'images/blog_3.jpg',
    1,
    N'Insurance Guide',
    312,
    1
),
(
    N'Best Road Trip Destinations for Car Rentals in 2026',
    N'<p>Planning a road trip? Here are the most scenic and exciting routes perfect for exploring with a rental car.</p>
    <h3>Pacific Coast Highway, California</h3>
    <p>Drive along stunning coastal cliffs with breathtaking ocean views. Best visited in spring or fall to avoid summer crowds.</p>
    <h3>Blue Ridge Parkway, Virginia to North Carolina</h3>
    <p>Experience spectacular fall foliage and mountain vistas on this 469-mile scenic byway.</p>
    <h3>Florida Keys, Florida</h3>
    <p>Island-hop across 42 bridges connecting the keys, ending in Key West for sunset celebrations.</p>
    <h3>Route 66, Chicago to Los Angeles</h3>
    <p>Take a nostalgic journey through America''s heartland on this historic highway.</p>
    <h3>Great Ocean Road, Australia</h3>
    <p>For international travelers, this Australian coastal route offers stunning rock formations and wildlife viewing.</p>',
    N'Discover the most beautiful and memorable road trip routes perfect for your next car rental adventure.',
    'images/blog_4.jpg',
    1,
    N'Travel Destinations',
    428,
    1
),
(
    N'Eco-Friendly Car Rentals: The Future is Green',
    N'<p>The car rental industry is going green. Learn about eco-friendly options and how they benefit both you and the environment.</p>
    <h3>Hybrid and Electric Vehicles</h3>
    <p>Major rental companies now offer hybrid and fully electric vehicles. While sometimes pricier upfront, you''ll save on fuel costs.</p>
    <h3>Benefits of Going Green</h3>
    <p>Lower emissions, reduced fuel costs, and access to HOV lanes in many cities make eco-friendly rentals attractive options.</p>
    <h3>Charging Infrastructure</h3>
    <p>Electric vehicle charging stations are increasingly common. Apps like PlugShare help you locate charging points along your route.</p>
    <h3>Carbon Offset Programs</h3>
    <p>Many rental companies offer carbon offset programs, allowing you to neutralize your trip''s environmental impact for a small fee.</p>
    <h3>The Future</h3>
    <p>With major manufacturers phasing out gas vehicles, rental fleets will increasingly feature electric and hybrid options.</p>',
    N'Explore eco-friendly car rental options, from hybrids to full electric vehicles, and learn how to reduce your carbon footprint.',
    'images/blog_5.jpg',
    1,
    N'Eco-Friendly',
    167,
    1
),
(
    N'Business Travel: Maximizing Your Car Rental Experience',
    N'<p>Frequent business travelers need efficiency and reliability. Here''s how to optimize your car rental experience for business trips.</p>
    <h3>Loyalty Programs</h3>
    <p>Join rental company loyalty programs for faster service, free upgrades, and points toward free rentals.</p>
    <h3>Express Services</h3>
    <p>Many companies offer express pickup and return, allowing you to skip the counter entirely.</p>
    <h3>Choose the Right Location</h3>
    <p>Airport locations are convenient but often more expensive. Consider off-airport locations if you have time.</p>
    <h3>Technology Integration</h3>
    <p>Use mobile apps for quick bookings, digital contracts, and keyless vehicle access.</p>
    <h3>Expense Tracking</h3>
    <p>Keep all receipts and use the rental company''s detailed invoice for accurate expense reporting.</p>',
    N'Business travelers: learn how to streamline your car rental process with loyalty programs, express services, and smart booking strategies.',
    'images/blog_6.jpg',
    1,
    N'Business Travel',
    203,
    1
);
GO

-- ======================================
-- Create Blog Comments Table (Optional)
-- ======================================

IF OBJECT_ID('dbo.BlogComments', 'U') IS NOT NULL
    DROP TABLE dbo.BlogComments;
GO

CREATE TABLE BlogComments (
    CommentID INT PRIMARY KEY IDENTITY(1,1),
    BlogID INT NOT NULL,
    UserID INT NOT NULL,
    Comment NVARCHAR(1000) NOT NULL,
    IsApproved BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (BlogID) REFERENCES Blogs(BlogID) ON DELETE CASCADE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

CREATE INDEX IX_BlogComments_BlogID ON BlogComments(BlogID);
GO

-- ======================================
-- Verify data
-- ======================================

SELECT 
    BlogID,
    Title,
    AuthorID,
    CategoryName,
    ViewCount,
    CreatedAt
FROM Blogs
ORDER BY CreatedAt DESC;
GO

PRINT 'Blog tables created and sample data inserted successfully!'
GO
