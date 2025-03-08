/*
	DATA CLEANING of Nashville Housing
*/

SELECT *
FROM housing;

-- Standardize Date format
ALTER TABLE housing
MODIFY COLUMN SaleDate DATE;

-- Populate Property Address data
SELECT PropertyAddress
FROM housing
WHERE PropertyAddress IS NULL;

SELECT h1.ParcelID, h1.PropertyAddress, h2.ParcelID, h2.PropertyAddress
FROM housing h1
INNER JOIN housing h2
	 ON h1.ParcelID = h2.ParcelID
     AND h1.PropertyAddress IS NOT NULL
     AND h2.PropertyAddress IS NULL
ORDER BY h1.ParcelID;

UPDATE housing h1
INNER JOIN housing h2
	 ON h1.ParcelID = h2.ParcelID
     AND h1.PropertyAddress IS NOT NULL
     AND h2.PropertyAddress IS NULL
SET h2.PropertyAddress = h1.PropertyAddress;

-- Breaking out address into individual columns (address, city, state)

-- Splitting PropertyAddress
SELECT PropertyAddress
FROM housing;

SELECT SUBSTR(PropertyAddress, 1, LOCATE(',', PropertyAddress) - 1) AS Address,
	SUBSTR(PropertyAddress, LOCATE(',', PropertyAddress) + 1, LENGTH(PropertyAddress)) AS City
FROM housing;

ALTER TABLE housing
ADD PropertySplitAddress VARCHAR(255);

ALTER TABLE housing
ADD PropertySplitCity VARCHAR(255);

UPDATE housing
SET PropertySplitAddress = SUBSTR(PropertyAddress, 1, LOCATE(',', PropertyAddress) - 1);

UPDATE housing
SET PropertySplitCity = SUBSTR(PropertyAddress, LOCATE(',', PropertyAddress) + 1, LENGTH(PropertyAddress));

SELECT *
FROM housing;

-- Splitting OwnerAddress
SELECT OwnerAddress
FROM housing;

SELECT SUBSTRING_INDEX(OwnerAddress, ',', 1) AS Address,
	SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1) AS City,
    SUBSTRING_INDEX(OwnerAddress, ',', -1) AS State
FROM housing;

ALTER TABLE housing
ADD OwnerSplitAddress VARCHAR(255);

ALTER TABLE housing
ADD OwnerSplitCity VARCHAR(255);

ALTER TABLE housing
ADD OwnerSplitState VARCHAR(255);

UPDATE housing
SET OwnerSplitAddress = SUBSTRING_INDEX(OwnerAddress, ',', 1);

UPDATE housing
SET OwnerSplitCity = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1);

UPDATE housing
SET OwnerSplitState = SUBSTRING_INDEX(OwnerAddress, ',', -1);

SELECT *
FROM housing;

-- Change Y & N to Yes & No in SoldAsVacant
SELECT DISTINCT SoldAsVacant
FROM housing;

UPDATE housing
SET SoldAsVacant = 'Yes'
WHERE SoldAsVacant = 'Y';

UPDATE housing
SET SoldAsVacant = 'No'
WHERE SoldAsVacant = 'N';

-- Remove duplicates
SELECT *
FROM housing;

WITH duplicates AS (
SELECT *,
	ROW_NUMBER() OVER(PARTITION BY ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference
					  ORDER BY UniqueID) AS row_num
FROM housing
ORDER BY ParcelID)

DELETE FROM housing
WHERE UniqueID IN 
(
	SELECT UniqueID
	FROM duplicates
	WHERE row_num > 1
);


WITH duplicates AS (
SELECT *,
	ROW_NUMBER() OVER(PARTITION BY ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference
					  ORDER BY UniqueID) AS row_num
FROM housing
ORDER BY ParcelID)
SELECT *
FROM duplicates
WHERE row_num > 1;

SELECT *
FROM housing
WHERE PARCELID = '081 02 0 144.00'; -- example of duplicates to verify

-- Delete unused colunns
SELECT *
FROM housing;

ALTER TABLE housing
DROP COLUMN PropertyAddress,
DROP COLUMN OwnerAddress,
DROP COLUMN TaxDistrict;