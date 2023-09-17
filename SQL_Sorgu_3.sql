-- Hangi üründen kaç adet sat?n al?nm??, ürün ad? ve sat?n al?nan adet bilgileri ile s?ralayal?m
SELECT
	(
		SELECT 
			ProductName
		FROM Products
		WHERE Products.ProductID = od.ProductID
	) AS ProductName,  -- Ürün Ad?
	SUM(od.Quantity) AS PurchasedAmount  -- Toplam Sat?n Al?nan Miktar

FROM [Order Details] AS od
GROUP BY od.ProductID
ORDER BY PurchasedAmount ASC;

-- Hangi Ülkede kaç adet mü?terim var, ülke ad? ve mü?teri say?s? olarak listeleyelim
-- (Customers)
SELECT
	Country,  -- Ülke
	COUNT(CustomerID) AS CustomerCount  -- Mü?teri Say?s?
FROM Customers
GROUP BY Country
ORDER BY CustomerCount;

-- Hangi tedarikçiden kaç çe?it ürün al?yorum? Tedarikçi ad? ve ürün çe?it say?s? olarak listeleyelim
-- (products , supplier)
SELECT
	(
		SELECT
			CompanyName
		FROM Suppliers
		WHERE Suppliers.SupplierID = Products.SupplierID
	) AS SupplierName,  -- Tedarikçi Ad?
	COUNT(Products.ProductID) AS ProductVarietyCount  -- Ürün Çe?it Say?s?

FROM Products
GROUP BY SupplierID;

-- Kazanc?m?n 1500$ ve üzeri oldu?u sipari?leri listeleyelim
-- (order details)
SELECT
	OrderID,  -- Sipari? ID
	SUM((Quantity * UnitPrice) * (1 - Discount)) AS TotalPrice  -- Toplam Fiyat

FROM [Order Details]
GROUP BY OrderID
HAVING SUM((Quantity * UnitPrice) * (1 - Discount)) >= 1500
ORDER BY TotalPrice;

-- Ürünlerimin ortalama fiyat?ndan yüksek olan ürünleri listeleyelim
-- (products)
SELECT
	ProductName,  -- Ürün Ad?
	UnitPrice     -- Ürün Fiyat?

FROM Products
GROUP BY ProductName, UnitPrice
HAVING  UnitPrice > (SELECT AVG(UnitPrice) FROM Products)
ORDER BY UnitPrice ASC;
