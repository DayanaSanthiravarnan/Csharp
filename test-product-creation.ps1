# Test Product Creation
$baseUrl = "http://localhost:5000/api"

Write-Host "`n=== TESTING PRODUCT CREATION ===" -ForegroundColor Cyan

# First, login to get token
Write-Host "`n1. Logging in..." -ForegroundColor Yellow
$loginBody = @{
    emailOrPhone = "dayanasanthiran123@gmail.com"
    password = "Daya@0905"
} | ConvertTo-Json

try {
    $loginResponse = Invoke-RestMethod -Uri "$baseUrl/auth/login" -Method POST -Body $loginBody -ContentType "application/json"
    $token = $loginResponse.accessToken
    Write-Host "   ✓ Login successful!" -ForegroundColor Green
    Write-Host "   Token: $($token.Substring(0,20))..." -ForegroundColor Gray
} catch {
    Write-Host "   ✗ Login failed: $($_.Exception.Message)" -ForegroundColor Red
    exit
}

# Create a test product
Write-Host "`n2. Creating test product..." -ForegroundColor Yellow
$productBody = @{
    title = "Test Product - Wireless Headphones"
    description = "High quality wireless headphones with noise cancellation"
    price = 5000
    category = "Electronics"
    stockQuantity = 50
    imageUrls = @("https://via.placeholder.com/300")
} | ConvertTo-Json

$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
}

try {
    $productResponse = Invoke-RestMethod -Uri "$baseUrl/products" -Method POST -Body $productBody -Headers $headers
    Write-Host "   ✓ Product created successfully!" -ForegroundColor Green
    Write-Host "   Product ID: $($productResponse.productId)" -ForegroundColor Gray
    
    # Get all products to verify
    Write-Host "`n3. Verifying product in database..." -ForegroundColor Yellow
    $allProducts = Invoke-RestMethod -Uri "$baseUrl/products?pageSize=5" -Method GET
    Write-Host "   ✓ Total products in database: $($allProducts.totalCount)" -ForegroundColor Green
    
    if ($allProducts.items.Count -gt 0) {
        Write-Host "`n   Recent Products:" -ForegroundColor Cyan
        $allProducts.items | ForEach-Object {
            Write-Host "   - $($_.title) (LKR $($_.price))" -ForegroundColor White
        }
    }
    
    Write-Host "`n✅ Product creation is working!" -ForegroundColor Green
    
} catch {
    Write-Host "   ✗ Product creation failed: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.ErrorDetails.Message) {
        Write-Host "   Details: $($_.ErrorDetails.Message)" -ForegroundColor Red
    }
}
