# Multi-Platform Deployment Script
# Deploys Dashboard to Render.com and Fly.io

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Multi-Platform Deployment Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Configuration
$DOCKER_IMAGE = "owlbandocker/dashboard:latest"
$APP_NAME = "owlban-group"
$FLY_REGION = "iad"  # Ashburn (US East) - matches fly.toml

# Function to check if command exists
function Test-Command {
    param($Command)
    try {
        if (Get-Command $Command -ErrorAction Stop) {
            return $true
        }
    }
    catch {
        return $false
    }
}

# Check prerequisites
Write-Host "Checking prerequisites..." -ForegroundColor Yellow
Write-Host ""

# Check Docker
if (Test-Command "docker") {
    Write-Host "✅ Docker is installed" -ForegroundColor Green
} else {
    Write-Host "❌ Docker is not installed" -ForegroundColor Red
    Write-Host "   Please install Docker Desktop from https://www.docker.com/products/docker-desktop" -ForegroundColor Yellow
    exit 1
}

# Check Fly CLI
if (Test-Command "flyctl") {
    Write-Host "✅ Fly CLI is installed" -ForegroundColor Green
    $flyVersion = flyctl version
    Write-Host "   Version: $flyVersion" -ForegroundColor Gray
} else {
    Write-Host "⚠️  Fly CLI is not installed" -ForegroundColor Yellow
    Write-Host "   Installing Fly CLI..." -ForegroundColor Yellow
    powershell -Command "iwr https://fly.io/install.ps1 -useb | iex"
    Write-Host "   Please restart PowerShell and run this script again" -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Deployment Options" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Deploy to Fly.io only" -ForegroundColor White
Write-Host "2. Open Render.com setup guide" -ForegroundColor White
Write-Host "3. Deploy to both (Fly.io + Render.com guide)" -ForegroundColor White
Write-Host "4. Check deployment status" -ForegroundColor White
Write-Host "5. Exit" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Select option (1-5)"

switch ($choice) {
    "1" {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host "Deploying to Fly.io" -ForegroundColor Cyan
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host ""
        
        # Check if logged in
        Write-Host "Checking Fly.io authentication..." -ForegroundColor Yellow
        $authCheck = flyctl auth whoami 2>&1
        
        if ($authCheck -match "not logged in" -or $LASTEXITCODE -ne 0) {
            Write-Host "⚠️  Not logged in to Fly.io" -ForegroundColor Yellow
            Write-Host "   Opening browser for login..." -ForegroundColor Yellow
            flyctl auth login
            
            if ($LASTEXITCODE -ne 0) {
                Write-Host "❌ Login failed" -ForegroundColor Red
                exit 1
            }
        }
        
        Write-Host "✅ Authenticated with Fly.io" -ForegroundColor Green
        Write-Host ""
        
        # Launch app
        Write-Host "Launching application on Fly.io..." -ForegroundColor Yellow
        Write-Host "   Image: $DOCKER_IMAGE" -ForegroundColor Gray
        Write-Host "   Name: $APP_NAME" -ForegroundColor Gray
        Write-Host "   Region: $FLY_REGION" -ForegroundColor Gray
        Write-Host ""
        
        flyctl launch --image $DOCKER_IMAGE --name $APP_NAME --region $FLY_REGION --now
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "✅ Deployment successful!" -ForegroundColor Green
            Write-Host ""
            Write-Host "Your app is available at: https://$APP_NAME.fly.dev" -ForegroundColor Cyan
            Write-Host ""
            
            # Ask to open
            $openApp = Read-Host "Open app in browser? (y/n)"
            if ($openApp -eq "y") {
                flyctl open
            }
            
            # Show status
            Write-Host ""
            Write-Host "App Status:" -ForegroundColor Yellow
            flyctl status
        } else {
            Write-Host ""
            Write-Host "❌ Deployment failed" -ForegroundColor Red
            Write-Host "   Check the error messages above" -ForegroundColor Yellow
            Write-Host "   Common issues:" -ForegroundColor Yellow
            Write-Host "   - App name already taken (try a different name)" -ForegroundColor Gray
            Write-Host "   - Credit card not added (required for Fly.io)" -ForegroundColor Gray
            Write-Host "   - Network connectivity issues" -ForegroundColor Gray
        }
    }
    
    "2" {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host "Render.com Setup" -ForegroundColor Cyan
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Opening Render.com setup guide..." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "📖 Guide: RENDER_FLYIO_SETUP_GUIDE.md" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Quick Steps:" -ForegroundColor Yellow
        Write-Host "1. Go to https://render.com" -ForegroundColor White
        Write-Host "2. Sign up with GitHub" -ForegroundColor White
Write-Host "3. Click New + then Web Service" -ForegroundColor White
        Write-Host "4. Select 'Deploy an existing image from a registry'" -ForegroundColor White
        Write-Host "5. Image URL: $DOCKER_IMAGE" -ForegroundColor White
        Write-Host "6. Name: $APP_NAME" -ForegroundColor White
        Write-Host "7. Select 'Free' tier" -ForegroundColor White
        Write-Host "8. Click 'Create Web Service'" -ForegroundColor White
        Write-Host ""
        
        $openRender = Read-Host "Open Render.com in browser? (y/n)"
        if ($openRender -eq "y") {
            Start-Process "https://render.com"
        }
        
        $openGuide = Read-Host "Open setup guide? (y/n)"
        if ($openGuide -eq "y") {
            Start-Process "RENDER_FLYIO_SETUP_GUIDE.md"
        }
    }
    
    "3" {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host "Deploy to Both Platforms" -ForegroundColor Cyan
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host ""
        
        # Deploy to Fly.io first
        Write-Host "Step 1: Deploying to Fly.io..." -ForegroundColor Yellow
        Write-Host ""
        
        flyctl auth whoami 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) {
            flyctl auth login
        }
        
        flyctl launch --image $DOCKER_IMAGE --name $APP_NAME --region $FLY_REGION --now
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Fly.io deployment successful!" -ForegroundColor Green
            Write-Host "   URL: https://$APP_NAME.fly.dev" -ForegroundColor Cyan
        }
        
        Write-Host ""
        Write-Host "Step 2: Render.com Setup" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Opening Render.com and setup guide..." -ForegroundColor Yellow
        Start-Process "https://render.com"
        Start-Process "RENDER_FLYIO_SETUP_GUIDE.md"
        
        Write-Host ""
        Write-Host "Follow the guide to complete Render.com deployment" -ForegroundColor Cyan
    }
    
    "4" {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host "Deployment Status" -ForegroundColor Cyan
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host ""
        
        # Check Fly.io
        Write-Host "Fly.io Status:" -ForegroundColor Yellow
        flyctl auth whoami 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) {
            flyctl status 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) {
                flyctl status
                Write-Host ""
                Write-Host "✅ Fly.io app is running" -ForegroundColor Green
            } else {
                Write-Host "⚠️  No Fly.io app found" -ForegroundColor Yellow
            }
        } else {
            Write-Host "⚠️  Not logged in to Fly.io" -ForegroundColor Yellow
        }
        
        Write-Host ""
        Write-Host "Render.com Status:" -ForegroundColor Yellow
        Write-Host "   Check at: https://dashboard.render.com" -ForegroundColor Cyan
        
        Write-Host ""
        Write-Host "Other Deployments:" -ForegroundColor Yellow
        Write-Host "   Heroku: https://esaowl.herokuapp.com" -ForegroundColor Cyan
        Write-Host "   Vercel: https://owlban-website.vercel.app" -ForegroundColor Cyan
        Write-Host "   Docker Hub: https://hub.docker.com/r/owlbandocker/dashboard" -ForegroundColor Cyan
    }
    
    "5" {
        Write-Host ""
        Write-Host "Exiting..." -ForegroundColor Yellow
        exit 0
    }
    
    default {
        Write-Host ""
        Write-Host "Invalid option" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Deployment Complete!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "1. Test your deployments" -ForegroundColor White
Write-Host "2. Configure environment variables if needed" -ForegroundColor White
Write-Host "3. Set up custom domains (optional)" -ForegroundColor White
Write-Host "4. Configure monitoring" -ForegroundColor White
Write-Host ""
Write-Host "Documentation:" -ForegroundColor Yellow
Write-Host "   Setup Guide: RENDER_FLYIO_SETUP_GUIDE.md" -ForegroundColor Cyan
Write-Host "   Completion Summary: FLY_RENDER_DEPLOYMENT_COMPLETE.md" -ForegroundColor Cyan
Write-Host ""
