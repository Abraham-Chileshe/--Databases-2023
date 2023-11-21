SELECT 
    s."LastName" || ' ' || s."FirstName" AS SellerFullName,
    SUM(p."SellingPrice" * si."QuantitySold") AS TotalRevenue,
    COUNT(DISTINCT sa."ID") AS CountOfSales
FROM 
    "Sellers" s
JOIN 
    "Sales" sa ON s."ID" = sa."SellerID"
JOIN 
    "SalesItems" si ON sa."ID" = si."SaleID"
JOIN 
    "Products" p ON si."ProductID" = p."ID"
GROUP BY 
    SellerFullName
ORDER BY
	TotalRevenue DESC
LIMIT 10;
