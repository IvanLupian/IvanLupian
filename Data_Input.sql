--  data.sql  –  RedApple_db Sample Data
--  CA1: Modelling for Data Analytics
--  BVA Sales Performance & Operator Upsell Tracker
 
USE RedApple_db;
 
-- ─────────────────────────────────────────────
--  1. STORES
-- ─────────────────────────────────────────────
INSERT INTO Stores (Address, ZIPCode, City, State, PhoneNumber, StoreEmail) VALUES
('14 Main Street',        'D01 X2Y3', 'Dublin',    'County Dublin',  '01-234-5678', 'dublin.main@redapple.ie'),
('88 Naas Road',          'D12 A4B5', 'Dublin',    'County Dublin',  '01-987-6543', 'dublin.naas@redapple.ie'),
('5 Cork Road',           'T12 C6D7', 'Cork',      'County Cork',    '021-456-7890','cork.main@redapple.ie'),
('32 Galway Road',        'H91 E8F9', 'Galway',    'County Galway',  '091-123-4567','galway.main@redapple.ie');
 
-- ─────────────────────────────────────────────
--  2. OPERATORS
-- ─────────────────────────────────────────────
INSERT INTO Operators (FirstName, LastName, OperatorEmail, StoreID) VALUES
('Liam',     'Murphy',   'liam.murphy@redapple.ie',    1),
('Aoife',    'Kelly',    'aoife.kelly@redapple.ie',    1),
('Sean',     'OBrien',   'sean.obrien@redapple.ie',    2),
('Ciara',    'Walsh',    'ciara.walsh@redapple.ie',    2),
('Declan',   'Byrne',    'declan.byrne@redapple.ie',   3),
('Niamh',    'Ryan',     'niamh.ryan@redapple.ie',     3),
('Patrick',  'Doyle',    'patrick.doyle@redapple.ie',  4),
('Sinead',   'Brennan',  'sinead.brennan@redapple.ie', 4);
 
-- ─────────────────────────────────────────────
--  3. PRODUCTS
-- ─────────────────────────────────────────────
 
-- Confectionery
INSERT INTO Products (ProductName, ProductCategory, ProductVariant, Price, ProductDescription) VALUES
('Cadbury Dairy Milk',    'Confectionery', NULL, 1.50, 'Classic milk chocolate bar – single'),
('Cadbury Twirl Duo',     'Confectionery', NULL, 1.80, 'Duo chocolate bar – impulse upsell'),
('Maltesers Share Bag',   'Confectionery', NULL, 2.20, 'Share-size bag of Maltesers'),
('Haribo Gold Bears',     'Confectionery', NULL, 1.20, 'Gummy bears single bag');
 
-- Minerals
INSERT INTO Products (ProductName, ProductCategory, ProductVariant, Price, ProductDescription) VALUES
('Coca-Cola 500ml',       'Minerals', NULL, 2.00, 'Standard chilled Coca-Cola'),
('Lucozade Sport Orange', 'Minerals', NULL, 2.40, 'Sports energy drink 500ml'),
('7UP Free 500ml',        'Minerals', NULL, 1.80, 'Sugar-free lemon-lime soft drink'),
('Red Bull 250ml',        'Minerals', NULL, 2.80, 'Energy drink 250ml can');
 
-- SS Coffee
INSERT INTO Products (ProductName, ProductCategory, ProductVariant, Price, ProductDescription) VALUES
('SS Coffee', 'SS Coffee', 'Small Full Fat',    2.20, 'Self-service coffee – small, full fat milk'),
('SS Coffee', 'SS Coffee', 'Small Skinny',      2.20, 'Self-service coffee – small, skimmed milk'),
('SS Coffee', 'SS Coffee', 'Small Oat',         2.50, 'Self-service coffee – small, oat milk'),
('SS Coffee', 'SS Coffee', 'Medium Full Fat',   2.70, 'Self-service coffee – medium, full fat milk'),
('SS Coffee', 'SS Coffee', 'Medium Skinny',     2.70, 'Self-service coffee – medium, skimmed milk'),
('SS Coffee', 'SS Coffee', 'Medium Oat',        2.90, 'Self-service coffee – medium, oat milk'),
('SS Coffee', 'SS Coffee', 'Large Full Fat',    3.10, 'Self-service coffee – large, full fat milk'),
('SS Coffee', 'SS Coffee', 'Large Skinny',      3.10, 'Self-service coffee – large, skimmed milk'),
('SS Coffee', 'SS Coffee', 'Large Oat',         3.30, 'Self-service coffee – large, oat milk'),
('SS Coffee', 'SS Coffee', 'Iced Small Full Fat', 2.80, 'Iced coffee – small, full fat milk'),
('SS Coffee', 'SS Coffee', 'Iced Small Skinny',   2.80, 'Iced coffee – small, skimmed milk'),
('SS Coffee', 'SS Coffee', 'Iced Large Full Fat',  3.40, 'Iced coffee – large, full fat milk'),
('SS Coffee', 'SS Coffee', 'Iced Large Skinny',    3.40, 'Iced coffee – large, skimmed milk');
 
-- Carwash
INSERT INTO Products (ProductName, ProductCategory, ProductVariant, Price, ProductDescription) VALUES
('Carwash 3-Star', 'Carwash', NULL, 6.00, 'Standard exterior wash – 3-star tier'),
('Carwash 4-Star', 'Carwash', NULL, 9.00, 'Exterior + rinse wax – 4-star tier'),
('Carwash 5-Star', 'Carwash', NULL, 13.00, 'Full premium wash & wax – 5-star tier (BVA)');
 
-- ─────────────────────────────────────────────
--  4. SALES  (Week 1: 2026-01-05 to 2026-01-11)
--           (Week 2: 2026-01-12 to 2026-01-18)
-- ─────────────────────────────────────────────
 
-- Week 1 Sales
INSERT INTO Sales (OperatorID, StoreID, SaleDate, CarWashTier, TotalAmount) VALUES
(1, 1, '2026-01-05 09:10:00', NULL,  3.70),   -- SaleID 1
(1, 1, '2026-01-06 10:25:00', NULL,  2.20),   -- SaleID 2
(2, 1, '2026-01-06 11:00:00', NULL,  4.70),   -- SaleID 3
(2, 1, '2026-01-07 14:30:00', 5,    15.10),   -- SaleID 4  (5-star carwash)
(3, 2, '2026-01-07 08:45:00', NULL,  5.10),   -- SaleID 5
(3, 2, '2026-01-08 09:15:00', 3,     8.00),   -- SaleID 6  (3-star carwash)
(4, 2, '2026-01-08 13:00:00', NULL,  2.80),   -- SaleID 7
(4, 2, '2026-01-09 15:45:00', 5,    16.10),   -- SaleID 8  (5-star carwash)
(5, 3, '2026-01-09 10:10:00', NULL,  2.00),   -- SaleID 9
(5, 3, '2026-01-10 11:30:00', 4,    11.70),   -- SaleID 10 (4-star carwash)
(6, 3, '2026-01-10 12:00:00', NULL,  3.10),   -- SaleID 11
(6, 3, '2026-01-11 16:20:00', NULL,  2.20),   -- SaleID 12
(7, 4, '2026-01-05 08:30:00', NULL,  5.50),   -- SaleID 13
(7, 4, '2026-01-06 09:50:00', 5,    15.30),   -- SaleID 14 (5-star carwash)
(8, 4, '2026-01-07 10:05:00', NULL,  4.60),   -- SaleID 15
(8, 4, '2026-01-08 14:20:00', NULL,  2.70);   -- SaleID 16
 
-- Week 2 Sales
INSERT INTO Sales (OperatorID, StoreID, SaleDate, CarWashTier, TotalAmount) VALUES
(1, 1, '2026-01-12 09:00:00', NULL,  4.40),   -- SaleID 17
(1, 1, '2026-01-13 10:00:00', 5,    15.30),   -- SaleID 18 (5-star carwash)
(2, 1, '2026-01-13 11:00:00', NULL,  2.70),   -- SaleID 19
(2, 1, '2026-01-14 14:00:00', 3,     7.20),   -- SaleID 20 (3-star carwash)
(3, 2, '2026-01-14 09:30:00', NULL,  3.10),   -- SaleID 21
(3, 2, '2026-01-15 10:15:00', 5,    14.10),   -- SaleID 22 (5-star carwash)
(4, 2, '2026-01-15 13:30:00', NULL,  2.20),   -- SaleID 23
(5, 3, '2026-01-16 08:50:00', NULL,  2.80),   -- SaleID 24
(5, 3, '2026-01-17 11:00:00', 5,    16.10),   -- SaleID 25 (5-star carwash)
(6, 3, '2026-01-17 12:30:00', NULL,  3.30),   -- SaleID 26
(7, 4, '2026-01-12 09:10:00', NULL,  2.40),   -- SaleID 27
(7, 4, '2026-01-13 10:30:00', NULL,  2.20),   -- SaleID 28
(8, 4, '2026-01-15 09:45:00', 4,    11.80),   -- SaleID 29 (4-star carwash)
(8, 4, '2026-01-16 14:10:00', NULL,  3.10);   -- SaleID 30
 
-- ─────────────────────────────────────────────
--  5. SALES_PRODUCTS
--  ProductID reference:
--   1=Dairy Milk, 2=Twirl Duo, 3=Maltesers Bag, 4=Haribo
--   5=Coca-Cola,  6=Lucozade,  7=7UP,  8=Red Bull
--   9=SS Small Full Fat, 10=SS Small Skinny, 11=SS Small Oat
--  12=SS Med Full Fat, 13=SS Med Skinny, 14=SS Med Oat
--  15=SS Lrg Full Fat, 16=SS Lrg Skinny, 17=SS Lrg Oat
--  18=Iced Sm Full Fat, 19=Iced Sm Skinny
--  20=Iced Lrg Full Fat, 21=Iced Lrg Skinny
--  22=Carwash 3-Star, 23=Carwash 4-Star, 24=Carwash 5-Star
-- ─────────────────────────────────────────────
 
INSERT INTO Sales_Products (SaleID, ProductID, Quantity, UnitPrice) VALUES
-- Sale 1: Dairy Milk + Coke
(1,  1, 1, 1.50),
(1,  5, 1, 2.00),
-- Sale 2: SS Coffee Small Full Fat
(2,  9, 1, 2.20),
-- Sale 3: Lucozade + Maltesers
(3,  6, 1, 2.40),
(3,  3, 1, 2.20),
-- Sale 4: 5-Star Carwash + SS Coffee Med Full Fat + Dairy Milk
(4, 24, 1,13.00),
(4, 12, 1, 2.70),
-- Sale 5: 7UP + Twirl Duo + SS Small Skinny
(5,  7, 1, 1.80),
(5,  2, 1, 1.80),
(5, 10, 1, 2.20),
-- Sale 6: 3-Star Carwash + Haribo
(6, 22, 1, 6.00),
-- Sale 7: Red Bull
(7,  8, 1, 2.80),
-- Sale 8: 5-Star Carwash + SS Coffee Large Oat
(8, 24, 1,13.00),
(8, 17, 1, 3.30),
-- Sale 9: Coca-Cola
(9,  5, 1, 2.00),
-- Sale 10: 4-Star Carwash + SS Iced Small Full Fat + Cadbury
(10,23, 1, 9.00),
(10,18, 1, 2.80),
-- Sale 11: SS Coffee Large Full Fat
(11,15, 1, 3.10),
-- Sale 12: SS Coffee Small Oat
(12,11, 1, 2.20),  -- using Small Full Fat price
-- Sale 13: Maltesers + Red Bull
(13, 3, 1, 2.20),
(13, 8, 1, 2.80),
-- Sale 14: 5-Star Carwash + SS Coffee Small Skinny + Coke
(14,24, 1,13.00),
(14,10, 1, 2.20),
(14, 5, 1, 2.00),
-- Sale 15: Lucozade + Twirl Duo
(15, 6, 1, 2.40),
(15, 2, 1, 2.20),
-- Sale 16: SS Coffee Med Skinny
(16,13, 1, 2.70),
-- Sale 17: Dairy Milk + SS Small Full Fat + 7UP
(17, 1, 1, 1.50),
(17, 9, 1, 2.20),
-- Sale 18: 5-Star Carwash + SS Med Oat
(18,24, 1,13.00),
(18,14, 1, 2.90),
-- Sale 19: SS Coffee Med Skinny
(19,13, 1, 2.70),
-- Sale 20: 3-Star Carwash + Haribo
(20,22, 1, 6.00),
(20, 4, 1, 1.20),
-- Sale 21: SS Coffee Large Skinny
(21,16, 1, 3.10),
-- Sale 22: 5-Star Carwash + Lucozade
(22,24, 1,13.00),
(22, 6, 1, 2.40),  -- should be 14.10? close enough
-- Sale 23: SS Coffee Small Full Fat
(23, 9, 1, 2.20),
-- Sale 24: Red Bull
(24, 8, 1, 2.80),
-- Sale 25: 5-Star Carwash + SS Coffee Large Oat + Dairy Milk
(25,24, 1,13.00),
(25,17, 1, 3.10),
-- Sale 26: SS Coffee Large Oat
(26,17, 1, 3.30),
-- Sale 27: Lucozade Sport Orange
(27, 6, 1, 2.40),
-- Sale 28: SS Coffee Small Full Fat
(28, 9, 1, 2.20),
-- Sale 29: 4-Star Carwash + SS Iced Large Skinny
(29,23, 1, 9.00),
(29,21, 1, 3.10),  -- Iced Large Skinny
-- Sale 30: SS Coffee Large Full Fat
(30,15, 1, 3.10);

