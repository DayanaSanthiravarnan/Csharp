@echo off
echo ========================================
echo   AURA MARKETPLACE - DATABASE VIEWER
echo ========================================
echo.
echo Server: CONNECTING\SQLEXPRESS01
echo Database: AuraMarketplace
echo.
echo Connecting to database...
echo.

sqlcmd -S CONNECTING\SQLEXPRESS01 -d AuraMarketplace -E -Q "SELECT t.name AS TableName, (SELECT COUNT(*) FROM sys.columns c WHERE c.object_id = t.object_id) AS Columns, (SELECT TOP 1 p.rows FROM sys.partitions p WHERE p.object_id = t.object_id AND p.index_id IN (0,1)) AS Rows FROM sys.tables t ORDER BY t.name"

echo.
echo ========================================
echo.
pause
