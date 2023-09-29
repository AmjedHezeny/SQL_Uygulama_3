-- Hangi üründen kaç adet satın alınmış, ürün adı ve satın alınan adet bilgileri ile sıralayalım
SELECT
	(
		SELECT 
			ProductName
		FROM Products
		WHERE Products.ProductID = od.ProductID
	) AS ProductName,  -- Ürün Adı
	SUM(od.Quantity) AS PurchasedAmount  -- Toplam Satın Alınan Miktar
FROM [Order Details] AS od
GROUP BY od.ProductID
ORDER BY PurchasedAmount ASC;

-- Hangi Ülkede kaç adet müşterim var, ülke adı ve müşteri sayısı olarak listeleyelim
SELECT
	Country,  -- Ülke
	COUNT(CustomerID) AS CustomerCount  -- Müşteri Sayısı
FROM Customers
GROUP BY Country
ORDER BY CustomerCount;

-- Hangi tedarikçiden kaç çeşit ürün alıyorum? Tedarikçi adı ve ürün çeşit sayısı olarak listeleyelim
SELECT
	(
		SELECT
			CompanyName
		FROM Suppliers
		WHERE Suppliers.SupplierID = Products.SupplierID
	) AS SupplierName,  -- Tedarikçi Adı
	COUNT(Products.ProductID) AS ProductVarietyCount  -- Ürün Çeşit Sayısı
FROM Products
GROUP BY SupplierID;

-- Kazancımın 1500$ ve üzeri olduğu siparişleri listeleyelim
SELECT
	OrderID,  -- Sipariş ID
	SUM((Quantity * UnitPrice) * (1 - Discount)) AS TotalPrice  -- Toplam Fiyat
FROM [Order Details]
GROUP BY OrderID
HAVING SUM((Quantity * UnitPrice) * (1 - Discount)) >= 1500
ORDER BY TotalPrice;

-- Ürünlerimin ortalama fiyatından yüksek olan ürünleri listeleyelim
SELECT
	ProductName,  -- Ürün Adı
	UnitPrice     -- Ürün Fiyatı
FROM Products
GROUP BY ProductName, UnitPrice
HAVING  UnitPrice > (SELECT AVG(UnitPrice) FROM Products)
ORDER BY UnitPrice ASC;


---------------------------------------
CREATE FUNCTION Emcet (@Yas FLOAT) 
RETURNS FLOAT
AS
BEGIN
    DECLARE @Yıl FLOAT;
    SET @Yıl = @Yas * 26;
    RETURN @Yıl;
END;

