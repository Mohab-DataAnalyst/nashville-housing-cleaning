
![Logo](https://images.pexels.com/photos/1370704/pexels-photo-1370704.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1)


# 🏡 Nashville Housing Data Cleaning (SQL)

📊 This project focuses on cleaning and transforming *Nashville housing data* to improve data quality and usability for analysis. 

## ⚙️ Key Cleaning Steps
- Standardized Date Format → Converted *SaleDate* to a proper *DATE* format.
- Filled Missing Property Addresses → Used *ParcelID* to populate missing values.
- Split Address Columns → Separated *PropertyAddress* and *OwnerAddress;* into individual components (Address, City, State).
- Standardized Categorical Values → Converted *SoldAsVacant* values from 'Y/N' to 'Yes/No'.
- Removed Duplicates → Identified and deleted duplicate rows based on key property details.
- Dropped Unused Columns → Removed unnecessary columns (*PropertyAddress, OwnerAddress, TaxDistrict*) to streamline the dataset.
## 🛠️ Technology Used
- SQL (MySQL) → Performed cleaning operations using functions like *ALTER TABLE, UPDATE, ROW_NUMBER(), SUBSTRING_INDEX(), and DELETE*.
## 📌 Getting Started 
## 🔧 **Requirements**
- MySQL database system 🐬
- MySQL IDE (e.g., MySQL Workbench, DBeaver) 
- `housing` table containing Nashville housing data 
## ▶️ **How to Run** 
- Open your MySQL IDE and connect to your database 
- Ensure the housing table is available 
- Run the SQL queries in sequence to clean and standardize the data
## 📎 Acknowledgements
- This project was inspired by [@Alex The Analyst.](https://youtu.be/8rO7ztF4NtU?si=2nsCc0zcK1O1iiPe)
- Dataset [here.](https://github.com/AlexTheAnalyst/PortfolioProjects/blob/main/Nashville%20Housing%20Data%20for%20Data%20Cleaning.xlsx)
## ✍️ Author
- 👤 [@Mohab-DataAnalyst](https://github.com/Mohab-DataAnalyst)
