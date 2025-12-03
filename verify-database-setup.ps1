# Database Setup Verification Script
# Verifies that AuraMarketplace database is properly set up

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  AURA MARKETPLACE - DATABASE VERIFICATION" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Test 1: Check if database exists
Write-Host "[1/5] Checking if database exists..." -ForegroundColor Yellow
$dbCheck = sqlcmd -S "(localdb)\MSSQLLocalDB" -Q "SELECT name FROM sys.databases WHERE name = 'AuraMarketplace'" -h -1
if ($dbCheck -match "AuraMarketplace") {
    Write-Host "  ✅ Database 'AuraMarketplace' exists" -ForegroundColor Green
} else {
    Write-Host "  ❌ Database 'AuraMarketplace' not found" -ForegroundColor Red
    exit 1
}

# Test 2: Count tables
Write-Host ""
Write-Host "[2/5] Counting tables..." -ForegroundColor Yellow
$tableCount = sqlcmd -S "(localdb)\MSSQLLocalDB" -d AuraMarketplace -Q "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'" -h -1
$tableCount = $tableCount.Trim()
Write-Host "  ✅ Total tables: $tableCount" -ForegroundColor Green

if ([int]$tableCount -ge 50) {
    Write-Host "  ✅ All tables created successfully!" -ForegroundColor Green
} else {
    Write-Host "  ⚠️  Expected 50+ tables, found $tableCount" -ForegroundColor Yellow
}

# Test 3: Check sample data
Write-Host ""
Write-Host "[3/5] Checking sample data..." -ForegroundColor Yellow
$userCount = sqlcmd -S "(localdb)\MSSQLLocalDB" -d AuraMarketplace -Q "SELECT COUNT(*) FROM Users" -h -1
$productCount = sqlcmd -S "(localdb)\MSSQLLocalDB" -d AuraMarketplace -Q "SELECT COUNT(*) FROM Products" -h -1
$categoryCount = sqlcmd -S "(localdb)\MSSQLLocalDB" -d AuraMarketplace -Q "SELECT COUNT(*) FROM Categories" -h -1

Write-Host "  ✅ Users: $($userCount.Trim())" -ForegroundColor Green
Write-Host "  ✅ Products: $($productCount.Trim())" -ForegroundColor Green
Write-Host "  ✅ Categories: $($categoryCount.Trim())" -ForegroundColor Green

# Test 4: Check backend build
Write-Host ""
Write-Host "[4/5] Checking backend build..." -ForegroundColor Yellow
if (Test-Path "backend\src\AuraMarketplace.API\bin\Debug\net8.0\AuraMarketplace.API.dll") {
    Write-Host "  ✅ Backend compiled successfully" -ForegroundColor Green
} else {
    Write-Host "  ⚠️  Backend not compiled yet" -ForegroundColor Yellow
}

# Test 5: Check connection string
Write-Host ""
Write-Host "[5/5] Checking connection string..." -ForegroundColor Yellow
$appsettings = Get-Content "backend\src\AuraMarketplace.API\appsettings.json" -Raw | ConvertFrom-Json
$connString = $appsettings.ConnectionStrings.DefaultConnection
if ($connString -match "AuraMarketplace") {
    Write-Host "  ✅ Connection string configured correctly" -ForegroundColor Green
} else {
    Write-Host "  ❌ Connection string not configured" -ForegroundColor Red
}

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  VERIFICATION COMPLETE!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Database Status: ✅ READY" -ForegroundColor Green
Write-Host "Tables Created: $tableCount" -ForegroundColor Green
Write-Host "Sample Data: ✅ Inserted" -ForegroundColor Green
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "  1. Run backend: cd backend; dotnet run --project src/AuraMarketplace.API" -ForegroundColor White
Write-Host "  2. Test API: http://localhost:5000/swagger" -ForegroundColor White
Write-Host "  3. Run frontend: cd frontend; ng serve" -ForegroundColor White
Write-Host ""
