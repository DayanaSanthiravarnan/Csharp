# Download Product Images Script
# Downloads sample product images for the database

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  DOWNLOADING PRODUCT IMAGES" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Create images directory
$imagesDir = "product-images"
if (-not (Test-Path $imagesDir)) {
    New-Item -ItemType Directory -Path $imagesDir | Out-Null
    Write-Host "✅ Created directory: $imagesDir" -ForegroundColor Green
}

# Product image URLs (using placeholder images from Unsplash/Pexels)
$products = @(
    @{Name="iphone-15-pro"; Url="https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=800"},
    @{Name="samsung-tv"; Url="https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=800"},
    @{Name="sony-headphones"; Url="https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=800"},
    @{Name="nike-airmax"; Url="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800"},
    @{Name="levis-jeans"; Url="https://images.unsplash.com/photo-1542272604-787c3835535d?w=800"},
    @{Name="adidas-tshirt"; Url="https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800"},
    @{Name="mac-lipstick"; Url="https://images.unsplash.com/photo-1586495777744-4413f21062fa?w=800"},
    @{Name="neutrogena-facewash"; Url="https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=800"},
    @{Name="loreal-shampoo"; Url="https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?w=800"},
    @{Name="lego-starwars"; Url="https://images.unsplash.com/photo-1587654780291-39c9404d746b?w=800"},
    @{Name="hotwheels-pack"; Url="https://images.unsplash.com/photo-1558060370-d644479cb6f7?w=800"},
    @{Name="dyson-vacuum"; Url="https://images.unsplash.com/photo-1558317374-067fb5f30001?w=800"},
    @{Name="garden-tools"; Url="https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=800"},
    @{Name="wilson-basketball"; Url="https://images.unsplash.com/photo-1546519638-68e109498ffc?w=800"},
    @{Name="yoga-mat"; Url="https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=800"},
    @{Name="samsung-s24"; Url="https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=800"},
    @{Name="ipad-pro"; Url="https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=800"},
    @{Name="harry-potter-set"; Url="https://images.unsplash.com/photo-1621351183012-e2f9972dd9bf?w=800"},
    @{Name="atomic-habits"; Url="https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=800"},
    @{Name="office-chair"; Url="https://images.unsplash.com/photo-1580480055273-228ff5388ef8?w=800"},
    @{Name="coffee-table"; Url="https://images.unsplash.com/photo-1533090161767-e6ffed986c88?w=800"},
    @{Name="laptop-stand"; Url="https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=800"},
    @{Name="wireless-mouse"; Url="https://images.unsplash.com/photo-1527814050087-3793815479db?w=800"}
)

Write-Host "Downloading $($products.Count) product images..." -ForegroundColor Yellow
Write-Host ""

$downloaded = 0
$failed = 0

foreach ($product in $products) {
    $fileName = "$imagesDir/$($product.Name).jpg"
    
    try {
        Write-Host "  Downloading: $($product.Name).jpg..." -NoNewline
        Invoke-WebRequest -Uri $product.Url -OutFile $fileName -ErrorAction Stop
        Write-Host " ✅" -ForegroundColor Green
        $downloaded++
    }
    catch {
        Write-Host " ❌ Failed" -ForegroundColor Red
        $failed++
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  DOWNLOAD COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "✅ Downloaded: $downloaded images" -ForegroundColor Green
if ($failed -gt 0) {
    Write-Host "❌ Failed: $failed images" -ForegroundColor Red
}
Write-Host ""
Write-Host "Images saved to: $imagesDir/" -ForegroundColor Yellow
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "  1. Review images in $imagesDir/ folder" -ForegroundColor White
Write-Host "  2. Upload to Firebase Storage using Firebase Console" -ForegroundColor White
Write-Host "  3. Or use the upload script: .\upload-to-firebase.ps1" -ForegroundColor White
Write-Host ""
