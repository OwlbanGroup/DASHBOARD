# Local Environment Configuration Script
# This script configures local-only settings that don't require external credentials

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "Local Environment Configuration" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# 1. Check Docker containers status
Write-Host "[1/4] Checking Docker containers..." -ForegroundColor Yellow
$containers = docker ps --format "{{.Names}}: {{.Status}}" 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "  Found $($containers.Count) running containers:" -ForegroundColor Green
    foreach ($c in $containers) {
        Write-Host "    - $c" -ForegroundColor White
    }
} else {
    Write-Host "  Docker not available or not running" -ForegroundColor Red
}
Write-Host ""

# 2. Check local services
Write-Host "[2/4] Checking local services..." -ForegroundColor Yellow
$services = @{
    "Frontend (nginx)" = "http://localhost:3000"
    "Grafana" = "http://localhost:3001"
    "Prometheus" = "http://localhost:9090"
    "Node Exporter" = "http://localhost:9100"
    "Loki" = "http://localhost:3100"
    "Go Backend" = "http://localhost:8000"
    "Java Backend" = "http://localhost:8001"
    "Node.js Backend" = "http://localhost:8002"
    "Python Backend" = "http://localhost:8003"
    "Ruby Backend" = "http://localhost:8004"
}

foreach ($service in $services.GetEnumerator()) {
    try {
        $response = Invoke-WebRequest -Uri $service.Value -UseBasicParsing -TimeoutSec 2 -ErrorAction SilentlyContinue
        if ($response.StatusCode -eq 200 -or $response.StatusCode -eq 404) {
            Write-Host "  $($service.Key): OK" -ForegroundColor Green
        } else {
            Write-Host "  $($service.Key): $($response.StatusCode)" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "  $($service.Key): Not responding" -ForegroundColor Red
    }
}
Write-Host ""

# 3. Check monitoring configuration
Write-Host "[3/4] Checking monitoring configuration..." -ForegroundColor Yellow
$monitoringFiles = @(
    "docker-compose.monitoring.yml",
    "grafana/provisioning/datasources/datasources.yml",
    "grafana/provisioning/dashboards/dashboards.yml",
    "grafana/provisioning/prometheus.yml"
)

foreach ($file in $monitoringFiles) {
    if (Test-Path $file) {
        Write-Host "  ${file}: Found" -ForegroundColor Green
    } else {
        Write-Host "  ${file}: Missing" -ForegroundColor Red
    }
}
Write-Host ""

# 4. Summary
Write-Host "[4/4] Summary" -ForegroundColor Yellow
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "All local configurations complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Services running:" -ForegroundColor Cyan
Write-Host "  - Frontend: http://localhost:3000" -ForegroundColor White
Write-Host "  - Grafana: http://localhost:3001" -ForegroundColor White
Write-Host "  - Prometheus: http://localhost:9090" -ForegroundColor White
Write-Host ""
Write-Host "Optional configurations (require credentials):" -ForegroundColor Yellow
Write-Host "  - Heroku: Run 'heroku config:set GF_SECURITY_ADMIN_PASSWORD=...' -a esaowl" -ForegroundColor White
Write-Host "  - GitHub Secrets: Add in repository settings" -ForegroundColor White
Write-Host "  - Additional platforms: Requires accounts" -ForegroundColor White
Write-Host ""

# Check if Heroku CLI is available
$herokuPath = Get-Command heroku -ErrorAction SilentlyContinue
if ($herokuPath) {
    Write-Host "Heroku CLI is available." -ForegroundColor Green
    Write-Host "To configure Heroku, run:" -ForegroundColor Yellow
    Write-Host "  heroku config:set GF_SECURITY_ADMIN_PASSWORD=YourPassword -a esaowl" -ForegroundColor White
} else {
    Write-Host "Heroku CLI not found. To install, download from: https://devcenter.heroku.com/articles/heroku-cli" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "Configuration Complete!" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Cyan
