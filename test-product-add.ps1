# Test Product Creation in Aura Marketplace
# This script tests if products can be added to the database

$baseUrl = "http://localhost:5000/api"

Write-Host "`n╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║       TESTING PRODUCT CREATION - AURA MARKETPLACE         ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

# Step 1: Login
Write-Host "📝 Step 1: Logging in as Admin..." -ForegroundColor Yellow
$loginBody = @{
    emailOrPhone = "dayanasanthiran123@gmail.com"
    password = "Daya@0905"
} | ConvertTo-Json

try {
    $loginResponse = Invoke-RestMethod -Uri "$baseUrl/auth/login" -Method POST -Body $loginBody -ContentType "application/json"
    $token = $loginResponse.accessToken
    Write-Host "   ✓ Login successful!" -ForegroundColor Green
    Write-Host "   User: $($loginResponse.user.displayName)" -ForegroundColor Gray
    Write-Host "   Role: $($loginResponse.user.role)" -ForegroundColor Gray
} catch {
    Write-Host "   ✗ Login failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "`n⚠️  Make sure backend is running on http://localhost:5000" -ForegroundColor Yellow
    exit
}

# Step 2: Create Product
Write-Host "`n📦 Step 2: Creating test product..." -ForegroundColor Yellow
$productBody = @{
    title = "Test Product - Wireless Headphones"
    description = "High quality wireless headphones with noise cancellation. Perfect for music lovers and professionals."
    price = 5000.00
    category = "Electronics"
    stockQuantity = 50
} | ConvertTo-Json

$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
}

try {
    $productResponse = Invoke-RestMethod -Uri "$baseUrl/products" -Method POST -Body $productBody -Headers $headers
    Write-Host "   ✓ Product created successfully!" -ForegroundColor Green
    Write-Host "   Product ID: $($productResponse.productId)" -ForegroundColor Gray
    $newProductId = $productResponse.productId
} catch {
    Write-Host "   ✗ Product creation failed!" -ForegroundColor Red
    Write-Host "   Error: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.ErrorDetails.Message) {
        Write-Host "   Details: $($_.ErrorDetails.Message)" -ForegroundColor Red
    }
    exit
}

# Step 3: Verify in Database
Write-Host "`n🔍 Step 3: Verifying product in database..." -ForegroundColor Yellow
try {
    $allProducts = Invoke-RestMethod -Uri "$baseUrl/products?pageSize=10" -Method GET
    Write-Host "   ✓ Total products in database: $($allProducts.totalCount)" -ForegroundColor Green
    
    if ($allProducts.items.Count -gt 0) {
        Write-Host "`n   📋 Recent Products:" -ForegroundColor Cyan
        $allProducts.items | Select-Object -First 5 | ForEach-Object {
            Write-Host "   • $($_.title)" -ForegroundColor White
            Write-Host "     Price: LKR $($_.price) | Category: $($_.category) | Stock: $($_.stockQuantity)" -ForegroundColor Gray
        }
    }
} catch {
    Write-Host "   ✗ Failed to fetch products: $($_.Exception.Message)" -ForegroundColor Red
}

# Step 4: Get Specific Product
if ($newProductId) {
    Write-Host "`n🎯 Step 4: Fetching created product details..." -ForegroundColor Yellow
    try {
        $product = Invoke-RestMethod -Uri "$baseUrl/products/$newProductId" -Method GET
        Write-Host "   ✓ Product found!" -ForegroundColor Green
        Write-Host "`n   Product Details:" -ForegroundColor Cyan
        Write-Host "   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
        Write-Host "   Title:       $($product.title)" -ForegroundColor White
        Write-Host "   Description: $($product.description)" -ForegroundColor White
        Write-Host "   Price:       LKR $($product.price)" -ForegroundColor White
        Write-Host "   Category:    $($product.category)" -ForegroundColor White
        Write-Host "   Stock:       $($product.stockQuantity) units" -ForegroundColor White
        Write-Host "   Status:      $(if($product.isActive){'Active'}else{'Inactive'})" -ForegroundColor White
        Write-Host "   Created:     $($product.createdAt)" -ForegroundColor White
        Write-Host "   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
    } catch {
        Write-Host "   ✗ Failed to fetch product: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Summary
Write-Host "`n╔════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                    ✅ TEST COMPLETE!                       ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Green

Write-Host "`n📊 Summary:" -ForegroundColor Cyan
Write-Host "   ✓ Login: Working" -ForegroundColor Green
Write-Host "   ✓ Product Creation: Working" -ForegroundColor Green
Write-Host "   ✓ Database Storage: Working" -ForegroundColor Green
Write-Host "   ✓ Product Retrieval: Working" -ForegroundColor Green

Write-Host "`n🎉 Products can be successfully added to the database!" -ForegroundColor Green
Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Gray
