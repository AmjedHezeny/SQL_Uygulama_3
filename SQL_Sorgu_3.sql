-- Hangi �r�nden ka� adet sat?n al?nm??, �r�n ad? ve sat?n al?nan adet bilgileri ile s?ralayal?m
SELECT
	(
		SELECT 
			ProductName
		FROM Products
		WHERE Products.ProductID = od.ProductID
	) AS ProductName,  -- �r�n Ad?
	SUM(od.Quantity) AS PurchasedAmount  -- Toplam Sat?n Al?nan Miktar

FROM [Order Details] AS od
GROUP BY od.ProductID
ORDER BY PurchasedAmount ASC;

-- Hangi �lkede ka� adet m�?terim var, �lke ad? ve m�?teri say?s? olarak listeleyelim
-- (Customers)
SELECT
	Country,  -- �lke
	COUNT(CustomerID) AS CustomerCount  -- M�?teri Say?s?
FROM Customers
GROUP BY Country
ORDER BY CustomerCount;

-- Hangi tedarik�iden ka� �e?it �r�n al?yorum? Tedarik�i ad? ve �r�n �e?it say?s? olarak listeleyelim
-- (products , supplier)
SELECT
	(
		SELECT
			CompanyName
		FROM Suppliers
		WHERE Suppliers.SupplierID = Products.SupplierID
	) AS SupplierName,  -- Tedarik�i Ad?
	COUNT(Products.ProductID) AS ProductVarietyCount  -- �r�n �e?it Say?s?

FROM Products
GROUP BY SupplierID;

-- Kazanc?m?n 1500$ ve �zeri oldu?u sipari?leri listeleyelim
-- (order details)
SELECT
	OrderID,  -- Sipari? ID
	SUM((Quantity * UnitPrice) * (1 - Discount)) AS TotalPrice  -- Toplam Fiyat

FROM [Order Details]
GROUP BY OrderID
HAVING SUM((Quantity * UnitPrice) * (1 - Discount)) >= 1500
ORDER BY TotalPrice;

-- �r�nlerimin ortalama fiyat?ndan y�ksek olan �r�nleri listeleyelim
-- (products)
SELECT
	ProductName,  -- �r�n Ad?
	UnitPrice     -- �r�n Fiyat?

FROM Products
GROUP BY ProductName, UnitPrice
HAVING  UnitPrice > (SELECT AVG(UnitPrice) FROM Products)
ORDER BY UnitPrice ASC;
