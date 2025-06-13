--Query 1: Basic Overview of the Dataset
SELECT 
    COUNT(*) AS total_properties,
    MIN(SalePrice) AS min_price,
    MAX(SalePrice) AS max_price,
    AVG(SalePrice) AS avg_price,
    COUNT(DISTINCT LandUse) AS unique_land_use_types
FROM NashvilleHousing;

--Query 2: Sales Trends Over Time
SELECT 
    YEAR(SaleDate) AS sale_year,
    COUNT(*) AS total_sales,
    AVG(SalePrice) AS avg_sale_price,
    SUM(SalePrice) AS total_sales_volume
FROM NashvilleHousing
GROUP BY YEAR(SaleDate)
ORDER BY sale_year;

--Query 3: Property Values by Land Use
SELECT 
    LandUse,
    COUNT(*) AS property_count,
    AVG(SalePrice) AS avg_price,
    AVG(TotalValue) AS avg_total_value,
    AVG(Acreage) AS avg_acreage
FROM NashvilleHousing
GROUP BY LandUse
ORDER BY avg_price DESC;

--Query 4: Price Distribution by Neighborhood (TaxDistrict)
SELECT 
    TaxDistrict,
    COUNT(*) AS property_count,
    AVG(SalePrice) AS avg_price,
    MIN(SalePrice) AS min_price,
    MAX(SalePrice) AS max_price
FROM NashvilleHousing
GROUP BY TaxDistrict
ORDER BY avg_price DESC;

--Query 5: Vacant vs. Occupied Sales
SELECT 
    SoldAsVacant,
    COUNT(*) AS sales_count,
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM NashvilleHousing)) AS percentage
FROM NashvilleHousing
GROUP BY SoldAsVacant;

--Query 6: Property Age vs. Value
SELECT 
    (YEAR(SaleDate) - YearBuilt) AS property_age,
    AVG(SalePrice) AS avg_price,
    COUNT(*) AS property_count
FROM NashvilleHousing
WHERE YearBuilt > 0
GROUP BY (YEAR(SaleDate) - YearBuilt)
ORDER BY property_age;

--Query 7: High-Value Properties with Low Land Value (Potential Undervaluation)
SELECT 
    ParcelID,
    PropertyAddress,
    SalePrice,
    LandValue,
    (SalePrice - LandValue) AS building_value_diff
FROM NashvilleHousing
WHERE LandValue < (SELECT AVG(LandValue) FROM NashvilleHousing)
AND SalePrice > (SELECT AVG(SalePrice) FROM NashvilleHousing)
ORDER BY building_value_diff DESC;

