SELECT P.Title, C.Name AS CategoryName, P.SellingPrice
FROM Products P
LEFT JOIN Categories C ON P.CategoryID = C.ID
LEFT JOIN (
    SELECT ProductID, SUM(QuantitySold) AS TotalSold
    FROM SalesItems
    GROUP BY ProductID
) S ON P.ID = S.ProductID
LEFT JOIN (
    SELECT ProductID, SUM(QuantityBought) AS TotalBought
    FROM PurchaseItems
    GROUP BY ProductID
) B ON P.ID = B.ProductID
WHERE (B.TotalBought - COALESCE(S.TotalSold, 0)) = 0
ORDER BY P.SellingPrice DESC;
