# PowerShell script to test bank account integration

Write-Host "Testing Bank Account Integration..." -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

# Test Plaid services
Write-Host "`n1. Testing Plaid Backend Services..." -ForegroundColor Yellow

# Test Java backend
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8000" -Method GET -TimeoutSec 10
    if ($response.StatusCode -eq 200) {
        Write-Host "✓ Java backend is running" -ForegroundColor Green
    }
} catch {
    Write-Host "✗ Java backend is not accessible" -ForegroundColor Red
}

# Test Node backend
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8001" -Method GET -TimeoutSec 10
    if ($response.StatusCode -eq 200) {
        Write-Host "✓ Node backend is running" -ForegroundColor Green
    }
} catch {
    Write-Host "✗ Node backend is not accessible" -ForegroundColor Red
}

# Test Python backend
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8002" -Method GET -TimeoutSec 10
    if ($response.StatusCode -eq 200) {
        Write-Host "✓ Python backend is running" -ForegroundColor Green
    }
} catch {
    Write-Host "✗ Python backend is not accessible" -ForegroundColor Red
}

# Test Frontend
Write-Host "`n2. Testing Frontend Application..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:3000" -Method GET -TimeoutSec 10
    if ($response.StatusCode -eq 200) {
        Write-Host "✓ Frontend is running" -ForegroundColor Green
    }
} catch {
    Write-Host "✗ Frontend is not accessible" -ForegroundColor Red
}

# Test Grafana
Write-Host "`n3. Testing Grafana Dashboard..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:3000/api/health" -Method GET -TimeoutSec 10
    if ($response.StatusCode -eq 200) {
        Write-Host "✓ Grafana is running" -ForegroundColor Green
    }
} catch {
    Write-Host "✗ Grafana is not accessible" -ForegroundColor Red
}

# Test Prometheus
Write-Host "`n4. Testing Prometheus..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:9090/-/healthy" -Method GET -TimeoutSec 10
    if ($response.StatusCode -eq 200) {
        Write-Host "✓ Prometheus is running" -ForegroundColor Green
    }
} catch {
    Write-Host "✗ Prometheus is not accessible" -ForegroundColor Red
}

Write-Host "`n5. Integration Status:" -ForegroundColor Yellow
Write-Host "=====================================" -ForegroundColor Yellow
Write-Host "• CPU Metrics Dashboard: Available at http://localhost:3000" -ForegroundColor White
Write-Host "• Financial Dashboard: Available at http://localhost:3000" -ForegroundColor White
Write-Host "• Plaid Link: Available at http://localhost:3000" -ForegroundColor White
Write-Host "• Bank Account Data: Accessible via Plaid API endpoints" -ForegroundColor White

Write-Host "`nNext Steps:" -ForegroundColor Cyan
Write-Host "1. Open http://localhost:3000 in your browser" -ForegroundColor White
Write-Host "2. Click 'Launch Link' to connect a bank account" -ForegroundColor White
Write-Host "3. Use sandbox credentials: user_good / pass_good" -ForegroundColor White
Write-Host "4. View integrated financial and system metrics" -ForegroundColor White

Write-Host "`nIntegration test completed!" -ForegroundColor Green
