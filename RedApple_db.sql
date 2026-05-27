CREATE DATABASE IF NOT EXISTS RedApple_db;
USE RedApple_db;

------------------------------ CREATE TABLES -------------------------

CREATE TABLE Stores (
    StoreID INT(15) NOT NULL AUTO_INCREMENT,
    Address VARCHAR(50) NOT NULL,
    ZIPCode VARCHAR(10) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(20),
    StoreEmail VARCHAR(50),
    
    CONSTRAINT pk_stores PRIMARY KEY (StoreID)
);

CREATE TABLE Operators (
    OperatorID INT(15) NOT NULL AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    OperatorEmail VARCHAR(50) NOT NULL,
    StoreID INT(15) NOT NULL,
    
    CONSTRAINT pk_operators PRIMARY KEY (OperatorID),
    CONSTRAINT fk_op_store FOREIGN KEY (StoreID)
		REFERENCES Stores(StoreID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
	
    CONSTRAINT uq_operator_email UNIQUE (OperatorEmail)
);

CREATE TABLE Products (
    ProductID INT(15) NOT NULL AUTO_INCREMENT,
    ProductName VARCHAR(50) NOT NULL,
    ProductCategory VARCHAR(50) NOT NULL,
    ProductVariant VARCHAR(50),
    Price DECIMAL(10, 2) NOT NULL,
    ProductDescription TEXT,
    
    CONSTRAINT pk_products PRIMARY KEY (ProductID),
    
    -- Only allow the four BVA product categories
    CONSTRAINT chk_product_category CHECK (
		ProductCategory IN (
			'Confectionery',
            'Minerals',
            'SS Coffee',
            'Carwash'
		)
	),

	-- Variants
	CONSTRAINT chk_ss_coffee_variant CHECK (
        ProductCategory != 'SS Coffee'
        OR ProductVariant IN (
            'Small Full Fat',
            'Small Skinny',
            'Small Oat',
            'Medium Full Fat',
            'Medium Skinny',
            'Medium Oat',
            'Large Full Fat',
            'Large Skinny',
            'Large Oat',
            'Iced Small Full Fat',
            'Iced Small Skinny',
            'Iced Large Full Fat',
            'Iced Large Skinny'
        )
    ),
    
    -- SS Coffee must have a variant specified
	CONSTRAINT chk_ss_coffee_variant_required CHECK (
        ProductCategory != 'SS Coffee'
        OR ProductVariant IS NOT NULL
    )
);

CREATE TABLE Sales (
    SaleID INT(15) NOT NULL AUTO_INCREMENT,
    OperatorID INT(15) NOT NULL,
    StoreID INT(15) NOT NULL,
    SaleDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Keeps the exact time of the transaction
    CarWashTier INT,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    
    CONSTRAINT pk_sales PRIMARY KEY (SaleID),
    CONSTRAINT fk_sale_op FOREIGN KEY (OperatorID)
        REFERENCES Operators(OperatorID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
        
    CONSTRAINT fk_sale_store  FOREIGN KEY (StoreID)
        REFERENCES Stores(StoreID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
	
    -- CarWashTier must be 3, 4, or 5 if provided
	CONSTRAINT chk_carwash_tier CHECK (
		CarWashTier IS NULL
        OR CarWashTier IN (3,4,5)
	),
    
    CONSTRAINT chk_total_positive CHECK (TotalAmount >=0)
);

CREATE TABLE Sales_Products (
    SaleID INT(15) NOT NULL,
    ProductID INT(15) NOT NULL,
    Quantity INT(10) NOT NULL DEFAULT 1,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    
    CONSTRAINT pk_sale_product  PRIMARY KEY (SaleID, ProductID),
    CONSTRAINT fk_sp_sale       FOREIGN KEY (SaleID)
        REFERENCES Sales(SaleID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_sp_product    FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_quantity_positive  CHECK (Quantity > 0),
    CONSTRAINT chk_unitprice_positive CHECK (UnitPrice >= 0)
);

CREATE INDEX idx_sales_operator ON Sales(OperatorID);
CREATE INDEX idx_sales_store ON Sales(StoreID);
CREATE INDEX idx_sales_date ON Sales(SaleDate);
CREATE INDEX idx_ops_store ON Operators(StoreID);
CREATE INDEX idx_prod_category ON Products(ProductCategory);

-- Filters CarWashTier = 5-star only for KPI
CREATE OR REPLACE VIEW vw_weekly_bva_performance AS
SELECT
    o.OperatorID,
    o.FirstName,
    o.LastName,
    st.City AS StoreCity,
    p.ProductCategory,
    p.ProductVariant,
    YEARWEEK(s.SaleDate, 1) AS SaleWeek,
    SUM(sp.Quantity) AS TotalUnitsSold,
    SUM(sp.Quantity * sp.UnitPrice) AS TotalRevenue,
    
    -- BVA KPI flag: Carwash only counts if tier 5
    CASE
        WHEN p.ProductCategory = 'Carwash'
             AND s.CarWashTier = 5 THEN 'BVA'
        WHEN p.ProductCategory != 'Carwash' THEN 'BVA'
        ELSE 'Non-BVA'
    END AS BVA_Flag

FROM Sales s
JOIN Sales_Products sp ON s.SaleID = sp.SaleID
JOIN Products p  ON sp.ProductID = p.ProductID
JOIN Operators o  ON s.OperatorID = o.OperatorID
JOIN Stores st ON s.StoreID = st.StoreID
GROUP BY
    o.OperatorID, o.FirstName, o.LastName,
    st.City, p.ProductCategory, p.ProductVariant,
    YEARWEEK(s.SaleDate, 1),
    BVA_Flag;

-- Carwash 5-star ratio per operator
CREATE OR REPLACE VIEW vw_carwash_ratio AS
SELECT
    o.OperatorID,
    CONCAT(o.FirstName, ' ', o.LastName) AS OperatorName,
    COUNT(*) AS TotalCarwashSales,
    SUM(CASE WHEN s.CarWashTier = 5 THEN 1 ELSE 0 END) AS FiveStarSales,
    ROUND(
        SUM(CASE WHEN s.CarWashTier = 5 THEN 1 ELSE 0 END)
        / COUNT(*) * 100, 1
    ) AS FiveStarPct
FROM Sales s
JOIN Sales_Products sp ON s.SaleID = sp.SaleID
JOIN Products p ON sp.ProductID = p.ProductID
JOIN Operators o ON s.OperatorID = o.OperatorID
WHERE p.ProductCategory = 'Carwash'
GROUP BY o.OperatorID, OperatorName;